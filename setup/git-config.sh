git config --global user.name "Michał Terczyński";
git config --global user.email "mterczynski1@gmail.com";
git config --global alias.ch checkout;
git config --global alias.s status;
git config --global alias.com commit;
git config --global alias.f fetch;
git config --global alias.m merge;
git config --global push.default current; # Don't require manual "--set-upstream" before first push on a new branch
git config --global core.editor "vim";

alias s="git status";
alias a="git add .";
alias f="git fetch";
alias fm="git fetch; git merge origin/main";
alias com="git commit";
alias ch="git checkout";
alias r="git reset";
alias p="git pull";
alias pull="git pull";
alias merge="git merge";
alias main="git checkout main || git checkout master";
alias master="main";
