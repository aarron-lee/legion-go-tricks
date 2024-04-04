# source: https://github.com/fedora-silverblue/issue-tracker/issues/436
# copr helper script on bazzite

mkdir -p $HOME/.local/bin

cat <<EOF > "$HOME/.local/bin/copr"
#!/bin/bash
pushd /tmp

author="$(echo $2 | cut -d '/' -f1)"
reponame="$(echo $2 | cut -d '/' -f2)"

if [ ! $3 ]; then
 releasever="$(rpm -E %fedora)"
else
 releasever=$3
fi

if [[ "$1" == "enable" ]]; then
 echo "$author/$reponame -> $releasever"
 curl -fsSL https://copr.fedorainfracloud.org/coprs/$author/$reponame/repo/fedora-$releasever/$author-$reponame-fedora-.repo | sudo tee /etc/yum.repos.d/$author-$reponame.repo
elif [[ "$1" == "remove" ]]; then
 sudo rm /etc/yum.repos.d/$author-$reponame.repo
fi
EOF

chmod +x $HOME/.local/bin/copr