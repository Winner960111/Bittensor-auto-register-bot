Winner960111: can I run this codebase on Ubuntu?
That's because I need to register to bittensor on ubuntu system sole.

Workspace: Collecting workspace informationYes, you can run this codebase on Ubuntu. All scripts in registration-bot/ are Bash or Expect scripts, which are compatible with Ubuntu. Make sure you have the following dependencies installed:

- Bash (default on Ubuntu)
- [expect](https://manpages.ubuntu.com/manpages/jammy/man1/expect.1.html) (`sudo apt-get install expect`)
- [pm2](https://pm2.keymetrics.io/) (if you use process management)
- [btcli](https://github.com/opentensor/bittensor) (for Bittensor registration)

Refer to the setup instructions in command-center.txt for installing Python, Expect, and other required packages.

Winner960111: can you guide me step by step?

GitHub Copilot: Certainly! Here’s a step-by-step guide to run your launcher.sh codebase on Ubuntu:

---

### 1. **Install Required Packages**

Open your terminal and run:
```
sudo apt update
sudo apt install bash expect
```

---

### 2. **Copy Your Codebase to Ubuntu**

Transfer your project folder (`bittensor-auto-registration-bot`) to your Ubuntu machine. You can use SCP, SFTP, or a USB drive.

---

### 3. **Make Scripts Executable**

Navigate to your project directory and make all scripts executable:
```
cd /path/to/bittensor-auto-registration-bot/registration-bot
chmod +x launcher.sh wrapper.sh wrapper-2.sh wrapper-3.sh wrapper-4.sh sn-reg.sh
```

---

### 4. **Install Bittensor CLI (if needed)**

If your scripts use `btcli`, install it by following [Bittensor’s official instructions](https://github.com/opentensor/bittensor).

---

### 5. **Run the Launcher Script**

Start the registration bot:
```
./launcher.sh
```
This will:
- Clone `sn-reg.sh` into 3 more scripts.
- Start 4 wrapper scripts in the background.
- Log output to `launcher.log`.
- Monitor the processes and terminate all if any wrapper exits.

---

### 6. **Monitor Logs**

Check `launcher.log` for progress and errors:
```
tail -f launcher.log
```

---

### 7. **Stop the Bot**

To stop all processes manually:
```
pkill -f wrapper.sh
pkill -f sn-reg.sh
```

---

Let me know if you need help with any specific step!