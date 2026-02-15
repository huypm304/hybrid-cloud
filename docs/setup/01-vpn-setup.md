# VPN Setup - WireGuard

## Date: 15/2/2026
## Status: Working

## Topology
```
VPS (10.10.0.1) ←→ Local (10.10.0.2)
```

## VPS Configuration

**Location:** `/etc/wireguard/wg0.conf`
```ini
[Interface]
PrivateKey = (hidden)
Address = 10.10.0.1/24
ListenPort = 51820
PostUp = iptables -A FORWARD -i wg0 -j ACCEPT
PostDown = iptables -D FORWARD -i wg0 -j ACCEPT

[Peer]
# Local 
PublicKey = gljLkjAJAGyDftucY3RDXoFfy0+NBvMCMt1KE3VT4XM=
AllowedIPs = 10.10.0.0/24
```

**Start command:**
```bash
sudo systemctl enable wg-quick@wg0
sudo systemctl start wg-quick@wg0
```

## Local Configuration

**Location:** `/etc/wireguard/wg0.conf`
```ini
[Interface]
PrivateKey = (hidden)
Address = 10.10.0.2/24

[Peer]
# VPS
PublicKey = EgJOhtUpYGjnmZh81JC/ITA8nvESwmNxkEsfabh6BG0=
Endpoint = 14.225.208.14:51820
AllowedIPs = 10.10.0.0/24
PersistentKeepalive = 25
```

**Start command:**
```bash
sudo systemctl enable wg-quick@wg0
sudo systemctl start wg-quick@wg0
```

## Verification
```bash
# Check status
sudo wg show

# Test connectivity
ping -c 4 10.10.0.1  # from Local
ping -c 4 10.10.0.2  # from VPS
```

## Troubleshooting Log

### Issue 1: [If you had any issues]
**Problem:** [describe]
**Solution:** [what you did]
**Lesson:** [what you learned]

## Next Steps
- [ ] Install K3s master on VPS
- [ ] Join Local as worker
