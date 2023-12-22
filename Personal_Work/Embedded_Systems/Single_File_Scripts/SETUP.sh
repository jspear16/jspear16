# Joseph Spear 9 July 2021
#
# This is the Setup file, which installs the necessary programs for an embedded project. 
# All prerequisite installations are downloaded and installed with this script.
# Make sure to give this file execution privilages with chmod +x SETUP.sh
 


function show_help(){
    echo -e "Usage: $0 [option]\n"
    echo -e "\n"

    echo -e "-------------------------------------------------------------------------------------------------"
    echo -e "|Default (no user-given arguments) setup script installs the following:                          |"
    echo -e "|                                                                                                |"
    echo -e "|  arm-none-eabi-*, all program files related to compiling code for the ARM Cortex-M processor   |"
    echo -e "|  The miktex distribution of latex                                                              |"
    echo -e "|  The doxygen code documentation application                                                    |"
    echo -e "|  The doxygen-gui for more use of doxygen's graphical capabilities                              |"
    echo -e "|  The graphviz application to support the doxygen-gui                                           |"
    echo -e "-------------------------------------------------------------------------------------------------\n"
    echo -e "\n"

    echo -e "------------------------------------------------------------------------------"
    echo -e "|Options:                                                                     |"
    echo -e "|                                                                             |"
    echo -e "|  -h|--help, Print this help menu                                            |"
    echo -e "|  -U|--uninstall-all, Uninstall all programs installed from a default setup  |"
    echo -e "|  --uninstall-arm, Uninstalls the current arm-none-eabi-* programs only      |"
    echo -e "|  --uninstall-mik, Uninstalls the miktex distribution                        |"
    echo -e "|  --uninstall-dox, Uninstalls doxygen and supporting programs                |"
    echo -e "------------------------------------------------------------------------------\n"
    echo -e "\n"
    
    return 0
}


case "${1}" in

    "")

        echo -e "------------------------------------------\n| Setup is now beginning  |\n------------------------------------------\n"

        # TODO Uninstall any possible ARM compiler

        #sudo apt-get --purge remove 

        #   Get CPU architecture
        CPU_ARCH_TYEPE=$(uname -m)

        #   Compiler name variables
        TARBALL_NAME="gnu-arm-embedded-toolchain.tar.xz"
        COMPILER_NAME=gnu-arm-embedded-toolchain


        # Check Arch type
        if [ ${CPU_ARCH_TYEPE} = "x86_64" ]
        then
            echo "You are running a ${CPU_ARCH_TYEPE} system."
        else
            echo "This is not an x86_64 computer"
            exit -1
        fi

        # Moving compiler to proper place
        if [ -d "/usr/bin/gnu-arm-embedded-toolchain" ]; then
            echo -e "\nThe arm compiler has already been downloaded\n"
        else
            echo -e "Extracting Tarball now...\n"
            sudo cp ./Compiler_Tarball/${TARBALL_NAME} /usr/bin/
            cd /usr/bin/
            sudo tar -xf ${TARBALL_NAME}
            sudo rm -r ${TARBALL_NAME}
            cd -
        fi


        # Permanantly add the Path
        if [[ $PATH == *"/usr/bin/gnu-arm-embedded-toolchain/bin/"* ]]; then 
            echo -e "\n/usr/bin/gnu-arm-embedded-toolchain/bin/ is already added to your PATH \n"
        else
            echo >> ${HOME}/.bashrc
            echo "# GCC ARM Compiler was added to the PATH here" >> $HOME/.bashrc
            echo "PATH=${PATH}:/usr/bin/gnu-arm-embedded-toolchain/bin/" >> $HOME/.bashrc
            echo -e "\nCompiler directory added to global PATH\n"
        fi
        echo -e "\narm-none-eabi files were installed successfully\n"


        # Install Miktex, Doxygen, and Doxygen support
        sudo apt-get install miktex
        sudo apt-get install doxygen 
        sudo apt-get install doxygen-gui
        sudo apt-get install graphviz


        # TODO Add a way to install necessary LaTex packages

        echo -e "Finished installing necessary files for MAD IMU\n"

        exit 0
        # ---------------------------------------- end of default case ----------------------------------------
        ;;

    --uninstall-all|-U)
        echo -e "Uninstalling all programs\n"


        # Move to proper directory
        cd /usr/bin/

        sudo rm -r gnu-arm-embedded-toolchain
        sudo apt-get --purge remove miktex
        sudo apt-get --purge remove doxygen 
        sudo apt-get --purge remove doxygen-gui
        sudo apt-get --purge remove graphviz
        echo -e "Finished uninstall\n"
        ;;
    
    --uninstall-arm)
        echo -e "Uninstalling all arm-none-eabi-* files\n"
        # Move to proper directory
        cd /usr/bin/
        
        sudo rm -r gnu-arm-embedded-toolchain
        echo -e "Finished uninstall\n"
        ;;
    
    --uninstall-mik)
        echo -e "Uninstalling miktex\n"
        sudo apt-get --purge remove miktex
        echo -e "Finished uninstall\n"
        ;;
    
    --uninstall-dox)
        echo -e "Uninstalling doxygen and supporting files\n"

        sudo apt-get --purge remove doxygen 
        sudo apt-get --purge remove doxygen-gui
        sudo apt-get --purge remove graphviz
        echo -e "Finished uninstall\n"
        ;;
    
    --help|-h|*)
        show_help;;

esac

#   end of script
