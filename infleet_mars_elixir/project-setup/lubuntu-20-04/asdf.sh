echo "!!! Installing asdf !!!"

# it will crash over retry and its ok to avoid plus appending on .bashrc
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2 \
    && echo '' >> ~/.bashrc \
    && echo '. $HOME/.asdf/asdf.sh' >> ~/.bashrc \
    && echo '. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc \
    && echo '' >> ~/.bashrc \
    && source ~/.bashrc

asdf plugin-add elixir
asdf plugin-add erlang
asdf plugin-add yarn
asdf plugin-add nodejs
asdf install