#### [LINUX / TMUX / COLAB] [MIDO/OXYGEN] ####

#### COLAB INSTANCE ####

<a href="https://colab.research.google.com/github/Jebaitedneko/mochi-porter/blob/e/mochi-porter.ipynb" target="_parent"><img src="https://colab.research.google.com/assets/colab-badge.svg" alt="Port In Colab"/></a>

#### AUTO PORTER INSTRUCTIONS ####
1. Clone this repo
2. Download a treble mido rom of your choice and place it inside the repo folder root
3. Script Usage: `./port("-arm" for arm arch).sh < "m" for mido "o" for oxygen > rom.zip`
4. You'll have a modified zip in the repo root
5. Wipe all partitions except internal storage 
6. Reboot recovery (important)
7. Install zip

#### IMPORTANT ####
Termux users must first run `pkg install root-repo` and then `apt install git` to install git

`git clone --depth=1 https://github.com/Jebaitedneko/mochi-porter` to clone repo

Repo will be saved in /data/data/com.termux/files/home/mochi-porter

Use a root browser to travel to that directory, place the rom zip you want to port inside the repo folder and run port-arm script
