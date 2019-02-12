# Python Notes

## Setting up a python project
In the past, when I used python for projects, I would just write scripts and run them. If I needed a new package, I would `pip install packageA`. I did have both python 2 and python 3 installed, and I would use python3 to access the latter. This is fine for beginners, but it means that if I want to share the python script, the user would need to worry about making sure her python environment had the right packages installed. To make this easier, I learned about virtual environments and other tools that make sharing python projects easier

### Different versions of python
To manage different versions of python, you can use [pyenv](https://github.com/pyenv/pyenv).

Install: `brew install pyenv`
Enable - this can be included in your bash profile: `eval "$pyenv init -)"` 

To install a certain version of python, use: `pyenv install 2.7.5`
Check versions installed: `pyenv versions`
Set automatic versions either globally or locally:
```
pyenv global 3.3.1
pyenv local 3.5.2
```

### Virtual environments
This section is heavily borrowed from [this post](https://dev.to/codemouse92/dead-simple-python-virtual-environments-and-pip-5b56), which also has some great python xkcd comics.

Virtual environments allow you to create an isolated environment with just the setup that you need for a particular project. This should be done on project setup, and the virtual environment should be activated everytime you are working on a project and deactivated when you stop working on it. This allows only the dependencies you need for that project to be installed (this also requires updating the requirements file, as discussed below).

First, you need to have pip installed, with homebrew or otherwise. Then you can install python virtualenv with: `pip install virtualenv`.

In the project folder, setup a virtual environment by running:
```
virtualenv -p python venv
```
In this example, `venv` is the name of the virtual environment. A folder of that name will be created in your project folder. If `python` runs the version of python that you want to use for a given project, then you can just run that. Otherwise, you may need to specify with `python3`.

In order to activate your virtual environment, run: `source venv/bin/activate`

Now you are working in your virtual environment. Whenever you need a new package installed, you can run `pip install packageA` to install that package and it will be installed in your virtual environment. You can also upgrade packages with: `pip install --upgrade packageA` or remove them with `pip uninstall packageA`.

To make it easy for someone to replicate your python environment, you need to set up a `requirements.txt` file. An easy way to do that is by running `pip freeze > requirements.txt`. This takes a snapshot of your environment and writes required packages to the file. 

Then, if someone else wants to replicate your environment, they can run `pip install -r requirements.txt`.

To stop working in your virtual environment, run `deactivate`.

 
