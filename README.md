# asl3-connection-log

A simple connection logging solution for **AllStar Link 3 (ASL3)** nodes running on Debian/Ubuntu. Logs node connections and disconnections with timestamps to a dedicated log file.

## Features

- Logs when a remote node connects to your node
- Logs when a remote node disconnects from your node
- Timestamps every event with time and date
- Falls back to system logger if the log file is unavailable
- Lightweight — just two small bash scripts

## Requirements

- ASL3 (AllStar Link 3) installed and running
- Asterisk running as the `asterisk` user
- Bash

## Installation

Run the following command as root or with sudo on your ASL3 node:

```bash
curl -sSL https://raw.githubusercontent.com/N6LKA/asl3-connection-log/main/install.sh | sudo bash
```

This will:
1. Create the `/etc/asterisk/scripts/` directory
2. Copy `conlog.sh` and `dislog.sh` to that directory
3. Set execute permissions on both scripts
4. Create the log file at `/var/log/asterisk/connectlog`
5. Set ownership of the log file to `asterisk:asterisk`

## Configuration

After installation, edit your `/etc/asterisk/rpt.conf` and add the following lines to your node stanza:

```ini
connpgm = /etc/asterisk/scripts/conlog.sh
discpgm = /etc/asterisk/scripts/dislog.sh
```

After editing `rpt.conf`, restart Asterisk:

```bash
sudo systemctl restart asterisk
```

## Log File Location

```
/var/log/asterisk/connectlog
```

Example log entries:
```
12345 connected to 67890 on 14:32:01 - 03-11-2026
12345 disconnected from 67890 on 15:10:44 - 03-11-2026
```

## Viewing the Log

```bash
tail -f /var/log/asterisk/connectlog
```

## File Overview

| File | Description |
|------|-------------|
| `conlog.sh` | Logs node connections |
| `dislog.sh` | Logs node disconnections |
| `install.sh` | Installation script |

## License

MIT License — Copyright 2026 Larry K. Aycock (N6LKA)

See [LICENSE](LICENSE) for details.

## Author

Larry K. Aycock (N6LKA)
