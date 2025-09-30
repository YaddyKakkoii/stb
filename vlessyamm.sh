#!/bin/bash
set -euo pipefail

readonly Y='\033[1;93m'   # Yellow
readonly C='\033[0;36m'   # Cyan
readonly G='\033[0;32m'   # Green
readonly R='\033[1;31m'   # Red
readonly NC='\033[0m'     # Reset color

readonly DEFAULT_FOLDER="/storage/emulated/0/openclash"
readonly DEFAULT_SUBDOMAIN="indo.vpnpremium.com"
readonly DEFAULT_UUID="password-id-akun-kamu"
readonly IPHOST_URL="https://raw.githubusercontent.com/YaddyKakkoii/stb/main/iphost.txt"
readonly IPHOST_FILE="iphost.txt"

FOLDER="${VLESS_FOLDER:-$DEFAULT_FOLDER}"
SUBDOMAIN=""
UUID=""
declare -a IPS=()

log() {
    local level="$1"
    shift
    echo -e "${level}[$(date '+%Y-%m-%d %H:%M:%S')] $*${NC}" >&2
}

log_info() { log "$G" "$@"; }
log_warn() { log "$Y" "$@"; }
log_error() { log "$R" "$@"; }

spinner() {
    local pid=$1
    local delay=0.1
    local spinstr='|/-\'
    while ps -p "$pid" > /dev/null 2>&1; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

validate_subdomain() {
    local subdomain="$1"
    if [[ ! "$subdomain" =~ ^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        log_error "Invalid subdomain format: $subdomain"
        return 1
    fi
    return 0
}

validate_uuid() {
    local uuid="$1"

    if [[ ${#uuid} -lt 8 ]]; then
        log_warn "UUID/Password seems too short (< 8 characters)"
    fi
    return 0
}

create_directory() {
    local dir="$1"
    if ! mkdir -p "$dir" 2>/dev/null; then
        log_error "Failed to create directory: $dir"
        exit 1
    fi
    log_info "Directory created/verified: $dir"
}

download_iphost() {
    if [[ ! -f "$IPHOST_FILE" ]]; then
        log_info "Downloading IP host file..."
        if ! curl -fsSL "$IPHOST_URL" -o "$IPHOST_FILE"; then
            log_error "Failed to download IP host file from $IPHOST_URL"
            exit 1
        fi
        log_info "IP host file downloaded successfully"
    else
        log_info "Using existing IP host file"
    fi
}

load_ips() {
    if [[ ! -f "$IPHOST_FILE" ]]; then
        log_error "IP host file not found: $IPHOST_FILE"
        exit 1
    fi
    
    mapfile -t IPS < "$IPHOST_FILE"
    
    if [[ ${#IPS[@]} -eq 0 ]]; then
        log_error "No IPs found in $IPHOST_FILE"
        exit 1
    fi
    
    log_info "Loaded ${#IPS[@]} IP addresses"
}

get_user_input() {
    echo -e "${C}———————————————————————————————————————$”${NC}"
    echo -e "${Y}        VLESS CONFIGURATION SETUP${NC}"
    echo -e "${C}———————————————————————————————————————$”${NC}"
    
    while true; do
        echo -ne "${Y}Input Host/subdomain [default: $DEFAULT_SUBDOMAIN]: ${NC}"
        read -r SUBDOMAIN
        
        if [[ -z "$SUBDOMAIN" ]]; then
            SUBDOMAIN="$DEFAULT_SUBDOMAIN"
        fi
        
        if validate_subdomain "$SUBDOMAIN"; then
            break
        fi
        log_error "Please enter a valid subdomain"
    done

    echo -ne "${Y}Input UUID/Password [default: $DEFAULT_UUID]: ${NC}"
    read -r UUID
    
    if [[ -z "$UUID" ]]; then
        UUID="$DEFAULT_UUID"
    fi
    
    validate_uuid "$UUID"
    
    log_info "Configuration set - Subdomain: $SUBDOMAIN, UUID: ${UUID:0:8}..."
}

generate_vless_mobile() {
    local output_file="${FOLDER}/NTLS_mobile.txt"
    log_info "Generating VLESS configuration for mobile devices..."
    
    {
        for ip in "${IPS[@]}"; do
            [[ -n "$ip" ]] && echo "vless://${UUID}@${ip}:80?encryption=none&host=${SUBDOMAIN}&path=%2Fvless&security=none&type=ws#vless%20NTLS%20${SUBDOMAIN}%20${ip}"
        done
    } > "$output_file"
    
    log_info "Mobile configuration saved to: $output_file"
    log_info "Generated ${#IPS[@]} mobile configurations"
}

generate_vless_openwrt() {
    local output_file="${FOLDER}/NTLS_openwrt.yaml"
    log_info "Generating VLESS configuration for OpenWrt STB..."
    
    {
        local count=1
        for ip in "${IPS[@]}"; do
            if [[ -n "$ip" ]]; then
                cat <<EOF
- name: ${count}🔥“${SUBDOMAIN}🔥“${ip}
  type: vless
  server: ${ip}
  port: 443
  uuid: ${UUID}
  alterId: 0
  cipher: auto
  udp: true
  tls: true
  skip-cert-verify: true
  servername: ${SUBDOMAIN}
  network: ws
  ws-opts:
    path: /vless
    headers:
      Host: ${SUBDOMAIN}

EOF
                ((count++))
            fi
        done
    } > "$output_file"
    
    log_info "OpenWrt configuration saved to: $output_file"
    log_info "Generated $((count-1)) OpenWrt configurations"
}

generate_both() {
    log_info "Generating both mobile and OpenWrt configurations..."
    generate_vless_openwrt
    generate_vless_mobile
    log_info "All configurations generated successfully"
}

show_menu() {
    clear
    echo -e "${C}———————————————————————————————————————$”${NC}"
    echo -e "${Y}            VLESS CONFIG GENERATOR${NC}"
    echo -e "${C}———————————————————————————————————————$”${NC}"
    echo -e "${G}  1.) Create VLESS Config for OpenWrt STB${NC}"
    echo -e "${G}  2.) Create VLESS Config for Mobile${NC}"
    echo -e "${G}  3.) Create Both Configurations${NC}"
    echo -e "${G}  4.) Change Configuration Settings${NC}"
    echo -e "${R}  x.) Exit${NC}"
    echo -e "${C}———————————————————————————————————————$”${NC}"
    echo -e "${Y}Current settings:${NC}"
    echo -e "${Y}  Subdomain: ${SUBDOMAIN:-"Not set"}${NC}"
    echo -e "${Y}  UUID: ${UUID:0:8}...${NC}"
    echo -e "${Y}  Output folder: $FOLDER${NC}"
    echo -e "${C}———————————————————————————————————————$”${NC}"
    echo -ne "${Y}Choose option [1-4/x]: ${NC}"
}

execute_choice() {
    local choice="$1"
    local pid
    
    case "$choice" in
        1)
            generate_vless_openwrt &
            pid=$!
            spinner $pid
            wait $pid
            echo -e "${G}✓“ OpenWrt STB configuration ${NC}generated successfully${NC}"
            ;;
        2)
            generate_vless_mobile &
            pid=$!
            spinner $pid
            wait $pid
            echo -e "${G}✓“ Mobile configuration ${NC}generated successfully${NC}"
            ;;
        3)
            generate_both &
            pid=$!
            spinner $pid
            wait $pid
            echo -e "${G}✓“ Both configurations ${NC}generated successfully${NC}"
            ;;
        4)
            get_user_input
            return 0
            ;;
        x|X)
            log_info "Exiting VLESS Config Generator..."
            exit 0
            ;;
        *)
            log_error "Invalid option: $choice"
            return 1
            ;;
    esac
    
    echo -ne "${Y}Press Enter to continue...${NC}"
    read -r
    return 0
}

main_menu() {
    while true; do
        show_menu
        read -r choice
        
        if ! execute_choice "$choice"; then
            echo -ne "${Y}Press Enter to try again...${NC}"
            read -r
        fi
    done
}

cleanup() {
    log_info "Cleaning up..."
}

trap cleanup EXIT INT TERM

main() {

    log_info "Starting VLESS Configuration Generator"
    create_directory "$FOLDER"
    
    download_iphost
    load_ips
    
    get_user_input
    main_menu
}

main "$@"
