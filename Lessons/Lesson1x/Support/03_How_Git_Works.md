# How Git Works

Let's have a situation where a developer starts working on a project A. He will write some code and store some files that go with the code or are in some way connected with the project. Since the project will take some time, the developer wants to make sure he can have a look back at the changes that he/she made. Also the developer would like to be able to revert any changes that he/she for some reason does not like anymore and wants to return to the previous part of the code.

So the developer sets up a repository using Git. Now s/he has ability to do all of the things listed above and s/he can use also other features of the Git.

Now the Git has project A stored as a repository. This is the place where all the codes and files of the developer will be stored and it is also the place where the changes will be tracked.

### Commits
Git keeps track of the changes in the files using commits. Commit is basically a way of telling Git that the code or a file has been saved and it can do a comparison with the previous version of the code or file. It is important to note that unlike in Google Docs this is not an automated process but it requires the activity of the developer.

Each commit gets its own unique name called hash. This is an important fact that can be used especially in those cases when the developer wants to review, compare or reverse to a specific point of the code development.
