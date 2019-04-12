# How to Use Git from Your Computer

#### Key Words: [Git](https://juristr.com/blog/2013/04/git-explained/), [Fork](https://help.github.com/articles/fork-a-repo/), [GitHub R Studio Cheat Sheet](http://www.audhalbritter.com/wp-content/uploads/2016/12/Github-%E2%80%93-R-studio-Cheat-Sheet.pdf), [Git Commands](https://education.github.com/git-cheat-sheet-education.pdf), [Branches](https://blog.thoughtram.io/git/rebase-book/2015/02/10/understanding-branches-in-git.html), [Pull Requests](https://help.github.com/articles/about-pull-requests/)  
### This section will try to answer the following questions:
* What is GIT
> This is the way we make sure we can all collaborate on the same class, that is publicly available, we all have up to date information, but we never destroy the original content (called master). If you want to know more visit [git wiki](https://en.wikipedia.org/wiki/Git) for more details.
* How is it used
> GIT is a piece of software that is installed on your computer and allows you to send commands via command line or other software (e.g. R). You are able to operate "git" commands on any directory, that contains git folder set up.  
> For this class, the directory is already set up here in [github](https://github.com/ex-man/GeneralInsurance_Class), so it is enough to clone it (build a replica) in your local machine. You can do so from R Studio directly, and this is what we recommend, as this class will do 99% of the things using R. We will do it later on.
* How to set it up
> It is worth installing GIT before using it to save yourself some trouble. 
* How to start
> We will be using GitHub for this entire class, so you need to create an GitHub account. *Please create one if you do not have one already.*

> Then you need to ![Fork](About_git_files/Fork.png) our repository. This will create a replica of our class under your account and you can make changes there directly such as writing notes without messing around with anyone. 

> Then you need to **Clone** your web directory to your local machine. The best way of doing this is directly via **R Studio** by opening a project from Git repository. Just follow instructions on **page 4** of [GitHub R Studio Cheat Sheet](http://www.audhalbritter.com/wp-content/uploads/2016/12/Github-%E2%80%93-R-studio-Cheat-Sheet.pdf). Last step with Shell may not be needed.
> Remember to use your own **Fork** of this class. Otherwise you will not be allowed to update any content.

* Why is there `add`, `commit` and `push`?
> Git is a great tool, because it has multiple stages of your saved work. 
> There is your current folder visible on your computer or as a R project, 
> Then there is your local *staging* area, where you move files using `git add`.
> Then there is also your public repository, where you move stuff from your staging using `git commit`. Git is creating log of your progress in the background.
> Once you are happy with everything, you `git push` your changes and make them visible to everyone.

> Why is it so complicated? Well, there are always short-cuts you can make. Using R you skip many of these steps, but in reality, there are many situations, when you want to do partial saves, as you are not sure what will work best. These "complicated" steps will help you achieve it.

* How to publish content (`git push`)
> Once you are happy with the changes, you need to save them to your master repository on GitHub. This is achieved via `git push` command. This will only push the changes you have committed earlier, and raise any conflicts with your co-workers' work. We are not expecting to have any conflicts in this class, but if they arise, we will look at resolving them. 
> Remember to `commit` often and `push` reasonably frequently as well. There is no "auto-commit" and "auto-push" that you may be familiar from editors like MS Word (auto-save).

* How to synchronise content (`git pull` or `git checkout`)
> There will frequently be new content available, that is produced by others. You may want to download this content and add it to your repository to make your local copy of the directory up to date. `git pull` takes the "new" things from master directory and apply them to your folder. But you may sometimes want to `checkout` everything to have a fresh copy of all data (**Note:** this will overwrite all changes you have made and pick the latest version of all files).

* Branches
> **Branches** allow you to do a parallel development. They are very powerful, but we are  not planning to using them. What to know more about branches? Go [here](https://blog.thoughtram.io/git/rebase-book/2015/02/10/understanding-branches-in-git.html)

* Git Explained For Beginners
> More about commands in Git can be found [here](https://juristr.com/blog/2013/04/git-explained/)

# How it links to this class
Hopefully you got some insight above about what git is. We decided to use it for this class (despite being and overkill) to allow us to be more up to date with the technology stack and to allow us to interact with you better. And we want to avoid sending emails back and forth. It also has one additional feature called **Pull Request** described bellow. 

## Homework checking using pull requests
We want to make sure you practice what we do in the class also at home and do not loose contact with the class. On the other hand, we work full time, so we need your help with checking what you have done. You should be sending **Pull Requests** to our git project and then comment on other requests saying why they are better or worse then yours.

If you are using GitHub UI, it will navigate you through the process of getting the content of the pull request and then also via *check-out* of the right branch, and then it also suggest how to `git merge` it with your current code.

For more information on [Pull Requests](https://help.github.com/articles/about-pull-requests/) click on the link.

# Committing and Pushing via RStudio and Console

#### Key Words: [Basic Git Commands](https://www.quora.com/How-many-git-commands-are-there-Do-I-need-to-know-them-all-to-have-good-knowledge-of-git)

#### Publish content using RStudio
> Now change content of *Notes.md* adding more notes. **Save** it to your project. Then **Commit** changes using RStudio interface giving it description *"Committing my first change"*. And **Push** it to GitHub.

#### Publish content using command line
> Change content of *Notes.md* again and **Save** it.  

> Navigate to the folder containing files for this subject. Being in folder use *Right-Click -> GitBash Here* to open git console.

> You will be using the following commands, try to resolve the correct order (this [page](https://www.quora.com/How-many-git-commands-are-there-Do-I-need-to-know-them-all-to-have-good-knowledge-of-git) may help):  
`git commit -m "Committing my second change"`  
`git status`  
`git add .*`  
`git push`  

#### Make sure you do not have local changes
> If you have some local not commited cahnges you can save them temporarily by `git stash`. Using `git stash apply` you can approach them again

#### Update from original class
> Now you are ready to update your local repository with our latest changes.

`git pull original_class master -s recursive -X ours`

#### Confirm merged commit
> Now you should see message suggested by git describing you are merging changes from our original class. Probably you are using `vim` editor and can confirm message by `Esc` then `:` then `wq`

#### Do not forget to push you changes to your fork
> Now you are completely setup, but still only locally. To push your locally merged changes push it by using: 

`git push origin`

[Back](./README.md)