# VPS as remote PC

## Description

Turns a VPS into a basic remote PC.

![image](https://github.com/ManuelFte/VPS-as-remote-PC/assets/68722732/9ce618da-1ba4-4cc7-9676-9c9da785cd10)

## Installed software

* LXQt (with Openbox)
* TigerVNC Standalone Server
* Chromium

## Optional modes

- `--scratch / -sc` - When the script is being run on a new VPS. Adjusts the clock and sets up a password for the current user.
- `--dns / -dn` - Sets up OpenDNS nameservers (more options available in `resolved.conf`).
- `--full / -fl` - Does all of the above.


## Usage

Clone the repository:

```
git clone https://github.com/ManuelFte/VPS-as-remote-PC
```

Enter the script's directory:

```
cd VPS-as-remote-PC
```

Open `main.sh` and set the correct timezone in the user variables:

```
nano main.sh
```

Run the script:

```
bash main.sh [<mode(s)>]
```

After the script has finished, type one of these commands in the **client** machine to connect:

a) If you're using login via SSH key:

```
ssh -i ~/.ssh/id_rsa -L 7000:localhost:5900 -N -v <user>@<IP>

```

b) If you're using login via password:

```
ssh -L 7000:localhost:5900 -N -v <user>@<IP>
```

Then, also from the **client** machine, use a VNC program like TigerVNC to connect to `localhost:7000` (on Linux you can use `vncviewer localhost:7000`).