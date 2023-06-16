## UDP Custom & UDP Request - Install Manager
#### * Version ⇢ 9.2-Rocket 🚀
---
UDP (User Datagram Protocol) is a network communication protocol that operates on top of IP (Internet Protocol). It is a simpler protocol compared to TCP (Transmission Control Protocol), as it aims for speed rather than reliability.

---

# Supported OS
- ubuntu 20.04 [x86_64] ✅ _(recommended)_
- [arm] ❌

## Install
```
sudo -s
``` 
```
wget "https://raw.githubusercontent.com/ghafoorali176/manager/main/install.sh" -O install.sh && chmod +x install.sh && ./install.sh
```


## Manually

## Note: 
 * Use optional port exclude when port udp between 1-65535 already use by other udp tunnel, like badvpn, ovpn udp and other.
 * Edit path config /root/udp/config.json, after changing it then reboot
 * Optional port exclude separated by coma, ex. 53,5300
