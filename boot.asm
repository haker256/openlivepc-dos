BITS 16
jmp short start ; Переход к метке с пропуском описания диска
nop ; Дополнение перед описанием диска
%include "bpb.asm"
start:
mov ax, 07C0h ; Адрес загрузки
mov ds, ax ; Сегмент данных
mov ax, 9000h ; Подготовка стека
mov ss, ax
mov sp, 0FFFFh ; Стек растет вниз!
cld ; Установка флага направления
mov si, kern_filename
call load_file
jmp 2000h:0000h ; Переход к загруженному из файла бинарному коду ядра ОС
kern_filename db "MYKERNELBIN"
%include "disk.asm"
times 510-($-$$) db 0 ; Дополнение бинарного кода нулями до 510 байт
dw 0AA55h ; Метка окончания бинарного кода системного загрузчика
buffer: ; Начало буфера для содержимого диска
