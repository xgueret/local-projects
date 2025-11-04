# Quick Start Guide: Ollama + Open WebUI

Get Ollama and Open WebUI up and running in minutes!

## Quick Installation

### 1. Deploy Ollama and Open WebUI

```bash
ansible-playbook deploy.yml --tags "ollama,open_webui"
```

### 2. Verify Everything Works

```bash
# Check that containers are running
docker ps | grep -E "ollama|open-webui"

# Test Ollama API
curl http://localhost:11434/api/version
```

### 3. Access Open WebUI

Open your browser: http://localhost:8080

## Connection Configuration (Important!)

### Common Issue

By default, Open WebUI is configured with:
```yaml
open_webui_ollama_base_url: "http://127.0.0.1:11434/"
```

This configuration **may not work** because Docker containers cannot always access `127.0.0.1` from the host.

### ✅ Recommended Solution

Modify the configuration to use the container name:

**File: `group_vars/all/main.yml`**

Add this line:
```yaml
open_webui_ollama_base_url: "http://ollama:11434"
```

Then redeploy:
```bash
ansible-playbook deploy.yml --tags "open_webui"
```

### Verify Configuration

Use the test script:
```bash
./scripts/test-ollama-connection.sh
```

## Quick Troubleshooting

### Open WebUI Cannot See Ollama

**Symptom:** Error message "Cannot connect to Ollama" in Open WebUI

**Solution:**
1. Verify that Ollama is running:
   ```bash
   docker ps | grep ollama
   ```

2. Modify the configuration (see above)

3. Redeploy Open WebUI:
   ```bash
   ansible-playbook deploy.yml --tags "open_webui"
   ```

4. Check the logs:
   ```bash
   docker logs open-webui
   ```

### Test Connection Manually

From the Open WebUI container:
```bash
docker exec -it open-webui wget -O- http://ollama:11434/api/version
```

If this command works, then `http://ollama:11434` is the correct URL.

## Usage

### Download a Model

From the host:
```bash
# Via local CLI
ollama-local pull llama3.2

# Or directly via Docker
docker exec -it ollama ollama pull llama3.2
```

### List Models

```bash
ollama-local list
```

### Web Interface

1. Go to http://localhost:8080
2. Create an account (first user becomes admin)
3. Start chatting with your models!

## Popular Models to Try

```bash
# Small and fast
ollama-local pull llama3.2

# Larger and more capable
ollama-local pull llama3:8b

# Coding assistant
ollama-local pull codellama

# Vision model
ollama-local pull llava
```

## Advanced Configuration

For more configuration options, see:
- [Complete Open WebUI Configuration](OPEN_WEBUI_CONFIGURATION.md)
- [Main README](../README.md)

## Command Reference

```bash
# Deploy
ansible-playbook deploy.yml --tags "ollama,open_webui"

# Test connection
./scripts/test-ollama-connection.sh

# Check containers
docker ps | grep -E "ollama|open-webui"

# View logs
docker logs ollama
docker logs open-webui

# Use Ollama
ollama-local pull llama3.2
ollama-local list
ollama-local run llama3.2

# Uninstall
ansible-playbook uninstall.yml --tags "ollama,open_webui"
```

## Next Steps

- Explore more models at [Ollama Model Library](https://ollama.ai/library)
- Configure GPU acceleration (see main README)
- Customize Open WebUI settings
- Connect external AI APIs to Open WebUI
