
#!/bin/bash

# Функция: Очистка ( полная, включая промотку вверх ) экрана терминала 
function cv() { (clear && clear) }


# Очистка ( не полная, не включая промотку вверх ) экрана терминала 
function c() { (clear) }


# Функция: User
function im() { whoami ; } ;


function wis() { (GLIG_ASTRX_ON && wis-f) } ;