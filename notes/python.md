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

### Building Packages

If you have a project that has multiple directories from which you want to call functions or applications, Python's `__init__.py` file allows you to [treat directories as containing packages](https://docs.python.org/3/tutorial/modules.html#packages). This is also useful if you want tests to live in a different folder. 

### Unit tests

Python's main unit test framework is [unittest](https://docs.python.org/3/library/unittest.html). The documentation is pretty helpful.

In your test script, you create a class extending `unittest.TestCase` which should include a bunch of methods that mimic the functions and methods you want to test but are prefixed by `test_`. For example:
```
import unittest

class TestX(unittest.TestCase):

    def test_upper(self):
        self.assertEqual('foo'.upper(), 'FOO')

if __name__ == '__main__':
    unittest.main()
```

The tests can be run from the command line as a module or as a class. For example, in a project I have, I run them with:
```
python -m unittest test.test_scrape_congressional_record
```

The module has multiple test classes, and this command runs them both.

The official documentation lists all of the assert statements that the package has. Additionally, it allows you to define `setUp(self)` and `tearDown(self)` within a test class that are run at the beginning and end of the set of tests. This allows you, for example, to set up and then delete a temporary directory that tests can write to.

#### Mocks
Some things are inherently hard to write unit tests for. In particular, http requests. The `mock_requests` [package](https://requests-mock.readthedocs.io/en/latest/) allows you to set up mock requests in a way that is very simple (so simple, that it took me awhile to understand because I thought it had to be more complicated).

If the function you are testing is making an http request, the first thing you need to do is add one before the function definition:
```
@requests_mock.Mocker()
def test_http_thing(self, mocker):
```

Then, inside the method, you need to run:
```
moc$ker.get(url, text = mock_text)
``` 
`url` is the web address that you want to mimic the http request from (as a string). `mock_text` is a string of what that request should return. The text can easily be read in from a file.

That is it. Now when you run the test function, when it gets to an http request, as long as the address is specified correctly for the mocker, the request will return your desired text.

TODO: learn more about other mock functionality and how the package internals work. 

## Things I forget

`__file__` is set to the file name

If/else in list comprehension

```
l = [22, 13, 24, 56]
[x + 1 if x >= 23 for x in l]
```

Loop through two lists with zip
```
for x, y in zip(a, b):
```
 
