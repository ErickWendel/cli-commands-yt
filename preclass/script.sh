
# 1 = JQ + tee
curl https://next.json-generator.com/api/json/get/NJafGjxXq --silent | jq '.[] | {name: .name, category: .category}' | pbcopy
curl https://next.json-generator.com/api/json/get/NJafGjxXq --silent | jq '[.[] | {name: .name, category: .category}]' | tee myfile.json
curl https://next.json-generator.com/api/json/get/NJafGjxXq --silent | jq '[.[] | {name: .name, category: .category}]' | tee myfile2.json

git clone https://github.com/ErickWendel/lives-aquecimento02-javascript-expert
git submodule update --init --recursive

# 2 - FIND + XARGS
find . -name '*.js' -or -name '*.mjs'

ls | wc -l           
ls | xargs wc -l

find . -name '*.js' -or -name '*.mjs' | xargs cat
find . -name '*.js' -or -name '*.mjs' | xargs head -n 1

# 3 - for & jq

CMD=`PWD`
# -d directoryqq
for project in `find . -name recorded  -type d`
do
    cd $CMD/$project
    echo restoring $project
    cat ./package.json | jq .dependencies
    npm ci --silent
done
cd $CMD

find . -name 'node_modules' -type d -exec rm -rf '{}' +

# 4 - IPT + XARGS + SED
npm i -g ipt

find . -name '*.js' -not -path '*node_modules**' | ipt
find . -name '*.js' -not -path '*node_modules**' | ipt -o

# 4 - XARGS
find . -name '*.js' -not -path '*node_modules**' | ipt -o | xargs cat 

find . -name '*.json' |
 ipt -o |
 xargs -I '{file}' sed  -e 's/category/categoria/' -e 's/name/nome/' {file} 


# https://www.geeksforgeeks.org/sed-command-in-linux-unix-with-examples/
# https://www.geeksforgeeks.org/wc-command-linux-examples/
# https://www.tecmint.com/xargs-command-examples/
# https://stedolan.github.io/jq/tutorial/