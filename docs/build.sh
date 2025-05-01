#!/usr/bin/bash
set -e 
# curl https://raw.githubusercontent.com/nios-students/helper_scripts/refs/heads/main/build.sh | bash

# Assume we're already in cf pages which lands us in docs folder

# cleanup
rm -rf helper-scripts/ wiki/ home/ contribute.md takedown.md typography.md ../node_modules .vitepress/dist || true 

# Clone sources
git clone https://github.com/nios-students/helper_scripts/ helper-scripts --depth=1 || true # Scripts 
#git clone https://github.com/examdawn/NEP2020_2023_BCA NEP2020/2023/BCA --depth=1 # Clone BCA
#git clone https://github.com/examdawn/NEP2020_2024_BCA NEP2020/2024/BCA --depth=1 # Clone BCA
#git clone https://github.com/examdawn/NEP2020_2024_BSc NEP2020/2024/BSc --depth=1 # Clone BSc

# Copy Our course content to wiki folder
if [[ "$1" == "SKIP_DOCS" ]]; then
  echo "Skipping cloning docs, assuming it is at docs/temp folder"
  mv temp/{wiki,home} . && mv temp/index.md . || true
else
  git clone https://github.com/nios-students/docs -b contents temp && mv temp/{wiki,home} . && mv temp/index.md . || true
fi
#git clone https://github.com/examdawn/NEP_2023_BCA NEP2020/2023/BSc-Math --depth=1
#git clone https://github.com/examdawn/NEP_2023_BCA NEP2020/2023/BSc-Physics --depth=1


mv helper-scripts/md/*.md . || true # Move the md files to current docs dir

#bash helper-scripts/gen-md.sh # Create all the folders

cd .. #assume we're starting in docs folder
npm install || true
npm run docs:build # Build, it will pop up in 
#cp docs/helper-scripts/templates/template_headers docs/.vitepress/dist/_headers # Copy headers, https://vitepress-python-editor.netlify.app/installation#_4-set-http-headers

# Cleanup
rm -rf temp || true
