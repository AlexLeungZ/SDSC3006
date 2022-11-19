# SDSC3006 Machine Leaning I

## Setting up running environment (with conda)

### Install Conda or mamba

### Set up for conda-forge

```bash
conda config --add channels conda-forge
```

### Set up conda environment

```bash
conda create -n r_env # with environment name r_env as example
conda activate r_env
```

### Required package

- Base package
  1. r-base
  2. r-recommended
  3. r-languageserver
  4. r-lintr
  5. r-renv
- Recommended package
  1. radian
  2. Jupyter
  3. r-irkernel
- Required Dataset
  1. r-islr
  2. r-islr2
- Required Library
  1. r-dplyr
  2. r-ggplot2
  3. r-haven
  4. r-reshape2
  5. r-rpart
  6. r-rpart.plot
  7. r-hrbrthemes
  8. r-glmnet
  9. r-tree
  10. r-leaps
  11. r-gbm
  12. r-e1071
  13. r-randomforest
  14. r-pls
  15. r-mlbench
  16. r-deepnet
  17. r-neuralnet
  18. r-faraway
  19. r-nnet

### Install package (mamba is recommended)

```bash
conda install -c conda-forge r-base r-recommended r-lintr r-languageserver 
conda install -c conda-forge radian Jupyter r-irkernel r-renv
conda install -c conda-forge r-islr r-islr2
conda install -c conda-forge r-dplyr r-ggplot2 r-haven r-reshape2 
conda install -c conda-forge r-rpart r-rpart.plot r-hrbrthemes r-glmnet 
conda install -c conda-forge r-tree r-leaps r-gbm r-e1071 r-randomforest r-pls
conda install -c conda-forge r-mlbench r-deepnet r-neuralnet r-faraway r-nnet
```

## Assign Radian as the default R (optional)

```bash
alias r="radian"
```

## Setup the R kernel

### Setup the R kernel for Jupyter

```bash
radian # r if you did not install radian
```

```R
IRkernel::installspec()
quit()
```

### Choosing R as Jupyter kernel

### Try running a test code

1. Run the code ```tools\r_test.ipynb```

## Credits

[Conda Docs](https://docs.conda.io/projects/conda/en/latest/user-guide/install/index.html "Conda Docs")

[Conda-forge](https://conda-forge.org/docs/user/introduction.html "Conda-forge")

[Radian](https://github.com/randy3k/radian "Radian")
