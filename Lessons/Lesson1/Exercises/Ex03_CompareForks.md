### Exercise - Commit and Push
* Compare Forks
> On GitHub page navigate to your **Fork**.  
> Go to ![](../Support/About_git_files/Insights.png)  
> In ![](../Support/About_git_files/Network.png) and ![](../Support/About_git_files/Forks.png) tabs you can find more info about different **Branches** and **Forks**
* Understand how homework is submitted
> As mentioned before during this class you will need to cooperate with your co-students. Aim of this approach is to exercise cooperation using **Pull Requests** and peer-reviewing of solutions.  
> Let's excercise this on simple scenario where you will be adding note to his/her reporitory.
> First thing to do is to create new "named" remote linking to co-student's reporitory. You will nead to know his/her login and path to his/her *Fork* (same thing you used for [Cloning](Ex01_Fork.md) to local in RStudio).  

**Step1**
> Use following command in GitBash or command line being navigated to your local repository:  
**$ git remote add** *your_name_of_link_to_repository_your_colleague*  *link_to_repository_your_colleague*  
like  
`$ git remote add JankoMrkvicka_repository https://github.com/JankoMrkvicka/GeneralInsurance_Class.git`

**Step2**
> Next thing to do is to create new **Branch** of your repository that will be based on co-student's content rather than your own. Use specific name:  
**$ git checkout -b** *new_name_of_branch* *your_name_of_link_to_repository_your_colleague*/**master**  
like  
`$ git checkout -b Excercise_Lesson1_Ex3 JankoMrkvicka_repository/master`  

**Step3**
>  Now you can modify this branch locally on your computer. Put in some new file with simple content.  

**Step4**
> Do not forget to **add** and **commit**  
`$ git add Homework/blabla.R`  
`$ git commit -m "My new file for Lesson1/Ex3"`  

**Step5**
> Also **push** to your GitHub repository  
`$ git push origin`  

**Step6**
> Go to GitHub and check if new **Branch** and new file are there  
> Make pull request using this new branch  
> In **<>Code** tab select ![](../Support/About_git_files/NewPullRequest.png)  
> Set *base fork* to co-student's fork  
> Set *base* to **master** (unless he/she has renamed or branched something)  
> Set *head fork* to fork you created in **Step2**  
> Set *base* to **master** (unless you have renamed or branched something)  
> And **Create pull request**

More about **Pull Requests** can be found [here](https://help.github.com/articles/checking-out-pull-requests-locally)
