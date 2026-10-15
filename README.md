# GeneralInsurance_Class
This repository forms a backbone to the class we teach at Universities. It is related to General insurance and covers the following topics:
  
1) [Introduction to insurance, environment and R packages](/Lessons/Lesson1/README.md) (Insurance Intro, Posit Cloud, Rmarkdown, Dplyr, GGplot2)
2) [Portfolio performance metrics](/Lessons/Lesson2/README.md) (Basic terminology, losses, expenses, premiums, ratios, dplyr/ggplot2 practice)
3) [Closer look at the losses](/Lessons/Lesson3/README.md) (Loss development triangles, discounting, time value of money)
4) [Which loss is the most significant](/Lessons/Lesson4/README.md) (Joining policy and claims data, exposure, burning cost as modelling target, one-way variable analysis, GLM motivation)
5) [Use past data to predict future experience Part 1](/Lessons/Lesson5/README.md) (Model validation, model metrics, feature engineering, GLM)
6) [Use past data to predict future experience Part 2](/Lessons/Lesson6/README.md) (Tree based methods, model evaluation, final thoughts on model output usage)

## Notes for maintainers
- **Known warning when knitting outside Posit Cloud:** the exercises use the Posit Cloud layout (`/cloud/project/Data/...`, `/cloud/project/Support/...`). Knitting elsewhere prints `Could not fetch resource .../Support/img_*.png` (also for `join_diagram.png`) and cannot read the data. It is not a missing file - with the paths pointed at the local lesson `Data/` and `Support/` folders, the knit has no warnings.
- **Generated images:** the explanatory pictures in Lesson 4 (`Lessons/Lesson4/Support/img_*.png`) were generated with an image model. The prompts and the generator are in [tools/image_generation](/tools/image_generation/README.md).
