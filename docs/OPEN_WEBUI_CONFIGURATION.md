# Open WebUI Configuration Guide

Comprehensive guide for configuring Open WebUI to work with Ollama and other LLM backends.

## Table of Contents

- [Ollama Connection Configuration](#ollama-connection-configuration)
- [Configuration Methods](#configuration-methods)
- [Deployment After Changes](#deployment-after-changes)
- [Verification](#verification)
- [Troubleshooting](#troubleshooting)
- [Advanced Network Configuration](#advanced-network-configuration)

## Ollama Connection Configuration

Open WebUI must be able to communicate with Ollama to function. The `open_webui_ollama_base_url` variable determines the URL used to connect to the Ollama service.

### Configuration Options

There are **3 methods** to configure this connection:

#### 1. Via Host (Current Default)

**File:** `roles/open_webui/vars/main.yml`

```yaml
open_webui_ollama_base_url: "http://127.0.0.1:11434/"
```

**Advantages:**
- Works immediately if Ollama port is exposed on the host
- Simple to understand

**Disadvantages:**
- May not work depending on Docker network configuration
- Less performant (goes through the host)
- Not recommended for production use

#### 2. Via Container Name (Recommended)

**File:** `roles/open_webui/vars/main.yml`

```yaml
open_webui_ollama_base_url: "http://ollama:11434"
```

**Advantages:**
- Direct communication between containers on Docker network
- More performant
- Works even if ports are not exposed
- Best practice for containerized applications

**Disadvantages:**
- Requires containers to be on the same Docker network

**Note:** This configuration works because:
- Both containers use the `local_network` network
- The Ollama container is named `ollama` (defined in `ollama_container_name`)

#### 3. Via Custom IP

**File:** `group_vars/all/main.yml`

```yaml
open_webui_ollama_base_url: "http://192.168.1.100:11434/"
```

**Use Cases:**
- Ollama installed on a different machine
- Local network configuration
- Remote Ollama server

## Configuration Methods

### Method 1: Edit Role Variables File

Edit `roles/open_webui/vars/main.yml`:

```yaml
---
open_webui_version: "v0.6.34"
open_webui_container_name: "open-webui"
open_webui_app_path: "{{ app_path }}/openWebUI"
open_webui_port: 8080
open_webui_ollama_base_url: "http://ollama:11434"  # ← Modify here
open_webui_use_ollama_docker: false
```

### Method 2: Override in group_vars (Recommended)

Add to `group_vars/all/main.yml`:

```yaml
---
# ... other variables ...

# Open WebUI configuration override
open_webui_ollama_base_url: "http://ollama:11434"
```

**Advantage:** Modifications in `group_vars` take precedence over `roles/*/vars/main.yml`

### Method 3: Runtime Override

```bash
ansible-playbook deploy.yml --tags "open_webui" \
  -e "open_webui_ollama_base_url=http://ollama:11434"
```

## Deployment After Changes

After modifying the configuration, redeploy Open WebUI:

```bash
ansible-playbook deploy.yml --tags "open_webui"
```

## Verification

### Check Current Configuration

```bash
# View current configuration
cat $HOME/Workspace/07-local/app/openWebUI/.env

# Verify containers are on the same network
docker network inspect local_network
```

### Test the Connection

```bash
# From the host
curl http://localhost:11434/api/version

# From inside the Open WebUI container
docker exec -it open-webui wget -O- http://ollama:11434/api/version
```

## Troubleshooting

### Open WebUI Cannot Connect to Ollama

**Symptoms:**
- "Cannot connect to Ollama" error message
- No models appearing in the UI
- Connection timeout errors

**Solutions:**

1. **Verify Ollama is running:**
   ```bash
   docker ps | grep ollama
   ```

2. **Test connection from Open WebUI container:**
   ```bash
   docker exec -it open-webui wget -O- http://ollama:11434/api/version
   ```

   If this works, the container name method is correct.

3. **Check Docker network:**
   ```bash
   docker network inspect local_network | grep -A 5 "ollama\|open-webui"
   ```

   Both containers should be listed in the network.

4. **Check logs:**
   ```bash
   docker logs open-webui
   docker logs ollama
   ```

### Test Different URLs Manually

```bash
# From the host
curl http://127.0.0.1:11434/api/version

# From Open WebUI container
docker exec open-webui wget -O- http://ollama:11434/api/version
docker exec open-webui wget -O- http://127.0.0.1:11434/api/version
```

### Common Error Messages

| Error | Cause | Solution |
|-------|-------|----------|
| `Connection refused` | Ollama not running | Start Ollama container |
| `Could not resolve host` | Wrong container name | Use `ollama` not `ollama-container` |
| `Timeout` | Network issue | Check Docker network configuration |
| `404 Not Found` | Wrong URL path | Ensure URL doesn't have extra path |

## Advanced Network Configuration

### Using network_mode: host

If you want Open WebUI to use the host's network directly:

**File:** `roles/open_webui/tasks/main.yml`

Modify the `common_app` call:

```yaml
common_network_mode: "host"
```

**Important Notes:**
- With `network_mode: host`, the configured port must be different from Ollama's port if both services run on the same host
- This bypasses Docker network isolation
- May be required for certain network configurations
- Works best when services need direct access to host network interfaces

### Custom Docker Network

To use a custom Docker network:

1. Create the network:
   ```bash
   docker network create --driver bridge my_custom_network
   ```

2. Update `group_vars/all/main.yml`:
   ```yaml
   app_network: my_custom_network
   ```

3. Redeploy all services:
   ```bash
   ansible-playbook deploy.yml
   ```

## Additional Configuration Options

### Change Port

Edit `roles/open_webui/vars/main.yml`:

```yaml
open_webui_port: 3000  # Change from default 8080
```

### Change Version

```yaml
open_webui_version: "v0.6.34"  # Specify exact version
```

### Configure External API

To use OpenAI or other external APIs instead of Ollama:

1. Access Open WebUI at http://localhost:8080
2. Go to Settings > Connections
3. Add your API key and endpoint
4. Select the external API as your model provider

## Environment Variables

Open WebUI supports many environment variables. You can add them in the role's template file.

Common variables:
- `OLLAMA_BASE_URL` - Ollama connection URL
- `WEBUI_SECRET_KEY` - Secret key for sessions
- `DEFAULT_MODELS` - Default models to show
- `ENABLE_SIGNUP` - Allow user registration

Refer to [Open WebUI documentation](https://docs.openwebui.com/) for complete list.

## Best Practices

1. **Use container names** for service-to-service communication
2. **Keep configurations in `group_vars`** for easy management
3. **Test connections** after deployment
4. **Check logs** if issues occur
5. **Use specific versions** in production (not `latest`)
6. **Backup configurations** before making changes

## Related Documentation

- [Quick Start Guide](QUICK_START_OLLAMA.md)
- [Main README](../README.md)
- [Official Open WebUI Documentation](https://docs.openwebui.com/)
- [Ollama Documentation](https://github.com/ollama/ollama/blob/main/docs/README.md)
