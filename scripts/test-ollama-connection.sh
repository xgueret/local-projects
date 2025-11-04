#!/bin/bash
# Script to test Ollama connection from Open WebUI container

set -e

echo "=================================================="
echo "Testing Ollama Connection"
echo "=================================================="
echo ""

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if containers are running
echo "1. Checking if containers are running..."
if docker ps | grep -q "ollama"; then
	echo -e "${GREEN}✓${NC} Ollama container is running"
else
	echo -e "${RED}✗${NC} Ollama container is NOT running"
	exit 1
fi

if docker ps | grep -q "open-webui"; then
	echo -e "${GREEN}✓${NC} Open WebUI container is running"
else
	echo -e "${YELLOW}⚠${NC} Open WebUI container is NOT running (this is ok for testing)"
fi

echo ""

# Check current Open WebUI configuration
echo "2. Checking current Open WebUI configuration..."
if [ -f "$HOME/Workspace/local/app/openWebUI/.env" ]; then
	echo "Current OLLAMA_BASE_URL:"
	grep "OLLAMA_BASE_URL" "$HOME/Workspace/local/app/openWebUI/.env" || echo "Not found"
else
	echo -e "${YELLOW}⚠${NC} .env file not found"
fi

echo ""

# Test connection from host
echo "3. Testing connection from HOST..."
if curl -s http://127.0.0.1:11434/api/version >/dev/null; then
	echo -e "${GREEN}✓${NC} Connection from host successful: http://127.0.0.1:11434"
	echo "   Response: $(curl -s http://127.0.0.1:11434/api/version)"
else
	echo -e "${RED}✗${NC} Connection from host FAILED: http://127.0.0.1:11434"
fi

echo ""

# Test connection from Open WebUI container (if running)
if docker ps | grep -q "open-webui"; then
	echo "4. Testing connection from OPEN WEBUI CONTAINER..."

	# Test via container name
	echo "   Testing: http://ollama:11434 (via container name)"
	if docker exec open-webui wget -q -O- http://ollama:11434/api/version 2>/dev/null; then
		echo -e "   ${GREEN}✓${NC} Connection via container name successful"
		echo "      Response: $(docker exec open-webui wget -q -O- http://ollama:11434/api/version)"
	else
		echo -e "   ${RED}✗${NC} Connection via container name FAILED"
	fi

	echo ""

	# Test via localhost
	echo "   Testing: http://127.0.0.1:11434 (via localhost)"
	if docker exec open-webui wget -q -O- http://127.0.0.1:11434/api/version 2>/dev/null; then
		echo -e "   ${GREEN}✓${NC} Connection via localhost successful"
		echo "      Response: $(docker exec open-webui wget -q -O- http://127.0.0.1:11434/api/version)"
	else
		echo -e "   ${RED}✗${NC} Connection via localhost FAILED"
	fi
else
	echo -e "${YELLOW}⚠${NC} Open WebUI container not running, skipping container tests"
fi

echo ""

# Check Docker network
echo "5. Checking Docker network configuration..."
if docker network inspect local_network &>/dev/null; then
	echo -e "${GREEN}✓${NC} local_network exists"
	echo "   Containers on this network:"
	docker network inspect local_network | jq -r '.[] | .Containers | to_entries[] | "   - \(.value.Name) (\(.value.IPv4Address))"' 2>/dev/null ||
		docker network inspect local_network | grep -A 2 "Containers" || echo "   Unable to parse network info"
else
	echo -e "${RED}✗${NC} local_network does NOT exist"
fi

echo ""
echo "=================================================="
echo "Recommendations:"
echo "=================================================="
echo ""

if docker ps | grep -q "open-webui" && docker exec open-webui wget -q -O- http://ollama:11434/api/version &>/dev/null; then
	echo -e "${GREEN}✓${NC} Recommended configuration: http://ollama:11434"
	echo "  Add to group_vars/all/main.yml:"
	echo '  open_webui_ollama_base_url: "http://ollama:11434"'
elif curl -s http://127.0.0.1:11434/api/version >/dev/null; then
	echo -e "${YELLOW}⚠${NC} Current configuration works: http://127.0.0.1:11434/"
	echo "  But consider using: http://ollama:11434 for better performance"
else
	echo -e "${RED}✗${NC} No working configuration found. Check if Ollama is running."
fi

echo ""
echo "For more details, see: docs/OPEN_WEBUI_CONFIGURATION.md"
