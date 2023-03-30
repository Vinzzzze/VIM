################################################################################
#  Makefile                                                                    #
#                                                                              #
# Auteur : [@ELEMENT_AUTHOR@]                                                  #
#          [@ELEMENT_EMAIL@]                                                   #
# Date : [@ELEMENT_DATE@]                                                      #
#------------------------------------------------------------------------------#
# Description :                                                                #
#   [@ELEMENT_DESC@]                                                           #
#                                                                              #
#------------------------------------------------------------------------------#
# Cibles :                                                                     #
#                                                                              #
#------------------------------------------------------------------------------#
# Variables :                                                                  #
#                                                                              #
#---< Declaration des variables >----------------------------------------------#

# Répertoire de localisation des fichiers objets
#-----------------------------------------------
REP_OBJET=OBJETS

# Répertoire de localisation des éxécutables et autres librairies partagées
#--------------------------------------------------------------------------
REP_FINAL=EXE

#---< Déclaration des variables d'option >-------------------------------------#

# Les options de compilation :
# -c : pour dire qu'on ne veut pas effectuer de linkage
# -ansi : Pour l'utilisation du C-ANSI
# -pedantic : Pour une déclaration stricte
# -I : pour ajouter des répertoires aux répertoires d'include courant
# -Wall : Pour ajouter tout un tas de warning lors de la compilation
# -o : pour spécifer le nom du fichier généré
#--------------------------------------------------------------------
CC_OPTIONS=-c -ansi -pedantic -D_SVID_SOURCE -D_BSD_SOURCE -I. -I../COMMON -Wall -o

# Les options de linkage :
# -o : le mon du fichier produit
#-------------------------------
LD_OPTION=-o

#---< Déclaration des variables de programmes >--------------------------------#

CC_PRG=gcc
LD_PRG=gcc

#---< Initialisation des variables de désignation des cibles >-----------------#

OBJECT_FILES=\

RESULT_EXE=\

RESULT_LIB=\

#---< Déclaration de la cible primaire >---------------------------------------#

All: ${RESULT_EXE}

RebuildAll: DeleteAll All

DeleteAll:
   rm -f ${RESULT_EXE} ${RESULT_LIB} ${OBJECT_LIB}

#---< Déclaration des cibles secondaires >-------------------------------------#

#---< Fin du fichier >---------------------------------------------------------#
