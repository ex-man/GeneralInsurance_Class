## Exercise - Commit and Push
### Compare Forks
> On GitHub page navigate to your **Fork**.  
> Go to ![](../Support/About_git_files/Insights.png)  
> In ![](../Support/About_git_files/Network.png) and ![](../Support/About_git_files/Forks.png) tabs you can find more info about different **Branches** and **Forks**  

### Understand how homework is submitted
> When you are done with your homework, you should submit it to Github. Here is how to do it:

#### Step 1 Make a commit describing you homework
> Go to command line or terminal from RStudio and **add** files you want to commit (submit) by

`$ git add Homework/blabla.R Homework/blabla2.R`  
> and **commit** by typing

`$ git commit -m "My new file for Lesson1/Ex3"`  

#### Step 2 Make sure you are updated with your fork
> it can happen, wen you are working from different places (PCs), you forget to update your current work from the Github you worked on different PC. Make sure you do this step every time you know you updated something on the Github.

`git pull origin master -s recursive -X ours # this will update automatically all changes from your Github, but leaves differences you created locally by previous commit`

#### Step 3 Push commits to your Github
> Now you are ready to push your commited homewrok to Github

`git push origin`

### Submitting homework using web
> Previous way to submit homework is safest, but you see there is a lot of steps. Sometimes when you do not have any conflicts with your original code hosted on Github you can submit homework laso using the web interface.

> It is very nice described at Github manuals: `https://guides.github.com/activities/hello-world/#commit`

### Synchronize with our class
> Sometimes we upgrade our class during semester and probably you would like to stay updated as well. So to update your __forked__ repository to the latest code in __our class__ follow this steps:

#### Step 1 Add link to our original class
> Use following command in GitBash or command line being navigated to your local repository:  

`$ git remote add original_class https://github.com/ex-man/GeneralInsurance_Class.git`

#### Step 2 Make sure you do not have local changes
> If you have some local not commited cahnges you can save them temporarily by `git stash`. Using `git stash apply` you can approach them again

#### Step 3 Update from original class
> Now you area ready to update you local repository eith our latest changes.

`git pull original_class master -s recursive -X ours # this will update automatically all changes from our class Github, but leaves differences you created locally by some previous commit`

#### Step 4 Confirm merged commit
> Now you should see message suggested by git describing you are merging changes from our original class. Probably you are using `vim` editor and can confirm message by `Esc + : + wq`

#### Step 5 Do not forget to push you changes to your fork
> Now you are completely setup, but still only locally. To push your locally merged changes push it by using: 

`git push origin`

### Synchronizing with our class using web
> Previous way to synchrinize is safest, but you see there is a lot of steps. Sometimes when you do not have any conflicts you can synchronize with our class using the web interface.

> Make pull request using our original class repository 
> In **<>Code** tab select ![](../Support/About_git_files/NewPullRequest.png)  
> Set *base fork* to our class repository 
> Set *base* to **master** 
> Set *head fork* to your fork
> Set *base* to **master** (unless you have renamed or branched something)  
> And **Create pull request**

More about **Pull Requests** can be found [here](https://help.github.com/articles/checking-out-pull-requests-locally)
