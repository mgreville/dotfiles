#!/usr/bin/bash

. dotfiles/colours

for file in $(find dotfiles -type f); do
    # Get install details
    OBJECT=$( [[ $(head -n1 ${file}) =~ :(.*) ]] && echo ${BASH_REMATCH[1]} )
    DIR=$(eval echo $(dirname ${OBJECT}))
    FILE=$(basename ${OBJECT})

    echo $OBJECT, $DIR, $FILE
    [[ ! -d ${DIR} ]] && mkdir -p ${DIR}

    if [[ $FILE == 'ini' ]]; then
        #Special case for the ini file not being installed with a leading '.'
        [[ -f ${DIR}/${FILE} ]] && rm ${DIR}/${FILE}
        ln dotfiles/${FILE} ${DIR}/${FILE} && echo -e "${Green}Sucess linking ${FILE}${Color_Off}" || echo -e "${Red}Failed linking ${FILE}${Color_Off}"
    else
        [[ -f ${DIR}/${FILE} ]] && rm ${DIR}/${FILE}
        ln dotfiles/${FILE#?} ${DIR}/${FILE} && echo -e "${Green}Sucess linking ${FILE}${Color_Off}" || echo -e "${Red}Failed linking ${FILE}${Color_Off}"
        ls -l ${DIR}/${FILE}
    fi

done
exit
