distro="${DISTRO:-lubuntu-20-04}"

# ! we assume that git is already installed

chmod +x ./project-setup/$distro/*
./project-setup/$distro/main.sh
chmod -x ./project-setup/$distro/*
