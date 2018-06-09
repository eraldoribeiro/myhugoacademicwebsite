

### 1 Cloning the website repositories



**Create a directory to store the website files**. This is where I keep the repositories related to my website(s). 

```shell
mkdir ~/Documents/website 
```



**Clone the website repositories into this directory**. I use two repositories. One repository contains the website-project files, and the other is my actual github-page repository. 

```shell
cd ~/Documents/website 
git clone https://github.com/eraldoribeiro/eraldoribeiro.github.io.git
cd eraldoribeiro.github.io/
git pull origin master

cd ~/Documents/website 
git clone https://github.com/eraldoribeiro/myhugoacademicwebsite.git
cd myhugoacademicwebsite
git pull origin master
```



**Git Ignore the public directory created by Hugo**. Depending on how we call Hugo, it creates a directory called `public/` inside the project directory. We do not want this directory to be stored into the repository. Thus, we must create the relevant `.gitignore` file. <u>If this file does not exist,</u> create one by typing:

```shell
echo 'public/' >> .gitignore
```



### 2 Updating and deploying



**Make changes to the website**. Update the website files (e.g., configuration, contents). 

**Test the website on a local server.** Then, test the changes by running the website locally: 

```shell
hugo server -w 
open http://localhost:1313/    
```

If everything looks fine, kill the server by pressing Ctrl+C. 

**Re-create the static files of the website**. Re-create the static-website files by running hugo again. This time, tell hugo to store the website files into the local directory where the GitHub-page is stored, i.e., 

```shell
echo "Generating static website files ..."
hugo -d ~/Documents/website/eraldoribeiro.github.io/
```



**Update the GitHub page**. Push all changes into the master repository for your GitHub-page: 

```shell
echo "Pushing to publish"
cd ~/Documents/website/eraldoribeiro.github.io/
git add --all
git status
git commit -am "More changes"
git push origin master
```



**Update the project files**. Finally, don't forget to also push the changes into the master repository of the website-project on GitHub:

```shell
echo "Updating the project files"
cd ~/Documents/website/myhugoacademicwebsite/
git add --all
git status
git commit -am "More changes"
git push origin master
```



### 3 Deploying using a shell script



**A shell script** `deploy.sh`

Automate the "deploying" process using a shell script. 

```shell
#!/bin/sh

echo "Generating static website files ..."
cd ~/Documents/website/myhugoacademicwebsite
hugo -d ~/Documents/website/eraldoribeiro.github.io/

echo "Pushing to publish"
cd ~/Documents/website/eraldoribeiro.github.io/
git add --all
git status
git commit -am "More changes"
git push origin master

echo "Updating the project files"
cd ~/Documents/website/myhugoacademicwebsite/
git add --all
git status
git commit -am "More changes"
git push origin master
```



### 4 Generating publication files using python 

The Hugo academic theme needs each publication to be in its own markdown file. This markdown file has a specific format which can be created manually or generated automatically using `parse_bib.py`, a python script created by [Petros Aristidou's python script](https://github.com/apetros/parse_bib). To create all files from a bibtex library and place them in the correct location in the Hugo's content directory, run the following:  

```shell
cd ~/Documents/website/myhugoacademicwebsite/
python3 parse_bib.py -i myrefs.bib 
```

To make the script work, I used `python3` and installed the [bibtextparser](https://github.com/sciunto-org/python-bibtexparser) library. To add a new publication, I just need to add a new record to`myrefs.bib` and run `parse_bib.py` on it. Then, I call call `deploy.sh` to update the website. 