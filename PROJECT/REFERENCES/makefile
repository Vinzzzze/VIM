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

# R�pertoire de localisation des fichiers objets
#-----------------------------------------------
REP_OBJET=OBJETS

# R�pertoire de localisation des �x�cutables et autres librairies partag�es
#--------------------------------------------------------------------------
REP_FINAL=EXE

#---< D�claration des variables d'option >-------------------------------------#

# Les options de compilation :
# -c : pour dire qu'on ne veut pas effectuer de linkage
# -ansi : Pour l'utilisation du C-ANSI
# -pedantic : Pour une d�claration stricte
# -I : pour ajouter des r�pertoires aux r�pertoires d'include courant
# -Wall : Pour ajouter tout un tas de warning lors de la compilation
# -o : pour sp�cifer le nom du fichier g�n�r�
#--------------------------------------------------------------------
CC_OPTIONS=-c -ansi -pedantic -D_SVID_SOURCE -D_BSD_SOURCE -I. -I../COMMON -Wall -o

# Les options de linkage :
# -o : le mon du fichier produit
#-------------------------------
LD_OPTION=-o

#---< D�claration des variables de programmes >--------------------------------#

CC_PRG=gcc
LD_PRG=gcc

#---< Initialisation des variables de d�signation des cibles >-----------------#

OBJECT_FILES=\

RESULT_EXE=\

RESULT_LIB=\

#---< D�claration de la cible primaire >---------------------------------------#

All: ${RESULT_EXE}

RebuildAll: DeleteAll All

DeleteAll:
   rm -f ${RESULT_EXE} ${RESULT_LIB} ${OBJECT_LIB}

#---< D�claration des cibles secondaires >-------------------------------------#

#---< Fin du fichier >---------------------------------------------------------#
