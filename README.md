# Explanation

This project is intended to be used at command line to create and manipulate a YeAPF2 project.

## Installation this package

1. Install this package globally
    ```bash
    composer global require esteban/yeapf2-tools
    ```

2. You can find the composer path using this command:
   ```bash
   composer global config bin-dir --absolute
   ```
   This path will be used later in third point

   Or use just the `$HOME/.composer/vendor/bin`.

3. Change your PATH variable
   
   In MacOS you can do `nano ~/.bash_profile` if using bash or `nano ~/.zshrc`

   In Linux you can do `nano ~/.bashrc`

   Add aline as this:

   ```bash
   export PATH="$PATH:$HOME/.composer/vendor/bin"
   ```

### Installing a project alone
  Go to the folder of your project and run this command:
  This will install `y2-classic-example` project in `www` folder of your project.

  ```bash
   bash <(curl -Ls https://raw.githubusercontent.com/EDortta/yeapf2-tools/main/install-project.sh ) y2-classic-example
   ```  

   You can just ompit the project name and it will list the projects available.
  ```bash
   bash <(curl -Ls https://raw.githubusercontent.com/EDortta/yeapf2-tools/main/install-project.sh ) 
   ```   