#!/bin/bash
# based on https://gist.github.com/subfuzion/90e8498a26c206ae393b66804c032b79
curl -fsSL https://get.docker.com/ | sh
sudo usermod -aG docker $USER
sudo systemctl restart docker