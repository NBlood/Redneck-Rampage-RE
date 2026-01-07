.386

_DATA SEGMENT BYTE PUBLIC USE32 'DATA'

EXTRN _prev_timer2:WORD
EXTRN _sync_time:DWORD
EXTRN _sync_wait_quanta:DWORD
EXTRN _snd_8to16:WORD
EXTRN _nf_buf_prv:DWORD
EXTRN _nf_buf_cur:DWORD
EXTRN _nf_fqty:BYTE
EXTRN _nf_new_x:DWORD
EXTRN _nf_new_w:DWORD
EXTRN _nf_new_y:DWORD
EXTRN _nf_new_h:DWORD
EXTRN _nf_new_row0:DWORD
EXTRN _nf_width:DWORD
EXTRN _nf_new_line:DWORD
EXTRN _nf_back_right:DWORD
EXTRN _nf_hicolor:DWORD
EXTRN _opt_hscale_step:DWORD
EXTRN _opt_hscale_adj:DWORD
EXTRN _sf_LineWidth:DWORD
EXTRN _sf_SetBank:DWORD
EXTRN _sf_WriteWinLimit:DWORD
EXTRN _sf_WinGran:DWORD
EXTRN _sf_WriteWinPtr:DWORD
EXTRN _sf_WinGranPerSize:DWORD
EXTRN _sf_WriteWin:DWORD
EXTRN _sf_WinSize:DWORD
EXTRN _pal15_tbl:BYTE
EXTRN _pal_tbl:BYTE

dword_124484 dd 256 dup (0)
word_124884	dw 0F8F8h, 0F8F9h, 0F8FAh, 0F8FBh, 0F8FCh, 0F8FDh, 0F8FEh
		dw 0F8FFh, 0F800h, 0F801h, 0F802h, 0F803h, 0F804h, 0F805h
		dw 0F806h, 0F807h, 0F9F8h, 0F9F9h, 0F9FAh, 0F9FBh, 0F9FCh
		dw 0F9FDh, 0F9FEh, 0F9FFh, 0F900h, 0F901h, 0F902h, 0F903h
		dw 0F904h, 0F905h, 0F906h, 0F907h, 0FAF8h, 0FAF9h, 0FAFAh
		dw 0FAFBh, 0FAFCh, 0FAFDh, 0FAFEh, 0FAFFh, 0FA00h, 0FA01h
		dw 0FA02h, 0FA03h, 0FA04h, 0FA05h, 0FA06h, 0FA07h, 0FBF8h
		dw 0FBF9h, 0FBFAh, 0FBFBh, 0FBFCh, 0FBFDh, 0FBFEh, 0FBFFh
		dw 0FB00h, 0FB01h, 0FB02h, 0FB03h, 0FB04h, 0FB05h, 0FB06h
		dw 0FB07h, 0FCF8h, 0FCF9h, 0FCFAh, 0FCFBh, 0FCFCh, 0FCFDh
		dw 0FCFEh, 0FCFFh, 0FC00h, 0FC01h, 0FC02h, 0FC03h, 0FC04h
		dw 0FC05h, 0FC06h, 0FC07h, 0FDF8h, 0FDF9h, 0FDFAh, 0FDFBh
		dw 0FDFCh, 0FDFDh, 0FDFEh, 0FDFFh, 0FD00h, 0FD01h, 0FD02h
		dw 0FD03h, 0FD04h, 0FD05h, 0FD06h, 0FD07h, 0FEF8h, 0FEF9h
		dw 0FEFAh, 0FEFBh, 0FEFCh, 0FEFDh, 0FEFEh, 0FEFFh, 0FE00h
		dw 0FE01h, 0FE02h, 0FE03h, 0FE04h, 0FE05h, 0FE06h, 0FE07h
		dw 0FFF8h, 0FFF9h, 0FFFAh, 0FFFBh, 0FFFCh, 0FFFDh, 0FFFEh
		dw 0FFFFh, 0FF00h, 0FF01h, 0FF02h, 0FF03h, 0FF04h, 0FF05h
		dw 0FF06h, 0FF07h, 0F8h, 0F9h, 0FAh, 0FBh, 0FCh, 0FDh
		dw 0FEh, 0FFh, 0, 1, 2,	3, 4, 5, 6, 7, 1F8h, 1F9h, 1FAh
		dw 1FBh, 1FCh, 1FDh, 1FEh, 1FFh, 100h, 101h, 102h, 103h
		dw 104h, 105h, 106h, 107h, 2F8h, 2F9h, 2FAh, 2FBh, 2FCh
		dw 2FDh, 2FEh, 2FFh, 200h, 201h, 202h, 203h, 204h, 205h
		dw 206h, 207h, 3F8h, 3F9h, 3FAh, 3FBh, 3FCh, 3FDh, 3FEh
		dw 3FFh, 300h, 301h, 302h, 303h, 304h, 305h, 306h, 307h
		dw 4F8h, 4F9h, 4FAh, 4FBh, 4FCh, 4FDh, 4FEh, 4FFh, 400h
		dw 401h, 402h, 403h, 404h, 405h, 406h, 407h, 5F8h, 5F9h
		dw 5FAh, 5FBh, 5FCh, 5FDh, 5FEh, 5FFh, 500h, 501h, 502h
		dw 503h, 504h, 505h, 506h, 507h, 6F8h, 6F9h, 6FAh, 6FBh
		dw 6FCh, 6FDh, 6FEh, 6FFh, 600h, 601h, 602h, 603h, 604h
		dw 605h, 606h, 607h, 7F8h, 7F9h, 7FAh, 7FBh, 7FCh, 7FDh
		dw 7FEh, 7FFh, 700h, 701h, 702h, 703h, 704h, 705h, 706h
		dw 707h
word_124A84	dw 8, 9, 0Ah, 0Bh, 0Ch,	0Dh, 0Eh, 108h,	109h, 10Ah, 10Bh
		dw 10Ch, 10Dh, 10Eh, 208h, 209h, 20Ah, 20Bh, 20Ch, 20Dh
		dw 20Eh, 308h, 309h, 30Ah, 30Bh, 30Ch, 30Dh, 30Eh, 408h
		dw 409h, 40Ah, 40Bh, 40Ch, 40Dh, 40Eh, 508h, 509h, 50Ah
		dw 50Bh, 50Ch, 50Dh, 50Eh, 608h, 609h, 60Ah, 60Bh, 60Ch
		dw 60Dh, 60Eh, 708h, 709h, 70Ah, 70Bh, 70Ch, 70Dh, 70Eh
		dw 8F2h, 8F3h, 8F4h, 8F5h, 8F6h, 8F7h, 8F8h, 8F9h, 8FAh
		dw 8FBh, 8FCh, 8FDh, 8FEh, 8FFh, 800h, 801h, 802h, 803h
		dw 804h, 805h, 806h, 807h, 808h, 809h, 80Ah, 80Bh, 80Ch
		dw 80Dh, 80Eh, 9F2h, 9F3h, 9F4h, 9F5h, 9F6h, 9F7h, 9F8h
		dw 9F9h, 9FAh, 9FBh, 9FCh, 9FDh, 9FEh, 9FFh, 900h, 901h
		dw 902h, 903h, 904h, 905h, 906h, 907h, 908h, 909h, 90Ah
		dw 90Bh, 90Ch, 90Dh, 90Eh, 0AF2h, 0AF3h, 0AF4h,	0AF5h
		dw 0AF6h, 0AF7h, 0AF8h,	0AF9h, 0AFAh, 0AFBh, 0AFCh, 0AFDh
		dw 0AFEh, 0AFFh, 0A00h,	0A01h, 0A02h, 0A03h, 0A04h, 0A05h
		dw 0A06h, 0A07h, 0A08h,	0A09h, 0A0Ah, 0A0Bh, 0A0Ch, 0A0Dh
		dw 0A0Eh, 0BF2h, 0BF3h,	0BF4h, 0BF5h, 0BF6h, 0BF7h, 0BF8h
		dw 0BF9h, 0BFAh, 0BFBh,	0BFCh, 0BFDh, 0BFEh, 0BFFh, 0B00h
		dw 0B01h, 0B02h, 0B03h,	0B04h, 0B05h, 0B06h, 0B07h, 0B08h
		dw 0B09h, 0B0Ah, 0B0Bh,	0B0Ch, 0B0Dh, 0B0Eh, 0CF2h, 0CF3h
		dw 0CF4h, 0CF5h, 0CF6h,	0CF7h, 0CF8h, 0CF9h, 0CFAh, 0CFBh
		dw 0CFCh, 0CFDh, 0CFEh,	0CFFh, 0C00h, 0C01h, 0C02h, 0C03h
		dw 0C04h, 0C05h, 0C06h,	0C07h, 0C08h, 0C09h, 0C0Ah, 0C0Bh
		dw 0C0Ch, 0C0Dh, 0C0Eh,	0DF2h, 0DF3h, 0DF4h, 0DF5h, 0DF6h
		dw 0DF7h, 0DF8h, 0DF9h,	0DFAh, 0DFBh, 0DFCh, 0DFDh, 0DFEh
		dw 0DFFh, 0D00h, 0D01h,	0D02h, 0D03h, 0D04h, 0D05h, 0D06h
		dw 0D07h, 0D08h, 0D09h,	0D0Ah, 0D0Bh, 0D0Ch, 0D0Dh, 0D0Eh
		dw 0EF2h, 0EF3h, 0EF4h,	0EF5h, 0EF6h, 0EF7h, 0EF8h, 0EF9h
		dw 0EFAh, 0EFBh, 0EFCh,	0EFDh, 0EFEh, 0EFFh, 0E00h, 0E01h
		dw 0E02h, 0E03h, 0E04h,	0E05h, 0E06h, 0E07h, 0E08h, 0E09h
		dw 0E0Ah, 0E0Bh
byte_124C84	db 0C3h, 0C3h, 0C3h, 0C3h, 0C3h, 0C1h, 0C3h, 0C3h, 0C1h
		db 0C3h, 0C3h, 0C3h, 0C1h, 0C1h, 0C3h, 0C3h, 0C3h, 0C3h
		db 0C3h, 0C1h, 0C3h, 0C1h, 0C3h, 0C1h, 0C1h, 0C3h, 0C3h
		db 0C1h, 0C1h, 0C1h, 0C3h, 0C1h, 0C3h, 0C3h, 0C1h, 0C3h
		db 0C3h, 0C1h, 0C1h, 0C3h, 0C1h, 0C3h, 0C1h, 0C3h, 0C1h
		db 0C1h, 0C1h, 0C3h, 0C3h, 0C3h, 0C1h, 0C1h, 0C3h, 0C1h
		db 0C1h, 0C1h, 0C1h, 0C3h, 0C1h, 0C1h, 0C1h, 0C1h, 0C1h
		db 0C1h
byte_124CC4	db 0C3h, 0C3h, 0C3h, 0C3h, 0C3h, 0C2h, 0C3h, 0C3h, 0C3h
		db 0C1h, 0C3h, 0C3h, 0C3h, 0C5h, 0C3h, 0C3h, 0C2h, 0C3h
		db 0C3h, 0C3h, 0C2h, 0C2h, 0C3h, 0C3h, 0C2h, 0C1h, 0C3h
		db 0C3h, 0C2h, 0C5h, 0C3h, 0C3h, 0C1h, 0C3h, 0C3h, 0C3h
		db 0C1h, 0C2h, 0C3h, 0C3h, 0C1h, 0C1h, 0C3h, 0C3h, 0C1h
		db 0C5h, 0C3h, 0C3h, 0C5h, 0C3h, 0C3h, 0C3h, 0C5h, 0C2h
		db 0C3h, 0C3h, 0C5h, 0C1h, 0C3h, 0C3h, 0C5h, 0C5h, 0C3h
		db 0C3h, 0C3h, 0C3h, 0C3h, 0C2h, 0C3h, 0C2h, 0C3h, 0C2h
		db 0C3h, 0C1h, 0C3h, 0C2h, 0C3h, 0C5h, 0C3h, 0C2h, 0C2h
		db 0C3h, 0C3h, 0C2h, 0C2h, 0C2h, 0C3h, 0C2h, 0C2h, 0C1h
		db 0C3h, 0C2h, 0C2h, 0C5h, 0C3h, 0C2h, 0C1h, 0C3h, 0C3h
		db 0C2h, 0C1h, 0C2h, 0C3h, 0C2h, 0C1h, 0C1h, 0C3h, 0C2h
		db 0C1h, 0C5h, 0C3h, 0C2h, 0C5h, 0C3h, 0C3h, 0C2h, 0C5h
		db 0C2h, 0C3h, 0C2h, 0C5h, 0C1h, 0C3h, 0C2h, 0C5h, 0C5h
		db 0C3h, 0C2h, 0C3h, 0C3h, 0C3h, 0C1h, 0C3h, 0C2h, 0C3h
		db 0C1h, 0C3h, 0C1h, 0C3h, 0C1h, 0C3h, 0C5h, 0C3h, 0C1h
		db 0C2h, 0C3h, 0C3h, 0C1h, 0C2h, 0C2h, 0C3h, 0C1h, 0C2h
		db 0C1h, 0C3h, 0C1h, 0C2h, 0C5h, 0C3h, 0C1h, 0C1h, 0C3h
		db 0C3h, 0C1h, 0C1h, 0C2h, 0C3h, 0C1h, 0C1h, 0C1h, 0C3h
		db 0C1h, 0C1h, 0C5h, 0C3h, 0C1h, 0C5h, 0C3h, 0C3h, 0C1h
		db 0C5h, 0C2h, 0C3h, 0C1h, 0C5h, 0C1h, 0C3h, 0C1h, 0C5h
		db 0C5h, 0C3h, 0C1h, 0C3h, 0C3h, 0C3h, 0C5h, 0C3h, 0C2h
		db 0C3h, 0C5h, 0C3h, 0C1h, 0C3h, 0C5h, 0C3h, 0C5h, 0C3h
		db 0C5h, 0C2h, 0C3h, 0C3h, 0C5h, 0C2h, 0C2h, 0C3h, 0C5h
		db 0C2h, 0C1h, 0C3h, 0C5h, 0C2h, 0C5h, 0C3h, 0C5h, 0C1h
		db 0C3h, 0C3h, 0C5h, 0C1h, 0C2h, 0C3h, 0C5h, 0C1h, 0C1h
		db 0C3h, 0C5h, 0C1h, 0C5h, 0C3h, 0C5h, 0C5h, 0C3h, 0C3h
		db 0C5h, 0C5h, 0C2h, 0C3h, 0C5h, 0C5h, 0C1h, 0C3h, 0C5h
		db 0C5h, 0C5h, 0C3h, 0C5h, 0C3h, 0C3h, 0C2h, 0C3h, 0C3h
		db 0C2h, 0C2h, 0C3h, 0C3h, 0C1h, 0C2h, 0C3h, 0C3h, 0C5h
		db 0C2h, 0C3h, 0C2h, 0C3h, 0C2h, 0C3h, 0C2h, 0C2h, 0C2h
		db 0C3h, 0C2h, 0C1h, 0C2h, 0C3h, 0C2h, 0C5h, 0C2h, 0C3h
		db 0C1h, 0C3h, 0C2h, 0C3h, 0C1h, 0C2h, 0C2h, 0C3h, 0C1h
		db 0C1h, 0C2h, 0C3h, 0C1h, 0C5h, 0C2h, 0C3h, 0C5h, 0C3h
		db 0C2h, 0C3h, 0C5h, 0C2h, 0C2h, 0C3h, 0C5h, 0C1h, 0C2h
		db 0C3h, 0C5h, 0C5h, 0C2h, 0C3h, 0C3h, 0C3h, 0C2h, 0C2h
		db 0C3h, 0C2h, 0C2h, 0C2h, 0C3h, 0C1h, 0C2h, 0C2h, 0C3h
		db 0C5h, 0C2h, 0C2h, 0C2h, 0C3h, 0C2h, 0C2h, 0C2h, 0C2h
		db 0C2h, 0C2h, 0C2h, 0C1h, 0C2h, 0C2h, 0C2h, 0C5h, 0C2h
		db 0C2h, 0C1h, 0C3h, 0C2h, 0C2h, 0C1h, 0C2h, 0C2h, 0C2h
		db 0C1h, 0C1h, 0C2h, 0C2h, 0C1h, 0C5h, 0C2h, 0C2h, 0C5h
		db 0C3h, 0C2h, 0C2h, 0C5h, 0C2h, 0C2h, 0C2h, 0C5h, 0C1h
		db 0C2h, 0C2h, 0C5h, 0C5h, 0C2h, 0C2h, 0C3h, 0C3h, 0C2h
		db 0C1h, 0C3h, 0C2h, 0C2h, 0C1h, 0C3h, 0C1h, 0C2h, 0C1h
		db 0C3h, 0C5h, 0C2h, 0C1h, 0C2h, 0C3h, 0C2h, 0C1h, 0C2h
		db 0C2h, 0C2h, 0C1h, 0C2h, 0C1h, 0C2h, 0C1h, 0C2h, 0C5h
		db 0C2h, 0C1h, 0C1h, 0C3h, 0C2h, 0C1h, 0C1h, 0C2h, 0C2h
		db 0C1h, 0C1h, 0C1h, 0C2h, 0C1h, 0C1h, 0C5h, 0C2h, 0C1h
		db 0C5h, 0C3h, 0C2h, 0C1h, 0C5h, 0C2h, 0C2h, 0C1h, 0C5h
		db 0C1h, 0C2h, 0C1h, 0C5h, 0C5h, 0C2h, 0C1h, 0C3h, 0C3h
		db 0C2h, 0C5h, 0C3h, 0C2h, 0C2h, 0C5h, 0C3h, 0C1h, 0C2h
		db 0C5h, 0C3h, 0C5h, 0C2h, 0C5h, 0C2h, 0C3h, 0C2h, 0C5h
		db 0C2h, 0C2h, 0C2h, 0C5h, 0C2h, 0C1h, 0C2h, 0C5h, 0C2h
		db 0C5h, 0C2h, 0C5h, 0C1h, 0C3h, 0C2h, 0C5h, 0C1h, 0C2h
		db 0C2h, 0C5h, 0C1h, 0C1h, 0C2h, 0C5h, 0C1h, 0C5h, 0C2h
		db 0C5h, 0C5h, 0C3h, 0C2h, 0C5h, 0C5h, 0C2h, 0C2h, 0C5h
		db 0C5h, 0C1h, 0C2h, 0C5h, 0C5h, 0C5h, 0C2h, 0C5h, 0C3h
		db 0C3h, 0C1h, 0C3h, 0C3h, 0C2h, 0C1h, 0C3h, 0C3h, 0C1h
		db 0C1h, 0C3h, 0C3h, 0C5h, 0C1h, 0C3h, 0C2h, 0C3h, 0C1h
		db 0C3h, 0C2h, 0C2h, 0C1h, 0C3h, 0C2h, 0C1h, 0C1h, 0C3h
		db 0C2h, 0C5h, 0C1h, 0C3h, 0C1h, 0C3h, 0C1h, 0C3h, 0C1h
		db 0C2h, 0C1h, 0C3h, 0C1h, 0C1h, 0C1h, 0C3h, 0C1h, 0C5h
		db 0C1h, 0C3h, 0C5h, 0C3h, 0C1h, 0C3h, 0C5h, 0C2h, 0C1h
		db 0C3h, 0C5h, 0C1h, 0C1h, 0C3h, 0C5h, 0C5h, 0C1h, 0C3h
		db 0C3h, 0C3h, 0C1h, 0C2h, 0C3h, 0C2h, 0C1h, 0C2h, 0C3h
		db 0C1h, 0C1h, 0C2h, 0C3h, 0C5h, 0C1h, 0C2h, 0C2h, 0C3h
		db 0C1h, 0C2h, 0C2h, 0C2h, 0C1h, 0C2h, 0C2h, 0C1h, 0C1h
		db 0C2h, 0C2h, 0C5h, 0C1h, 0C2h, 0C1h, 0C3h, 0C1h, 0C2h
		db 0C1h, 0C2h, 0C1h, 0C2h, 0C1h, 0C1h, 0C1h, 0C2h, 0C1h
		db 0C5h, 0C1h, 0C2h, 0C5h, 0C3h, 0C1h, 0C2h, 0C5h, 0C2h
		db 0C1h, 0C2h, 0C5h, 0C1h, 0C1h, 0C2h, 0C5h, 0C5h, 0C1h
		db 0C2h, 0C3h, 0C3h, 0C1h, 0C1h, 0C3h, 0C2h, 0C1h, 0C1h
		db 0C3h, 0C1h, 0C1h, 0C1h, 0C3h, 0C5h, 0C1h, 0C1h, 0C2h
		db 0C3h, 0C1h, 0C1h, 0C2h, 0C2h, 0C1h, 0C1h, 0C2h, 0C1h
		db 0C1h, 0C1h, 0C2h, 0C5h, 0C1h, 0C1h, 0C1h, 0C3h, 0C1h
		db 0C1h, 0C1h, 0C2h, 0C1h, 0C1h, 0C1h, 0C1h, 0C1h, 0C1h
		db 0C1h, 0C5h, 0C1h, 0C1h, 0C5h, 0C3h, 0C1h, 0C1h, 0C5h
		db 0C2h, 0C1h, 0C1h, 0C5h, 0C1h, 0C1h, 0C1h, 0C5h, 0C5h
		db 0C1h, 0C1h, 0C3h, 0C3h, 0C1h, 0C5h, 0C3h, 0C2h, 0C1h
		db 0C5h, 0C3h, 0C1h, 0C1h, 0C5h, 0C3h, 0C5h, 0C1h, 0C5h
		db 0C2h, 0C3h, 0C1h, 0C5h, 0C2h, 0C2h, 0C1h, 0C5h, 0C2h
		db 0C1h, 0C1h, 0C5h, 0C2h, 0C5h, 0C1h, 0C5h, 0C1h, 0C3h
		db 0C1h, 0C5h, 0C1h, 0C2h, 0C1h, 0C5h, 0C1h, 0C1h, 0C1h
		db 0C5h, 0C1h, 0C5h, 0C1h, 0C5h, 0C5h, 0C3h, 0C1h, 0C5h
		db 0C5h, 0C2h, 0C1h, 0C5h, 0C5h, 0C1h, 0C1h, 0C5h, 0C5h
		db 0C5h, 0C1h, 0C5h, 0C3h, 0C3h, 0C5h, 0C3h, 0C3h, 0C2h
		db 0C5h, 0C3h, 0C3h, 0C1h, 0C5h, 0C3h, 0C3h, 0C5h, 0C5h
		db 0C3h, 0C2h, 0C3h, 0C5h, 0C3h, 0C2h, 0C2h, 0C5h, 0C3h
		db 0C2h, 0C1h, 0C5h, 0C3h, 0C2h, 0C5h, 0C5h, 0C3h, 0C1h
		db 0C3h, 0C5h, 0C3h, 0C1h, 0C2h, 0C5h, 0C3h, 0C1h, 0C1h
		db 0C5h, 0C3h, 0C1h, 0C5h, 0C5h, 0C3h, 0C5h, 0C3h, 0C5h
		db 0C3h, 0C5h, 0C2h, 0C5h, 0C3h, 0C5h, 0C1h, 0C5h, 0C3h
		db 0C5h, 0C5h, 0C5h, 0C3h, 0C3h, 0C3h, 0C5h, 0C2h, 0C3h
		db 0C2h, 0C5h, 0C2h, 0C3h, 0C1h, 0C5h, 0C2h, 0C3h, 0C5h
		db 0C5h, 0C2h, 0C2h, 0C3h, 0C5h, 0C2h, 0C2h, 0C2h, 0C5h
		db 0C2h, 0C2h, 0C1h, 0C5h, 0C2h, 0C2h, 0C5h, 0C5h, 0C2h
		db 0C1h, 0C3h, 0C5h, 0C2h, 0C1h, 0C2h, 0C5h, 0C2h, 0C1h
		db 0C1h, 0C5h, 0C2h, 0C1h, 0C5h, 0C5h, 0C2h, 0C5h, 0C3h
		db 0C5h, 0C2h, 0C5h, 0C2h, 0C5h, 0C2h, 0C5h, 0C1h, 0C5h
		db 0C2h, 0C5h, 0C5h, 0C5h, 0C2h, 0C3h, 0C3h, 0C5h, 0C1h
		db 0C3h, 0C2h, 0C5h, 0C1h, 0C3h, 0C1h, 0C5h, 0C1h, 0C3h
		db 0C5h, 0C5h, 0C1h, 0C2h, 0C3h, 0C5h, 0C1h, 0C2h, 0C2h
		db 0C5h, 0C1h, 0C2h, 0C1h, 0C5h, 0C1h, 0C2h, 0C5h, 0C5h
		db 0C1h, 0C1h, 0C3h, 0C5h, 0C1h, 0C1h, 0C2h, 0C5h, 0C1h
		db 0C1h, 0C1h, 0C5h, 0C1h, 0C1h, 0C5h, 0C5h, 0C1h, 0C5h
		db 0C3h, 0C5h, 0C1h, 0C5h, 0C2h, 0C5h, 0C1h, 0C5h, 0C1h
		db 0C5h, 0C1h, 0C5h, 0C5h, 0C5h, 0C1h, 0C3h, 0C3h, 0C5h
		db 0C5h, 0C3h, 0C2h, 0C5h, 0C5h, 0C3h, 0C1h, 0C5h, 0C5h
		db 0C3h, 0C5h, 0C5h, 0C5h, 0C2h, 0C3h, 0C5h, 0C5h, 0C2h
		db 0C2h, 0C5h, 0C5h, 0C2h, 0C1h, 0C5h, 0C5h, 0C2h, 0C5h
		db 0C5h, 0C5h, 0C1h, 0C3h, 0C5h, 0C5h, 0C1h, 0C2h, 0C5h
		db 0C5h, 0C1h, 0C1h, 0C5h, 0C5h, 0C1h, 0C5h, 0C5h, 0C5h
		db 0C5h, 0C3h, 0C5h, 0C5h, 0C5h, 0C2h, 0C5h, 0C5h, 0C5h
		db 0C1h, 0C5h, 0C5h, 0C5h, 0C5h, 0C5h, 0C5h
byte_1250C4	db 0C3h, 0E3h, 0C3h, 0E3h, 0C3h, 0E3h, 0C7h, 0E3h, 0C3h
		db 0E3h, 0C1h, 0E3h, 0C3h, 0E3h, 0C5h, 0E3h, 0C3h, 0E3h
		db 0C3h, 0E7h, 0C3h, 0E3h, 0C7h, 0E7h, 0C3h, 0E3h, 0C1h
		db 0E7h, 0C3h, 0E3h, 0C5h, 0E7h, 0C3h, 0E3h, 0C3h, 0E1h
		db 0C3h, 0E3h, 0C7h, 0E1h, 0C3h, 0E3h, 0C1h, 0E1h, 0C3h
		db 0E3h, 0C5h, 0E1h, 0C3h, 0E3h, 0C3h, 0E5h, 0C3h, 0E3h
		db 0C7h, 0E5h, 0C3h, 0E3h, 0C1h, 0E5h, 0C3h, 0E3h, 0C5h
		db 0E5h, 0C7h, 0E3h, 0C3h, 0E3h, 0C7h, 0E3h, 0C7h, 0E3h
		db 0C7h, 0E3h, 0C1h, 0E3h, 0C7h, 0E3h, 0C5h, 0E3h, 0C7h
		db 0E3h, 0C3h, 0E7h, 0C7h, 0E3h, 0C7h, 0E7h, 0C7h, 0E3h
		db 0C1h, 0E7h, 0C7h, 0E3h, 0C5h, 0E7h, 0C7h, 0E3h, 0C3h
		db 0E1h, 0C7h, 0E3h, 0C7h, 0E1h, 0C7h, 0E3h, 0C1h, 0E1h
		db 0C7h, 0E3h, 0C5h, 0E1h, 0C7h, 0E3h, 0C3h, 0E5h, 0C7h
		db 0E3h, 0C7h, 0E5h, 0C7h, 0E3h, 0C1h, 0E5h, 0C7h, 0E3h
		db 0C5h, 0E5h, 0C1h, 0E3h, 0C3h, 0E3h, 0C1h, 0E3h, 0C7h
		db 0E3h, 0C1h, 0E3h, 0C1h, 0E3h, 0C1h, 0E3h, 0C5h, 0E3h
		db 0C1h, 0E3h, 0C3h, 0E7h, 0C1h, 0E3h, 0C7h, 0E7h, 0C1h
		db 0E3h, 0C1h, 0E7h, 0C1h, 0E3h, 0C5h, 0E7h, 0C1h, 0E3h
		db 0C3h, 0E1h, 0C1h, 0E3h, 0C7h, 0E1h, 0C1h, 0E3h, 0C1h
		db 0E1h, 0C1h, 0E3h, 0C5h, 0E1h, 0C1h, 0E3h, 0C3h, 0E5h
		db 0C1h, 0E3h, 0C7h, 0E5h, 0C1h, 0E3h, 0C1h, 0E5h, 0C1h
		db 0E3h, 0C5h, 0E5h, 0C5h, 0E3h, 0C3h, 0E3h, 0C5h, 0E3h
		db 0C7h, 0E3h, 0C5h, 0E3h, 0C1h, 0E3h, 0C5h, 0E3h, 0C5h
		db 0E3h, 0C5h, 0E3h, 0C3h, 0E7h, 0C5h, 0E3h, 0C7h, 0E7h
		db 0C5h, 0E3h, 0C1h, 0E7h, 0C5h, 0E3h, 0C5h, 0E7h, 0C5h
		db 0E3h, 0C3h, 0E1h, 0C5h, 0E3h, 0C7h, 0E1h, 0C5h, 0E3h
		db 0C1h, 0E1h, 0C5h, 0E3h, 0C5h, 0E1h, 0C5h, 0E3h, 0C3h
		db 0E5h, 0C5h, 0E3h, 0C7h, 0E5h, 0C5h, 0E3h, 0C1h, 0E5h
		db 0C5h, 0E3h, 0C5h, 0E5h, 0C3h, 0E7h, 0C3h, 0E3h, 0C3h
		db 0E7h, 0C7h, 0E3h, 0C3h, 0E7h, 0C1h, 0E3h, 0C3h, 0E7h
		db 0C5h, 0E3h, 0C3h, 0E7h, 0C3h, 0E7h, 0C3h, 0E7h, 0C7h
		db 0E7h, 0C3h, 0E7h, 0C1h, 0E7h, 0C3h, 0E7h, 0C5h, 0E7h
		db 0C3h, 0E7h, 0C3h, 0E1h, 0C3h, 0E7h, 0C7h, 0E1h, 0C3h
		db 0E7h, 0C1h, 0E1h, 0C3h, 0E7h, 0C5h, 0E1h, 0C3h, 0E7h
		db 0C3h, 0E5h, 0C3h, 0E7h, 0C7h, 0E5h, 0C3h, 0E7h, 0C1h
		db 0E5h, 0C3h, 0E7h, 0C5h, 0E5h, 0C7h, 0E7h, 0C3h, 0E3h
		db 0C7h, 0E7h, 0C7h, 0E3h, 0C7h, 0E7h, 0C1h, 0E3h, 0C7h
		db 0E7h, 0C5h, 0E3h, 0C7h, 0E7h, 0C3h, 0E7h, 0C7h, 0E7h
		db 0C7h, 0E7h, 0C7h, 0E7h, 0C1h, 0E7h, 0C7h, 0E7h, 0C5h
		db 0E7h, 0C7h, 0E7h, 0C3h, 0E1h, 0C7h, 0E7h, 0C7h, 0E1h
		db 0C7h, 0E7h, 0C1h, 0E1h, 0C7h, 0E7h, 0C5h, 0E1h, 0C7h
		db 0E7h, 0C3h, 0E5h, 0C7h, 0E7h, 0C7h, 0E5h, 0C7h, 0E7h
		db 0C1h, 0E5h, 0C7h, 0E7h, 0C5h, 0E5h, 0C1h, 0E7h, 0C3h
		db 0E3h, 0C1h, 0E7h, 0C7h, 0E3h, 0C1h, 0E7h, 0C1h, 0E3h
		db 0C1h, 0E7h, 0C5h, 0E3h, 0C1h, 0E7h, 0C3h, 0E7h, 0C1h
		db 0E7h, 0C7h, 0E7h, 0C1h, 0E7h, 0C1h, 0E7h, 0C1h, 0E7h
		db 0C5h, 0E7h, 0C1h, 0E7h, 0C3h, 0E1h, 0C1h, 0E7h, 0C7h
		db 0E1h, 0C1h, 0E7h, 0C1h, 0E1h, 0C1h, 0E7h, 0C5h, 0E1h
		db 0C1h, 0E7h, 0C3h, 0E5h, 0C1h, 0E7h, 0C7h, 0E5h, 0C1h
		db 0E7h, 0C1h, 0E5h, 0C1h, 0E7h, 0C5h, 0E5h, 0C5h, 0E7h
		db 0C3h, 0E3h, 0C5h, 0E7h, 0C7h, 0E3h, 0C5h, 0E7h, 0C1h
		db 0E3h, 0C5h, 0E7h, 0C5h, 0E3h, 0C5h, 0E7h, 0C3h, 0E7h
		db 0C5h, 0E7h, 0C7h, 0E7h, 0C5h, 0E7h, 0C1h, 0E7h, 0C5h
		db 0E7h, 0C5h, 0E7h, 0C5h, 0E7h, 0C3h, 0E1h, 0C5h, 0E7h
		db 0C7h, 0E1h, 0C5h, 0E7h, 0C1h, 0E1h, 0C5h, 0E7h, 0C5h
		db 0E1h, 0C5h, 0E7h, 0C3h, 0E5h, 0C5h, 0E7h, 0C7h, 0E5h
		db 0C5h, 0E7h, 0C1h, 0E5h, 0C5h, 0E7h, 0C5h, 0E5h, 0C3h
		db 0E1h, 0C3h, 0E3h, 0C3h, 0E1h, 0C7h, 0E3h, 0C3h, 0E1h
		db 0C1h, 0E3h, 0C3h, 0E1h, 0C5h, 0E3h, 0C3h, 0E1h, 0C3h
		db 0E7h, 0C3h, 0E1h, 0C7h, 0E7h, 0C3h, 0E1h, 0C1h, 0E7h
		db 0C3h, 0E1h, 0C5h, 0E7h, 0C3h, 0E1h, 0C3h, 0E1h, 0C3h
		db 0E1h, 0C7h, 0E1h, 0C3h, 0E1h, 0C1h, 0E1h, 0C3h, 0E1h
		db 0C5h, 0E1h, 0C3h, 0E1h, 0C3h, 0E5h, 0C3h, 0E1h, 0C7h
		db 0E5h, 0C3h, 0E1h, 0C1h, 0E5h, 0C3h, 0E1h, 0C5h, 0E5h
		db 0C7h, 0E1h, 0C3h, 0E3h, 0C7h, 0E1h, 0C7h, 0E3h, 0C7h
		db 0E1h, 0C1h, 0E3h, 0C7h, 0E1h, 0C5h, 0E3h, 0C7h, 0E1h
		db 0C3h, 0E7h, 0C7h, 0E1h, 0C7h, 0E7h, 0C7h, 0E1h, 0C1h
		db 0E7h, 0C7h, 0E1h, 0C5h, 0E7h, 0C7h, 0E1h, 0C3h, 0E1h
		db 0C7h, 0E1h, 0C7h, 0E1h, 0C7h, 0E1h, 0C1h, 0E1h, 0C7h
		db 0E1h, 0C5h, 0E1h, 0C7h, 0E1h, 0C3h, 0E5h, 0C7h, 0E1h
		db 0C7h, 0E5h, 0C7h, 0E1h, 0C1h, 0E5h, 0C7h, 0E1h, 0C5h
		db 0E5h, 0C1h, 0E1h, 0C3h, 0E3h, 0C1h, 0E1h, 0C7h, 0E3h
		db 0C1h, 0E1h, 0C1h, 0E3h, 0C1h, 0E1h, 0C5h, 0E3h, 0C1h
		db 0E1h, 0C3h, 0E7h, 0C1h, 0E1h, 0C7h, 0E7h, 0C1h, 0E1h
		db 0C1h, 0E7h, 0C1h, 0E1h, 0C5h, 0E7h, 0C1h, 0E1h, 0C3h
		db 0E1h, 0C1h, 0E1h, 0C7h, 0E1h, 0C1h, 0E1h, 0C1h, 0E1h
		db 0C1h, 0E1h, 0C5h, 0E1h, 0C1h, 0E1h, 0C3h, 0E5h, 0C1h
		db 0E1h, 0C7h, 0E5h, 0C1h, 0E1h, 0C1h, 0E5h, 0C1h, 0E1h
		db 0C5h, 0E5h, 0C5h, 0E1h, 0C3h, 0E3h, 0C5h, 0E1h, 0C7h
		db 0E3h, 0C5h, 0E1h, 0C1h, 0E3h, 0C5h, 0E1h, 0C5h, 0E3h
		db 0C5h, 0E1h, 0C3h, 0E7h, 0C5h, 0E1h, 0C7h, 0E7h, 0C5h
		db 0E1h, 0C1h, 0E7h, 0C5h, 0E1h, 0C5h, 0E7h, 0C5h, 0E1h
		db 0C3h, 0E1h, 0C5h, 0E1h, 0C7h, 0E1h, 0C5h, 0E1h, 0C1h
		db 0E1h, 0C5h, 0E1h, 0C5h, 0E1h, 0C5h, 0E1h, 0C3h, 0E5h
		db 0C5h, 0E1h, 0C7h, 0E5h, 0C5h, 0E1h, 0C1h, 0E5h, 0C5h
		db 0E1h, 0C5h, 0E5h, 0C3h, 0E5h, 0C3h, 0E3h, 0C3h, 0E5h
		db 0C7h, 0E3h, 0C3h, 0E5h, 0C1h, 0E3h, 0C3h, 0E5h, 0C5h
		db 0E3h, 0C3h, 0E5h, 0C3h, 0E7h, 0C3h, 0E5h, 0C7h, 0E7h
		db 0C3h, 0E5h, 0C1h, 0E7h, 0C3h, 0E5h, 0C5h, 0E7h, 0C3h
		db 0E5h, 0C3h, 0E1h, 0C3h, 0E5h, 0C7h, 0E1h, 0C3h, 0E5h
		db 0C1h, 0E1h, 0C3h, 0E5h, 0C5h, 0E1h, 0C3h, 0E5h, 0C3h
		db 0E5h, 0C3h, 0E5h, 0C7h, 0E5h, 0C3h, 0E5h, 0C1h, 0E5h
		db 0C3h, 0E5h, 0C5h, 0E5h, 0C7h, 0E5h, 0C3h, 0E3h, 0C7h
		db 0E5h, 0C7h, 0E3h, 0C7h, 0E5h, 0C1h, 0E3h, 0C7h, 0E5h
		db 0C5h, 0E3h, 0C7h, 0E5h, 0C3h, 0E7h, 0C7h, 0E5h, 0C7h
		db 0E7h, 0C7h, 0E5h, 0C1h, 0E7h, 0C7h, 0E5h, 0C5h, 0E7h
		db 0C7h, 0E5h, 0C3h, 0E1h, 0C7h, 0E5h, 0C7h, 0E1h, 0C7h
		db 0E5h, 0C1h, 0E1h, 0C7h, 0E5h, 0C5h, 0E1h, 0C7h, 0E5h
		db 0C3h, 0E5h, 0C7h, 0E5h, 0C7h, 0E5h, 0C7h, 0E5h, 0C1h
		db 0E5h, 0C7h, 0E5h, 0C5h, 0E5h, 0C1h, 0E5h, 0C3h, 0E3h
		db 0C1h, 0E5h, 0C7h, 0E3h, 0C1h, 0E5h, 0C1h, 0E3h, 0C1h
		db 0E5h, 0C5h, 0E3h, 0C1h, 0E5h, 0C3h, 0E7h, 0C1h, 0E5h
		db 0C7h, 0E7h, 0C1h, 0E5h, 0C1h, 0E7h, 0C1h, 0E5h, 0C5h
		db 0E7h, 0C1h, 0E5h, 0C3h, 0E1h, 0C1h, 0E5h, 0C7h, 0E1h
		db 0C1h, 0E5h, 0C1h, 0E1h, 0C1h, 0E5h, 0C5h, 0E1h, 0C1h
		db 0E5h, 0C3h, 0E5h, 0C1h, 0E5h, 0C7h, 0E5h, 0C1h, 0E5h
		db 0C1h, 0E5h, 0C1h, 0E5h, 0C5h, 0E5h, 0C5h, 0E5h, 0C3h
		db 0E3h, 0C5h, 0E5h, 0C7h, 0E3h, 0C5h, 0E5h, 0C1h, 0E3h
		db 0C5h, 0E5h, 0C5h, 0E3h, 0C5h, 0E5h, 0C3h, 0E7h, 0C5h
		db 0E5h, 0C7h, 0E7h, 0C5h, 0E5h, 0C1h, 0E7h, 0C5h, 0E5h
		db 0C5h, 0E7h, 0C5h, 0E5h, 0C3h, 0E1h, 0C5h, 0E5h, 0C7h
		db 0E1h, 0C5h, 0E5h, 0C1h, 0E1h, 0C5h, 0E5h, 0C5h, 0E1h
		db 0C5h, 0E5h, 0C3h, 0E5h, 0C5h, 0E5h, 0C7h, 0E5h, 0C5h
		db 0E5h, 0C1h, 0E5h, 0C5h, 0E5h, 0C5h, 0E5h
off_1254C4	dd offset L121
		dd offset L122
		dd offset L123
		dd offset L125
		dd offset L126
		dd offset L127
		dd offset L129
		dd offset L133
		dd offset L137
		dd offset L143
		dd offset L151
		dd offset L157
		dd offset L158
		dd offset L159
		dd offset L160
		dd offset L161
off_125504	dd offset L168
		dd offset L169
		dd offset L170
		dd offset L172
		dd offset L173
		dd offset L174
		dd offset L178
		dd offset L182
		dd offset L186
		dd offset L192
		dd offset L200
		dd offset L206
		dd offset L207
		dd offset L208
		dd offset L209
		dd offset L210
byte_125544	db 0C3h, 0C3h, 0C3h, 0C3h, 0C1h, 0C3h, 0C3h, 0C3h, 0C3h
		db 0C1h, 0C3h, 0C3h, 0C1h, 0C1h, 0C3h, 0C3h, 0C3h, 0C3h
		db 0C1h, 0C3h, 0C1h, 0C3h, 0C1h, 0C3h, 0C3h, 0C1h, 0C1h
		db 0C3h, 0C1h, 0C1h, 0C1h, 0C3h, 0C3h, 0C3h, 0C3h, 0C1h
		db 0C1h, 0C3h, 0C3h, 0C1h, 0C3h, 0C1h, 0C3h, 0C1h, 0C1h
		db 0C1h, 0C3h, 0C1h, 0C3h, 0C3h, 0C1h, 0C1h, 0C1h, 0C3h
		db 0C1h, 0C1h, 0C3h, 0C1h, 0C1h, 0C1h, 0C1h, 0C1h, 0C1h
		db 0C1h
byte_125584	db 5Fh,	5Fh, 5Fh, 5Fh, 57h, 5Fh, 5Fh, 5Fh, 4Fh,	5Fh, 5Fh
		db 5Fh,	6Fh, 5Fh, 5Fh, 5Fh, 5Fh, 57h, 5Fh, 5Fh,	57h, 57h
		db 5Fh,	5Fh, 4Fh, 57h, 5Fh, 5Fh, 6Fh, 57h, 5Fh,	5Fh, 5Fh
		db 4Fh,	5Fh, 5Fh, 57h, 4Fh, 5Fh, 5Fh, 4Fh, 4Fh,	5Fh, 5Fh
		db 6Fh,	4Fh, 5Fh, 5Fh, 5Fh, 6Fh, 5Fh, 5Fh, 57h,	6Fh, 5Fh
		db 5Fh,	4Fh, 6Fh, 5Fh, 5Fh, 6Fh, 6Fh, 5Fh, 5Fh,	5Fh, 5Fh
		db 57h,	5Fh, 57h, 5Fh, 57h, 5Fh, 4Fh, 5Fh, 57h,	5Fh, 6Fh
		db 5Fh,	57h, 5Fh, 5Fh, 57h, 57h, 5Fh, 57h, 57h,	57h, 5Fh
		db 4Fh,	57h, 57h, 5Fh, 6Fh, 57h, 57h, 5Fh, 5Fh,	4Fh, 57h
		db 5Fh,	57h, 4Fh, 57h, 5Fh, 4Fh, 4Fh, 57h, 5Fh,	6Fh, 4Fh
		db 57h,	5Fh, 5Fh, 6Fh, 57h, 5Fh, 57h, 6Fh, 57h,	5Fh, 4Fh
		db 6Fh,	57h, 5Fh, 6Fh, 6Fh, 57h, 5Fh, 5Fh, 5Fh,	4Fh, 5Fh
		db 57h,	5Fh, 4Fh, 5Fh, 4Fh, 5Fh, 4Fh, 5Fh, 6Fh,	5Fh, 4Fh
		db 5Fh,	5Fh, 57h, 4Fh, 5Fh, 57h, 57h, 4Fh, 5Fh,	4Fh, 57h
		db 4Fh,	5Fh, 6Fh, 57h, 4Fh, 5Fh, 5Fh, 4Fh, 4Fh,	5Fh, 57h
		db 4Fh,	4Fh, 5Fh, 4Fh, 4Fh, 4Fh, 5Fh, 6Fh, 4Fh,	4Fh, 5Fh
		db 5Fh,	6Fh, 4Fh, 5Fh, 57h, 6Fh, 4Fh, 5Fh, 4Fh,	6Fh, 4Fh
		db 5Fh,	6Fh, 6Fh, 4Fh, 5Fh, 5Fh, 5Fh, 6Fh, 5Fh,	57h, 5Fh
		db 6Fh,	5Fh, 4Fh, 5Fh, 6Fh, 5Fh, 6Fh, 5Fh, 6Fh,	5Fh, 5Fh
		db 57h,	6Fh, 5Fh, 57h, 57h, 6Fh, 5Fh, 4Fh, 57h,	6Fh, 5Fh
		db 6Fh,	57h, 6Fh, 5Fh, 5Fh, 4Fh, 6Fh, 5Fh, 57h,	4Fh, 6Fh
		db 5Fh,	4Fh, 4Fh, 6Fh, 5Fh, 6Fh, 4Fh, 6Fh, 5Fh,	5Fh, 6Fh
		db 6Fh,	5Fh, 57h, 6Fh, 6Fh, 5Fh, 4Fh, 6Fh, 6Fh,	5Fh, 6Fh
		db 6Fh,	6Fh, 5Fh, 5Fh, 5Fh, 5Fh, 57h, 57h, 5Fh,	5Fh, 57h
		db 4Fh,	5Fh, 5Fh, 57h, 6Fh, 5Fh, 5Fh, 57h, 5Fh,	57h, 5Fh
		db 57h,	57h, 57h, 5Fh, 57h, 4Fh, 57h, 5Fh, 57h,	6Fh, 57h
		db 5Fh,	57h, 5Fh, 4Fh, 5Fh, 57h, 57h, 4Fh, 5Fh,	57h, 4Fh
		db 4Fh,	5Fh, 57h, 6Fh, 4Fh, 5Fh, 57h, 5Fh, 6Fh,	5Fh, 57h
		db 57h,	6Fh, 5Fh, 57h, 4Fh, 6Fh, 5Fh, 57h, 6Fh,	6Fh, 5Fh
		db 57h,	5Fh, 5Fh, 57h, 57h, 57h, 5Fh, 57h, 57h,	4Fh, 5Fh
		db 57h,	57h, 6Fh, 5Fh, 57h, 57h, 5Fh, 57h, 57h,	57h, 57h
		db 57h,	57h, 57h, 4Fh, 57h, 57h, 57h, 6Fh, 57h,	57h, 57h
		db 5Fh,	4Fh, 57h, 57h, 57h, 4Fh, 57h, 57h, 4Fh,	4Fh, 57h
		db 57h,	6Fh, 4Fh, 57h, 57h, 5Fh, 6Fh, 57h, 57h,	57h, 6Fh
		db 57h,	57h, 4Fh, 6Fh, 57h, 57h, 6Fh, 6Fh, 57h,	57h, 5Fh
		db 5Fh,	4Fh, 57h, 57h, 5Fh, 4Fh, 57h, 4Fh, 5Fh,	4Fh, 57h
		db 6Fh,	5Fh, 4Fh, 57h, 5Fh, 57h, 4Fh, 57h, 57h,	57h, 4Fh
		db 57h,	4Fh, 57h, 4Fh, 57h, 6Fh, 57h, 4Fh, 57h,	5Fh, 4Fh
		db 4Fh,	57h, 57h, 4Fh, 4Fh, 57h, 4Fh, 4Fh, 4Fh,	57h, 6Fh
		db 4Fh,	4Fh, 57h, 5Fh, 6Fh, 4Fh, 57h, 57h, 6Fh,	4Fh, 57h
		db 4Fh,	6Fh, 4Fh, 57h, 6Fh, 6Fh, 4Fh, 57h, 5Fh,	5Fh, 6Fh
		db 57h,	57h, 5Fh, 6Fh, 57h, 4Fh, 5Fh, 6Fh, 57h,	6Fh, 5Fh
		db 6Fh,	57h, 5Fh, 57h, 6Fh, 57h, 57h, 57h, 6Fh,	57h, 4Fh
		db 57h,	6Fh, 57h, 6Fh, 57h, 6Fh, 57h, 5Fh, 4Fh,	6Fh, 57h
		db 57h,	4Fh, 6Fh, 57h, 4Fh, 4Fh, 6Fh, 57h, 6Fh,	4Fh, 6Fh
		db 57h,	5Fh, 6Fh, 6Fh, 57h, 57h, 6Fh, 6Fh, 57h,	4Fh, 6Fh
		db 6Fh,	57h, 6Fh, 6Fh, 6Fh, 57h, 5Fh, 5Fh, 5Fh,	4Fh, 57h
		db 5Fh,	5Fh, 4Fh, 4Fh, 5Fh, 5Fh, 4Fh, 6Fh, 5Fh,	5Fh, 4Fh
		db 5Fh,	57h, 5Fh, 4Fh, 57h, 57h, 5Fh, 4Fh, 4Fh,	57h, 5Fh
		db 4Fh,	6Fh, 57h, 5Fh, 4Fh, 5Fh, 4Fh, 5Fh, 4Fh,	57h, 4Fh
		db 5Fh,	4Fh, 4Fh, 4Fh, 5Fh, 4Fh, 6Fh, 4Fh, 5Fh,	4Fh, 5Fh
		db 6Fh,	5Fh, 4Fh, 57h, 6Fh, 5Fh, 4Fh, 4Fh, 6Fh,	5Fh, 4Fh
		db 6Fh,	6Fh, 5Fh, 4Fh, 5Fh, 5Fh, 57h, 4Fh, 57h,	5Fh, 57h
		db 4Fh,	4Fh, 5Fh, 57h, 4Fh, 6Fh, 5Fh, 57h, 4Fh,	5Fh, 57h
		db 57h,	4Fh, 57h, 57h, 57h, 4Fh, 4Fh, 57h, 57h,	4Fh, 6Fh
		db 57h,	57h, 4Fh, 5Fh, 4Fh, 57h, 4Fh, 57h, 4Fh,	57h, 4Fh
		db 4Fh,	4Fh, 57h, 4Fh, 6Fh, 4Fh, 57h, 4Fh, 5Fh,	6Fh, 57h
		db 4Fh,	57h, 6Fh, 57h, 4Fh, 4Fh, 6Fh, 57h, 4Fh,	6Fh, 6Fh
		db 57h,	4Fh, 5Fh, 5Fh, 4Fh, 4Fh, 57h, 5Fh, 4Fh,	4Fh, 4Fh
		db 5Fh,	4Fh, 4Fh, 6Fh, 5Fh, 4Fh, 4Fh, 5Fh, 57h,	4Fh, 4Fh
		db 57h,	57h, 4Fh, 4Fh, 4Fh, 57h, 4Fh, 4Fh, 6Fh,	57h, 4Fh
		db 4Fh,	5Fh, 4Fh, 4Fh, 4Fh, 57h, 4Fh, 4Fh, 4Fh,	4Fh, 4Fh
		db 4Fh,	4Fh, 6Fh, 4Fh, 4Fh, 4Fh, 5Fh, 6Fh, 4Fh,	4Fh, 57h
		db 6Fh,	4Fh, 4Fh, 4Fh, 6Fh, 4Fh, 4Fh, 6Fh, 6Fh,	4Fh, 4Fh
		db 5Fh,	5Fh, 6Fh, 4Fh, 57h, 5Fh, 6Fh, 4Fh, 4Fh,	5Fh, 6Fh
		db 4Fh,	6Fh, 5Fh, 6Fh, 4Fh, 5Fh, 57h, 6Fh, 4Fh,	57h, 57h
		db 6Fh,	4Fh, 4Fh, 57h, 6Fh, 4Fh, 6Fh, 57h, 6Fh,	4Fh, 5Fh
		db 4Fh,	6Fh, 4Fh, 57h, 4Fh, 6Fh, 4Fh, 4Fh, 4Fh,	6Fh, 4Fh
		db 6Fh,	4Fh, 6Fh, 4Fh, 5Fh, 6Fh, 6Fh, 4Fh, 57h,	6Fh, 6Fh
		db 4Fh,	4Fh, 6Fh, 6Fh, 4Fh, 6Fh, 6Fh, 6Fh, 4Fh,	5Fh, 5Fh
		db 5Fh,	6Fh, 57h, 5Fh, 5Fh, 6Fh, 4Fh, 5Fh, 5Fh,	6Fh, 6Fh
		db 5Fh,	5Fh, 6Fh, 5Fh, 57h, 5Fh, 6Fh, 57h, 57h,	5Fh, 6Fh
		db 4Fh,	57h, 5Fh, 6Fh, 6Fh, 57h, 5Fh, 6Fh, 5Fh,	4Fh, 5Fh
		db 6Fh,	57h, 4Fh, 5Fh, 6Fh, 4Fh, 4Fh, 5Fh, 6Fh,	6Fh, 4Fh
		db 5Fh,	6Fh, 5Fh, 6Fh, 5Fh, 6Fh, 57h, 6Fh, 5Fh,	6Fh, 4Fh
		db 6Fh,	5Fh, 6Fh, 6Fh, 6Fh, 5Fh, 6Fh, 5Fh, 5Fh,	57h, 6Fh
		db 57h,	5Fh, 57h, 6Fh, 4Fh, 5Fh, 57h, 6Fh, 6Fh,	5Fh, 57h
		db 6Fh,	5Fh, 57h, 57h, 6Fh, 57h, 57h, 57h, 6Fh,	4Fh, 57h
		db 57h,	6Fh, 6Fh, 57h, 57h, 6Fh, 5Fh, 4Fh, 57h,	6Fh, 57h
		db 4Fh,	57h, 6Fh, 4Fh, 4Fh, 57h, 6Fh, 6Fh, 4Fh,	57h, 6Fh
		db 5Fh,	6Fh, 57h, 6Fh, 57h, 6Fh, 57h, 6Fh, 4Fh,	6Fh, 57h
		db 6Fh,	6Fh, 6Fh, 57h, 6Fh, 5Fh, 5Fh, 4Fh, 6Fh,	57h, 5Fh
		db 4Fh,	6Fh, 4Fh, 5Fh, 4Fh, 6Fh, 6Fh, 5Fh, 4Fh,	6Fh, 5Fh
		db 57h,	4Fh, 6Fh, 57h, 57h, 4Fh, 6Fh, 4Fh, 57h,	4Fh, 6Fh
		db 6Fh,	57h, 4Fh, 6Fh, 5Fh, 4Fh, 4Fh, 6Fh, 57h,	4Fh, 4Fh
		db 6Fh,	4Fh, 4Fh, 4Fh, 6Fh, 6Fh, 4Fh, 4Fh, 6Fh,	5Fh, 6Fh
		db 4Fh,	6Fh, 57h, 6Fh, 4Fh, 6Fh, 4Fh, 6Fh, 4Fh,	6Fh, 6Fh
		db 6Fh,	4Fh, 6Fh, 5Fh, 5Fh, 6Fh, 6Fh, 57h, 5Fh,	6Fh, 6Fh
		db 4Fh,	5Fh, 6Fh, 6Fh, 6Fh, 5Fh, 6Fh, 6Fh, 5Fh,	57h, 6Fh
		db 6Fh,	57h, 57h, 6Fh, 6Fh, 4Fh, 57h, 6Fh, 6Fh,	6Fh, 57h
		db 6Fh,	6Fh, 5Fh, 4Fh, 6Fh, 6Fh, 57h, 4Fh, 6Fh,	6Fh, 4Fh
		db 4Fh,	6Fh, 6Fh, 6Fh, 4Fh, 6Fh, 6Fh, 5Fh, 6Fh,	6Fh, 6Fh
		db 57h,	6Fh, 6Fh, 6Fh, 4Fh, 6Fh, 6Fh, 6Fh, 6Fh,	6Fh, 6Fh
		db 6Fh
byte_125984	db 0C3h, 0C3h, 0C3h, 0C3h, 0C2h, 0C3h, 0C3h, 0C3h, 0C1h
		db 0C3h, 0C3h, 0C3h, 0C5h, 0C3h, 0C3h, 0C3h, 0C3h, 0C2h
		db 0C3h, 0C3h, 0C2h, 0C2h, 0C3h, 0C3h, 0C1h, 0C2h, 0C3h
		db 0C3h, 0C5h, 0C2h, 0C3h, 0C3h, 0C3h, 0C1h, 0C3h, 0C3h
		db 0C2h, 0C1h, 0C3h, 0C3h, 0C1h, 0C1h, 0C3h, 0C3h, 0C5h
		db 0C1h, 0C3h, 0C3h, 0C3h, 0C5h, 0C3h, 0C3h, 0C2h, 0C5h
		db 0C3h, 0C3h, 0C1h, 0C5h, 0C3h, 0C3h, 0C5h, 0C5h, 0C3h
		db 0C3h, 0C3h, 0C3h, 0C2h, 0C3h, 0C2h, 0C3h, 0C2h, 0C3h
		db 0C1h, 0C3h, 0C2h, 0C3h, 0C5h, 0C3h, 0C2h, 0C3h, 0C3h
		db 0C2h, 0C2h, 0C3h, 0C2h, 0C2h, 0C2h, 0C3h, 0C1h, 0C2h
		db 0C2h, 0C3h, 0C5h, 0C2h, 0C2h, 0C3h, 0C3h, 0C1h, 0C2h
		db 0C3h, 0C2h, 0C1h, 0C2h, 0C3h, 0C1h, 0C1h, 0C2h, 0C3h
		db 0C5h, 0C1h, 0C2h, 0C3h, 0C3h, 0C5h, 0C2h, 0C3h, 0C2h
		db 0C5h, 0C2h, 0C3h, 0C1h, 0C5h, 0C2h, 0C3h, 0C5h, 0C5h
		db 0C2h, 0C3h, 0C3h, 0C3h, 0C1h, 0C3h, 0C2h, 0C3h, 0C1h
		db 0C3h, 0C1h, 0C3h, 0C1h, 0C3h, 0C5h, 0C3h, 0C1h, 0C3h
		db 0C3h, 0C2h, 0C1h, 0C3h, 0C2h, 0C2h, 0C1h, 0C3h, 0C1h
		db 0C2h, 0C1h, 0C3h, 0C5h, 0C2h, 0C1h, 0C3h, 0C3h, 0C1h
		db 0C1h, 0C3h, 0C2h, 0C1h, 0C1h, 0C3h, 0C1h, 0C1h, 0C1h
		db 0C3h, 0C5h, 0C1h, 0C1h, 0C3h, 0C3h, 0C5h, 0C1h, 0C3h
		db 0C2h, 0C5h, 0C1h, 0C3h, 0C1h, 0C5h, 0C1h, 0C3h, 0C5h
		db 0C5h, 0C1h, 0C3h, 0C3h, 0C3h, 0C5h, 0C3h, 0C2h, 0C3h
		db 0C5h, 0C3h, 0C1h, 0C3h, 0C5h, 0C3h, 0C5h, 0C3h, 0C5h
		db 0C3h, 0C3h, 0C2h, 0C5h, 0C3h, 0C2h, 0C2h, 0C5h, 0C3h
		db 0C1h, 0C2h, 0C5h, 0C3h, 0C5h, 0C2h, 0C5h, 0C3h, 0C3h
		db 0C1h, 0C5h, 0C3h, 0C2h, 0C1h, 0C5h, 0C3h, 0C1h, 0C1h
		db 0C5h, 0C3h, 0C5h, 0C1h, 0C5h, 0C3h, 0C3h, 0C5h, 0C5h
		db 0C3h, 0C2h, 0C5h, 0C5h, 0C3h, 0C1h, 0C5h, 0C5h, 0C3h
		db 0C5h, 0C5h, 0C5h, 0C3h, 0C3h, 0C3h, 0C3h, 0C2h, 0C2h
		db 0C3h, 0C3h, 0C2h, 0C1h, 0C3h, 0C3h, 0C2h, 0C5h, 0C3h
		db 0C3h, 0C2h, 0C3h, 0C2h, 0C3h, 0C2h, 0C2h, 0C2h, 0C3h
		db 0C2h, 0C1h, 0C2h, 0C3h, 0C2h, 0C5h, 0C2h, 0C3h, 0C2h
		db 0C3h, 0C1h, 0C3h, 0C2h, 0C2h, 0C1h, 0C3h, 0C2h, 0C1h
		db 0C1h, 0C3h, 0C2h, 0C5h, 0C1h, 0C3h, 0C2h, 0C3h, 0C5h
		db 0C3h, 0C2h, 0C2h, 0C5h, 0C3h, 0C2h, 0C1h, 0C5h, 0C3h
		db 0C2h, 0C5h, 0C5h, 0C3h, 0C2h, 0C3h, 0C3h, 0C2h, 0C2h
		db 0C2h, 0C3h, 0C2h, 0C2h, 0C1h, 0C3h, 0C2h, 0C2h, 0C5h
		db 0C3h, 0C2h, 0C2h, 0C3h, 0C2h, 0C2h, 0C2h, 0C2h, 0C2h
		db 0C2h, 0C2h, 0C1h, 0C2h, 0C2h, 0C2h, 0C5h, 0C2h, 0C2h
		db 0C2h, 0C3h, 0C1h, 0C2h, 0C2h, 0C2h, 0C1h, 0C2h, 0C2h
		db 0C1h, 0C1h, 0C2h, 0C2h, 0C5h, 0C1h, 0C2h, 0C2h, 0C3h
		db 0C5h, 0C2h, 0C2h, 0C2h, 0C5h, 0C2h, 0C2h, 0C1h, 0C5h
		db 0C2h, 0C2h, 0C5h, 0C5h, 0C2h, 0C2h, 0C3h, 0C3h, 0C1h
		db 0C2h, 0C2h, 0C3h, 0C1h, 0C2h, 0C1h, 0C3h, 0C1h, 0C2h
		db 0C5h, 0C3h, 0C1h, 0C2h, 0C3h, 0C2h, 0C1h, 0C2h, 0C2h
		db 0C2h, 0C1h, 0C2h, 0C1h, 0C2h, 0C1h, 0C2h, 0C5h, 0C2h
		db 0C1h, 0C2h, 0C3h, 0C1h, 0C1h, 0C2h, 0C2h, 0C1h, 0C1h
		db 0C2h, 0C1h, 0C1h, 0C1h, 0C2h, 0C5h, 0C1h, 0C1h, 0C2h
		db 0C3h, 0C5h, 0C1h, 0C2h, 0C2h, 0C5h, 0C1h, 0C2h, 0C1h
		db 0C5h, 0C1h, 0C2h, 0C5h, 0C5h, 0C1h, 0C2h, 0C3h, 0C3h
		db 0C5h, 0C2h, 0C2h, 0C3h, 0C5h, 0C2h, 0C1h, 0C3h, 0C5h
		db 0C2h, 0C5h, 0C3h, 0C5h, 0C2h, 0C3h, 0C2h, 0C5h, 0C2h
		db 0C2h, 0C2h, 0C5h, 0C2h, 0C1h, 0C2h, 0C5h, 0C2h, 0C5h
		db 0C2h, 0C5h, 0C2h, 0C3h, 0C1h, 0C5h, 0C2h, 0C2h, 0C1h
		db 0C5h, 0C2h, 0C1h, 0C1h, 0C5h, 0C2h, 0C5h, 0C1h, 0C5h
		db 0C2h, 0C3h, 0C5h, 0C5h, 0C2h, 0C2h, 0C5h, 0C5h, 0C2h
		db 0C1h, 0C5h, 0C5h, 0C2h, 0C5h, 0C5h, 0C5h, 0C2h, 0C3h
		db 0C3h, 0C3h, 0C1h, 0C2h, 0C3h, 0C3h, 0C1h, 0C1h, 0C3h
		db 0C3h, 0C1h, 0C5h, 0C3h, 0C3h, 0C1h, 0C3h, 0C2h, 0C3h
		db 0C1h, 0C2h, 0C2h, 0C3h, 0C1h, 0C1h, 0C2h, 0C3h, 0C1h
		db 0C5h, 0C2h, 0C3h, 0C1h, 0C3h, 0C1h, 0C3h, 0C1h, 0C2h
		db 0C1h, 0C3h, 0C1h, 0C1h, 0C1h, 0C3h, 0C1h, 0C5h, 0C1h
		db 0C3h, 0C1h, 0C3h, 0C5h, 0C3h, 0C1h, 0C2h, 0C5h, 0C3h
		db 0C1h, 0C1h, 0C5h, 0C3h, 0C1h, 0C5h, 0C5h, 0C3h, 0C1h
		db 0C3h, 0C3h, 0C2h, 0C1h, 0C2h, 0C3h, 0C2h, 0C1h, 0C1h
		db 0C3h, 0C2h, 0C1h, 0C5h, 0C3h, 0C2h, 0C1h, 0C3h, 0C2h
		db 0C2h, 0C1h, 0C2h, 0C2h, 0C2h, 0C1h, 0C1h, 0C2h, 0C2h
		db 0C1h, 0C5h, 0C2h, 0C2h, 0C1h, 0C3h, 0C1h, 0C2h, 0C1h
		db 0C2h, 0C1h, 0C2h, 0C1h, 0C1h, 0C1h, 0C2h, 0C1h, 0C5h
		db 0C1h, 0C2h, 0C1h, 0C3h, 0C5h, 0C2h, 0C1h, 0C2h, 0C5h
		db 0C2h, 0C1h, 0C1h, 0C5h, 0C2h, 0C1h, 0C5h, 0C5h, 0C2h
		db 0C1h, 0C3h, 0C3h, 0C1h, 0C1h, 0C2h, 0C3h, 0C1h, 0C1h
		db 0C1h, 0C3h, 0C1h, 0C1h, 0C5h, 0C3h, 0C1h, 0C1h, 0C3h
		db 0C2h, 0C1h, 0C1h, 0C2h, 0C2h, 0C1h, 0C1h, 0C1h, 0C2h
		db 0C1h, 0C1h, 0C5h, 0C2h, 0C1h, 0C1h, 0C3h, 0C1h, 0C1h
		db 0C1h, 0C2h, 0C1h, 0C1h, 0C1h, 0C1h, 0C1h, 0C1h, 0C1h
		db 0C5h, 0C1h, 0C1h, 0C1h, 0C3h, 0C5h, 0C1h, 0C1h, 0C2h
		db 0C5h, 0C1h, 0C1h, 0C1h, 0C5h, 0C1h, 0C1h, 0C5h, 0C5h
		db 0C1h, 0C1h, 0C3h, 0C3h, 0C5h, 0C1h, 0C2h, 0C3h, 0C5h
		db 0C1h, 0C1h, 0C3h, 0C5h, 0C1h, 0C5h, 0C3h, 0C5h, 0C1h
		db 0C3h, 0C2h, 0C5h, 0C1h, 0C2h, 0C2h, 0C5h, 0C1h, 0C1h
		db 0C2h, 0C5h, 0C1h, 0C5h, 0C2h, 0C5h, 0C1h, 0C3h, 0C1h
		db 0C5h, 0C1h, 0C2h, 0C1h, 0C5h, 0C1h, 0C1h, 0C1h, 0C5h
		db 0C1h, 0C5h, 0C1h, 0C5h, 0C1h, 0C3h, 0C5h, 0C5h, 0C1h
		db 0C2h, 0C5h, 0C5h, 0C1h, 0C1h, 0C5h, 0C5h, 0C1h, 0C5h
		db 0C5h, 0C5h, 0C1h, 0C3h, 0C3h, 0C3h, 0C5h, 0C2h, 0C3h
		db 0C3h, 0C5h, 0C1h, 0C3h, 0C3h, 0C5h, 0C5h, 0C3h, 0C3h
		db 0C5h, 0C3h, 0C2h, 0C3h, 0C5h, 0C2h, 0C2h, 0C3h, 0C5h
		db 0C1h, 0C2h, 0C3h, 0C5h, 0C5h, 0C2h, 0C3h, 0C5h, 0C3h
		db 0C1h, 0C3h, 0C5h, 0C2h, 0C1h, 0C3h, 0C5h, 0C1h, 0C1h
		db 0C3h, 0C5h, 0C5h, 0C1h, 0C3h, 0C5h, 0C3h, 0C5h, 0C3h
		db 0C5h, 0C2h, 0C5h, 0C3h, 0C5h, 0C1h, 0C5h, 0C3h, 0C5h
		db 0C5h, 0C5h, 0C3h, 0C5h, 0C3h, 0C3h, 0C2h, 0C5h, 0C2h
		db 0C3h, 0C2h, 0C5h, 0C1h, 0C3h, 0C2h, 0C5h, 0C5h, 0C3h
		db 0C2h, 0C5h, 0C3h, 0C2h, 0C2h, 0C5h, 0C2h, 0C2h, 0C2h
		db 0C5h, 0C1h, 0C2h, 0C2h, 0C5h, 0C5h, 0C2h, 0C2h, 0C5h
		db 0C3h, 0C1h, 0C2h, 0C5h, 0C2h, 0C1h, 0C2h, 0C5h, 0C1h
		db 0C1h, 0C2h, 0C5h, 0C5h, 0C1h, 0C2h, 0C5h, 0C3h, 0C5h
		db 0C2h, 0C5h, 0C2h, 0C5h, 0C2h, 0C5h, 0C1h, 0C5h, 0C2h
		db 0C5h, 0C5h, 0C5h, 0C2h, 0C5h, 0C3h, 0C3h, 0C1h, 0C5h
		db 0C2h, 0C3h, 0C1h, 0C5h, 0C1h, 0C3h, 0C1h, 0C5h, 0C5h
		db 0C3h, 0C1h, 0C5h, 0C3h, 0C2h, 0C1h, 0C5h, 0C2h, 0C2h
		db 0C1h, 0C5h, 0C1h, 0C2h, 0C1h, 0C5h, 0C5h, 0C2h, 0C1h
		db 0C5h, 0C3h, 0C1h, 0C1h, 0C5h, 0C2h, 0C1h, 0C1h, 0C5h
		db 0C1h, 0C1h, 0C1h, 0C5h, 0C5h, 0C1h, 0C1h, 0C5h, 0C3h
		db 0C5h, 0C1h, 0C5h, 0C2h, 0C5h, 0C1h, 0C5h, 0C1h, 0C5h
		db 0C1h, 0C5h, 0C5h, 0C5h, 0C1h, 0C5h, 0C3h, 0C3h, 0C5h
		db 0C5h, 0C2h, 0C3h, 0C5h, 0C5h, 0C1h, 0C3h, 0C5h, 0C5h
		db 0C5h, 0C3h, 0C5h, 0C5h, 0C3h, 0C2h, 0C5h, 0C5h, 0C2h
		db 0C2h, 0C5h, 0C5h, 0C1h, 0C2h, 0C5h, 0C5h, 0C5h, 0C2h
		db 0C5h, 0C5h, 0C3h, 0C1h, 0C5h, 0C5h, 0C2h, 0C1h, 0C5h
		db 0C5h, 0C1h, 0C1h, 0C5h, 0C5h, 0C5h, 0C1h, 0C5h, 0C5h
		db 0C3h, 0C5h, 0C5h, 0C5h, 0C2h, 0C5h, 0C5h, 0C5h, 0C1h
		db 0C5h, 0C5h, 0C5h, 0C5h, 0C5h, 0C5h, 0C5h
off_125D84	dd offset L217
		dd offset L218
		dd offset L219
		dd offset L221
		dd offset L222
		dd offset L223
		dd offset L225
		dd offset L227
		dd offset L231
		dd offset L237
		dd offset L245
		dd offset L251
		dd offset L252
		dd offset L253
		dd offset L254
		dd offset L255

_DATA ENDS

_TEXT SEGMENT DWORD PUBLIC USE32 'CODE'

ASSUME CS:_TEXT
ASSUME DS:_DATA

PUBLIC _syncCallback
_syncCallback:
		push	eax
		push	ebx
		mov	al, 80h
		out	43h, al
		in	al, 42h
		mov	bl, al
		in	al, 42h
		mov	ah, al
		mov	al, bl
		xor	ebx, ebx
		mov	bx, _prev_timer2
		mov	_prev_timer2, ax
		sub	bx, ax
		add	_sync_time, ebx
		pop	ebx
		pop	eax
		retn

PUBLIC _syncReset
_syncReset:
		push	ebp
		mov	ebp, esp
		push	ebx
		cli
		mov	eax, [ebp+8]
		mov	_sync_time, eax
		mov	al, 80h
		out	43h, al
		in	al, 42h
		mov	bl, al
		in	al, 42h
		mov	ah, al
		mov	al, bl
		xor	ebx, ebx
		mov	bx, _prev_timer2
		sub	bx, ax
		sub	_sync_time, ebx
		sti
		pop	ebx
		leave
		retn

PUBLIC _syncInit2
_syncInit2:
		cli
		in	al, 61h
		and	al, 0FCh
		out	61h, al
		mov	al, 0B4h
		out	43h, al
		mov	al, 0
		out	42h, al
		out	42h, al
		in	al, 61h
		or	al, 1
		out	61h, al
		mov	_prev_timer2, 0FFFFh
		mov	eax, _sync_wait_quanta
		mov	_sync_time, eax
		sti
		retn

PUBLIC _syncMaybeWait
_syncMaybeWait:
		push	ebx
		mov	ecx, 0
		cmp	_sync_time, 0
		js	short L2
		jmp	short L3
L1:
		mov	ecx, 1

L2:
		mov	al, 80h
		cli
		out	43h, al
		in	al, 42h
		mov	bl, al
		in	al, 42h
		mov	ah, al
		mov	al, bl
		xor	ebx, ebx
		mov	bx, _prev_timer2
		sub	bx, ax
		add	ebx, _sync_time
		sti
		js	short L1

L3:
		mov	eax, ecx
		pop	ebx
		retn

PUBLIC _syncMaybeWaitLevel
_syncMaybeWaitLevel:
		push	ebp
		mov	ebp, esp
		push	ebx
		mov	ecx, [ebp+8]

L4:
		mov	al, 80h
		cli
		out	43h, al
		in	al, 42h
		mov	bl, al
		in	al, 42h
		mov	ah, al
		mov	al, bl
		xor	ebx, ebx
		mov	bx, _prev_timer2
		sub	bx, ax
		add	ebx, _sync_time
		sti
		sub	ebx, ecx
		js	short L4
		mov	eax, ebx
		pop	ebx
		leave
		retn

PUBLIC _syncTime
_syncTime:
		push	ebx
		mov	al, 80h
		cli
		out	43h, al
		in	al, 42h
		mov	bl, al
		in	al, 42h
		mov	ah, al
		mov	al, bl
		xor	ebx, ebx
		mov	bx, _prev_timer2
		sub	bx, ax
		add	ebx, _sync_time
		sti
		mov	eax, ebx
		pop	ebx
		retn

PUBLIC _getDMAByteCnt
_getDMAByteCnt:
		push	ebp
		mov	ebp, esp
		xor	eax, eax
		out	0Ch, al
		jmp	short $+2
		mov	edx, [ebp+8]
		in	al, dx
		jmp	short $+2
		mov	ah, al
		in	al, dx
		jmp	short $+2
		xchg	al, ah
		inc	eax
		cmp	edx, 7
		jbe	short L5
		shl	eax, 1

L5:
		leave
		retn

PUBLIC _sndDecompM16
_sndDecompM16:
		push	ebp
		mov	ebp, esp
		push	esi
		push	edi
		push	ebx
		mov	ecx, [ebp+10h]
		shr	ecx, 1
		jz	short L7
		mov	esi, [ebp+0ch]
		mov	edi, [ebp+8h]
		mov	ax, [esi]
		add	esi, 2
		xor	ebx, ebx
		mov	[edi], ax
		add	edi, 2
		dec	ecx
		jz	short L7

L6:
		mov	bl, [esi]
		add	esi, 1
		add	ax, _snd_8to16[ebx*2]
		mov	[edi], ax
		add	edi, 2
		dec	ecx
		jnz	short L6

L7:
		pop	ebx
		pop	edi
		pop	esi
		leave
		retn

PUBLIC _sndDecompS16
_sndDecompS16:
		push	ebp
		mov	ebp, esp
		push	esi
		push	edi
		push	ebx
		mov	ecx, [ebp+10h]
		shr	ecx, 1
		jz	short L9
		mov	esi, [ebp+0ch]
		mov	edi, [ebp+8h]
		mov	ax, [esi]
		add	esi, 2
		xor	ebx, ebx
		mov	[edi], ax
		add	edi, 2
		dec	ecx
		jz	short L9
		mov	dx, [esi]
		add	esi, 2
		xor	ebx, ebx
		mov	[edi], dx
		add	edi, 2
		dec	ecx
		jz	short L9

L8:
		mov	bl, [esi]
		add	esi, 1
		add	ax, _snd_8to16[ebx*2]
		mov	[edi], ax
		add	edi, 2
		dec	ecx
		jz	short L9
		mov	bl, [esi]
		add	esi, 1
		add	dx, _snd_8to16[ebx*2]
		mov	[edi], dx
		add	edi, 2
		dec	ecx
		jnz	short L8

L9:
		pop	ebx
		pop	edi
		pop	esi
		leave
		retn

PUBLIC _sndDecompM8
_sndDecompM8:
		push	ebp
		mov	ebp, esp
		push	esi
		push	edi
		push	ebx
		mov	ecx, [ebp+10h]
		or	ecx, ecx
		jz	short L11
		mov	esi, [ebp+0ch]
		mov	edi, [ebp+8h]
		mov	ax, [esi]
		add	esi, 2
		xor	ebx, ebx
		xor	ah, 80h
		mov	[edi], ah
		inc	edi
		dec	ecx
		jz	short L11

L10:
		mov	bl, [esi]
		add	esi, 1
		add	ax, _snd_8to16[ebx*2]
		mov	[edi], ah
		inc	edi
		dec	ecx
		jnz	short L10

L11:
		pop	ebx
		pop	edi
		pop	esi
		leave
		retn

PUBLIC _sndDecompS8
_sndDecompS8:
		push	ebp
		mov	ebp, esp
		push	esi
		push	edi
		push	ebx
		mov	ecx, [ebp+10h]
		or	ecx, ecx
		jz	short L13
		mov	esi, [ebp+0ch]
		mov	edi, [ebp+8h]
		mov	ax, [esi]
		add	esi, 2
		xor	ebx, ebx
		xor	ah, 80h
		mov	[edi], ah
		inc	edi
		dec	ecx
		jz	short L13
		mov	dx, [esi]
		add	esi, 2
		xor	ebx, ebx
		xor	dh, 80h
		mov	[edi], dh
		inc	edi
		dec	ecx
		jz	short L13

L12:
		mov	bl, [esi]
		add	esi, 1
		add	ax, _snd_8to16[ebx*2]
		mov	[edi], ah
		inc	edi
		dec	ecx
		jz	short L13
		mov	bl, [esi]
		add	esi, 1
		add	dx, _snd_8to16[ebx*2]
		mov	[edi], dh
		inc	edi
		dec	ecx
		jnz	short L12

L13:
		pop	ebx
		pop	edi
		pop	esi
		leave
		retn

PUBLIC _sndCnv16to8
_sndCnv16to8:
		push	ebp
		mov	ebp, esp
		push	esi
		push	edi
		mov	ecx, [ebp+10h]
		or	ecx, ecx
		jz	short L15
		mov	esi, [ebp+0ch]
		mov	edi, [ebp+8h]

L14:
		mov	ax, [esi]
		add	esi, 2
		xor	ah, 80h
		mov	[edi], ah
		inc	edi
		dec	ecx
		jnz	short L14

L15:
		pop	edi
		pop	esi
		leave
		retn

PUBLIC _nfHiColorDecomp
_nfHiColorDecomp:
		push	ebp
		mov	ebp, esp
		add	esp, 0FFFFFFF0h
		push	esi
		push	edi
		push	ebx
		mov	ax, ds
		mov	es, ax
		mov	eax, _nf_buf_prv
		sub	eax, _nf_buf_cur
		mov	[ebp-0ch], eax
		xor	ebx, ebx
		mov	bl, _nf_fqty
		mov	eax, [ebp+0ch]
		shl	eax, 4
		mov	_nf_new_x, eax
		mov	eax, [ebp+14h]
		shl	eax, 4
		mov	_nf_new_w, eax
		mov	eax, [ebp+10h]
		shl	eax, 3
		mul	ebx
		mov	_nf_new_y, eax
		mov	eax, [ebp+18h]
		shl	eax, 3
		mul	ebx
		mov	_nf_new_h, eax
		mov	eax, _nf_new_row0
		sub	eax, _nf_new_w
		mov	[ebp-8], eax
		mov	eax, _nf_buf_cur
		mov	[ebp-4], eax
		cmp	dword ptr [ebp+0ch], 0
		jnz	short L16
		cmp	dword ptr [ebp+10h], 0
		jz	short L17

L16:
		mov	eax, _nf_new_y
		mul	_nf_width
		add	eax, _nf_new_x
		add	[ebp-4], eax

L17:
		mov	eax, [ebp+14h]
		mul	dword ptr [ebp+18h]
		mul	ebx
		shl	eax, 1
		mov	[ebp-10h], eax
		mov	edi, [ebp-4]
		mov	edx, _nf_new_line
		mov	ebx, [ebp+8]
		mov	esi, ebx
		add	esi, [ebp-10h]
		mov	cl, _nf_fqty

L18:
		push	ecx
		push	edi
		mov	ch, byte ptr [ebp+18h]

L19:
		mov	cl, byte ptr [ebp+14h]

L20:
		cmp	word ptr [ebx],	0
		jz	short L22
		add	edi, 10h

L21:
		add	ebx, 2
		dec	cl
		jnz	short L20
		add	edi, [ebp-8]
		dec	ch
		jnz	short L19
		pop	edi
		pop	ecx
		add	edi, _nf_width
		dec	cl
		jnz	short L18
		jmp	short L23

L22:
		movsd
		movsd
		movsd
		movsd
		add	edi, edx
		movsd
		movsd
		movsd
		movsd
		add	edi, edx
		movsd
		movsd
		movsd
		movsd
		add	edi, edx
		movsd
		movsd
		movsd
		movsd
		add	edi, edx
		movsd
		movsd
		movsd
		movsd
		add	edi, edx
		movsd
		movsd
		movsd
		movsd
		add	edi, edx
		movsd
		movsd
		movsd
		movsd
		add	edi, edx
		movsd
		movsd
		movsd
		movsd
		sub	edi, _nf_back_right
		jmp	short L21

L23:
		sub	ebx, [ebp-10h]
		mov	edi, [ebp-4]
		mov	cl, _nf_fqty
		xor	esi, esi

L24:
		push	ecx
		push	edi
		mov	ch, byte ptr [ebp+18h]

L25:
		mov	cl, byte ptr [ebp+14h]

L26:
		or	si, [ebx]
		jg	short L29
		jl	short L28
		add	edi, 10h

L27:
		add	ebx, 2
		dec	cl
		jnz	short L26
		add	edi, [ebp-8]
		dec	ch
		jnz	short L25
		pop	edi
		pop	ecx
		add	edi, _nf_width
		dec	cl
		jnz	short L24
		jmp	L36

L28:
		jmp	short L35

L29:
		lea	esi, [edi+esi*2-8000h]
		movsd
		movsd
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		movsd
		movsd
		sub	edi, _nf_back_right
		xor	esi, esi
		jmp	short L27

L30:
		push	ecx
		push	edi
		mov	ch, byte ptr [ebp+18h]

L31:
		mov	cl, byte ptr [ebp+14h]

L32:
		or	si, [ebx]
		jl	short L35
		jg	short L34
		add	edi, 10h

L33:
		add	ebx, 2
		dec	cl
		jnz	short L32
		add	edi, [ebp-8]
		dec	ch
		jnz	short L31
		pop	edi
		pop	ecx
		add	edi, _nf_width
		dec	cl
		jnz	short L30
		jmp	short L36

L34:
		jmp	short L29

L35:
		lea	esi, [edi+esi*2-18000h]
		add	esi, [ebp-0ch]
		movsd
		movsd
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		movsd
		movsd
		sub	edi, _nf_back_right
		xor	esi, esi
		jmp	short L33
L36:
		pop	ebx
		pop	edi
		pop	esi
		leave
		retn

PUBLIC _nfHiColorDecompChg
_nfHiColorDecompChg:
		push	ebp
		mov	ebp, esp
		add	esp, 0FFFFFFF0h
		push	esi
		push	edi
		push	ebx
		mov	ax, ds
		mov	es, ax
		mov	eax, _nf_buf_prv
		sub	eax, _nf_buf_cur
		mov	[ebp-0ch], eax
		xor	ebx, ebx
		mov	bl, _nf_fqty
		mov	eax, [ebp+14h]
		shl	eax, 4
		mov	_nf_new_x, eax
		mov	eax, [ebp+1ch]
		shl	eax, 4
		mov	_nf_new_w, eax
		mov	eax, [ebp+18h]
		shl	eax, 3
		mul	ebx
		mov	_nf_new_y, eax
		mov	eax, [ebp+20h]
		shl	eax, 3
		mul	ebx
		mov	_nf_new_h, eax
		mov	eax, _nf_new_row0
		sub	eax, _nf_new_w
		mov	[ebp-8], eax
		mov	eax, _nf_buf_cur
		mov	[ebp-4], eax
		cmp	dword ptr [ebp+14h], 0
		jnz	short L37
		cmp	dword ptr [ebp+18h], 0
		jz	short L38

L37:
		mov	eax, _nf_new_y
		mul	_nf_width
		add	eax, _nf_new_x
		add	[ebp-4], eax

L38:
		mov	edi, [ebp-4]
		mov	edx, _nf_new_line
		mov	esi, [ebp+10h]
		mov	ebx, [ebp+0ch]
		mov	eax, [ebp+8]
		mov	[ebp-10h], eax
		mov	eax, 0
		mov	cl, _nf_fqty

L39:
		push	ecx
		push	edi
		mov	ch, byte ptr [ebp+20h]

L40:
		mov	cl, byte ptr [ebp+1ch]

L41:
		add	ax, ax
		ja	short L42
		jz	short L44
		cmp	word ptr [ebx],	0
		jz	short L45
		add	ebx, 2

L42:
		add	edi, 10h

L43:
		dec	cl
		jnz	short L41
		add	edi, [ebp-8]
		dec	ch
		jnz	short L40
		pop	edi
		pop	ecx
		add	edi, _nf_width
		dec	cl
		jnz	short L39
		jmp	short L46

L44:
		mov	eax, [ebp-10h]
		add	dword ptr [ebp-10h], 2
		mov	ax, [eax]
		jmp	short L41

L45:
		movsd
		movsd
		movsd
		movsd
		add	edi, edx
		movsd
		movsd
		movsd
		movsd
		add	edi, edx
		movsd
		movsd
		movsd
		movsd
		add	edi, edx
		movsd
		movsd
		movsd
		movsd
		add	edi, edx
		movsd
		movsd
		movsd
		movsd
		add	edi, edx
		movsd
		movsd
		movsd
		movsd
		add	edi, edx
		movsd
		movsd
		movsd
		movsd
		add	edi, edx
		movsd
		movsd
		movsd
		movsd
		sub	edi, _nf_back_right
		add	ebx, 2
		jmp	short L43

L46:
		mov	edi, [ebp-4]
		mov	ebx, [ebp+0ch]
		mov	eax, [ebp+8]
		mov	[ebp-10h], eax
		mov	eax, 0
		mov	cl, _nf_fqty
		xor	esi, esi

L47:
		push	ecx
		push	edi
		mov	ch, byte ptr [ebp+20h]

L48:
		mov	cl, byte ptr [ebp+1ch]

L49:
		add	ax, ax
		ja	short L50
		jz	short L52
		or	si, [ebx]
		jg	short L54
		jl	short L53
		add	ebx, 2

L50:
		add	edi, 10h

L51:
		dec	cl
		jnz	short L49
		add	edi, [ebp-8]
		dec	ch
		jnz	short L48
		pop	edi
		pop	ecx
		add	edi, _nf_width
		dec	cl
		jnz	short L47
		jmp	L63

L52:
		mov	eax, [ebp-10h]
		add	dword ptr [ebp-10h], 2
		mov	ax, [eax]
		jmp	short L49

L53:
		jmp	L62

L54:
		lea	esi, [edi+esi*2-8000h]
		movsd
		movsd
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		movsd
		movsd
		sub	edi, _nf_back_right
		xor	esi, esi
		add	ebx, 2
		jmp	short L51

L55:
		push	ecx
		push	edi
		mov	ch, byte ptr [ebp+20h]

L56:
		mov	cl, byte ptr [ebp+1ch]

L57:
		add	ax, ax
		ja	short L58
		jz	short L60
		or	si, [ebx]
		jl	short L62
		jg	short L61
		add	ebx, 2

L58:
		add	edi, 10h

L59:
		dec	cl
		jnz	short L57
		add	edi, [ebp-8]
		dec	ch
		jnz	short L56
		pop	edi
		pop	ecx
		add	edi, _nf_width
		dec	cl
		jnz	short L55
		jmp	short L63

L60:
		mov	eax, [ebp-10h]
		add	dword ptr [ebp-10h], 2
		mov	ax, [eax]
		jmp	short L57

L61:
		jmp	L54

L62:
		lea	esi, [edi+esi*2-18000h]
		add	esi, [ebp-0ch]
		movsd
		movsd
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		movsd
		movsd
		sub	edi, _nf_back_right
		add	ebx, 2
		xor	esi, esi
		jmp	short L59

L63:
		pop	ebx
		pop	edi
		pop	esi
		leave
		retn

PUBLIC _nfDecomp
_nfDecomp:
		push	ebp
		mov	ebp, esp
		add	esp, 0FFFFFFF0h
		push	esi
		push	edi
		push	ebx
		cmp	_nf_hicolor, 0
		jz	short L64
		push	dword ptr [ebp+18h]
		push	dword ptr [ebp+14h]
		push	dword ptr [ebp+10h]
		push	dword ptr [ebp+0ch]
		push	dword ptr [ebp+8]
		call	_nfHiColorDecomp
		add	esp, 14h
		pop	ebx
		pop	edi
		pop	esi
		leave
		retn

L64:
		mov	ax, ds
		mov	es, ax
		mov	eax, _nf_buf_prv
		sub	eax, _nf_buf_cur
		mov	[ebp-0ch], eax
		xor	ebx, ebx
		mov	bl, _nf_fqty
		mov	eax, [ebp+0ch]
		shl	eax, 3
		mov	_nf_new_x, eax
		mov	eax, [ebp+14h]
		shl	eax, 3
		mov	_nf_new_w, eax
		mov	eax, [ebp+10h]
		shl	eax, 3
		mul	ebx
		mov	_nf_new_y, eax
		mov	eax, [ebp+18h]
		shl	eax, 3
		mul	ebx
		mov	_nf_new_h, eax
		mov	eax, _nf_new_row0
		sub	eax, _nf_new_w
		mov	[ebp-8], eax
		mov	eax, _nf_buf_cur
		mov	[ebp-4], eax
		cmp	dword ptr [ebp+0ch], 0
		jnz	short L65
		cmp	dword ptr [ebp+10h], 0
		jz	short L66

L65:
		mov	eax, _nf_new_y
		mul	_nf_width
		add	eax, _nf_new_x
		add	[ebp-4], eax

L66:
		mov	eax, [ebp+14h]
		mul	dword ptr [ebp+18h]
		mul	ebx
		shl	eax, 1
		mov	[ebp-10h], eax
		mov	edi, [ebp-4]
		mov	edx, _nf_new_line
		mov	ebx, [ebp+8]
		mov	esi, ebx
		add	esi, [ebp-10h]
		mov	cl, _nf_fqty

L67:
		push	ecx
		push	edi
		mov	ch, byte ptr [ebp+18h]

L68:
		mov	cl, byte ptr [ebp+14h]

L69:
		cmp	word ptr [ebx],	0
		jz	short L71
		add	edi, 8

L70:
		add	ebx, 2
		dec	cl
		jnz	short L69
		add	edi, [ebp-8]
		dec	ch
		jnz	short L68
		pop	edi
		pop	ecx
		add	edi, _nf_width
		dec	cl
		jnz	short L67
		jmp	short L72

L71:
		movsd
		movsd
		add	edi, edx
		movsd
		movsd
		add	edi, edx
		movsd
		movsd
		add	edi, edx
		movsd
		movsd
		add	edi, edx
		movsd
		movsd
		add	edi, edx
		movsd
		movsd
		add	edi, edx
		movsd
		movsd
		add	edi, edx
		movsd
		movsd
		sub	edi, _nf_back_right
		jmp	short L70

L72:
		sub	ebx, [ebp-10h]
		mov	edi, [ebp-4]
		mov	cl, _nf_fqty
		xor	esi, esi

L73:
		push	ecx
		push	edi
		mov	ch, byte ptr [ebp+18h]

L74:
		mov	cl, byte ptr [ebp+14h]

L75:
		or	si, [ebx]
		jg	short L78
		jl	short L77
		add	edi, 8

L76:
		add	ebx, 2
		dec	cl
		jnz	short L75
		add	edi, [ebp-8]
		dec	ch
		jnz	short L74
		pop	edi
		pop	ecx
		add	edi, _nf_width
		dec	cl
		jnz	short L73
		jmp	L85

L77:
		jmp	short L84

L78:
		lea	esi, [esi+edi-4000h]
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		sub	edi, _nf_back_right
		xor	esi, esi
		jmp	short L76

L79:
		push	ecx
		push	edi
		mov	ch, byte ptr [ebp+18h]

L80:
		mov	cl, byte ptr [ebp+14h]

L81:
		or	si, [ebx]
		jl	short L84
		jg	short L83
		add	edi, 8

L82:
		add	ebx, 2
		dec	cl
		jnz	short L81
		add	edi, [ebp-8]
		dec	ch
		jnz	short L80
		pop	edi
		pop	ecx
		add	edi, _nf_width
		dec	cl
		jnz	short L79
		jmp	short L85

L83:
		jmp	short L78

L84:
		lea	esi, [esi+edi-0C000h]
		add	esi, [ebp-0ch]
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		sub	edi, _nf_back_right
		xor	esi, esi
		jmp	short L82

L85:
		pop	ebx
		pop	edi
		pop	esi
		leave
		retn

PUBLIC _nfDecompChg
_nfDecompChg:
		push	ebp
		mov	ebp, esp
		add	esp, 0FFFFFFF0h
		push	esi
		push	edi
		push	ebx
		cmp	_nf_hicolor, 0
		jz	short L86
		push	dword ptr [ebp+20h]
		push	dword ptr [ebp+1ch]
		push	dword ptr [ebp+18h]
		push	dword ptr [ebp+14h]
		push	dword ptr [ebp+10h]
		push	dword ptr [ebp+0ch]
		push	dword ptr [ebp+8]
		call	_nfHiColorDecompChg
		add	esp, 1Ch
		pop	ebx
		pop	edi
		pop	esi
		leave
		retn

L86:
		mov	ax, ds
		mov	es, ax
		mov	eax, _nf_buf_prv
		sub	eax, _nf_buf_cur
		mov	[ebp-0ch], eax
		xor	ebx, ebx
		mov	bl, _nf_fqty
		mov	eax, [ebp+14h]
		shl	eax, 3
		mov	_nf_new_x, eax
		mov	eax, [ebp+1ch]
		shl	eax, 3
		mov	_nf_new_w, eax
		mov	eax, [ebp+18h]
		shl	eax, 3
		mul	ebx
		mov	_nf_new_y, eax
		mov	eax, [ebp+20h]
		shl	eax, 3
		mul	ebx
		mov	_nf_new_h, eax
		mov	eax, _nf_new_row0
		sub	eax, _nf_new_w
		mov	[ebp-8], eax
		mov	eax, _nf_buf_cur
		mov	[ebp-4], eax
		cmp	dword ptr [ebp+14h], 0
		jnz	short L87
		cmp	dword ptr [ebp+18h], 0
		jz	short L88

L87:
		mov	eax, _nf_new_y
		mul	_nf_width
		add	eax, _nf_new_x
		add	[ebp-4], eax

L88:
		mov	edi, [ebp-4]
		mov	edx, _nf_new_line
		mov	esi, [ebp+10h]
		mov	ebx, [ebp+0ch]
		mov	eax, [ebp+8]
		mov	[ebp-10h], eax
		mov	eax, 0
		mov	cl, _nf_fqty

L89:
		push	ecx
		push	edi
		mov	ch, byte ptr [ebp+20h]

L90:
		mov	cl, byte ptr [ebp+1ch]

L91:
		add	ax, ax
		ja	short L92
		jz	short L94
		cmp	word ptr [ebx],	0
		jz	short L95
		add	ebx, 2

L92:
		add	edi, 8

L93:
		dec	cl
		jnz	short L91
		add	edi, [ebp-8]
		dec	ch
		jnz	short L90
		pop	edi
		pop	ecx
		add	edi, _nf_width
		dec	cl
		jnz	short L89
		jmp	short L96

L94:
		mov	eax, [ebp-10h]
		add	dword ptr [ebp-10h], 2
		mov	ax, [eax]
		jmp	short L91

L95:
		movsd
		movsd
		add	edi, edx
		movsd
		movsd
		add	edi, edx
		movsd
		movsd
		add	edi, edx
		movsd
		movsd
		add	edi, edx
		movsd
		movsd
		add	edi, edx
		movsd
		movsd
		add	edi, edx
		movsd
		movsd
		add	edi, edx
		movsd
		movsd
		sub	edi, _nf_back_right
		add	ebx, 2
		jmp	short L93

L96:
		mov	edi, [ebp-4]
		mov	ebx, [ebp+0ch]
		mov	eax, [ebp+8]
		mov	[ebp-10h], eax
		mov	eax, 0
		mov	cl, _nf_fqty
		xor	esi, esi

L97:
		push	ecx
		push	edi
		mov	ch, byte ptr [ebp+20h]

L98:
		mov	cl, byte ptr [ebp+1ch]

L99:
		add	ax, ax
		ja	short L100
		jz	short L102
		or	si, [ebx]
		jg	short L104
		jl	short L103
		add	ebx, 2

L100:
		add	edi, 8

L101:
		dec	cl
		jnz	short L99
		add	edi, [ebp-8]
		dec	ch
		jnz	short L98
		pop	edi
		pop	ecx
		add	edi, _nf_width
		dec	cl
		jnz	short L97
		jmp	L113

L102:
		mov	eax, [ebp-10h]
		add	dword ptr [ebp-10h], 2
		mov	ax, [eax]
		jmp	short L99

L103:
		jmp	L112

L104:
		lea	esi, [esi+edi-4000h]
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		sub	edi, _nf_back_right
		xor	esi, esi
		add	ebx, 2
		jmp	short L101

L105:
		push	ecx
		push	edi
		mov	ch, byte ptr [ebp+20h]

L106:
		mov	cl, byte ptr [ebp+1ch]

L107:
		add	ax, ax
		ja	short L108
		jz	short L110
		or	si, [ebx]
		jl	short L112
		jg	short L111
		add	ebx, 2

L108:
		add	edi, 8

L109:
		dec	cl
		jnz	short L107
		add	edi, [ebp-8]
		dec	ch
		jnz	short L106
		pop	edi
		pop	ecx
		add	edi, _nf_width
		dec	cl
		jnz	short L105
		jmp	short L113

L110:
		mov	eax, [ebp-10h]
		add	dword ptr [ebp-10h], 2
		mov	ax, [eax]
		jmp	short L107

L111:
		jmp	L104

L112:
		lea	esi, [esi+edi-0C000h]
		add	esi, [ebp-0ch]
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		add	esi, edx
		add	edi, edx
		movsd
		movsd
		sub	edi, _nf_back_right
		add	ebx, 2
		xor	esi, esi
		jmp	short L109

L113:
		pop	ebx
		pop	edi
		pop	esi
		leave
		retn

PUBLIC _nfPkConfig
_nfPkConfig:
		push	esi
		push	edi
		push	ebx
		lea	edi, dword_124484
		mov	ebx, _nf_width
		mov	eax, 0
		mov	ecx, 80h

L114:
		mov	[edi], eax
		add	edi, 4
		add	eax, ebx
		dec	ecx
		jnz	short L114
		mov	eax, ebx
		shl	eax, 7
		neg	eax
		mov	ecx, 80h

L115:
		mov	[edi], eax
		add	edi, 4
		add	eax, ebx
		dec	ecx
		jnz	short L115
		pop	ebx
		pop	edi
		pop	esi
		retn

PUBLIC _nfPkDecomp
_nfPkDecomp:
		push	ebp
		mov	ebp, esp
		add	esp, 0FFFFFFECh
		push	esi
		push	edi
		push	ebx
		mov	ax, ds
		mov	es, ax
		mov	eax, _nf_buf_prv
		sub	eax, _nf_buf_cur
		mov	[ebp-0ch], eax
		xor	ebx, ebx
		mov	bl, _nf_fqty
		mov	eax, [ebp+10h]
		shl	eax, 3
		mov	_nf_new_x, eax
		mov	eax, [ebp+18h]
		shl	eax, 3
		mov	_nf_new_w, eax
		mov	eax, [ebp+14h]
		shl	eax, 3
		mul	ebx
		mov	_nf_new_y, eax
		mov	eax, [ebp+1ch]
		shl	eax, 3
		mul	ebx
		mov	_nf_new_h, eax
		mov	eax, _nf_new_row0
		sub	eax, _nf_new_w
		mov	[ebp-8], eax
		mov	eax, _nf_buf_cur
		mov	[ebp-4], eax
		cmp	dword ptr [ebp+10h], 0
		jnz	short L116
		cmp	dword ptr [ebp+14h], 0
		jz	short L117

L116:
		mov	eax, _nf_new_y
		mul	_nf_width
		add	eax, _nf_new_x
		add	[ebp-4], eax

L117:
		mov	eax, _nf_back_right
		sub	eax, 8
		mov	[ebp-10h], eax
		mov	esi, [ebp+0ch]
		mov	edi, [ebp-4]

L118:
		mov	eax, [ebp+18h]
		shr	eax, 1
		mov	[ebp-14h], eax

L119:
		dec	dword ptr [ebp-14h]
		js	short L120
		mov	ebx, [ebp+8]
		mov	al, [ebx]
		inc	ebx
		mov	[ebp+8], ebx
		xor	ebx, ebx
		mov	bl, al
		shr	bl, 4
		and	eax, 0Fh
		push	offset L119
		push	off_1254C4[ebx*4]
		jmp	off_1254C4[eax*4]

L120:
		add	edi, [ebp-8]
		dec	dword ptr [ebp+1ch]
		jnz	short L118
		pop	ebx
		pop	edi
		pop	esi
		leave
		retn

L121:
		mov	eax, [ebp-0ch]
		jmp	L132

L122:
		add	edi, 8
		retn

L123:
		xor	eax, eax
		mov	al, [esi]
		inc	esi
		mov	ax, word_124A84[eax*2]

L124:
		xor	ebx, ebx
		mov	bl, ah
		shl	eax, 18h
		sar	eax, 18h
		add	eax, dword_124484[ebx*4]
		jmp	short L132

L125:
		xor	eax, eax
		mov	al, [esi]
		inc	esi
		mov	ax, word_124A84[eax*2]
		neg	al
		neg	ah
		jmp	short L124
		align 4

L126:
		xor	eax, eax
		mov	al, [esi]
		inc	esi
		mov	ax, word_124884[eax*2]
		jmp	short L128
		align 4

L127:
		mov	ax, [esi]
		add	esi, 2

L128:
		xor	ebx, ebx
		mov	bl, ah
		shl	eax, 18h
		sar	eax, 18h
		add	eax, dword_124484[ebx*4]
		add	eax, [ebp-0ch]
		jmp	short L132

L129:
		add	esp, 4
		add	ebx, 2
		mov	eax, eax

L130:
		add	edi, 10h
		dec	ebx
		jz	short L131
		dec	dword ptr [ebp-14h]
		jns	short L130
		add	edi, [ebp-8]
		dec	dword ptr [ebp+1ch]
		mov	eax, [ebp+18h]
		shr	eax, 1
		dec	eax
		mov	[ebp-14h], eax
		jmp	short L130

L131:
		retn
		align 4

L132:
		mov	ebx, esi
		lea	esi, [edi+eax]
		mov	edx, _nf_width
		mov	eax, [esi]
		mov	[edi], eax
		mov	eax, [esi+4]
		mov	[edi+4], eax
		add	esi, edx
		add	edi, edx
		mov	eax, [esi]
		mov	[edi], eax
		mov	eax, [esi+4]
		mov	[edi+4], eax
		add	esi, edx
		add	edi, edx
		mov	eax, [esi]
		mov	[edi], eax
		mov	eax, [esi+4]
		mov	[edi+4], eax
		add	esi, edx
		add	edi, edx
		mov	eax, [esi]
		mov	[edi], eax
		mov	eax, [esi+4]
		mov	[edi+4], eax
		add	esi, edx
		add	edi, edx
		mov	eax, [esi]
		mov	[edi], eax
		mov	eax, [esi+4]
		mov	[edi+4], eax
		add	esi, edx
		add	edi, edx
		mov	eax, [esi]
		mov	[edi], eax
		mov	eax, [esi+4]
		mov	[edi+4], eax
		add	esi, edx
		add	edi, edx
		mov	eax, [esi]
		mov	[edi], eax
		mov	eax, [esi+4]
		mov	[edi+4], eax
		add	esi, edx
		add	edi, edx
		mov	eax, [esi]
		mov	[edi], eax
		mov	eax, [esi+4]
		mov	[edi+4], eax
		sub	edi, [ebp-10h]
		mov	esi, ebx
		retn
		align 4

L133:
		mov	ax, [esi]
		cmp	al, ah
		ja	L135
		xor	eax, eax
		lea	ecx, byte_124CC4
		lea	edx, L134+2
		mov	al, [esi+2]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+6], bh
		shr	ebx, 10h
		mov	[edx+0Bh], bl
		mov	[edx+11h], bh
		mov	al, [esi+3]
		mov	ebx, [ecx+eax*4]
		mov	[edx+19h], bl
		mov	[edx+1Fh], bh
		shr	ebx, 10h
		mov	[edx+24h], bl
		mov	[edx+2Ah], bh
		mov	al, [esi+4]
		mov	ebx, [ecx+eax*4]
		mov	[edx+32h], bl
		mov	[edx+38h], bh
		shr	ebx, 10h
		mov	[edx+3Dh], bl
		mov	[edx+43h], bh
		mov	al, [esi+5]
		mov	ebx, [ecx+eax*4]
		mov	[edx+4Bh], bl
		mov	[edx+51h], bh
		shr	ebx, 10h
		mov	[edx+56h], bl
		mov	[edx+5Ch], bh
		lea	edx, [edx+64h]
		mov	al, [esi+6]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+6], bh
		shr	ebx, 10h
		mov	[edx+0Bh], bl
		mov	[edx+11h], bh
		mov	al, [esi+7]
		mov	ebx, [ecx+eax*4]
		mov	[edx+19h], bl
		mov	[edx+1Fh], bh
		shr	ebx, 10h
		mov	[edx+24h], bl
		mov	[edx+2Ah], bh
		mov	al, [esi+8]
		mov	ebx, [ecx+eax*4]
		mov	[edx+32h], bl
		mov	[edx+38h], bh
		shr	ebx, 10h
		mov	[edx+3Dh], bl
		mov	[edx+43h], bh
		mov	al, [esi+9]
		mov	ebx, [ecx+eax*4]
		mov	[edx+4Bh], bl
		mov	[edx+51h], bh
		shr	ebx, 10h
		mov	[edx+56h], bl
		mov	[edx+5Ch], bh
		push	ebp
		push	esi
		mov	cx, [esi]
		mov	esi, _nf_width
		mov	bl, cl
		mov	bh, cl
		mov	dl, ch
		mov	dh, cl
		mov	al, ch
		mov	ah, ch
		mov	ebp, eax
		jmp	short L134
		align 4

L134:
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		pop	esi
		pop	ebp
		add	esi, 0Ah
		sub	edi, [ebp-10h]
		retn
		align 4

L135:
		xor	eax, eax
		lea	ecx, byte_124C84
		lea	edx, L136+2
		mov	al, [esi+2]
		and	al, 0Fh
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+6], bh
		shr	ebx, 10h
		mov	[edx+0Eh], bl
		mov	[edx+14h], bh
		mov	al, [esi+2]
		shr	al, 4
		mov	ebx, [ecx+eax*4]
		mov	[edx+21h], bl
		mov	[edx+27h], bh
		shr	ebx, 10h
		mov	[edx+2Fh], bl
		mov	[edx+35h], bh
		mov	al, [esi+3]
		and	al, 0Fh
		mov	ebx, [ecx+eax*4]
		mov	[edx+42h], bl
		mov	[edx+48h], bh
		shr	ebx, 10h
		mov	[edx+50h], bl
		mov	[edx+56h], bh
		mov	al, [esi+3]
		shr	al, 4
		mov	ebx, [ecx+eax*4]
		mov	[edx+63h], bl
		mov	[edx+69h], bh
		shr	ebx, 10h
		mov	[edx+71h], bl
		mov	[edx+77h], bh
		mov	edx, _nf_width
		mov	bx, [esi]
		mov	cl, bh
		mov	bh, bl
		mov	ch, cl
		jmp	short $+2

L136:
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	[edi+edx], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		mov	[edi+edx+4], eax
		lea	edi, [edi+edx*2]
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	[edi+edx], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		mov	[edi+edx+4], eax
		lea	edi, [edi+edx*2]
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	[edi+edx], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		mov	[edi+edx+4], eax
		lea	edi, [edi+edx*2]
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	[edi+edx], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, edx
		mov	[edi+4], eax
		sub	edi, [ebp-10h]
		add	esi, 4
		retn
		align 4

L137:
		mov	ax, [esi]
		cmp	al, ah
		ja	L139
		xor	eax, eax
		lea	ecx, byte_124CC4
		lea	edx, L138+2
		mov	al, [esi+2]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+6], bh
		shr	ebx, 10h
		mov	[edx+0Dh], bl
		mov	[edx+13h], bh
		mov	al, [esi+3]
		mov	ebx, [ecx+eax*4]
		mov	[edx+1Ah], bl
		mov	[edx+20h], bh
		shr	ebx, 10h
		mov	[edx+27h], bl
		mov	[edx+2Dh], bh
		mov	al, [esi+6]
		mov	ebx, [ecx+eax*4]
		mov	[edx+49h], bl
		mov	[edx+4Fh], bh
		shr	ebx, 10h
		mov	[edx+56h], bl
		mov	[edx+5Ch], bh
		mov	al, [esi+7]
		mov	ebx, [ecx+eax*4]
		mov	[edx+63h], bl
		mov	[edx+69h], bh
		shr	ebx, 10h
		mov	[edx+70h], bl
		mov	[edx+76h], bh
		add	edx, 9Bh
		mov	al, [esi+0Ah]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+6], bh
		shr	ebx, 10h
		mov	[edx+0Dh], bl
		mov	[edx+13h], bh
		mov	al, [esi+0Bh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+1Ah], bl
		mov	[edx+20h], bh
		shr	ebx, 10h
		mov	[edx+27h], bl
		mov	[edx+2Dh], bh
		mov	al, [esi+0Eh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+49h], bl
		mov	[edx+4Fh], bh
		shr	ebx, 10h
		mov	[edx+56h], bl
		mov	[edx+5Ch], bh
		mov	al, [esi+0Fh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+63h], bl
		mov	[edx+69h], bh
		shr	ebx, 10h
		mov	[edx+70h], bl
		mov	[edx+76h], bh
		push	ebp
		push	esi
		mov	cx, [esi]
		mov	esi, _nf_width
		mov	bl, cl
		mov	bh, cl
		mov	dl, ch
		mov	dh, cl
		mov	al, ch
		mov	ah, ch
		mov	ebp, eax
		jmp	short $+2

L138:
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		mov	eax, [esp]
		mov	cx, [eax+4]
		mov	bl, cl
		mov	bh, cl
		mov	dl, ch
		mov	dh, cl
		mov	al, ch
		mov	ah, ch
		mov	ebp, eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		lea	eax, ds:0FFFFFFFCh[esi*8]
		sub	edi, eax
		mov	eax, [esp]
		mov	cx, [eax+8]
		mov	bl, cl
		mov	bh, cl
		mov	dl, ch
		mov	dh, cl
		mov	al, ch
		mov	ah, ch
		mov	ebp, eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		mov	eax, [esp]
		mov	cx, [eax+0Ch]
		mov	bl, cl
		mov	bh, cl
		mov	dl, ch
		mov	dh, cl
		mov	al, ch
		mov	ah, ch
		mov	ebp, eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		pop	esi
		pop	ebp
		add	esi, 10h
		sub	edi, 4
		sub	edi, [ebp-10h]
		retn
		align 4

L139:
		mov	ax, [esi+6]
		cmp	al, ah
		ja	L141
		xor	eax, eax
		lea	ecx, byte_124CC4
		lea	edx, L140+2
		mov	al, [esi+2]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+6], bh
		shr	ebx, 10h
		mov	[edx+0Dh], bl
		mov	[edx+13h], bh
		mov	al, [esi+3]
		mov	ebx, [ecx+eax*4]
		mov	[edx+1Ah], bl
		mov	[edx+20h], bh
		shr	ebx, 10h
		mov	[edx+27h], bl
		mov	[edx+2Dh], bh
		mov	al, [esi+4]
		mov	ebx, [ecx+eax*4]
		mov	[edx+34h], bl
		mov	[edx+3Ah], bh
		shr	ebx, 10h
		mov	[edx+41h], bl
		mov	[edx+47h], bh
		mov	al, [esi+5]
		mov	ebx, [ecx+eax*4]
		mov	[edx+4Eh], bl
		mov	[edx+54h], bh
		shr	ebx, 10h
		mov	[edx+5Bh], bl
		mov	[edx+61h], bh
		add	edx, 86h
		mov	al, [esi+8]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+6], bh
		shr	ebx, 10h
		mov	[edx+0Dh], bl
		mov	[edx+13h], bh
		mov	al, [esi+9]
		mov	ebx, [ecx+eax*4]
		mov	[edx+1Ah], bl
		mov	[edx+20h], bh
		shr	ebx, 10h
		mov	[edx+27h], bl
		mov	[edx+2Dh], bh
		mov	al, [esi+0Ah]
		mov	ebx, [ecx+eax*4]
		mov	[edx+34h], bl
		mov	[edx+3Ah], bh
		shr	ebx, 10h
		mov	[edx+41h], bl
		mov	[edx+47h], bh
		mov	al, [esi+0Bh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+4Eh], bl
		mov	[edx+54h], bh
		shr	ebx, 10h
		mov	[edx+5Bh], bl
		mov	[edx+61h], bh
		push	ebp
		push	esi
		mov	cx, [esi]
		mov	esi, _nf_width
		mov	bl, cl
		mov	bh, cl
		mov	dl, ch
		mov	dh, cl
		mov	al, ch
		mov	ah, ch
		mov	ebp, eax
		jmp	short L140
		align 4

L140:
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		lea	eax, ds:0FFFFFFFCh[esi*8]
		sub	edi, eax
		mov	eax, [esp]
		mov	cx, [eax+6]
		mov	bl, cl
		mov	bh, cl
		mov	dl, ch
		mov	dh, cl
		mov	al, ch
		mov	ah, ch
		mov	ebp, eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		pop	esi
		pop	ebp
		add	esi, 0Ch
		sub	edi, 4
		sub	edi, [ebp-10h]
		retn

L141:
		xor	eax, eax
		lea	ecx, byte_124CC4
		lea	edx, L142+2
		mov	al, [esi+2]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+6], bh
		shr	ebx, 10h
		mov	[edx+0Bh], bl
		mov	[edx+11h], bh
		mov	al, [esi+3]
		mov	ebx, [ecx+eax*4]
		mov	[edx+19h], bl
		mov	[edx+1Fh], bh
		shr	ebx, 10h
		mov	[edx+24h], bl
		mov	[edx+2Ah], bh
		mov	al, [esi+4]
		mov	ebx, [ecx+eax*4]
		mov	[edx+32h], bl
		mov	[edx+38h], bh
		shr	ebx, 10h
		mov	[edx+3Dh], bl
		mov	[edx+43h], bh
		mov	al, [esi+5]
		mov	ebx, [ecx+eax*4]
		mov	[edx+4Bh], bl
		mov	[edx+51h], bh
		shr	ebx, 10h
		mov	[edx+56h], bl
		mov	[edx+5Ch], bh
		add	edx, L142_0-L142 ; hack
		mov	al, [esi+8]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+6], bh
		shr	ebx, 10h
		mov	[edx+0Bh], bl
		mov	[edx+11h], bh
		mov	al, [esi+9]
		mov	ebx, [ecx+eax*4]
		mov	[edx+19h], bl
		mov	[edx+1Fh], bh
		shr	ebx, 10h
		mov	[edx+24h], bl
		mov	[edx+2Ah], bh
		mov	al, [esi+0Ah]
		mov	ebx, [ecx+eax*4]
		mov	[edx+32h], bl
		mov	[edx+38h], bh
		shr	ebx, 10h
		mov	[edx+3Dh], bl
		mov	[edx+43h], bh
		mov	al, [esi+0Bh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+4Bh], bl
		mov	[edx+51h], bh
		shr	ebx, 10h
		mov	[edx+56h], bl
		mov	[edx+5Ch], bh
		push	ebp
		push	esi
		mov	cx, [esi]
		mov	esi, _nf_width
		mov	bl, cl
		mov	bh, cl
		mov	dl, ch
		mov	dh, cl
		mov	al, ch
		mov	ah, ch
		mov	ebp, eax
		jmp	short L142
		align 4

L142:
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	eax, [esp]
		mov	cx, [eax+6]
		mov	bl, cl
		mov	bh, cl
		mov	dl, ch
		mov	dh, cl
		mov	al, ch
		mov	ah, ch
		mov	ebp, eax
L142_0:
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		pop	esi
		pop	ebp
		add	esi, 0Ch
		sub	edi, [ebp-10h]
		retn

L143:
		mov	eax, [esi]
		cmp	al, ah
		ja	L147
		shr	eax, 10h
		cmp	al, ah
		ja	L145
		xor	eax, eax
		lea	ecx, byte_1250C4
		lea	edx, L144+1
		mov	al, [esi+4]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+2], bh
		shr	ebx, 10h
		mov	[edx+7], bl
		mov	[edx+9], bh
		mov	al, [esi+5]
		mov	ebx, [ecx+eax*4]
		mov	[edx+0Dh], bl
		mov	[edx+0Fh], bh
		shr	ebx, 10h
		mov	[edx+14h], bl
		mov	[edx+16h], bh
		mov	al, [esi+6]
		mov	ebx, [ecx+eax*4]
		mov	[edx+1Dh], bl
		mov	[edx+1Fh], bh
		shr	ebx, 10h
		mov	[edx+24h], bl
		mov	[edx+26h], bh
		mov	al, [esi+7]
		mov	ebx, [ecx+eax*4]
		mov	[edx+2Ah], bl
		mov	[edx+2Ch], bh
		shr	ebx, 10h
		mov	[edx+31h], bl
		mov	[edx+33h], bh
		mov	al, [esi+8]
		mov	ebx, [ecx+eax*4]
		mov	[edx+3Ah], bl
		mov	[edx+3Ch], bh
		shr	ebx, 10h
		mov	[edx+41h], bl
		mov	[edx+43h], bh
		mov	al, [esi+9]
		mov	ebx, [ecx+eax*4]
		mov	[edx+47h], bl
		mov	[edx+49h], bh
		shr	ebx, 10h
		mov	[edx+4Eh], bl
		mov	[edx+50h], bh
		mov	al, [esi+0Ah]
		mov	ebx, [ecx+eax*4]
		mov	[edx+57h], bl
		mov	[edx+59h], bh
		shr	ebx, 10h
		mov	[edx+5Eh], bl
		mov	[edx+60h], bh
		mov	al, [esi+0Bh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+64h], bl
		mov	[edx+66h], bh
		shr	ebx, 10h
		mov	[edx+6Bh], bl
		mov	[edx+6Dh], bh
		lea	edx, [edx+74h]
		mov	al, [esi+0Ch]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+2], bh
		shr	ebx, 10h
		mov	[edx+7], bl
		mov	[edx+9], bh
		mov	al, [esi+0Dh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+0Dh], bl
		mov	[edx+0Fh], bh
		shr	ebx, 10h
		mov	[edx+14h], bl
		mov	[edx+16h], bh
		mov	al, [esi+0Eh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+1Dh], bl
		mov	[edx+1Fh], bh
		shr	ebx, 10h
		mov	[edx+24h], bl
		mov	[edx+26h], bh
		mov	al, [esi+0Fh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+2Ah], bl
		mov	[edx+2Ch], bh
		shr	ebx, 10h
		mov	[edx+31h], bl
		mov	[edx+33h], bh
		mov	al, [esi+10h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+3Ah], bl
		mov	[edx+3Ch], bh
		shr	ebx, 10h
		mov	[edx+41h], bl
		mov	[edx+43h], bh
		mov	al, [esi+11h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+47h], bl
		mov	[edx+49h], bh
		shr	ebx, 10h
		mov	[edx+4Eh], bl
		mov	[edx+50h], bh
		mov	al, [esi+12h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+57h], bl
		mov	[edx+59h], bh
		shr	ebx, 10h
		mov	[edx+5Eh], bl
		mov	[edx+60h], bh
		mov	al, [esi+13h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+64h], bl
		mov	[edx+66h], bh
		shr	ebx, 10h
		mov	[edx+6Bh], bl
		mov	[edx+6Dh], bh
		mov	bx, [esi]
		mov	cx, [esi+2]
		mov	edx, _nf_width
		jmp	short L144
		align 4

L144:
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi+4], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi+4], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi+4], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi+4], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi+4], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi+4], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi+4], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi+4], eax
		add	esi, 14h
		sub	edi, [ebp-10h]
		retn
		align 4

L145:
		xor	eax, eax
		lea	ecx, byte_1250C4
		lea	edx, L146+1
		mov	al, [esi+4]
		mov	ebx, [ecx+eax*4]
		mov	[edx+17h], bl
		mov	[edx+10h], bh
		shr	ebx, 10h
		mov	[edx+7], bl
		mov	[edx], bh
		mov	al, [esi+5]
		mov	ebx, [ecx+eax*4]
		mov	[edx+3Ch], bl
		mov	[edx+35h], bh
		shr	ebx, 10h
		mov	[edx+2Ch], bl
		mov	[edx+25h], bh
		mov	al, [esi+6]
		mov	ebx, [ecx+eax*4]
		mov	[edx+61h], bl
		mov	[edx+5Ah], bh
		shr	ebx, 10h
		mov	[edx+51h], bl
		mov	[edx+4Ah], bh
		mov	al, [esi+7]
		mov	ebx, [ecx+eax*4]
		mov	[edx+86h], bl
		mov	[edx+7Fh], bh
		shr	ebx, 10h
		mov	[edx+76h], bl
		mov	[edx+6Fh], bh
		mov	bx, [esi]
		mov	cx, [esi+2]
		mov	edx, _nf_width
		jmp	short L146
		align 4

L146:
		mov	ah, bl
		mov	al, ah
		shl	eax, 10h
		mov	al, bl
		mov	ah, al
		mov	[edi], eax
		mov	[edi+edx], eax
		mov	ah, bl
		mov	al, ah
		shl	eax, 10h
		mov	al, bl
		mov	ah, al
		mov	[edi+4], eax
		mov	[edi+edx+4], eax
		lea	edi, [edi+edx*2]
		mov	ah, bl
		mov	al, ah
		shl	eax, 10h
		mov	al, bl
		mov	ah, al
		mov	[edi], eax
		mov	[edi+edx], eax
		mov	ah, bl
		mov	al, ah
		shl	eax, 10h
		mov	al, bl
		mov	ah, al
		mov	[edi+4], eax
		mov	[edi+edx+4], eax
		lea	edi, [edi+edx*2]
		mov	ah, bl
		mov	al, ah
		shl	eax, 10h
		mov	al, bl
		mov	ah, al
		mov	[edi], eax
		mov	[edi+edx], eax
		mov	ah, bl
		mov	al, ah
		shl	eax, 10h
		mov	al, bl
		mov	ah, al
		mov	[edi+4], eax
		mov	[edi+edx+4], eax
		lea	edi, [edi+edx*2]
		mov	ah, bl
		mov	al, ah
		shl	eax, 10h
		mov	al, bl
		mov	ah, al
		mov	[edi], eax
		mov	[edi+edx], eax
		mov	ah, bl
		mov	al, ah
		shl	eax, 10h
		mov	al, bl
		mov	ah, al
		mov	[edi+4], eax
		mov	[edi+edx+4], eax
		add	edi, edx
		add	esi, 8
		sub	edi, [ebp-10h]
		retn
		align 4

L147:
		shr	eax, 10h
		cmp	al, ah
		ja	L149
		xor	eax, eax
		lea	ecx, byte_1250C4
		lea	edx, L148+1
		mov	al, [esi+4]
		mov	ebx, [ecx+eax*4]
		mov	[edx+14h], bl
		mov	[edx+0Dh], bh
		shr	ebx, 10h
		mov	[edx+7], bl
		mov	[edx], bh
		mov	al, [esi+5]
		mov	ebx, [ecx+eax*4]
		mov	[edx+31h], bl
		mov	[edx+2Ah], bh
		shr	ebx, 10h
		mov	[edx+24h], bl
		mov	[edx+1Dh], bh
		mov	al, [esi+6]
		mov	ebx, [ecx+eax*4]
		mov	[edx+4Eh], bl
		mov	[edx+47h], bh
		shr	ebx, 10h
		mov	[edx+41h], bl
		mov	[edx+3Ah], bh
		mov	al, [esi+7]
		mov	ebx, [ecx+eax*4]
		mov	[edx+6Bh], bl
		mov	[edx+64h], bh
		shr	ebx, 10h
		mov	[edx+5Eh], bl
		mov	[edx+57h], bh
		lea	edx, [edx+74h]
		mov	al, [esi+8]
		mov	ebx, [ecx+eax*4]
		mov	[edx+14h], bl
		mov	[edx+0Dh], bh
		shr	ebx, 10h
		mov	[edx+7], bl
		mov	[edx], bh
		mov	al, [esi+9]
		mov	ebx, [ecx+eax*4]
		mov	[edx+31h], bl
		mov	[edx+2Ah], bh
		shr	ebx, 10h
		mov	[edx+24h], bl
		mov	[edx+1Dh], bh
		mov	al, [esi+0Ah]
		mov	ebx, [ecx+eax*4]
		mov	[edx+4Eh], bl
		mov	[edx+47h], bh
		shr	ebx, 10h
		mov	[edx+41h], bl
		mov	[edx+3Ah], bh
		mov	al, [esi+0Bh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+6Bh], bl
		mov	[edx+64h], bh
		shr	ebx, 10h
		mov	[edx+5Eh], bl
		mov	[edx+57h], bh
		mov	bx, [esi]
		mov	cx, [esi+2]
		mov	edx, _nf_width
		jmp	short L148
		align 4

L148:
		mov	ah, bl
		mov	al, ah
		shl	eax, 10h
		mov	al, bl
		mov	ah, al
		mov	[edi], eax
		mov	ah, bl
		mov	al, ah
		shl	eax, 10h
		mov	al, bl
		mov	ah, al
		mov	[edi+4], eax
		add	edi, edx
		mov	ah, bl
		mov	al, ah
		shl	eax, 10h
		mov	al, bl
		mov	ah, al
		mov	[edi], eax
		mov	ah, bl
		mov	al, ah
		shl	eax, 10h
		mov	al, bl
		mov	ah, al
		mov	[edi+4], eax
		add	edi, edx
		mov	ah, bl
		mov	al, ah
		shl	eax, 10h
		mov	al, bl
		mov	ah, al
		mov	[edi], eax
		mov	ah, bl
		mov	al, ah
		shl	eax, 10h
		mov	al, bl
		mov	ah, al
		mov	[edi+4], eax
		add	edi, edx
		mov	ah, bl
		mov	al, ah
		shl	eax, 10h
		mov	al, bl
		mov	ah, al
		mov	[edi], eax
		mov	ah, bl
		mov	al, ah
		shl	eax, 10h
		mov	al, bl
		mov	ah, al
		mov	[edi+4], eax
		add	edi, edx
		mov	ah, bl
		mov	al, ah
		shl	eax, 10h
		mov	al, bl
		mov	ah, al
		mov	[edi], eax
		mov	ah, bl
		mov	al, ah
		shl	eax, 10h
		mov	al, bl
		mov	ah, al
		mov	[edi+4], eax
		add	edi, edx
		mov	ah, bl
		mov	al, ah
		shl	eax, 10h
		mov	al, bl
		mov	ah, al
		mov	[edi], eax
		mov	ah, bl
		mov	al, ah
		shl	eax, 10h
		mov	al, bl
		mov	ah, al
		mov	[edi+4], eax
		add	edi, edx
		mov	ah, bl
		mov	al, ah
		shl	eax, 10h
		mov	al, bl
		mov	ah, al
		mov	[edi], eax
		mov	ah, bl
		mov	al, ah
		shl	eax, 10h
		mov	al, bl
		mov	ah, al
		mov	[edi+4], eax
		add	edi, edx
		mov	ah, bl
		mov	al, ah
		shl	eax, 10h
		mov	al, bl
		mov	ah, al
		mov	[edi], eax
		mov	ah, bl
		mov	al, ah
		shl	eax, 10h
		mov	al, bl
		mov	ah, al
		mov	[edi+4], eax
		add	esi, 0Ch
		sub	edi, [ebp-10h]
		retn
		align 4

L149:
		xor	eax, eax
		lea	ecx, byte_1250C4
		lea	edx, L150+1
		mov	al, [esi+4]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+2], bh
		shr	ebx, 10h
		mov	[edx+7], bl
		mov	[edx+9], bh
		mov	al, [esi+5]
		mov	ebx, [ecx+eax*4]
		mov	[edx+10h], bl
		mov	[edx+12h], bh
		shr	ebx, 10h
		mov	[edx+17h], bl
		mov	[edx+19h], bh
		mov	al, [esi+6]
		mov	ebx, [ecx+eax*4]
		mov	[edx+25h], bl
		mov	[edx+27h], bh
		shr	ebx, 10h
		mov	[edx+2Ch], bl
		mov	[edx+2Eh], bh
		mov	al, [esi+7]
		mov	ebx, [ecx+eax*4]
		mov	[edx+35h], bl
		mov	[edx+37h], bh
		shr	ebx, 10h
		mov	[edx+3Ch], bl
		mov	[edx+3Eh], bh
		mov	al, [esi+8]
		mov	ebx, [ecx+eax*4]
		mov	[edx+4Ah], bl
		mov	[edx+4Ch], bh
		shr	ebx, 10h
		mov	[edx+51h], bl
		mov	[edx+53h], bh
		mov	al, [esi+9]
		mov	ebx, [ecx+eax*4]
		mov	[edx+5Ah], bl
		mov	[edx+5Ch], bh
		shr	ebx, 10h
		mov	[edx+61h], bl
		mov	[edx+63h], bh
		mov	al, [esi+0Ah]
		mov	ebx, [ecx+eax*4]
		mov	[edx+6Fh], bl
		mov	[edx+71h], bh
		shr	ebx, 10h
		mov	[edx+76h], bl
		mov	[edx+78h], bh
		mov	al, [esi+0Bh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+7Fh], bl
		mov	[edx+81h], bh
		shr	ebx, 10h
		mov	[edx+86h], bl
		mov	[edx+88h], bh
		mov	bx, [esi]
		mov	cx, [esi+2]
		mov	edx, _nf_width
		jmp	short L150
		align 4

L150:
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		mov	[edi+edx], eax
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi+4], eax
		mov	[edi+edx+4], eax
		lea	edi, [edi+edx*2]
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		mov	[edi+edx], eax
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi+4], eax
		mov	[edi+edx+4], eax
		lea	edi, [edi+edx*2]
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		mov	[edi+edx], eax
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi+4], eax
		mov	[edi+edx+4], eax
		lea	edi, [edi+edx*2]
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		mov	[edi+edx], eax
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi+4], eax
		mov	[edi+edx+4], eax
		add	edi, edx
		add	esi, 0Ch
		sub	edi, [ebp-10h]
		retn
		align 4

L151:
		mov	ax, [esi]
		cmp	al, ah
		ja	L153
		xor	eax, eax
		lea	ecx, byte_1250C4
		lea	edx, L152+1
		mov	al, [esi+4]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+2], bh
		shr	ebx, 10h
		mov	[edx+7], bl
		mov	[edx+9], bh
		mov	al, [esi+5]
		mov	ebx, [ecx+eax*4]
		mov	[edx+0Fh], bl
		mov	[edx+11h], bh
		shr	ebx, 10h
		mov	[edx+16h], bl
		mov	[edx+18h], bh
		mov	al, [esi+6]
		mov	ebx, [ecx+eax*4]
		mov	[edx+1Eh], bl
		mov	[edx+20h], bh
		shr	ebx, 10h
		mov	[edx+25h], bl
		mov	[edx+27h], bh
		mov	al, [esi+7]
		mov	ebx, [ecx+eax*4]
		mov	[edx+2Dh], bl
		mov	[edx+2Fh], bh
		shr	ebx, 10h
		mov	[edx+34h], bl
		mov	[edx+36h], bh
		mov	al, [esi+0Ch]
		mov	ebx, [ecx+eax*4]
		mov	[edx+44h], bl
		mov	[edx+46h], bh
		shr	ebx, 10h
		mov	[edx+4Bh], bl
		mov	[edx+4Dh], bh
		mov	al, [esi+0Dh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+53h], bl
		mov	[edx+55h], bh
		shr	ebx, 10h
		mov	[edx+5Ah], bl
		mov	[edx+5Ch], bh
		mov	al, [esi+0Eh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+62h], bl
		mov	[edx+64h], bh
		shr	ebx, 10h
		mov	[edx+69h], bl
		mov	[edx+6Bh], bh
		mov	al, [esi+0Fh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+71h], bl
		mov	[edx+73h], bh
		shr	ebx, 10h
		mov	[edx+78h], bl
		mov	[edx+7Ah], bh
		lea	edx, [edx+91h]
		mov	al, [esi+14h]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+2], bh
		shr	ebx, 10h
		mov	[edx+7], bl
		mov	[edx+9], bh
		mov	al, [esi+15h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+0Fh], bl
		mov	[edx+11h], bh
		shr	ebx, 10h
		mov	[edx+16h], bl
		mov	[edx+18h], bh
		mov	al, [esi+16h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+1Eh], bl
		mov	[edx+20h], bh
		shr	ebx, 10h
		mov	[edx+25h], bl
		mov	[edx+27h], bh
		mov	al, [esi+17h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+2Dh], bl
		mov	[edx+2Fh], bh
		shr	ebx, 10h
		mov	[edx+34h], bl
		mov	[edx+36h], bh
		mov	al, [esi+1Ch]
		mov	ebx, [ecx+eax*4]
		mov	[edx+44h], bl
		mov	[edx+46h], bh
		shr	ebx, 10h
		mov	[edx+4Bh], bl
		mov	[edx+4Dh], bh
		mov	al, [esi+1Dh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+53h], bl
		mov	[edx+55h], bh
		shr	ebx, 10h
		mov	[edx+5Ah], bl
		mov	[edx+5Ch], bh
		mov	al, [esi+1Eh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+62h], bl
		mov	[edx+64h], bh
		shr	ebx, 10h
		mov	[edx+69h], bl
		mov	[edx+6Bh], bh
		mov	al, [esi+1Fh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+71h], bl
		mov	[edx+73h], bh
		shr	ebx, 10h
		mov	[edx+78h], bl
		mov	[edx+7Ah], bh
		mov	bx, [esi]
		mov	cx, [esi+2]
		mov	edx, _nf_width
		jmp	short $+2

L152:
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		mov	bx, [esi+8]
		mov	cx, [esi+0Ah]
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		lea	eax, ds:0FFFFFFFCh[edx*8]
		sub	edi, eax
		mov	bx, [esi+10h]
		mov	cx, [esi+12h]
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		mov	bx, [esi+18h]
		mov	cx, [esi+1Ah]
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	esi, 20h
		sub	edi, 4
		sub	edi, [ebp-10h]
		retn
		align 4

L153:
		mov	ax, [esi+0Ch]
		cmp	al, ah
		ja	L155
		xor	eax, eax
		lea	ecx, byte_1250C4
		lea	edx, L154+1
		mov	al, [esi+4]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+2], bh
		shr	ebx, 10h
		mov	[edx+7], bl
		mov	[edx+9], bh
		mov	al, [esi+5]
		mov	ebx, [ecx+eax*4]
		mov	[edx+0Fh], bl
		mov	[edx+11h], bh
		shr	ebx, 10h
		mov	[edx+16h], bl
		mov	[edx+18h], bh
		mov	al, [esi+6]
		mov	ebx, [ecx+eax*4]
		mov	[edx+1Eh], bl
		mov	[edx+20h], bh
		shr	ebx, 10h
		mov	[edx+25h], bl
		mov	[edx+27h], bh
		mov	al, [esi+7]
		mov	ebx, [ecx+eax*4]
		mov	[edx+2Dh], bl
		mov	[edx+2Fh], bh
		shr	ebx, 10h
		mov	[edx+34h], bl
		mov	[edx+36h], bh
		mov	al, [esi+8]
		mov	ebx, [ecx+eax*4]
		mov	[edx+3Ch], bl
		mov	[edx+3Eh], bh
		shr	ebx, 10h
		mov	[edx+43h], bl
		mov	[edx+45h], bh
		mov	al, [esi+9]
		mov	ebx, [ecx+eax*4]
		mov	[edx+4Bh], bl
		mov	[edx+4Dh], bh
		shr	ebx, 10h
		mov	[edx+52h], bl
		mov	[edx+54h], bh
		mov	al, [esi+0Ah]
		mov	ebx, [ecx+eax*4]
		mov	[edx+5Ah], bl
		mov	[edx+5Ch], bh
		shr	ebx, 10h
		mov	[edx+61h], bl
		mov	[edx+63h], bh
		mov	al, [esi+0Bh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+69h], bl
		mov	[edx+6Bh], bh
		shr	ebx, 10h
		mov	[edx+70h], bl
		mov	[edx+72h], bh
		lea	edx, [edx+89h]
		mov	al, [esi+10h]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+2], bh
		shr	ebx, 10h
		mov	[edx+7], bl
		mov	[edx+9], bh
		mov	al, [esi+11h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+0Fh], bl
		mov	[edx+11h], bh
		shr	ebx, 10h
		mov	[edx+16h], bl
		mov	[edx+18h], bh
		mov	al, [esi+12h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+1Eh], bl
		mov	[edx+20h], bh
		shr	ebx, 10h
		mov	[edx+25h], bl
		mov	[edx+27h], bh
		mov	al, [esi+13h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+2Dh], bl
		mov	[edx+2Fh], bh
		shr	ebx, 10h
		mov	[edx+34h], bl
		mov	[edx+36h], bh
		mov	al, [esi+14h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+3Ch], bl
		mov	[edx+3Eh], bh
		shr	ebx, 10h
		mov	[edx+43h], bl
		mov	[edx+45h], bh
		mov	al, [esi+15h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+4Bh], bl
		mov	[edx+4Dh], bh
		shr	ebx, 10h
		mov	[edx+52h], bl
		mov	[edx+54h], bh
		mov	al, [esi+16h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+5Ah], bl
		mov	[edx+5Ch], bh
		shr	ebx, 10h
		mov	[edx+61h], bl
		mov	[edx+63h], bh
		mov	al, [esi+17h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+69h], bl
		mov	[edx+6Bh], bh
		shr	ebx, 10h
		mov	[edx+70h], bl
		mov	[edx+72h], bh
		mov	bx, [esi]
		mov	cx, [esi+2]
		mov	edx, _nf_width
		jmp	short L154
		align 4

L154:
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		lea	eax, ds:0FFFFFFFCh[edx*8]
		sub	edi, eax
		mov	bx, [esi+0Ch]
		mov	cx, [esi+0Eh]
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	esi, 18h
		sub	edi, 4
		sub	edi, [ebp-10h]
		retn
		align 4

L155:
		xor	eax, eax
		lea	ecx, byte_1250C4
		lea	edx, L156+1
		mov	al, [esi+4]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+2], bh
		shr	ebx, 10h
		mov	[edx+7], bl
		mov	[edx+9], bh
		mov	al, [esi+5]
		mov	ebx, [ecx+eax*4]
		mov	[edx+0Dh], bl
		mov	[edx+0Fh], bh
		shr	ebx, 10h
		mov	[edx+14h], bl
		mov	[edx+16h], bh
		mov	al, [esi+6]
		mov	ebx, [ecx+eax*4]
		mov	[edx+1Dh], bl
		mov	[edx+1Fh], bh
		shr	ebx, 10h
		mov	[edx+24h], bl
		mov	[edx+26h], bh
		mov	al, [esi+7]
		mov	ebx, [ecx+eax*4]
		mov	[edx+2Ah], bl
		mov	[edx+2Ch], bh
		shr	ebx, 10h
		mov	[edx+31h], bl
		mov	[edx+33h], bh
		mov	al, [esi+8]
		mov	ebx, [ecx+eax*4]
		mov	[edx+3Ah], bl
		mov	[edx+3Ch], bh
		shr	ebx, 10h
		mov	[edx+41h], bl
		mov	[edx+43h], bh
		mov	al, [esi+9]
		mov	ebx, [ecx+eax*4]
		mov	[edx+47h], bl
		mov	[edx+49h], bh
		shr	ebx, 10h
		mov	[edx+4Eh], bl
		mov	[edx+50h], bh
		mov	al, [esi+0Ah]
		mov	ebx, [ecx+eax*4]
		mov	[edx+57h], bl
		mov	[edx+59h], bh
		shr	ebx, 10h
		mov	[edx+5Eh], bl
		mov	[edx+60h], bh
		mov	al, [esi+0Bh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+64h], bl
		mov	[edx+66h], bh
		shr	ebx, 10h
		mov	[edx+6Bh], bl
		mov	[edx+6Dh], bh
		lea	edx, [edx+7Ch]
		mov	al, [esi+10h]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+2], bh
		shr	ebx, 10h
		mov	[edx+7], bl
		mov	[edx+9], bh
		mov	al, [esi+11h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+0Dh], bl
		mov	[edx+0Fh], bh
		shr	ebx, 10h
		mov	[edx+14h], bl
		mov	[edx+16h], bh
		mov	al, [esi+12h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+1Dh], bl
		mov	[edx+1Fh], bh
		shr	ebx, 10h
		mov	[edx+24h], bl
		mov	[edx+26h], bh
		mov	al, [esi+13h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+2Ah], bl
		mov	[edx+2Ch], bh
		shr	ebx, 10h
		mov	[edx+31h], bl
		mov	[edx+33h], bh
		mov	al, [esi+14h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+3Ah], bl
		mov	[edx+3Ch], bh
		shr	ebx, 10h
		mov	[edx+41h], bl
		mov	[edx+43h], bh
		mov	al, [esi+15h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+47h], bl
		mov	[edx+49h], bh
		shr	ebx, 10h
		mov	[edx+4Eh], bl
		mov	[edx+50h], bh
		mov	al, [esi+16h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+57h], bl
		mov	[edx+59h], bh
		shr	ebx, 10h
		mov	[edx+5Eh], bl
		mov	[edx+60h], bh
		mov	al, [esi+17h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+64h], bl
		mov	[edx+66h], bh
		shr	ebx, 10h
		mov	[edx+6Bh], bl
		mov	[edx+6Dh], bh
		mov	bx, [esi]
		mov	cx, [esi+2]
		mov	edx, _nf_width
		jmp	short L156
		align 4

L156:
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi+4], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi+4], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi+4], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi+4], eax
		add	edi, edx
		mov	bx, [esi+0Ch]
		mov	cx, [esi+0Eh]
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi+4], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi+4], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi+4], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi+4], eax
		add	esi, 18h
		sub	edi, [ebp-10h]
		retn
		align 4

L157:
		mov	edx, _nf_width
		mov	eax, [esi]
		mov	[edi], eax
		mov	eax, [esi+4]
		mov	[edi+4], eax
		add	edi, edx
		mov	eax, [esi+8]
		mov	[edi], eax
		mov	eax, [esi+0Ch]
		mov	[edi+4], eax
		add	edi, edx
		mov	eax, [esi+10h]
		mov	[edi], eax
		mov	eax, [esi+14h]
		mov	[edi+4], eax
		add	edi, edx
		mov	eax, [esi+18h]
		mov	[edi], eax
		mov	eax, [esi+1Ch]
		mov	[edi+4], eax
		add	edi, edx
		mov	eax, [esi+20h]
		mov	[edi], eax
		mov	eax, [esi+24h]
		mov	[edi+4], eax
		add	edi, edx
		mov	eax, [esi+28h]
		mov	[edi], eax
		mov	eax, [esi+2Ch]
		mov	[edi+4], eax
		add	edi, edx
		mov	eax, [esi+30h]
		mov	[edi], eax
		mov	eax, [esi+34h]
		mov	[edi+4], eax
		add	edi, edx
		mov	eax, [esi+38h]
		mov	[edi], eax
		mov	eax, [esi+3Ch]
		mov	[edi+4], eax
		add	esi, 40h
		sub	edi, [ebp-10h]
		retn
		align 4

L158:
		mov	edx, _nf_width
		mov	eax, [esi]
		mov	bl, ah
		mov	bh, ah
		shl	ebx, 10h
		mov	bl, al
		mov	bh, al
		mov	[edi], ebx
		mov	[edi+edx], ebx
		shr	eax, 10h
		mov	bl, ah
		mov	bh, ah
		shl	ebx, 10h
		mov	bl, al
		mov	bh, al
		mov	[edi+4], ebx
		mov	[edi+edx+4], ebx
		lea	edi, [edi+edx*2]
		mov	eax, [esi+4]
		mov	bl, ah
		mov	bh, ah
		shl	ebx, 10h
		mov	bl, al
		mov	bh, al
		mov	[edi], ebx
		mov	[edi+edx], ebx
		shr	eax, 10h
		mov	bl, ah
		mov	bh, ah
		shl	ebx, 10h
		mov	bl, al
		mov	bh, al
		mov	[edi+4], ebx
		mov	[edi+edx+4], ebx
		lea	edi, [edi+edx*2]
		mov	eax, [esi+8]
		mov	bl, ah
		mov	bh, ah
		shl	ebx, 10h
		mov	bl, al
		mov	bh, al
		mov	[edi], ebx
		mov	[edi+edx], ebx
		shr	eax, 10h
		mov	bl, ah
		mov	bh, ah
		shl	ebx, 10h
		mov	bl, al
		mov	bh, al
		mov	[edi+4], ebx
		mov	[edi+edx+4], ebx
		lea	edi, [edi+edx*2]
		mov	eax, [esi+0Ch]
		mov	bl, ah
		mov	bh, ah
		shl	ebx, 10h
		mov	bl, al
		mov	bh, al
		mov	[edi], ebx
		mov	[edi+edx], ebx
		shr	eax, 10h
		mov	bl, ah
		mov	bh, ah
		shl	ebx, 10h
		mov	bl, al
		mov	bh, al
		mov	[edi+4], ebx
		mov	[edi+edx+4], ebx
		add	edi, edx
		sub	edi, [ebp-10h]
		add	esi, 10h
		retn
		align 4

L159:
		mov	edx, _nf_width
		mov	cl, [esi]
		mov	ch, cl
		mov	eax, ecx
		shl	eax, 10h
		mov	ax, cx
		mov	cl, [esi+1]
		mov	ch, cl
		mov	ebx, ecx
		shl	ebx, 10h
		mov	bx, cx
		mov	[edi], eax
		mov	[edi+4], ebx
		mov	[edi+edx], eax
		mov	[edi+edx+4], ebx
		lea	edi, [edi+edx*2]
		mov	[edi], eax
		mov	[edi+4], ebx
		mov	[edi+edx], eax
		mov	[edi+edx+4], ebx
		lea	edi, [edi+edx*2]
		mov	cl, [esi+2]
		mov	ch, cl
		mov	eax, ecx
		shl	eax, 10h
		mov	ax, cx
		mov	cl, [esi+3]
		mov	ch, cl
		mov	ebx, ecx
		shl	ebx, 10h
		mov	bx, cx
		mov	[edi], eax
		mov	[edi+4], ebx
		mov	[edi+edx], eax
		mov	[edi+edx+4], ebx
		lea	edi, [edi+edx*2]
		mov	[edi], eax
		mov	[edi+4], ebx
		add	edi, edx
		mov	[edi], eax
		mov	[edi+4], ebx
		sub	edi, [ebp-10h]
		add	esi, 4
		retn
		align 4

L160:
		mov	bl, [esi]
		inc	esi
		mov	bh, bl
		mov	eax, ebx
		shl	eax, 10h
		mov	ax, bx
		mov	ebx, eax
		jmp	short L162
		retn
		align 4

L161:
		mov	bx, [esi]
		add	esi, 2
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	ebx, eax
		rol	ebx, 8

L162:
		mov	edx, _nf_width
		mov	[edi], eax
		mov	[edi+4], eax
		add	edi, edx
		mov	[edi], ebx
		mov	[edi+4], ebx
		add	edi, edx
		mov	[edi], eax
		mov	[edi+4], eax
		add	edi, edx
		mov	[edi], ebx
		mov	[edi+4], ebx
		add	edi, edx
		mov	[edi], eax
		mov	[edi+4], eax
		add	edi, edx
		mov	[edi], ebx
		mov	[edi+4], ebx
		add	edi, edx
		mov	[edi], eax
		mov	[edi+4], eax
		add	edi, edx
		mov	[edi], ebx
		mov	[edi+4], ebx
		sub	edi, [ebp-10h]
		retn

PUBLIC _nfPkDecompH
_nfPkDecompH:
		push	ebp
		mov	ebp, esp
		add	esp, 0FFFFFFECh
		push	esi
		push	edi
		push	ebx
		mov	ax, ds
		mov	es, ax
		mov	eax, _nf_buf_prv
		sub	eax, _nf_buf_cur
		mov	[ebp-0ch], eax
		xor	ebx, ebx
		mov	bl, _nf_fqty
		mov	eax, [ebp+10h]
		shl	eax, 3
		mov	_nf_new_x, eax
		mov	eax, [ebp+18h]
		shl	eax, 3
		mov	_nf_new_w, eax
		mov	eax, [ebp+14h]
		shl	eax, 3
		mul	ebx
		mov	_nf_new_y, eax
		mov	eax, [ebp+1ch]
		shl	eax, 3
		mul	ebx
		mov	_nf_new_h, eax
		mov	eax, _nf_new_row0
		sub	eax, _nf_new_w
		mov	[ebp-8], eax
		mov	eax, _nf_buf_cur
		mov	[ebp-4], eax
		cmp	[ebp+10h], 0
		jnz	short L163
		cmp	[ebp+14h], 0
		jz	short L164

L163:
		mov	eax, _nf_new_y
		mul	_nf_width
		add	eax, _nf_new_x
		add	[ebp-4], eax

L164:
		mov	eax, _nf_width
		shl	eax, 2
		sub	eax, _nf_new_w
		mov	[ebp-8], eax
		shr	_nf_new_h, 1
		mov	eax, _nf_width
		lea	eax, [eax+eax*2-8]
		mov	[ebp-10h], eax
		mov	esi, [ebp+0ch]
		mov	edi, [ebp-4]

L165:
		mov	eax, [ebp+18h]
		shr	eax, 1
		mov	[ebp-14h], eax

L166:
		dec	dword ptr [ebp-14h]
		js	short L167
		mov	ebx, [ebp+8]
		mov	al, [ebx]
		inc	ebx
		mov	[ebp+8], ebx
		xor	ebx, ebx
		mov	bl, al
		shr	bl, 4
		and	eax, 0Fh
		push	offset L166
		push	off_125504[ebx*4]
		jmp	off_125504[eax*4]

L167:
		add	edi, [ebp-8]
		dec	dword ptr [ebp+1ch]
		jnz	short L165
		pop	ebx
		pop	edi
		pop	esi
		leave
		retn

L168:
		mov	eax, [ebp-0ch]
		jmp	L181

L169:
		add	edi, 8
		retn

L170:
		xor	eax, eax
		mov	al, [esi]
		inc	esi
		mov	ax, word_124A84[eax*2]

L171:
		xor	ebx, ebx
		mov	bl, ah
		shl	eax, 18h
		sar	eax, 18h
		add	bl, 80h
		adc	bl, 80h
		sar	bl, 1
		add	eax, dword_124484[ebx*4]
		jmp	short L181

L172:
		xor	eax, eax
		mov	al, [esi]
		inc	esi
		mov	ax, word_124A84[eax*2]
		neg	al
		neg	ah
		jmp	short L171
		align 4

L173:
		xor	eax, eax
		mov	al, [esi]
		inc	esi
		mov	ax, word_124884[eax*2]
		jmp	short L177
		align 4

L174:
		mov	ax, [esi]
		add	esi, 2

L177:
		xor	ebx, ebx
		mov	bl, ah
		shl	eax, 18h
		sar	eax, 18h
		add	bl, 80h
		adc	bl, 80h
		sar	bl, 1
		add	eax, dword_124484[ebx*4]
		add	eax, [ebp-0ch]
		jmp	short L181

L178:
		add	esp, 4
		add	ebx, 2
		mov	eax, eax

L179:
		add	edi, 10h
		dec	ebx
		jz	short L180
		dec	dword ptr [ebp-14h]
		jns	short L179
		add	edi, [ebp-8]
		dec	dword ptr [ebp+1ch]
		mov	eax, [ebp+18h]
		shr	eax, 1
		dec	eax
		mov	[ebp-14h], eax
		jmp	short L179

L180:
		retn
		align 4

L181:
		mov	ebx, esi
		lea	esi, [edi+eax]
		mov	edx, _nf_width
		mov	eax, [esi]
		mov	[edi], eax
		mov	eax, [esi+4]
		mov	[edi+4], eax
		add	esi, edx
		add	edi, edx
		mov	eax, [esi]
		mov	[edi], eax
		mov	eax, [esi+4]
		mov	[edi+4], eax
		add	esi, edx
		add	edi, edx
		mov	eax, [esi]
		mov	[edi], eax
		mov	eax, [esi+4]
		mov	[edi+4], eax
		add	esi, edx
		add	edi, edx
		mov	eax, [esi]
		mov	[edi], eax
		mov	eax, [esi+4]
		mov	[edi+4], eax
		sub	edi, [ebp-10h]
		mov	esi, ebx
		retn
		align 4

L182:
		mov	ax, [esi]
		cmp	al, ah
		ja	L184
		xor	eax, eax
		lea	ecx, byte_124CC4
		lea	edx, L183+2
		mov	al, [esi+2]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+6], bh
		shr	ebx, 10h
		mov	[edx+0Bh], bl
		mov	[edx+11h], bh
		mov	al, [esi+4]
		mov	ebx, [ecx+eax*4]
		mov	[edx+19h], bl
		mov	[edx+1Fh], bh
		shr	ebx, 10h
		mov	[edx+24h], bl
		mov	[edx+2Ah], bh
		lea	edx, [edx+32h]
		mov	al, [esi+6]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+6], bh
		shr	ebx, 10h
		mov	[edx+0Bh], bl
		mov	[edx+11h], bh
		mov	al, [esi+8]
		mov	ebx, [ecx+eax*4]
		mov	[edx+19h], bl
		mov	[edx+1Fh], bh
		shr	ebx, 10h
		mov	[edx+24h], bl
		mov	[edx+2Ah], bh
		push	ebp
		push	esi
		mov	cx, [esi]
		mov	esi, _nf_width
		mov	bl, cl
		mov	bh, cl
		mov	dl, ch
		mov	dh, cl
		mov	al, ch
		mov	ah, ch
		mov	ebp, eax
		jmp	short L183
		align 4

L183:
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		pop	esi
		pop	ebp
		add	esi, 0Ah
		sub	edi, [ebp-10h]
		retn
		align 4

L184:
		xor	eax, eax
		lea	ecx, byte_124C84
		lea	edx, L185+2
		mov	al, [esi+2]
		and	al, 0Fh
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+6], bh
		shr	ebx, 10h
		mov	[edx+0Bh], bl
		mov	[edx+11h], bh
		mov	al, [esi+2]
		shr	al, 4
		mov	ebx, [ecx+eax*4]
		mov	[edx+19h], bl
		mov	[edx+1Fh], bh
		shr	ebx, 10h
		mov	[edx+24h], bl
		mov	[edx+2Ah], bh
		mov	al, [esi+3]
		and	al, 0Fh
		mov	ebx, [ecx+eax*4]
		mov	[edx+32h], bl
		mov	[edx+38h], bh
		shr	ebx, 10h
		mov	[edx+3Dh], bl
		mov	[edx+43h], bh
		mov	al, [esi+3]
		shr	al, 4
		mov	ebx, [ecx+eax*4]
		mov	[edx+4Bh], bl
		mov	[edx+51h], bh
		shr	ebx, 10h
		mov	[edx+56h], bl
		mov	[edx+5Ch], bh
		mov	edx, _nf_width
		mov	bx, [esi]
		mov	cl, bh
		mov	bh, bl
		mov	ch, cl
		jmp	short $+2

L185:
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, edx
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, edx
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, edx
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		sub	edi, [ebp-10h]
		add	esi, 4
		retn
		align 4

L186:
		mov	ax, [esi]
		cmp	al, ah
		ja	L188
		xor	eax, eax
		lea	ecx, byte_124CC4
		lea	edx, L187+2
		mov	al, [esi+2]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+6], bh
		mov	al, [esi+3]
		mov	ebx, [ecx+eax*4]
		mov	[edx+0Dh], bl
		mov	[edx+13h], bh
		mov	al, [esi+6]
		mov	ebx, [ecx+eax*4]
		mov	[edx+2Fh], bl
		mov	[edx+35h], bh
		mov	al, [esi+7]
		mov	ebx, [ecx+eax*4]
		mov	[edx+3Ch], bl
		mov	[edx+42h], bh
		add	edx, L187_0-L187 ; hack
		mov	al, [esi+0Ah]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+6], bh
		mov	al, [esi+0Bh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+0Dh], bl
		mov	[edx+13h], bh
		mov	al, [esi+0Eh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+2Fh], bl
		mov	[edx+35h], bh
		mov	al, [esi+0Fh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+3Ch], bl
		mov	[edx+42h], bh
		push	ebp
		push	esi
		mov	cx, [esi]
		mov	esi, _nf_width
		mov	bl, cl
		mov	bh, cl
		mov	dl, ch
		mov	dh, cl
		mov	al, ch
		mov	ah, ch
		mov	ebp, eax
		jmp	short $+2

L187:
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		mov	eax, [esp]
		mov	cx, [eax+4]
		mov	bl, cl
		mov	bh, cl
		mov	dl, ch
		mov	dh, cl
		mov	al, ch
		mov	ah, ch
		mov	ebp, eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		lea	eax, ds:0FFFFFFFCh[esi*4]
		sub	edi, eax
		mov	eax, [esp]
		mov	cx, [eax+8]
		mov	bl, cl
		mov	bh, cl
		mov	dl, ch
		mov	dh, cl
		mov	al, ch
		mov	ah, ch
		mov	ebp, eax
L187_0:
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		mov	eax, [esp]
		mov	cx, [eax+0Ch]
		mov	bl, cl
		mov	bh, cl
		mov	dl, ch
		mov	dh, cl
		mov	al, ch
		mov	ah, ch
		mov	ebp, eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		pop	esi
		pop	ebp
		add	esi, 10h
		sub	edi, 4
		sub	edi, [ebp-10h]
		retn
		align 4

L188:
		mov	ax, [esi+6]
		cmp	al, ah
		ja	L190
		xor	eax, eax
		lea	ecx, byte_124CC4
		lea	edx, L189+2
		mov	al, [esi+2]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+6], bh
		mov	al, [esi+3]
		mov	ebx, [ecx+eax*4]
		mov	[edx+0Dh], bl
		mov	[edx+13h], bh
		mov	al, [esi+4]
		mov	ebx, [ecx+eax*4]
		mov	[edx+1Ah], bl
		mov	[edx+20h], bh
		mov	al, [esi+5]
		mov	ebx, [ecx+eax*4]
		mov	[edx+27h], bl
		mov	[edx+2Dh], bh
		add	edx, L189_0-L189 ; hack
		mov	al, [esi+8]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+6], bh
		mov	al, [esi+9]
		mov	ebx, [ecx+eax*4]
		mov	[edx+0Dh], bl
		mov	[edx+13h], bh
		mov	al, [esi+0Ah]
		mov	ebx, [ecx+eax*4]
		mov	[edx+1Ah], bl
		mov	[edx+20h], bh
		mov	al, [esi+0Bh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+27h], bl
		mov	[edx+2Dh], bh
		push	ebp
		push	esi
		mov	cx, [esi]
		mov	esi, _nf_width
		mov	bl, cl
		mov	bh, cl
		mov	dl, ch
		mov	dh, cl
		mov	al, ch
		mov	ah, ch
		mov	ebp, eax
		jmp	short L189
		align 4

L189:
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		lea	eax, ds:0FFFFFFFCh[esi*4]
		sub	edi, eax
		mov	eax, [esp]
		mov	cx, [eax+6]
		mov	bl, cl
		mov	bh, cl
		mov	dl, ch
		mov	dh, cl
		mov	al, ch
		mov	ah, ch
		mov	ebp, eax
L189_0:
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		pop	esi
		pop	ebp
		add	esi, 0Ch
		sub	edi, 4
		sub	edi, [ebp-10h]
		retn

L190:
		xor	eax, eax
		lea	ecx, byte_124CC4
		lea	edx, L191+2
		mov	al, [esi+2]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+6], bh
		shr	ebx, 10h
		mov	[edx+0Bh], bl
		mov	[edx+11h], bh
		mov	al, [esi+4]
		mov	ebx, [ecx+eax*4]
		mov	[edx+19h], bl
		mov	[edx+1Fh], bh
		shr	ebx, 10h
		mov	[edx+24h], bl
		mov	[edx+2Ah], bh
		add	edx, L191_0-L191
		mov	al, [esi+8]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+6], bh
		shr	ebx, 10h
		mov	[edx+0Bh], bl
		mov	[edx+11h], bh
		mov	al, [esi+0Ah]
		mov	ebx, [ecx+eax*4]
		mov	[edx+19h], bl
		mov	[edx+1Fh], bh
		shr	ebx, 10h
		mov	[edx+24h], bl
		mov	[edx+2Ah], bh
		push	ebp
		push	esi
		mov	cx, [esi]
		mov	esi, _nf_width
		mov	bl, cl
		mov	bh, cl
		mov	dl, ch
		mov	dh, cl
		mov	al, ch
		mov	ah, ch
		mov	ebp, eax
		jmp	short L191
		align 4

L191:
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	eax, [esp]
		mov	cx, [eax+6]
		mov	bl, cl
		mov	bh, cl
		mov	dl, ch
		mov	dh, cl
		mov	al, ch
		mov	ah, ch
		mov	ebp, eax
L191_0:
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		pop	esi
		pop	ebp
		add	esi, 0Ch
		sub	edi, [ebp-10h]
		retn
L192:
		mov	eax, [esi]
		cmp	al, ah
		ja	L196
		shr	eax, 10h
		cmp	al, ah
		ja	L194
		xor	eax, eax
		lea	ecx, byte_1250C4
		lea	edx, L193+1
		mov	al, [esi+4]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+2], bh
		shr	ebx, 10h
		mov	[edx+7], bl
		mov	[edx+9], bh
		mov	al, [esi+5]
		mov	ebx, [ecx+eax*4]
		mov	[edx+0Dh], bl
		mov	[edx+0Fh], bh
		shr	ebx, 10h
		mov	[edx+14h], bl
		mov	[edx+16h], bh
		mov	al, [esi+8]
		mov	ebx, [ecx+eax*4]
		mov	[edx+1Dh], bl
		mov	[edx+1Fh], bh
		shr	ebx, 10h
		mov	[edx+24h], bl
		mov	[edx+26h], bh
		mov	al, [esi+9]
		mov	ebx, [ecx+eax*4]
		mov	[edx+2Ah], bl
		mov	[edx+2Ch], bh
		shr	ebx, 10h
		mov	[edx+31h], bl
		mov	[edx+33h], bh
		lea	edx, [edx+3Ah]
		mov	al, [esi+0Ch]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+2], bh
		shr	ebx, 10h
		mov	[edx+7], bl
		mov	[edx+9], bh
		mov	al, [esi+0Dh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+0Dh], bl
		mov	[edx+0Fh], bh
		shr	ebx, 10h
		mov	[edx+14h], bl
		mov	[edx+16h], bh
		mov	al, [esi+10h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+1Dh], bl
		mov	[edx+1Fh], bh
		shr	ebx, 10h
		mov	[edx+24h], bl
		mov	[edx+26h], bh
		mov	al, [esi+11h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+2Ah], bl
		mov	[edx+2Ch], bh
		shr	ebx, 10h
		mov	[edx+31h], bl
		mov	[edx+33h], bh
		mov	bx, [esi]
		mov	cx, [esi+2]
		mov	edx, _nf_width
		jmp	short L193
		align 4

L193:
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi+4], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi+4], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi+4], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi+4], eax
		add	esi, 14h
		sub	edi, [ebp-10h]
		retn
		align 4

L194:
		xor	eax, eax
		lea	ecx, byte_1250C4
		lea	edx, L195+1
		mov	al, [esi+4]
		mov	ebx, [ecx+eax*4]
		mov	[edx+14h], bl
		mov	[edx+0Dh], bh
		shr	ebx, 10h
		mov	[edx+7], bl
		mov	[edx], bh
		mov	al, [esi+5]
		mov	ebx, [ecx+eax*4]
		mov	[edx+31h], bl
		mov	[edx+2Ah], bh
		shr	ebx, 10h
		mov	[edx+24h], bl
		mov	[edx+1Dh], bh
		mov	al, [esi+6]
		mov	ebx, [ecx+eax*4]
		mov	[edx+4Eh], bl
		mov	[edx+47h], bh
		shr	ebx, 10h
		mov	[edx+41h], bl
		mov	[edx+3Ah], bh
		mov	al, [esi+7]
		mov	ebx, [ecx+eax*4]
		mov	[edx+6Bh], bl
		mov	[edx+64h], bh
		shr	ebx, 10h
		mov	[edx+5Eh], bl
		mov	[edx+57h], bh
		mov	bx, [esi]
		mov	cx, [esi+2]
		mov	edx, _nf_width
		jmp	short $+2

L195:
		mov	ah, bl
		mov	al, ah
		shl	eax, 10h
		mov	al, bl
		mov	ah, al
		mov	[edi], eax
		mov	ah, bl
		mov	al, ah
		shl	eax, 10h
		mov	al, bl
		mov	ah, al
		mov	[edi+4], eax
		add	edi, edx
		mov	ah, bl
		mov	al, ah
		shl	eax, 10h
		mov	al, bl
		mov	ah, al
		mov	[edi], eax
		mov	ah, bl
		mov	al, ah
		shl	eax, 10h
		mov	al, bl
		mov	ah, al
		mov	[edi+4], eax
		add	edi, edx
		mov	ah, bl
		mov	al, ah
		shl	eax, 10h
		mov	al, bl
		mov	ah, al
		mov	[edi], eax
		mov	ah, bl
		mov	al, ah
		shl	eax, 10h
		mov	al, bl
		mov	ah, al
		mov	[edi+4], eax
		add	edi, edx
		mov	ah, bl
		mov	al, ah
		shl	eax, 10h
		mov	al, bl
		mov	ah, al
		mov	[edi], eax
		mov	ah, bl
		mov	al, ah
		shl	eax, 10h
		mov	al, bl
		mov	ah, al
		mov	[edi+4], eax
		add	esi, 8
		sub	edi, [ebp-10h]
		retn
		align 4

L196:
		shr	eax, 10h
		cmp	al, ah
		ja	L198
		xor	eax, eax
		lea	ecx, byte_1250C4
		lea	edx, L197+1
		mov	al, [esi+4]
		mov	ebx, [ecx+eax*4]
		mov	[edx+14h], bl
		mov	[edx+0Dh], bh
		shr	ebx, 10h
		mov	[edx+7], bl
		mov	[edx], bh
		mov	al, [esi+6]
		mov	ebx, [ecx+eax*4]
		mov	[edx+31h], bl
		mov	[edx+2Ah], bh
		shr	ebx, 10h
		mov	[edx+24h], bl
		mov	[edx+1Dh], bh
		lea	edx, [edx+3Ah]
		mov	al, [esi+8]
		mov	ebx, [ecx+eax*4]
		mov	[edx+14h], bl
		mov	[edx+0Dh], bh
		shr	ebx, 10h
		mov	[edx+7], bl
		mov	[edx], bh
		mov	al, [esi+0Ah]
		mov	ebx, [ecx+eax*4]
		mov	[edx+31h], bl
		mov	[edx+2Ah], bh
		shr	ebx, 10h
		mov	[edx+24h], bl
		mov	[edx+1Dh], bh
		mov	bx, [esi]
		mov	cx, [esi+2]
		mov	edx, _nf_width
		jmp	short L197
		align 4

L197:
		mov	ah, bl
		mov	al, ah
		shl	eax, 10h
		mov	al, bl
		mov	ah, al
		mov	[edi], eax
		mov	ah, bl
		mov	al, ah
		shl	eax, 10h
		mov	al, bl
		mov	ah, al
		mov	[edi+4], eax
		add	edi, edx
		mov	ah, bl
		mov	al, ah
		shl	eax, 10h
		mov	al, bl
		mov	ah, al
		mov	[edi], eax
		mov	ah, bl
		mov	al, ah
		shl	eax, 10h
		mov	al, bl
		mov	ah, al
		mov	[edi+4], eax
		add	edi, edx
		mov	ah, bl
		mov	al, ah
		shl	eax, 10h
		mov	al, bl
		mov	ah, al
		mov	[edi], eax
		mov	ah, bl
		mov	al, ah
		shl	eax, 10h
		mov	al, bl
		mov	ah, al
		mov	[edi+4], eax
		add	edi, edx
		mov	ah, bl
		mov	al, ah
		shl	eax, 10h
		mov	al, bl
		mov	ah, al
		mov	[edi], eax
		mov	ah, bl
		mov	al, ah
		shl	eax, 10h
		mov	al, bl
		mov	ah, al
		mov	[edi+4], eax
		add	esi, 0Ch
		sub	edi, [ebp-10h]
		retn
		align 4

L198:
		xor	eax, eax
		lea	ecx, byte_1250C4
		lea	edx, L199+1
		mov	al, [esi+4]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+2], bh
		shr	ebx, 10h
		mov	[edx+7], bl
		mov	[edx+9], bh
		mov	al, [esi+5]
		mov	ebx, [ecx+eax*4]
		mov	[edx+0Dh], bl
		mov	[edx+0Fh], bh
		shr	ebx, 10h
		mov	[edx+14h], bl
		mov	[edx+16h], bh
		mov	al, [esi+6]
		mov	ebx, [ecx+eax*4]
		mov	[edx+1Dh], bl
		mov	[edx+1Fh], bh
		shr	ebx, 10h
		mov	[edx+24h], bl
		mov	[edx+26h], bh
		mov	al, [esi+7]
		mov	ebx, [ecx+eax*4]
		mov	[edx+2Ah], bl
		mov	[edx+2Ch], bh
		shr	ebx, 10h
		mov	[edx+31h], bl
		mov	[edx+33h], bh
		mov	al, [esi+8]
		mov	ebx, [ecx+eax*4]
		mov	[edx+3Ah], bl
		mov	[edx+3Ch], bh
		shr	ebx, 10h
		mov	[edx+41h], bl
		mov	[edx+43h], bh
		mov	al, [esi+9]
		mov	ebx, [ecx+eax*4]
		mov	[edx+47h], bl
		mov	[edx+49h], bh
		shr	ebx, 10h
		mov	[edx+4Eh], bl
		mov	[edx+50h], bh
		mov	al, [esi+0Ah]
		mov	ebx, [ecx+eax*4]
		mov	[edx+57h], bl
		mov	[edx+59h], bh
		shr	ebx, 10h
		mov	[edx+5Eh], bl
		mov	[edx+60h], bh
		mov	al, [esi+0Bh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+64h], bl
		mov	[edx+66h], bh
		shr	ebx, 10h
		mov	[edx+6Bh], bl
		mov	[edx+6Dh], bh
		mov	bx, [esi]
		mov	cx, [esi+2]
		mov	edx, _nf_width
		jmp	short $+2

L199:
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi+4], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi+4], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi+4], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi+4], eax
		add	esi, 0Ch
		sub	edi, [ebp-10h]
		retn
		align 4

L200:
		mov	ax, [esi]
		cmp	al, ah
		ja	L202
		xor	eax, eax
		lea	ecx, byte_1250C4
		lea	edx, L201+1
		mov	al, [esi+4]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+2], bh
		shr	ebx, 10h
		mov	[edx+7], bl
		mov	[edx+9], bh
		mov	al, [esi+6]
		mov	ebx, [ecx+eax*4]
		mov	[edx+0Fh], bl
		mov	[edx+11h], bh
		shr	ebx, 10h
		mov	[edx+16h], bl
		mov	[edx+18h], bh
		mov	al, [esi+0Ch]
		mov	ebx, [ecx+eax*4]
		mov	[edx+26h], bl
		mov	[edx+28h], bh
		shr	ebx, 10h
		mov	[edx+2Dh], bl
		mov	[edx+2Fh], bh
		mov	al, [esi+0Eh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+35h], bl
		mov	[edx+37h], bh
		shr	ebx, 10h
		mov	[edx+3Ch], bl
		mov	[edx+3Eh], bh
		lea	edx, [edx+55h]
		mov	al, [esi+14h]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+2], bh
		shr	ebx, 10h
		mov	[edx+7], bl
		mov	[edx+9], bh
		mov	al, [esi+16h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+0Fh], bl
		mov	[edx+11h], bh
		shr	ebx, 10h
		mov	[edx+16h], bl
		mov	[edx+18h], bh
		mov	al, [esi+1Ch]
		mov	ebx, [ecx+eax*4]
		mov	[edx+26h], bl
		mov	[edx+28h], bh
		shr	ebx, 10h
		mov	[edx+2Dh], bl
		mov	[edx+2Fh], bh
		mov	al, [esi+1Eh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+35h], bl
		mov	[edx+37h], bh
		shr	ebx, 10h
		mov	[edx+3Ch], bl
		mov	[edx+3Eh], bh
		mov	bx, [esi]
		mov	cx, [esi+2]
		mov	edx, _nf_width
		jmp	short L201
		align 4

L201:
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		mov	bx, [esi+8]
		mov	cx, [esi+0Ah]
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		lea	eax, ds:0FFFFFFFCh[edx*4]
		sub	edi, eax
		mov	bx, [esi+10h]
		mov	cx, [esi+12h]
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		mov	bx, [esi+18h]
		mov	cx, [esi+1Ah]
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	esi, 20h
		sub	edi, 4
		sub	edi, [ebp-10h]
		retn
		align 4

L202:
		mov	ax, [esi+0Ch]
		cmp	al, ah
		ja	L204
		xor	eax, eax
		lea	ecx, byte_1250C4
		lea	edx, L203+1
		mov	al, [esi+4]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+2], bh
		shr	ebx, 10h
		mov	[edx+7], bl
		mov	[edx+9], bh
		mov	al, [esi+6]
		mov	ebx, [ecx+eax*4]
		mov	[edx+0Fh], bl
		mov	[edx+11h], bh
		shr	ebx, 10h
		mov	[edx+16h], bl
		mov	[edx+18h], bh
		mov	al, [esi+8]
		mov	ebx, [ecx+eax*4]
		mov	[edx+1Eh], bl
		mov	[edx+20h], bh
		shr	ebx, 10h
		mov	[edx+25h], bl
		mov	[edx+27h], bh
		mov	al, [esi+0Ah]
		mov	ebx, [ecx+eax*4]
		mov	[edx+2Dh], bl
		mov	[edx+2Fh], bh
		shr	ebx, 10h
		mov	[edx+34h], bl
		mov	[edx+36h], bh
		lea	edx, [edx+4Dh]
		mov	al, [esi+10h]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+2], bh
		shr	ebx, 10h
		mov	[edx+7], bl
		mov	[edx+9], bh
		mov	al, [esi+12h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+0Fh], bl
		mov	[edx+11h], bh
		shr	ebx, 10h
		mov	[edx+16h], bl
		mov	[edx+18h], bh
		mov	al, [esi+14h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+1Eh], bl
		mov	[edx+20h], bh
		shr	ebx, 10h
		mov	[edx+25h], bl
		mov	[edx+27h], bh
		mov	al, [esi+16h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+2Dh], bl
		mov	[edx+2Fh], bh
		shr	ebx, 10h
		mov	[edx+34h], bl
		mov	[edx+36h], bh
		mov	bx, [esi]
		mov	cx, [esi+2]
		mov	edx, _nf_width
		jmp	short L203
		align 4

L203:
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		lea	eax, ds:0FFFFFFFCh[edx*4]
		sub	edi, eax
		mov	bx, [esi+0Ch]
		mov	cx, [esi+0Eh]
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		add	esi, 18h
		sub	edi, 4
		sub	edi, [ebp-10h]
		retn
		align 4

L204:
		xor	eax, eax
		lea	ecx, byte_1250C4
		lea	edx, L205+1
		mov	al, [esi+4]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+2], bh
		shr	ebx, 10h
		mov	[edx+7], bl
		mov	[edx+9], bh
		mov	al, [esi+5]
		mov	ebx, [ecx+eax*4]
		mov	[edx+0Dh], bl
		mov	[edx+0Fh], bh
		shr	ebx, 10h
		mov	[edx+14h], bl
		mov	[edx+16h], bh
		mov	al, [esi+8]
		mov	ebx, [ecx+eax*4]
		mov	[edx+1Dh], bl
		mov	[edx+1Fh], bh
		shr	ebx, 10h
		mov	[edx+24h], bl
		mov	[edx+26h], bh
		mov	al, [esi+9]
		mov	ebx, [ecx+eax*4]
		mov	[edx+2Ah], bl
		mov	[edx+2Ch], bh
		shr	ebx, 10h
		mov	[edx+31h], bl
		mov	[edx+33h], bh
		lea	edx, [edx+42h]
		mov	al, [esi+10h]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+2], bh
		shr	ebx, 10h
		mov	[edx+7], bl
		mov	[edx+9], bh
		mov	al, [esi+11h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+0Dh], bl
		mov	[edx+0Fh], bh
		shr	ebx, 10h
		mov	[edx+14h], bl
		mov	[edx+16h], bh
		mov	al, [esi+14h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+1Dh], bl
		mov	[edx+1Fh], bh
		shr	ebx, 10h
		mov	[edx+24h], bl
		mov	[edx+26h], bh
		mov	al, [esi+15h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+2Ah], bl
		mov	[edx+2Ch], bh
		shr	ebx, 10h
		mov	[edx+31h], bl
		mov	[edx+33h], bh
		mov	bx, [esi]
		mov	cx, [esi+2]
		mov	edx, _nf_width
		jmp	short L205
		align 4

L205:
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi+4], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi+4], eax
		add	edi, edx
		mov	bx, [esi+0Ch]
		mov	cx, [esi+0Eh]
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi+4], eax
		add	edi, edx
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi], eax
		mov	al, bl
		mov	ah, bl
		shl	eax, 10h
		mov	al, bl
		mov	ah, bl
		mov	[edi+4], eax
		add	esi, 18h
		sub	edi, [ebp-10h]
		retn
		align 4

L206:
		mov	edx, _nf_width
		mov	eax, [esi]
		mov	[edi], eax
		mov	eax, [esi+4]
		mov	[edi+4], eax
		add	edi, edx
		mov	eax, [esi+10h]
		mov	[edi], eax
		mov	eax, [esi+14h]
		mov	[edi+4], eax
		add	edi, edx
		mov	eax, [esi+20h]
		mov	[edi], eax
		mov	eax, [esi+24h]
		mov	[edi+4], eax
		add	edi, edx
		mov	eax, [esi+30h]
		mov	[edi], eax
		mov	eax, [esi+34h]
		mov	[edi+4], eax
		add	esi, 40h
		sub	edi, [ebp-10h]
		retn
		align 4
L207:
		mov	edx, _nf_width
		mov	eax, [esi]
		mov	bl, ah
		mov	bh, ah
		shl	ebx, 10h
		mov	bl, al
		mov	bh, al
		mov	[edi], ebx
		shr	eax, 10h
		mov	bl, ah
		mov	bh, ah
		shl	ebx, 10h
		mov	bl, al
		mov	bh, al
		mov	[edi+4], ebx
		add	edi, edx
		mov	eax, [esi+4]
		mov	bl, ah
		mov	bh, ah
		shl	ebx, 10h
		mov	bl, al
		mov	bh, al
		mov	[edi], ebx
		shr	eax, 10h
		mov	bl, ah
		mov	bh, ah
		shl	ebx, 10h
		mov	bl, al
		mov	bh, al
		mov	[edi+4], ebx
		add	edi, edx
		mov	eax, [esi+8]
		mov	bl, ah
		mov	bh, ah
		shl	ebx, 10h
		mov	bl, al
		mov	bh, al
		mov	[edi], ebx
		shr	eax, 10h
		mov	bl, ah
		mov	bh, ah
		shl	ebx, 10h
		mov	bl, al
		mov	bh, al
		mov	[edi+4], ebx
		add	edi, edx
		mov	eax, [esi+0Ch]
		mov	bl, ah
		mov	bh, ah
		shl	ebx, 10h
		mov	bl, al
		mov	bh, al
		mov	[edi], ebx
		shr	eax, 10h
		mov	bl, ah
		mov	bh, ah
		shl	ebx, 10h
		mov	bl, al
		mov	bh, al
		mov	[edi+4], ebx
		sub	edi, [ebp-10h]
		add	esi, 10h
		retn
		align 4
L208:
		mov	edx, _nf_width
		mov	cl, [esi]
		mov	ch, cl
		mov	eax, ecx
		shl	eax, 10h
		mov	ax, cx
		mov	cl, [esi+1]
		mov	ch, cl
		mov	ebx, ecx
		shl	ebx, 10h
		mov	bx, cx
		mov	[edi], eax
		mov	[edi+4], ebx
		mov	[edi+edx], eax
		mov	[edi+edx+4], ebx
		lea	edi, [edi+edx*2]
		mov	cl, [esi+2]
		mov	ch, cl
		mov	eax, ecx
		shl	eax, 10h
		mov	ax, cx
		mov	cl, [esi+3]
		mov	ch, cl
		mov	ebx, ecx
		shl	ebx, 10h
		mov	bx, cx
		mov	[edi], eax
		mov	[edi+4], ebx
		add	edi, edx
		mov	[edi], eax
		mov	[edi+4], ebx
		sub	edi, [ebp-10h]
		add	esi, 4
		retn
		align 4
L209:
		mov	bl, [esi]
		inc	esi
		mov	bh, bl
		mov	eax, ebx
		shl	eax, 10h
		mov	ax, bx
		mov	ebx, eax
		jmp	short L211
		retn
		align 4

L210:
		mov	bx, [esi]
		add	esi, 2
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	ebx, eax
		rol	ebx, 8

L211:
		mov	edx, _nf_width
		mov	[edi], eax
		mov	[edi+4], eax
		add	edi, edx
		mov	[edi], ebx
		mov	[edi+4], ebx
		add	edi, edx
		mov	[edi], eax
		mov	[edi+4], eax
		add	edi, edx
		mov	[edi], ebx
		mov	[edi+4], ebx
		sub	edi, [ebp-10h]
		retn

PUBLIC _nfHPkDecomp
_nfHPkDecomp:
		push	ebp
		mov	ebp, esp
		add	esp, 0FFFFFFE8h
		push	esi
		push	edi
		push	ebx
		mov	ax, ds
		mov	es, ax
		mov	eax, _nf_buf_prv
		sub	eax, _nf_buf_cur
		mov	[ebp-0ch], eax
		xor	ebx, ebx
		mov	bl, _nf_fqty
		mov	eax, [ebp+10h]
		shl	eax, 4
		mov	_nf_new_x, eax
		mov	eax, [ebp+18h]
		shl	eax, 4
		mov	_nf_new_w, eax
		mov	eax, [ebp+14h]
		shl	eax, 3
		mul	ebx
		mov	_nf_new_y, eax
		mov	eax, [ebp+1ch]
		shl	eax, 3
		mul	ebx
		mov	_nf_new_h, eax
		mov	eax, _nf_new_row0
		sub	eax, _nf_new_w
		mov	[ebp-8], eax
		mov	eax, _nf_buf_cur
		mov	[ebp-4], eax
		cmp	[ebp+10h], 0
		jnz	short L212
		cmp	[ebp+14h], 0
		jz	short L213

L212:
		mov	eax, _nf_new_y
		mul	_nf_width
		add	eax, _nf_new_x
		add	[ebp-4], eax

L213:
		mov	eax, _nf_back_right
		sub	eax, 10h
		mov	[ebp-10h], eax
		mov	esi, [ebp+0ch]
		mov	edi, [ebp-4]
		xor	eax, eax
		mov	ax, [esi]
		add	eax, esi
		mov	[ebp-18h], eax
		add	esi, 2

L214:
		mov	eax, [ebp+18h]
		shr	eax, 1
		mov	[ebp-14h], eax
		align 4

L215:
		dec	dword ptr [ebp-14h]
		js	short L216
		mov	ebx, [ebp+8]
		mov	al, [ebx]
		inc	ebx
		mov	[ebp+8], ebx
		xor	ebx, ebx
		mov	bl, al
		shr	bl, 4
		and	eax, 0Fh
		push	offset L215
		push	off_125D84[ebx*4]
		jmp	off_125D84[eax*4]

L216:
		add	edi, [ebp-8]
		dec	dword ptr [ebp+1ch]
		jnz	short L214
		pop	ebx
		pop	edi
		pop	esi
		leave
		retn

		align 4
L217:
		mov	eax, [ebp-0ch]
		jmp	L226

		align 4
L218:
		add	edi, 10h
		retn

		align 4
L219:
		xor	eax, eax
		mov	ebx, [ebp-18h]
		inc	dword ptr [ebp-18h]
		mov	al, [ebx]
		mov	ax, word_124A84[eax*2]
L220:
		xor	ebx, ebx
		mov	bl, ah
		shl	eax, 18h
		sar	eax, 17h
		add	eax, dword_124484[ebx*4]
		jmp	short L226

		align 4
L221:
		xor	eax, eax
		mov	ebx, [ebp-18h]
		inc	dword ptr [ebp-18h]
		mov	al, [ebx]
		mov	ax, word_124A84[eax*2]
		neg	al
		neg	ah
		jmp	short L220

		align 4
L222:
		xor	eax, eax
		mov	ebx, [ebp-18h]
		inc	dword ptr [ebp-18h]
		mov	al, [ebx]
		mov	ax, word_124884[eax*2]
		jmp	short L224

		align 4
L223:
		mov	ax, [esi]
		add	esi, 2

L224:
		xor	ebx, ebx
		mov	bl, ah
		shl	eax, 18h
		sar	eax, 17h
		add	eax, dword_124484[ebx*4]
		add	eax, [ebp-0ch]
		jmp	short L226

		align 4
L225:
		mov	ax, [esi]
		add	esi, 2
		jmp	short L220

L226:
		mov	ebx, esi
		lea	esi, [edi+eax]
		mov	edx, _nf_width
		mov	eax, [esi]
		mov	[edi], eax
		mov	eax, [esi+4]
		mov	[edi+4], eax
		mov	eax, [esi+8]
		mov	[edi+8], eax
		mov	eax, [esi+0Ch]
		mov	[edi+0Ch], eax
		add	esi, edx
		add	edi, edx
		mov	eax, [esi]
		mov	[edi], eax
		mov	eax, [esi+4]
		mov	[edi+4], eax
		mov	eax, [esi+8]
		mov	[edi+8], eax
		mov	eax, [esi+0Ch]
		mov	[edi+0Ch], eax
		add	esi, edx
		add	edi, edx
		mov	eax, [esi]
		mov	[edi], eax
		mov	eax, [esi+4]
		mov	[edi+4], eax
		mov	eax, [esi+8]
		mov	[edi+8], eax
		mov	eax, [esi+0Ch]
		mov	[edi+0Ch], eax
		add	esi, edx
		add	edi, edx
		mov	eax, [esi]
		mov	[edi], eax
		mov	eax, [esi+4]
		mov	[edi+4], eax
		mov	eax, [esi+8]
		mov	[edi+8], eax
		mov	eax, [esi+0Ch]
		mov	[edi+0Ch], eax
		add	esi, edx
		add	edi, edx
		mov	eax, [esi]
		mov	[edi], eax
		mov	eax, [esi+4]
		mov	[edi+4], eax
		mov	eax, [esi+8]
		mov	[edi+8], eax
		mov	eax, [esi+0Ch]
		mov	[edi+0Ch], eax
		add	esi, edx
		add	edi, edx
		mov	eax, [esi]
		mov	[edi], eax
		mov	eax, [esi+4]
		mov	[edi+4], eax
		mov	eax, [esi+8]
		mov	[edi+8], eax
		mov	eax, [esi+0Ch]
		mov	[edi+0Ch], eax
		add	esi, edx
		add	edi, edx
		mov	eax, [esi]
		mov	[edi], eax
		mov	eax, [esi+4]
		mov	[edi+4], eax
		mov	eax, [esi+8]
		mov	[edi+8], eax
		mov	eax, [esi+0Ch]
		mov	[edi+0Ch], eax
		add	esi, edx
		add	edi, edx
		mov	eax, [esi]
		mov	[edi], eax
		mov	eax, [esi+4]
		mov	[edi+4], eax
		mov	eax, [esi+8]
		mov	[edi+8], eax
		mov	eax, [esi+0Ch]
		mov	[edi+0Ch], eax
		sub	edi, [ebp-10h]
		mov	esi, ebx
		retn
		align 4

L227:
		test	word ptr [esi],	8000h
		jnz	L229
		xor	eax, eax
		lea	ecx, byte_125584
		lea	edx, L228+1
		mov	al, [esi+4]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+3], bh
		shr	ebx, 10h
		mov	[edx+6], bl
		mov	[edx+9], bh
		mov	al, [esi+5]
		mov	ebx, [ecx+eax*4]
		mov	[edx+0Eh], bl
		mov	[edx+11h], bh
		shr	ebx, 10h
		mov	[edx+14h], bl
		mov	[edx+17h], bh
		mov	al, [esi+6]
		mov	ebx, [ecx+eax*4]
		mov	[edx+1Ch], bl
		mov	[edx+1Fh], bh
		shr	ebx, 10h
		mov	[edx+22h], bl
		mov	[edx+25h], bh
		mov	al, [esi+7]
		mov	ebx, [ecx+eax*4]
		mov	[edx+2Ah], bl
		mov	[edx+2Dh], bh
		shr	ebx, 10h
		mov	[edx+30h], bl
		mov	[edx+33h], bh
		lea	edx, [edx+38h]
		mov	al, [esi+8]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+3], bh
		shr	ebx, 10h
		mov	[edx+6], bl
		mov	[edx+9], bh
		mov	al, [esi+9]
		mov	ebx, [ecx+eax*4]
		mov	[edx+0Eh], bl
		mov	[edx+11h], bh
		shr	ebx, 10h
		mov	[edx+14h], bl
		mov	[edx+17h], bh
		mov	al, [esi+0Ah]
		mov	ebx, [ecx+eax*4]
		mov	[edx+1Ch], bl
		mov	[edx+1Fh], bh
		shr	ebx, 10h
		mov	[edx+22h], bl
		mov	[edx+25h], bh
		mov	al, [esi+0Bh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+2Ah], bl
		mov	[edx+2Dh], bh
		shr	ebx, 10h
		mov	[edx+30h], bl
		mov	[edx+33h], bh
		push	ebp
		push	esi
		mov	ecx, [esi]
		mov	esi, _nf_width
		mov	edx, ecx
		ror	edx, 10h
		mov	ebx, edx
		mov	bx, cx
		mov	ebp, ecx
		mov	bp, dx
		jmp	short L228
		align 4

L228:
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		mov	[ebp+8], ebx
		mov	[ebp+0ch], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		mov	[ebp+8], ebx
		mov	[ebp+0ch], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		mov	[ebp+8], ebx
		mov	[ebp+0ch], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		mov	[ebp+8], ebx
		mov	[ebp+0ch], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		mov	[ebp+8], ebx
		mov	[ebp+0ch], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		mov	[ebp+8], ebx
		mov	[ebp+0ch], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		mov	[ebp+8], ebx
		mov	[ebp+0ch], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		mov	[ebp+8], ebx
		mov	[ebp+0ch], ebx
		pop	esi
		pop	ebp
		add	esi, 0Ch
		sub	edi, [ebp-10h]
		retn
		align 4

L229:
		xor	eax, eax
		lea	ecx, byte_125544
		lea	edx, L230+1
		mov	al, [esi+4]
		and	al, 0Fh
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+7], bh
		shr	ebx, 10h
		mov	[edx+10h], bl
		mov	[edx+19h], bh
		mov	al, [esi+4]
		shr	al, 4
		mov	ebx, [ecx+eax*4]
		mov	[edx+25h], bl
		mov	[edx+2Ch], bh
		shr	ebx, 10h
		mov	[edx+35h], bl
		mov	[edx+3Eh], bh
		mov	al, [esi+5]
		and	al, 0Fh
		mov	ebx, [ecx+eax*4]
		mov	[edx+4Ah], bl
		mov	[edx+51h], bh
		shr	ebx, 10h
		mov	[edx+5Ah], bl
		mov	[edx+63h], bh
		mov	al, [esi+5]
		shr	al, 4
		mov	ebx, [ecx+eax*4]
		mov	[edx+6Fh], bl
		mov	[edx+76h], bh
		shr	ebx, 10h
		mov	[edx+7Fh], bl
		mov	[edx+88h], bh
		mov	edx, _nf_width
		mov	ebx, [esi]
		and	ebx, 7FFF7FFFh
		mov	ecx, ebx
		ror	ebx, 10h
		xchg	bx, cx
		jmp	short L230
		align 4

L230:
		mov	eax, ebx
		mov	[edi], eax
		mov	[edi+edx], eax
		mov	eax, ebx
		mov	[edi+4], eax
		mov	[edi+edx+4], eax
		mov	eax, ebx
		mov	[edi+8], eax
		mov	[edi+edx+8], eax
		mov	eax, ebx
		mov	[edi+0Ch], eax
		mov	[edi+edx+0Ch], eax
		lea	edi, [edi+edx*2]
		mov	eax, ebx
		mov	[edi], eax
		mov	[edi+edx], eax
		mov	eax, ebx
		mov	[edi+4], eax
		mov	[edi+edx+4], eax
		mov	eax, ebx
		mov	[edi+8], eax
		mov	[edi+edx+8], eax
		mov	eax, ebx
		mov	[edi+0Ch], eax
		mov	[edi+edx+0Ch], eax
		lea	edi, [edi+edx*2]
		mov	eax, ebx
		mov	[edi], eax
		mov	[edi+edx], eax
		mov	eax, ebx
		mov	[edi+4], eax
		mov	[edi+edx+4], eax
		mov	eax, ebx
		mov	[edi+8], eax
		mov	[edi+edx+8], eax
		mov	eax, ebx
		mov	[edi+0Ch], eax
		mov	[edi+edx+0Ch], eax
		lea	edi, [edi+edx*2]
		mov	eax, ebx
		mov	[edi], eax
		mov	[edi+edx], eax
		mov	eax, ebx
		mov	[edi+4], eax
		mov	[edi+edx+4], eax
		mov	eax, ebx
		mov	[edi+8], eax
		mov	[edi+edx+8], eax
		mov	eax, ebx
		mov	[edi+0Ch], eax
		mov	[edi+edx+0Ch], eax
		add	edi, edx
		sub	edi, [ebp-10h]
		add	esi, 6
		retn
		align 4

L231:
		test	word ptr [esi],	8000h
		jnz	L233
		xor	eax, eax
		lea	ecx, byte_125584
		lea	edx, L232+1
		mov	al, [esi+4]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+3], bh
		shr	ebx, 10h
		mov	[edx+8], bl
		mov	[edx+0Bh], bh
		mov	al, [esi+5]
		mov	ebx, [ecx+eax*4]
		mov	[edx+10h], bl
		mov	[edx+13h], bh
		shr	ebx, 10h
		mov	[edx+18h], bl
		mov	[edx+1Bh], bh
		mov	al, [esi+0Ah]
		mov	ebx, [ecx+eax*4]
		mov	[edx+35h], bl
		mov	[edx+38h], bh
		shr	ebx, 10h
		mov	[edx+3Dh], bl
		mov	[edx+40h], bh
		mov	al, [esi+0Bh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+45h], bl
		mov	[edx+48h], bh
		shr	ebx, 10h
		mov	[edx+4Dh], bl
		mov	[edx+50h], bh
		add	edx, L232_0-L232 ; hack
		mov	al, [esi+10h]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+3], bh
		shr	ebx, 10h
		mov	[edx+8], bl
		mov	[edx+0Bh], bh
		mov	al, [esi+11h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+10h], bl
		mov	[edx+13h], bh
		shr	ebx, 10h
		mov	[edx+18h], bl
		mov	[edx+1Bh], bh
		mov	al, [esi+16h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+35h], bl
		mov	[edx+38h], bh
		shr	ebx, 10h
		mov	[edx+3Dh], bl
		mov	[edx+40h], bh
		mov	al, [esi+17h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+45h], bl
		mov	[edx+48h], bh
		shr	ebx, 10h
		mov	[edx+4Dh], bl
		mov	[edx+50h], bh
		push	ebp
		push	esi
		mov	ecx, [esi]
		mov	esi, _nf_width
		mov	edx, ecx
		ror	edx, 10h
		mov	ebx, edx
		mov	bx, cx
		mov	ebp, ecx
		mov	bp, dx
		jmp	short $+2

L232:
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		add	edi, esi
		mov	eax, [esp]
		mov	ecx, [eax+6]
		mov	edx, ecx
		ror	edx, 10h
		mov	ebx, edx
		mov	bx, cx
		mov	ebp, ecx
		mov	bp, dx
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		add	edi, esi
		lea	eax, ds:0FFFFFFF8h[esi*8]
		sub	edi, eax
		mov	eax, [esp]
		mov	ecx, [eax+0Ch]
		mov	edx, ecx
		ror	edx, 10h
		mov	ebx, edx
		mov	bx, cx
		mov	ebp, ecx
		mov	bp, dx
L232_0:
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		add	edi, esi
		mov	eax, [esp]
		mov	ecx, [eax+12h]
		mov	edx, ecx
		ror	edx, 10h
		mov	ebx, edx
		mov	bx, cx
		mov	ebp, ecx
		mov	bp, dx
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		pop	esi
		pop	ebp
		add	esi, 18h
		sub	edi, 8
		sub	edi, [ebp-10h]
		retn
		align 4

L233:
		test	word ptr [esi+8], 8000h
		jnz	L235
		xor	eax, eax
		lea	ecx, byte_125584
		lea	edx, L234+1
		mov	al, [esi+4]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+3], bh
		shr	ebx, 10h
		mov	[edx+8], bl
		mov	[edx+0Bh], bh
		mov	al, [esi+5]
		mov	ebx, [ecx+eax*4]
		mov	[edx+10h], bl
		mov	[edx+13h], bh
		shr	ebx, 10h
		mov	[edx+18h], bl
		mov	[edx+1Bh], bh
		mov	al, [esi+6]
		mov	ebx, [ecx+eax*4]
		mov	[edx+20h], bl
		mov	[edx+23h], bh
		shr	ebx, 10h
		mov	[edx+28h], bl
		mov	[edx+2Bh], bh
		mov	al, [esi+7]
		mov	ebx, [ecx+eax*4]
		mov	[edx+30h], bl
		mov	[edx+33h], bh
		shr	ebx, 10h
		mov	[edx+38h], bl
		mov	[edx+3Bh], bh
		add	edx, L234_0-L234 ; hack
		mov	al, [esi+0Ch]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+3], bh
		shr	ebx, 10h
		mov	[edx+8], bl
		mov	[edx+0Bh], bh
		mov	al, [esi+0Dh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+10h], bl
		mov	[edx+13h], bh
		shr	ebx, 10h
		mov	[edx+18h], bl
		mov	[edx+1Bh], bh
		mov	al, [esi+0Eh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+20h], bl
		mov	[edx+23h], bh
		shr	ebx, 10h
		mov	[edx+28h], bl
		mov	[edx+2Bh], bh
		mov	al, [esi+0Fh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+30h], bl
		mov	[edx+33h], bh
		shr	ebx, 10h
		mov	[edx+38h], bl
		mov	[edx+3Bh], bh
		push	ebp
		push	esi
		mov	ecx, [esi]
		and	ecx, 7FFF7FFFh
		mov	esi, _nf_width
		mov	edx, ecx
		ror	edx, 10h
		mov	ebx, edx
		mov	bx, cx
		mov	ebp, ecx
		mov	bp, dx
		jmp	short L234
		align 4

L234:
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		add	edi, esi
		lea	eax, ds:0FFFFFFF8h[esi*8]
		sub	edi, eax
		mov	eax, [esp]
		mov	ecx, [eax+8]
		mov	edx, ecx
		ror	edx, 10h
		mov	ebx, edx
		mov	bx, cx
		mov	ebp, ecx
		mov	bp, dx
L234_0:
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		pop	esi
		pop	ebp
		add	esi, 10h
		sub	edi, 8
		sub	edi, [ebp-10h]
		retn

L235:
		xor	eax, eax
		lea	ecx, byte_125584
		lea	edx, L236+1
		mov	al, [esi+4]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+3], bh
		shr	ebx, 10h
		mov	[edx+6], bl
		mov	[edx+9], bh
		mov	al, [esi+5]
		mov	ebx, [ecx+eax*4]
		mov	[edx+0Eh], bl
		mov	[edx+11h], bh
		shr	ebx, 10h
		mov	[edx+14h], bl
		mov	[edx+17h], bh
		mov	al, [esi+6]
		mov	ebx, [ecx+eax*4]
		mov	[edx+1Ch], bl
		mov	[edx+1Fh], bh
		shr	ebx, 10h
		mov	[edx+22h], bl
		mov	[edx+25h], bh
		mov	al, [esi+7]
		mov	ebx, [ecx+eax*4]
		mov	[edx+2Ah], bl
		mov	[edx+2Dh], bh
		shr	ebx, 10h
		mov	[edx+30h], bl
		mov	[edx+33h], bh
		add	edx, L236_0-L236 ; hack
		mov	al, [esi+0Ch]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+3], bh
		shr	ebx, 10h
		mov	[edx+6], bl
		mov	[edx+9], bh
		mov	al, [esi+0Dh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+0Eh], bl
		mov	[edx+11h], bh
		shr	ebx, 10h
		mov	[edx+14h], bl
		mov	[edx+17h], bh
		mov	al, [esi+0Eh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+1Ch], bl
		mov	[edx+1Fh], bh
		shr	ebx, 10h
		mov	[edx+22h], bl
		mov	[edx+25h], bh
		mov	al, [esi+0Fh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+2Ah], bl
		mov	[edx+2Dh], bh
		shr	ebx, 10h
		mov	[edx+30h], bl
		mov	[edx+33h], bh
		push	ebp
		push	esi
		mov	ecx, [esi]
		and	ecx, 7FFF7FFFh
		mov	esi, _nf_width
		mov	edx, ecx
		ror	edx, 10h
		mov	ebx, edx
		mov	bx, cx
		mov	ebp, ecx
		mov	bp, dx
		jmp	short L236
		align 4

L236:
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		mov	[ebp+8], ebx
		mov	[ebp+0ch], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		mov	[ebp+8], ebx
		mov	[ebp+0ch], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		mov	[ebp+8], ebx
		mov	[ebp+0ch], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		mov	[ebp+8], ebx
		mov	[ebp+0ch], ebx
		add	edi, esi
		mov	eax, [esp]
		mov	ecx, [eax+8]
		and	ecx, 7FFF7FFFh
		mov	edx, ecx
		ror	edx, 10h
		mov	ebx, edx
		mov	bx, cx
		mov	ebp, ecx
		mov	bp, dx
L236_0:
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		mov	[ebp+8], ebx
		mov	[ebp+0ch], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		mov	[ebp+8], ebx
		mov	[ebp+0ch], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		mov	[ebp+8], ebx
		mov	[ebp+0ch], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		mov	[ebp+8], ebx
		mov	[ebp+0ch], ebx
		pop	esi
		pop	ebp
		add	esi, 10h
		sub	edi, [ebp-10h]
		retn
		align 4

L237:
		test	word ptr [esi],	8000h
		jnz	L241
		test	word ptr [esi+4], 8000h
		jnz	L239
		xor	eax, eax
		lea	ecx, byte_125984
		lea	edx, L238+2
		mov	al, [esi+8]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bh
		mov	[edx+6], bl
		shr	ebx, 10h
		mov	[edx+0Bh], bh
		mov	[edx+11h], bl
		mov	al, [esi+9]
		mov	ebx, [ecx+eax*4]
		mov	[edx+17h], bh
		mov	[edx+1Dh], bl
		shr	ebx, 10h
		mov	[edx+23h], bh
		mov	[edx+29h], bl
		mov	al, [esi+0Ah]
		mov	ebx, [ecx+eax*4]
		mov	[edx+31h], bh
		mov	[edx+37h], bl
		shr	ebx, 10h
		mov	[edx+3Ch], bh
		mov	[edx+42h], bl
		mov	al, [esi+0Bh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+48h], bh
		mov	[edx+4Eh], bl
		shr	ebx, 10h
		mov	[edx+54h], bh
		mov	[edx+5Ah], bl
		mov	al, [esi+0Ch]
		mov	ebx, [ecx+eax*4]
		mov	[edx+62h], bh
		mov	[edx+68h], bl
		shr	ebx, 10h
		mov	[edx+6Dh], bh
		mov	[edx+73h], bl
		mov	al, [esi+0Dh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+79h], bh
		mov	[edx+7Fh], bl
		shr	ebx, 10h
		mov	[edx+85h], bh
		mov	[edx+8Bh], bl
		mov	al, [esi+0Eh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+93h], bh
		mov	[edx+99h], bl
		shr	ebx, 10h
		mov	[edx+9Eh], bh
		mov	[edx+0A4h], bl
		mov	al, [esi+0Fh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+0AAh], bh
		mov	[edx+0B0h], bl
		shr	ebx, 10h
		mov	[edx+0B6h], bh
		mov	[edx+0BCh], bl
		lea	edx, [edx+0C4h]
		mov	al, [esi+10h]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bh
		mov	[edx+6], bl
		shr	ebx, 10h
		mov	[edx+0Bh], bh
		mov	[edx+11h], bl
		mov	al, [esi+11h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+17h], bh
		mov	[edx+1Dh], bl
		shr	ebx, 10h
		mov	[edx+23h], bh
		mov	[edx+29h], bl
		mov	al, [esi+12h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+31h], bh
		mov	[edx+37h], bl
		shr	ebx, 10h
		mov	[edx+3Ch], bh
		mov	[edx+42h], bl
		mov	al, [esi+13h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+48h], bh
		mov	[edx+4Eh], bl
		shr	ebx, 10h
		mov	[edx+54h], bh
		mov	[edx+5Ah], bl
		mov	al, [esi+14h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+62h], bh
		mov	[edx+68h], bl
		shr	ebx, 10h
		mov	[edx+6Dh], bh
		mov	[edx+73h], bl
		mov	al, [esi+15h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+79h], bh
		mov	[edx+7Fh], bl
		shr	ebx, 10h
		mov	[edx+85h], bh
		mov	[edx+8Bh], bl
		mov	al, [esi+16h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+93h], bh
		mov	[edx+99h], bl
		shr	ebx, 10h
		mov	[edx+9Eh], bh
		mov	[edx+0A4h], bl
		mov	al, [esi+17h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+0AAh], bh
		mov	[edx+0B0h], bl
		shr	ebx, 10h
		mov	[edx+0B6h], bh
		mov	[edx+0BCh], bl
		push	ebp
		push	esi
		mov	bx, [esi]
		mov	dx, [esi+2]
		mov	cx, [esi+4]
		mov	bp, [esi+6]
		mov	esi, _nf_width
		jmp	short L238
		align 4

L238:
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+8], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+0Ch], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+8], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+0Ch], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+8], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+0Ch], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+8], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+0Ch], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+8], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+0Ch], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+8], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+0Ch], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+8], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+0Ch], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+8], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+0Ch], eax
		pop	esi
		pop	ebp
		add	esi, 18h
		sub	edi, [ebp-10h]
		retn
		align 4

L239:
		xor	eax, eax
		lea	ecx, byte_125984
		lea	edx, L240+1
		mov	al, [esi+8]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+7], bh
		shr	ebx, 10h
		mov	[edx+10h], bl
		mov	[edx+19h], bh
		mov	al, [esi+9]
		mov	ebx, [ecx+eax*4]
		mov	[edx+25h], bl
		mov	[edx+2Ch], bh
		shr	ebx, 10h
		mov	[edx+35h], bl
		mov	[edx+3Eh], bh
		mov	al, [esi+0Ah]
		mov	ebx, [ecx+eax*4]
		mov	[edx+4Ah], bl
		mov	[edx+51h], bh
		shr	ebx, 10h
		mov	[edx+5Ah], bl
		mov	[edx+63h], bh
		mov	al, [esi+0Bh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+6Fh], bl
		mov	[edx+76h], bh
		shr	ebx, 10h
		mov	[edx+7Fh], bl
		mov	[edx+88h], bh
		push	ebp
		push	esi
		mov	ax, [esi]
		shrd	ebx, eax, 10h
		mov	bx, ax
		mov	ax, [esi+2]
		shrd	edx, eax, 10h
		mov	dx, ax
		mov	ax, [esi+4]
		and	eax, 7FFFh
		shrd	ecx, eax, 10h
		mov	cx, ax
		mov	ax, [esi+6]
		mov	esi, _nf_width
		shrd	ebp, eax, 10h
		mov	bp, ax
		jmp	short L240
		align 4

L240:
		mov	eax, ebx
		mov	[edi], eax
		mov	[edi+esi], eax
		mov	eax, ebx
		mov	[edi+4], eax
		mov	[edi+esi+4], eax
		mov	eax, ebx
		mov	[edi+8], eax
		mov	[edi+esi+8], eax
		mov	eax, ebx
		mov	[edi+0Ch], eax
		mov	[edi+esi+0Ch], eax
		lea	edi, [edi+esi*2]
		mov	eax, ebx
		mov	[edi], eax
		mov	[edi+esi], eax
		mov	eax, ebx
		mov	[edi+4], eax
		mov	[edi+esi+4], eax
		mov	eax, ebx
		mov	[edi+8], eax
		mov	[edi+esi+8], eax
		mov	eax, ebx
		mov	[edi+0Ch], eax
		mov	[edi+esi+0Ch], eax
		lea	edi, [edi+esi*2]
		mov	eax, ebx
		mov	[edi], eax
		mov	[edi+esi], eax
		mov	eax, ebx
		mov	[edi+4], eax
		mov	[edi+esi+4], eax
		mov	eax, ebx
		mov	[edi+8], eax
		mov	[edi+esi+8], eax
		mov	eax, ebx
		mov	[edi+0Ch], eax
		mov	[edi+esi+0Ch], eax
		lea	edi, [edi+esi*2]
		mov	eax, ebx
		mov	[edi], eax
		mov	[edi+esi], eax
		mov	eax, ebx
		mov	[edi+4], eax
		mov	[edi+esi+4], eax
		mov	eax, ebx
		mov	[edi+8], eax
		mov	[edi+esi+8], eax
		mov	eax, ebx
		mov	[edi+0Ch], eax
		mov	[edi+esi+0Ch], eax
		add	edi, esi
		pop	esi
		pop	ebp
		add	esi, 0Ch
		sub	edi, [ebp-10h]
		retn

L241:
		test	word ptr [esi+4], 8000h
		jnz	L243
		xor	eax, eax
		lea	ecx, byte_125584
		lea	edx, L242+1
		mov	al, [esi+8]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+3], bh
		shr	ebx, 10h
		mov	[edx+6], bl
		mov	[edx+9], bh
		mov	al, [esi+9]
		mov	ebx, [ecx+eax*4]
		mov	[edx+0Eh], bl
		mov	[edx+11h], bh
		shr	ebx, 10h
		mov	[edx+14h], bl
		mov	[edx+17h], bh
		mov	al, [esi+0Ah]
		mov	ebx, [ecx+eax*4]
		mov	[edx+1Ch], bl
		mov	[edx+1Fh], bh
		shr	ebx, 10h
		mov	[edx+22h], bl
		mov	[edx+25h], bh
		mov	al, [esi+0Bh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+2Ah], bl
		mov	[edx+2Dh], bh
		shr	ebx, 10h
		mov	[edx+30h], bl
		mov	[edx+33h], bh
		lea	edx, [edx+38h]
		mov	al, [esi+0Ch]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bl
		mov	[edx+3], bh
		shr	ebx, 10h
		mov	[edx+6], bl
		mov	[edx+9], bh
		mov	al, [esi+0Dh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+0Eh], bl
		mov	[edx+11h], bh
		shr	ebx, 10h
		mov	[edx+14h], bl
		mov	[edx+17h], bh
		mov	al, [esi+0Eh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+1Ch], bl
		mov	[edx+1Fh], bh
		shr	ebx, 10h
		mov	[edx+22h], bl
		mov	[edx+25h], bh
		mov	al, [esi+0Fh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+2Ah], bl
		mov	[edx+2Dh], bh
		shr	ebx, 10h
		mov	[edx+30h], bl
		mov	[edx+33h], bh
		push	ebp
		push	esi
		mov	ax, [esi]
		and	eax, 7FFFh
		shrd	ebx, eax, 10h
		mov	bx, ax
		mov	ax, [esi+2]
		shrd	edx, eax, 10h
		mov	dx, ax
		mov	ax, [esi+4]
		shrd	ecx, eax, 10h
		mov	cx, ax
		mov	ax, [esi+6]
		mov	esi, _nf_width
		shrd	ebp, eax, 10h
		mov	bp, ax
		jmp	short L242
		align 4

L242:
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		mov	[ebp+8], ebx
		mov	[ebp+0ch], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		mov	[ebp+8], ebx
		mov	[ebp+0ch], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		mov	[ebp+8], ebx
		mov	[ebp+0ch], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		mov	[ebp+8], ebx
		mov	[ebp+0ch], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		mov	[ebp+8], ebx
		mov	[ebp+0ch], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		mov	[ebp+8], ebx
		mov	[ebp+0ch], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		mov	[ebp+8], ebx
		mov	[ebp+0ch], ebx
		add	edi, esi
		mov	[ebp+0], ebx
		mov	[ebp+4], ebx
		mov	[ebp+8], ebx
		mov	[ebp+0ch], ebx
		pop	esi
		pop	ebp
		add	esi, 10h
		sub	edi, [ebp-10h]
		retn
		align 4

L243:
		xor	eax, eax
		lea	ecx, byte_125984
		lea	edx, L244+2
		mov	al, [esi+8]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bh
		mov	[edx+6], bl
		shr	ebx, 10h
		mov	[edx+0Eh], bh
		mov	[edx+14h], bl
		mov	al, [esi+9]
		mov	ebx, [ecx+eax*4]
		mov	[edx+1Eh], bh
		mov	[edx+24h], bl
		shr	ebx, 10h
		mov	[edx+2Eh], bh
		mov	[edx+34h], bl
		mov	al, [esi+0Ah]
		mov	ebx, [ecx+eax*4]
		mov	[edx+41h], bh
		mov	[edx+47h], bl
		shr	ebx, 10h
		mov	[edx+4Fh], bh
		mov	[edx+55h], bl
		mov	al, [esi+0Bh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+5Fh], bh
		mov	[edx+65h], bl
		shr	ebx, 10h
		mov	[edx+6Fh], bh
		mov	[edx+75h], bl
		mov	al, [esi+0Ch]
		mov	ebx, [ecx+eax*4]
		mov	[edx+82h], bh
		mov	[edx+88h], bl
		shr	ebx, 10h
		mov	[edx+90h], bh
		mov	[edx+96h], bl
		mov	al, [esi+0Dh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+0A0h], bh
		mov	[edx+0A6h], bl
		shr	ebx, 10h
		mov	[edx+0B0h], bh
		mov	[edx+0B6h], bl
		mov	al, [esi+0Eh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+0C3h], bh
		mov	[edx+0C9h], bl
		shr	ebx, 10h
		mov	[edx+0D1h], bh
		mov	[edx+0D7h], bl
		mov	al, [esi+0Fh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+0E1h], bh
		mov	[edx+0E7h], bl
		shr	ebx, 10h
		mov	[edx+0F1h], bh
		mov	[edx+0F7h], bl
		push	ebp
		push	esi
		mov	bx, [esi]
		and	ebx, 7FFFh
		mov	dx, [esi+2]
		mov	cx, [esi+4]
		and	ecx, 7FFFh
		mov	bp, [esi+6]
		mov	esi, _nf_width
		jmp	short L244
		align 4

L244:
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	[edi+esi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		mov	[edi+esi+4], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+8], eax
		mov	[edi+esi+8], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+0Ch], eax
		mov	[edi+esi+0Ch], eax
		lea	edi, [edi+esi*2]
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	[edi+esi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		mov	[edi+esi+4], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+8], eax
		mov	[edi+esi+8], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+0Ch], eax
		mov	[edi+esi+0Ch], eax
		lea	edi, [edi+esi*2]
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	[edi+esi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		mov	[edi+esi+4], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+8], eax
		mov	[edi+esi+8], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+0Ch], eax
		mov	[edi+esi+0Ch], eax
		lea	edi, [edi+esi*2]
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	[edi+esi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		mov	[edi+esi+4], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+8], eax
		mov	[edi+esi+8], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+0Ch], eax
		mov	[edi+esi+0Ch], eax
		add	edi, esi
		pop	esi
		pop	ebp
		add	esi, 10h
		sub	edi, [ebp-10h]
		retn

L245:
		test	word ptr [esi],	8000h
		jnz	L247
		xor	eax, eax
		lea	ecx, byte_125984
		lea	edx, L246+2
		mov	al, [esi+8]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bh
		mov	[edx+6], bl
		shr	ebx, 10h
		mov	[edx+0Bh], bh
		mov	[edx+11h], bl
		mov	al, [esi+9]
		mov	ebx, [ecx+eax*4]
		mov	[edx+19h], bh
		mov	[edx+1Fh], bl
		shr	ebx, 10h
		mov	[edx+24h], bh
		mov	[edx+2Ah], bl
		mov	al, [esi+0Ah]
		mov	ebx, [ecx+eax*4]
		mov	[edx+32h], bh
		mov	[edx+38h], bl
		shr	ebx, 10h
		mov	[edx+3Dh], bh
		mov	[edx+43h], bl
		mov	al, [esi+0Bh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+4Bh], bh
		mov	[edx+51h], bl
		shr	ebx, 10h
		mov	[edx+56h], bh
		mov	[edx+5Ch], bl
		mov	al, [esi+14h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+77h], bh
		mov	[edx+7Dh], bl
		shr	ebx, 10h
		mov	[edx+82h], bh
		mov	[edx+88h], bl
		mov	al, [esi+15h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+90h], bh
		mov	[edx+96h], bl
		shr	ebx, 10h
		mov	[edx+9Bh], bh
		mov	[edx+0A1h], bl
		mov	al, [esi+16h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+0A9h], bh
		mov	[edx+0AFh], bl
		shr	ebx, 10h
		mov	[edx+0B4h], bh
		mov	[edx+0BAh], bl
		mov	al, [esi+17h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+0C2h], bh
		mov	[edx+0C8h], bl
		shr	ebx, 10h
		mov	[edx+0CDh], bh
		mov	[edx+0D3h], bl
		lea	edx, [edx+0F7h]
		mov	al, [esi+20h]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bh
		mov	[edx+6], bl
		shr	ebx, 10h
		mov	[edx+0Bh], bh
		mov	[edx+11h], bl
		mov	al, [esi+21h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+19h], bh
		mov	[edx+1Fh], bl
		shr	ebx, 10h
		mov	[edx+24h], bh
		mov	[edx+2Ah], bl
		mov	al, [esi+22h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+32h], bh
		mov	[edx+38h], bl
		shr	ebx, 10h
		mov	[edx+3Dh], bh
		mov	[edx+43h], bl
		mov	al, [esi+23h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+4Bh], bh
		mov	[edx+51h], bl
		shr	ebx, 10h
		mov	[edx+56h], bh
		mov	[edx+5Ch], bl
		mov	al, [esi+2Ch]
		mov	ebx, [ecx+eax*4]
		mov	[edx+77h], bh
		mov	[edx+7Dh], bl
		shr	ebx, 10h
		mov	[edx+82h], bh
		mov	[edx+88h], bl
		mov	al, [esi+2Dh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+90h], bh
		mov	[edx+96h], bl
		shr	ebx, 10h
		mov	[edx+9Bh], bh
		mov	[edx+0A1h], bl
		mov	al, [esi+2Eh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+0A9h], bh
		mov	[edx+0AFh], bl
		shr	ebx, 10h
		mov	[edx+0B4h], bh
		mov	[edx+0BAh], bl
		mov	al, [esi+2Fh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+0C2h], bh
		mov	[edx+0C8h], bl
		shr	ebx, 10h
		mov	[edx+0CDh], bh
		mov	[edx+0D3h], bl
		push	ebp
		push	esi
		mov	bx, [esi]
		mov	dx, [esi+2]
		mov	cx, [esi+4]
		mov	bp, [esi+6]
		mov	esi, _nf_width
		jmp	short L246
		align 4

L246:
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	eax, [esp]
		mov	bx, [eax+0Ch]
		mov	dx, [eax+0Eh]
		mov	cx, [eax+10h]
		mov	bp, [eax+12h]
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		lea	eax, ds:0FFFFFFF8h[esi*8]
		sub	edi, eax
		mov	eax, [esp]
		mov	bx, [eax+18h]
		mov	dx, [eax+1Ah]
		mov	cx, [eax+1Ch]
		mov	bp, [eax+1Eh]
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	eax, [esp]
		mov	bx, [eax+24h]
		mov	dx, [eax+26h]
		mov	cx, [eax+28h]
		mov	bp, [eax+2Ah]
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		pop	esi
		pop	ebp
		add	esi, 30h
		sub	edi, 8
		sub	edi, [ebp-10h]
		retn

L247:
		test	word ptr [esi+10h], 8000h
		jnz	L249
		xor	eax, eax
		lea	ecx, byte_125984
		lea	edx, L248+2
		mov	al, [esi+8]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bh
		mov	[edx+6], bl
		shr	ebx, 10h
		mov	[edx+0Bh], bh
		mov	[edx+11h], bl
		mov	al, [esi+9]
		mov	ebx, [ecx+eax*4]
		mov	[edx+19h], bh
		mov	[edx+1Fh], bl
		shr	ebx, 10h
		mov	[edx+24h], bh
		mov	[edx+2Ah], bl
		mov	al, [esi+0Ah]
		mov	ebx, [ecx+eax*4]
		mov	[edx+32h], bh
		mov	[edx+38h], bl
		shr	ebx, 10h
		mov	[edx+3Dh], bh
		mov	[edx+43h], bl
		mov	al, [esi+0Bh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+4Bh], bh
		mov	[edx+51h], bl
		shr	ebx, 10h
		mov	[edx+56h], bh
		mov	[edx+5Ch], bl
		mov	al, [esi+0Ch]
		mov	ebx, [ecx+eax*4]
		mov	[edx+64h], bh
		mov	[edx+6Ah], bl
		shr	ebx, 10h
		mov	[edx+6Fh], bh
		mov	[edx+75h], bl
		mov	al, [esi+0Dh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+7Dh], bh
		mov	[edx+83h], bl
		shr	ebx, 10h
		mov	[edx+88h], bh
		mov	[edx+8Eh], bl
		mov	al, [esi+0Eh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+96h], bh
		mov	[edx+9Ch], bl
		shr	ebx, 10h
		mov	[edx+0A1h], bh
		mov	[edx+0A7h], bl
		mov	al, [esi+0Fh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+0AFh], bh
		mov	[edx+0B5h], bl
		shr	ebx, 10h
		mov	[edx+0BAh], bh
		mov	[edx+0C0h], bl
		lea	edx, [edx+0E4h]
		mov	al, [esi+18h]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bh
		mov	[edx+6], bl
		shr	ebx, 10h
		mov	[edx+0Bh], bh
		mov	[edx+11h], bl
		mov	al, [esi+19h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+19h], bh
		mov	[edx+1Fh], bl
		shr	ebx, 10h
		mov	[edx+24h], bh
		mov	[edx+2Ah], bl
		mov	al, [esi+1Ah]
		mov	ebx, [ecx+eax*4]
		mov	[edx+32h], bh
		mov	[edx+38h], bl
		shr	ebx, 10h
		mov	[edx+3Dh], bh
		mov	[edx+43h], bl
		mov	al, [esi+1Bh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+4Bh], bh
		mov	[edx+51h], bl
		shr	ebx, 10h
		mov	[edx+56h], bh
		mov	[edx+5Ch], bl
		mov	al, [esi+1Ch]
		mov	ebx, [ecx+eax*4]
		mov	[edx+64h], bh
		mov	[edx+6Ah], bl
		shr	ebx, 10h
		mov	[edx+6Fh], bh
		mov	[edx+75h], bl
		mov	al, [esi+1Dh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+7Dh], bh
		mov	[edx+83h], bl
		shr	ebx, 10h
		mov	[edx+88h], bh
		mov	[edx+8Eh], bl
		mov	al, [esi+1Eh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+96h], bh
		mov	[edx+9Ch], bl
		shr	ebx, 10h
		mov	[edx+0A1h], bh
		mov	[edx+0A7h], bl
		mov	al, [esi+1Fh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+0AFh], bh
		mov	[edx+0B5h], bl
		shr	ebx, 10h
		mov	[edx+0BAh], bh
		mov	[edx+0C0h], bl
		push	ebp
		push	esi
		mov	bx, [esi]
		and	ebx, 7FFFh
		mov	dx, [esi+2]
		mov	cx, [esi+4]
		mov	bp, [esi+6]
		mov	esi, _nf_width
		jmp	short L248
		align 4

L248:
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		lea	eax, ds:0FFFFFFF8h[esi*8]
		sub	edi, eax
		mov	eax, [esp]
		mov	bx, [eax+10h]
		mov	dx, [eax+12h]
		mov	cx, [eax+14h]
		mov	bp, [eax+16h]
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		pop	esi
		pop	ebp
		add	esi, 20h
		sub	edi, 8
		sub	edi, [ebp-10h]
		retn
		align 4

L249:
		xor	eax, eax
		lea	ecx, byte_125984
		lea	edx, L250+2
		mov	al, [esi+8]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bh
		mov	[edx+6], bl
		shr	ebx, 10h
		mov	[edx+0Bh], bh
		mov	[edx+11h], bl
		mov	al, [esi+9]
		mov	ebx, [ecx+eax*4]
		mov	[edx+17h], bh
		mov	[edx+1Dh], bl
		shr	ebx, 10h
		mov	[edx+23h], bh
		mov	[edx+29h], bl
		mov	al, [esi+0Ah]
		mov	ebx, [ecx+eax*4]
		mov	[edx+31h], bh
		mov	[edx+37h], bl
		shr	ebx, 10h
		mov	[edx+3Ch], bh
		mov	[edx+42h], bl
		mov	al, [esi+0Bh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+48h], bh
		mov	[edx+4Eh], bl
		shr	ebx, 10h
		mov	[edx+54h], bh
		mov	[edx+5Ah], bl
		mov	al, [esi+0Ch]
		mov	ebx, [ecx+eax*4]
		mov	[edx+62h], bh
		mov	[edx+68h], bl
		shr	ebx, 10h
		mov	[edx+6Dh], bh
		mov	[edx+73h], bl
		mov	al, [esi+0Dh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+79h], bh
		mov	[edx+7Fh], bl
		shr	ebx, 10h
		mov	[edx+85h], bh
		mov	[edx+8Bh], bl
		mov	al, [esi+0Eh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+93h], bh
		mov	[edx+99h], bl
		shr	ebx, 10h
		mov	[edx+9Eh], bh
		mov	[edx+0A4h], bl
		mov	al, [esi+0Fh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+0AAh], bh
		mov	[edx+0B0h], bl
		shr	ebx, 10h
		mov	[edx+0B6h], bh
		mov	[edx+0BCh], bl
		lea	edx, [edx+0DDh]
		mov	al, [esi+18h]
		mov	ebx, [ecx+eax*4]
		mov	[edx], bh
		mov	[edx+6], bl
		shr	ebx, 10h
		mov	[edx+0Bh], bh
		mov	[edx+11h], bl
		mov	al, [esi+19h]
		mov	ebx, [ecx+eax*4]
		mov	[edx+17h], bh
		mov	[edx+1Dh], bl
		shr	ebx, 10h
		mov	[edx+23h], bh
		mov	[edx+29h], bl
		mov	al, [esi+1Ah]
		mov	ebx, [ecx+eax*4]
		mov	[edx+31h], bh
		mov	[edx+37h], bl
		shr	ebx, 10h
		mov	[edx+3Ch], bh
		mov	[edx+42h], bl
		mov	al, [esi+1Bh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+48h], bh
		mov	[edx+4Eh], bl
		shr	ebx, 10h
		mov	[edx+54h], bh
		mov	[edx+5Ah], bl
		mov	al, [esi+1Ch]
		mov	ebx, [ecx+eax*4]
		mov	[edx+62h], bh
		mov	[edx+68h], bl
		shr	ebx, 10h
		mov	[edx+6Dh], bh
		mov	[edx+73h], bl
		mov	al, [esi+1Dh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+79h], bh
		mov	[edx+7Fh], bl
		shr	ebx, 10h
		mov	[edx+85h], bh
		mov	[edx+8Bh], bl
		mov	al, [esi+1Eh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+93h], bh
		mov	[edx+99h], bl
		shr	ebx, 10h
		mov	[edx+9Eh], bh
		mov	[edx+0A4h], bl
		mov	al, [esi+1Fh]
		mov	ebx, [ecx+eax*4]
		mov	[edx+0AAh], bh
		mov	[edx+0B0h], bl
		shr	ebx, 10h
		mov	[edx+0B6h], bh
		mov	[edx+0BCh], bl
		push	ebp
		push	esi
		mov	bx, [esi]
		and	ebx, 7FFFh
		mov	dx, [esi+2]
		mov	cx, [esi+4]
		mov	bp, [esi+6]
		mov	esi, _nf_width
		jmp	short L250
		align 4

L250:
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+8], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+0Ch], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+8], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+0Ch], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+8], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+0Ch], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+8], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+0Ch], eax
		add	edi, esi
		mov	eax, [esp]
		mov	bx, [eax+10h]
		and	ebx, 7FFFh
		mov	dx, [eax+12h]
		mov	cx, [eax+14h]
		mov	bp, [eax+16h]
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+8], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+0Ch], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+8], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+0Ch], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+8], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+0Ch], eax
		add	edi, esi
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+4], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+8], eax
		mov	ax, bx
		shl	eax, 10h
		mov	ax, bx
		mov	[edi+0Ch], eax
		pop	esi
		pop	ebp
		add	esi, 20h
		sub	edi, [ebp-10h]
		retn

L251:
		mov	edx, _nf_width
		mov	eax, [esi]
		mov	[edi], eax
		mov	eax, [esi+4]
		mov	[edi+4], eax
		mov	eax, [esi+8]
		mov	[edi+8], eax
		mov	eax, [esi+0Ch]
		mov	[edi+0Ch], eax
		add	edi, edx
		mov	eax, [esi+10h]
		mov	[edi], eax
		mov	eax, [esi+14h]
		mov	[edi+4], eax
		mov	eax, [esi+18h]
		mov	[edi+8], eax
		mov	eax, [esi+1Ch]
		mov	[edi+0Ch], eax
		add	edi, edx
		mov	eax, [esi+20h]
		mov	[edi], eax
		mov	eax, [esi+24h]
		mov	[edi+4], eax
		mov	eax, [esi+28h]
		mov	[edi+8], eax
		mov	eax, [esi+2Ch]
		mov	[edi+0Ch], eax
		add	edi, edx
		mov	eax, [esi+30h]
		mov	[edi], eax
		mov	eax, [esi+34h]
		mov	[edi+4], eax
		mov	eax, [esi+38h]
		mov	[edi+8], eax
		mov	eax, [esi+3Ch]
		mov	[edi+0Ch], eax
		add	edi, edx
		mov	eax, [esi+40h]
		mov	[edi], eax
		mov	eax, [esi+44h]
		mov	[edi+4], eax
		mov	eax, [esi+48h]
		mov	[edi+8], eax
		mov	eax, [esi+4Ch]
		mov	[edi+0Ch], eax
		add	edi, edx
		mov	eax, [esi+50h]
		mov	[edi], eax
		mov	eax, [esi+54h]
		mov	[edi+4], eax
		mov	eax, [esi+58h]
		mov	[edi+8], eax
		mov	eax, [esi+5Ch]
		mov	[edi+0Ch], eax
		add	edi, edx
		mov	eax, [esi+60h]
		mov	[edi], eax
		mov	eax, [esi+64h]
		mov	[edi+4], eax
		mov	eax, [esi+68h]
		mov	[edi+8], eax
		mov	eax, [esi+6Ch]
		mov	[edi+0Ch], eax
		add	edi, edx
		mov	eax, [esi+70h]
		mov	[edi], eax
		mov	eax, [esi+74h]
		mov	[edi+4], eax
		mov	eax, [esi+78h]
		mov	[edi+8], eax
		mov	eax, [esi+7Ch]
		mov	[edi+0Ch], eax
		add	esi, 80h
		sub	edi, [ebp-10h]
		retn
		align 4

L252:
		mov	edx, _nf_width
		mov	ax, [esi]
		shrd	ebx, eax, 10h
		mov	bx, ax
		mov	[edi], ebx
		mov	[edi+edx], ebx
		mov	ax, [esi+2]
		shrd	ebx, eax, 10h
		mov	bx, ax
		mov	[edi+4], ebx
		mov	[edi+edx+4], ebx
		mov	ax, [esi+4]
		shrd	ebx, eax, 10h
		mov	bx, ax
		mov	[edi+8], ebx
		mov	[edi+edx+8], ebx
		mov	ax, [esi+6]
		shrd	ebx, eax, 10h
		mov	bx, ax
		mov	[edi+0Ch], ebx
		mov	[edi+edx+0Ch], ebx
		lea	edi, [edi+edx*2]
		mov	ax, [esi+8]
		shrd	ebx, eax, 10h
		mov	bx, ax
		mov	[edi], ebx
		mov	[edi+edx], ebx
		mov	ax, [esi+0Ah]
		shrd	ebx, eax, 10h
		mov	bx, ax
		mov	[edi+4], ebx
		mov	[edi+edx+4], ebx
		mov	ax, [esi+0Ch]
		shrd	ebx, eax, 10h
		mov	bx, ax
		mov	[edi+8], ebx
		mov	[edi+edx+8], ebx
		mov	ax, [esi+0Eh]
		shrd	ebx, eax, 10h
		mov	bx, ax
		mov	[edi+0Ch], ebx
		mov	[edi+edx+0Ch], ebx
		lea	edi, [edi+edx*2]
		mov	ax, [esi+10h]
		shrd	ebx, eax, 10h
		mov	bx, ax
		mov	[edi], ebx
		mov	[edi+edx], ebx
		mov	ax, [esi+12h]
		shrd	ebx, eax, 10h
		mov	bx, ax
		mov	[edi+4], ebx
		mov	[edi+edx+4], ebx
		mov	ax, [esi+14h]
		shrd	ebx, eax, 10h
		mov	bx, ax
		mov	[edi+8], ebx
		mov	[edi+edx+8], ebx
		mov	ax, [esi+16h]
		shrd	ebx, eax, 10h
		mov	bx, ax
		mov	[edi+0Ch], ebx
		mov	[edi+edx+0Ch], ebx
		lea	edi, [edi+edx*2]
		mov	ax, [esi+18h]
		shrd	ebx, eax, 10h
		mov	bx, ax
		mov	[edi], ebx
		mov	[edi+edx], ebx
		mov	ax, [esi+1Ah]
		shrd	ebx, eax, 10h
		mov	bx, ax
		mov	[edi+4], ebx
		mov	[edi+edx+4], ebx
		mov	ax, [esi+1Ch]
		shrd	ebx, eax, 10h
		mov	bx, ax
		mov	[edi+8], ebx
		mov	[edi+edx+8], ebx
		mov	ax, [esi+1Eh]
		shrd	ebx, eax, 10h
		mov	bx, ax
		mov	[edi+0Ch], ebx
		mov	[edi+edx+0Ch], ebx
		add	edi, edx
		sub	edi, [ebp-10h]
		add	esi, 20h
		retn
		align 4

L253:
		mov	edx, _nf_width
		mov	ax, [esi]
		shrd	ebx, eax, 10h
		mov	bx, ax
		mov	ax, [esi+2]
		shrd	ecx, eax, 10h
		mov	cx, ax
		mov	[edi], ebx
		mov	[edi+4], ebx
		mov	[edi+8], ecx
		mov	[edi+0Ch], ecx
		mov	[edi+edx], ebx
		mov	[edi+edx+4], ebx
		mov	[edi+edx+8], ecx
		mov	[edi+edx+0Ch], ecx
		lea	edi, [edi+edx*2]
		mov	[edi], ebx
		mov	[edi+4], ebx
		mov	[edi+8], ecx
		mov	[edi+0Ch], ecx
		mov	[edi+edx], ebx
		mov	[edi+edx+4], ebx
		mov	[edi+edx+8], ecx
		mov	[edi+edx+0Ch], ecx
		lea	edi, [edi+edx*2]
		mov	ax, [esi+4]
		shrd	ebx, eax, 10h
		mov	bx, ax
		mov	ax, [esi+6]
		shrd	ecx, eax, 10h
		mov	cx, ax
		mov	[edi], ebx
		mov	[edi+4], ebx
		mov	[edi+8], ecx
		mov	[edi+0Ch], ecx
		mov	[edi+edx], ebx
		mov	[edi+edx+4], ebx
		mov	[edi+edx+8], ecx
		mov	[edi+edx+0Ch], ecx
		lea	edi, [edi+edx*2]
		mov	[edi], ebx
		mov	[edi+4], ebx
		mov	[edi+8], ecx
		mov	[edi+0Ch], ecx
		mov	[edi+edx], ebx
		mov	[edi+edx+4], ebx
		mov	[edi+edx+8], ecx
		mov	[edi+edx+0Ch], ecx
		add	edi, edx
		sub	edi, [ebp-10h]
		add	esi, 8
		retn
		align 4

L254:
		mov	ax, [esi]
		add	esi, 2
		shrd	ebx, eax, 10h
		mov	bx, ax
		mov	edx, _nf_width
		mov	[edi], ebx
		mov	[edi+4], ebx
		mov	[edi+8], ebx
		mov	[edi+0Ch], ebx
		add	edi, edx
		mov	[edi], ebx
		mov	[edi+4], ebx
		mov	[edi+8], ebx
		mov	[edi+0Ch], ebx
		add	edi, edx
		mov	[edi], ebx
		mov	[edi+4], ebx
		mov	[edi+8], ebx
		mov	[edi+0Ch], ebx
		add	edi, edx
		mov	[edi], ebx
		mov	[edi+4], ebx
		mov	[edi+8], ebx
		mov	[edi+0Ch], ebx
		add	edi, edx
		mov	[edi], ebx
		mov	[edi+4], ebx
		mov	[edi+8], ebx
		mov	[edi+0Ch], ebx
		add	edi, edx
		mov	[edi], ebx
		mov	[edi+4], ebx
		mov	[edi+8], ebx
		mov	[edi+0Ch], ebx
		add	edi, edx
		mov	[edi], ebx
		mov	[edi+4], ebx
		mov	[edi+8], ebx
		mov	[edi+0Ch], ebx
		add	edi, edx
		mov	[edi], ebx
		mov	[edi+4], ebx
		mov	[edi+8], ebx
		mov	[edi+0Ch], ebx
		sub	edi, [ebp-10h]
		retn
		align 4

L255:
		retn

PUBLIC _mve_ShowFrameField
_mve_ShowFrameField:
		push	ebp
		mov	ebp, esp
		add	esp, 0FFFFFFECh
		push	esi
		push	edi
		push	ebx
		mov	ax, ds
		mov	es, ax
		mov	eax, [ebp+1ch]
		shr	eax, 2
		mov	[ebp-8], eax
		cmp	_opt_hscale_step, 4
		jnz	short L256
		mov	eax, [ebp+0ch]
		sub	eax, [ebp+1ch]
		mov	[ebp-0ch], eax
		jmp	short L257

L256:
		mov	eax, _opt_hscale_adj
		mov	[ebp-0ch], eax

L257:
		mov	eax, _sf_LineWidth
		cmp	[ebp+2ch], 0
		jz	short L258
		add	eax, eax

L258:
		mov	[ebp-10h], eax
		sub	eax, [ebp+1ch]
		mov	[ebp-14h], eax
		mov	eax, [ebp+18h]
		mul	dword ptr [ebp+0ch]
		add	eax, [ebp+14h]
		add	[ebp+8], eax
		mov	eax, [ebp+14h]
		add	[ebp+24h], eax
		mov	eax, [ebp+0ch]
		shr	eax, 1
		cmp	[ebp+2ch], 0
		jz	short L259
		cmp	[ebp+14h], eax
		jb	short L259
		sub	[ebp+24h], eax

L259:
		mov	eax, [ebp+18h]
		add	[ebp+28h], eax
		cmp	_sf_SetBank, 0
		jnz	L264
		mov	edi, _sf_WriteWinPtr
		mov	eax, [ebp+28h]
		mul	dword ptr [ebp-10h]
		add	eax, [ebp+24h]
		add	edi, eax
		test	[ebp+2ch], 1
		jz	short L260
		add	edi, _sf_LineWidth

L260:
		mov	eax, [ebp-0ch]
		mov	edx, [ebp-14h]
		mov	esi, [ebp+8]
		mov	ebx, [ebp+20h]
		cmp	_opt_hscale_step, 3
		jnz	short L263
		sub	edi, 8

L261:
		mov	ecx, [ebp-8]
		shr	ecx, 2
		align 4

L262:
		mov	eax, [esi]
		mov	[edi+8], eax
		mov	eax, [esi+3]
		mov	[edi+0Ch], eax
		add	edi, 10h
		mov	eax, [esi+6]
		mov	[edi], eax
		mov	eax, [esi+9]
		mov	[edi+4], eax
		add	esi, 0Ch
		dec	ecx
		jnz	short L262
		mov	eax, [esi]
		mov	[edi+8], eax
		mov	eax, [esi+3]
		mov	[edi+0Ch], eax
		add	edi, 0Ch
		mov	eax, [esi+6]
		mov	[edi+4], eax
		add	esi, 9
		add	esi, [ebp-0ch]
		add	edi, edx
		dec	ebx
		jnz	short L261
		add	edi, 8
		jmp	L281

L263:
		mov	ecx, [ebp-8]
		rep movsd
		add	esi, eax
		add	edi, edx
		dec	ebx
		jnz	short L263
		jmp	L281

L264:
		mov	esi, [ebp+8]
		mov	eax, [ebp-10h]
		mul	dword ptr [ebp+28h]
		test	[ebp+2ch], 1
		jz	short L265
		add	eax, _sf_LineWidth

L265:
		add	eax, [ebp+24h]
		mov	edx, 0
		div	_sf_WinGran
		mov	[ebp-4], eax
		mov	edi, edx
		add	edi, _sf_WriteWinPtr
		mov	bh, 0
		mov	bl, byte ptr _sf_WriteWin
		mov	edx, [ebp-4]
		call	_sf_SetBank

L266:
		mov	eax, _sf_WriteWinLimit
		sub	eax, edi
		add	eax, [ebp-10h]
		sub	eax, [ebp+1ch]
		mov	edx, 0
		div	dword ptr [ebp-10h]
		cmp	[ebp+20h], eax
		jnb	short L267
		mov	eax, [ebp+20h]

L267:
		or	eax, eax
		jz	short L271
		sub	[ebp+20h], eax
		mov	ebx, [ebp-0ch]
		mov	edx, [ebp-14h]
		cmp	_opt_hscale_step, 3
		jnz	short L270
		sub	edi, 8

L268:
		mov	ecx, [ebp-8]
		shr	ecx, 2
		align 4

L269:
		mov	ebx, [esi]
		mov	[edi+8], ebx
		mov	ebx, [esi+3]
		mov	[edi+0Ch], ebx
		add	edi, 10h
		mov	ebx, [esi+6]
		mov	[edi], ebx
		mov	ebx, [esi+9]
		mov	[edi+4], ebx
		add	esi, 0Ch
		dec	ecx
		jnz	short L269
		mov	ebx, [esi]
		mov	[edi+8], ebx
		mov	ebx, [esi+3]
		mov	[edi+0Ch], ebx
		add	edi, 0Ch
		mov	ebx, [esi+6]
		mov	[edi+4], ebx
		add	esi, 9
		add	esi, [ebp-0ch]
		add	edi, edx
		dec	eax
		jnz	short L268
		add	edi, 8
		jmp	short L271

L270:
		mov	ecx, [ebp-8]
		rep movsd
		add	esi, ebx
		add	edi, edx
		dec	eax
		jnz	short L270

L271:
		or	eax, [ebp+20h]
		jz	L281
		mov	ecx, _sf_WriteWinLimit
		sub	ecx, edi
		sar	ecx, 2
		jns	short L272
		mov	ecx, 0

L272:
		push	ecx
		cmp	_opt_hscale_step, 3
		jnz	short L275
		or	ecx, ecx
		jz	short L274

L273:
		mov	eax, [esi]
		mov	[edi], eax
		add	esi, 3
		add	edi, 4
		dec	ecx
		jnz	short L273

L274:
		jmp	short L276

L275:
		rep movsd

L276:
		mov	eax, _sf_WinGranPerSize
		add	[ebp-4], eax
		sub	edi, _sf_WinSize
		mov	bh, 0
		mov	bl, byte ptr _sf_WriteWin
		mov	edx, [ebp-4]
		call	_sf_SetBank
		pop	eax
		mov	ecx, [ebp-8]
		sub	ecx, eax
		cmp	_opt_hscale_step, 3
		jnz	short L279
		nop
		or	ecx, ecx
		jz	short L278

L277:
		mov	eax, [esi]
		mov	[edi], eax
		add	esi, 3
		add	edi, 4
		dec	ecx
		jnz	short L277

L278:
		jmp	short L280

L279:
		rep movsd

L280:
		add	esi, [ebp-0ch]
		add	edi, [ebp-14h]
		dec	dword ptr [ebp+20h]
		jnz	L266

L281:
		pop	ebx
		pop	edi
		pop	esi
		leave
		retn

PUBLIC _mve_ShowFrameFieldHi
_mve_ShowFrameFieldHi:
		push	ebp
		mov	ebp, esp
		add	esp, 0FFFFFFECh
		push	esi
		push	edi
		push	ebx
		mov	ax, ds
		mov	es, ax
		mov	eax, [ebp+1ch]
		shr	eax, 1
		mov	[ebp-8], eax
		mov	eax, [ebp+0ch]
		sub	eax, [ebp+1ch]
		mov	[ebp-0ch], eax
		mov	eax, _sf_LineWidth
		cmp	[ebp+2Ch], 0
		jz	short L282
		add	eax, eax

L282:
		mov	[ebp-10h], eax
		sub	eax, [ebp+1ch]
		sub	eax, [ebp+1ch]
		mov	[ebp-14h], eax
		mov	eax, [ebp+18h]
		mul	dword ptr [ebp+0ch]
		add	eax, [ebp+14h]
		add	[ebp+8], eax
		mov	eax, [ebp+14h]
		add	[ebp+24h], eax
		mov	eax, [ebp+0ch]
		shr	eax, 1
		cmp	[ebp+2Ch], 0
		jz	short L283
		cmp	[ebp+14h], eax
		jb	short L283
		sub	[ebp+24h], eax

L283:
		mov	eax, [ebp+18h]
		add	[ebp+28h], eax
		cmp	_sf_SetBank, 0
		jnz	short L287
		mov	edi, _sf_WriteWinPtr
		mov	eax, [ebp+28h]
		mul	dword ptr [ebp-10h]
		add	eax, [ebp+24h]
		add	eax, [ebp+24h]
		add	edi, eax
		test	[ebp+2Ch], 1
		jz	short L284
		add	edi, _sf_LineWidth

L284:
		mov	esi, [ebp+8]
		mov	ebx, [ebp+20h]

L285:
		mov	ecx, [ebp-8]
		push	ebx
		lea	ebx, _pal15_tbl
		xor	eax, eax

L286:
		mov	al, [esi]
		add	esi, 2
		mov	dx, [ebx+eax*2]
		mov	al, [esi-1]
		shl	edx, 10h
		mov	dx, [ebx+eax*2]
		rol	edx, 10h
		mov	[edi], edx
		add	edi, 4
		dec	ecx
		jnz	short L286
		pop	ebx
		add	esi, [ebp-0ch]
		add	edi, [ebp-14h]
		dec	ebx
		jnz	short L285
		jmp	L299

L287:
		mov	esi, [ebp+8]
		mov	eax, [ebp-10h]
		mul	dword ptr [ebp+28h]
		test	[ebp+2Ch], 1
		jz	short L288
		add	eax, _sf_LineWidth

L288:
		add	eax, [ebp+24h]
		add	eax, [ebp+24h]
		mov	edx, 0
		div	_sf_WinGran
		mov	[ebp-4], eax
		mov	edi, edx
		add	edi, _sf_WriteWinPtr
		mov	bh, 0
		mov	bl, byte ptr _sf_WriteWin
		mov	edx, [ebp-4]
		call	_sf_SetBank

L289:
		mov	eax, _sf_WriteWinLimit
		sub	eax, edi
		add	eax, [ebp-14h]
		mov	edx, 0
		div	dword ptr [ebp-10h]
		cmp	[ebp+20h], eax
		jnb	short L290
		mov	eax, [ebp+20h]

L290:
		or	eax, eax
		jz	short L293
		sub	[ebp+20h], eax
		lea	ebx, _pal15_tbl

L291:
		mov	ecx, [ebp-8]
		push	eax
		xor	eax, eax

L292:
		mov	al, [esi]
		add	esi, 2
		mov	dx, [ebx+eax*2]
		mov	al, [esi-1]
		shl	edx, 10h
		mov	dx, [ebx+eax*2]
		rol	edx, 10h
		mov	[edi], edx
		add	edi, 4
		dec	ecx
		jnz	short L292
		pop	eax
		add	esi, [ebp-0ch]
		add	edi, [ebp-14h]
		dec	eax
		jnz	short L291

L293:
		or	eax, [ebp+20h]
		jz	L299
		mov	ecx, _sf_WriteWinLimit
		sub	ecx, edi
		sar	ecx, 2
		jns	short L294
		mov	ecx, 0

L294:
		push	ecx
		or	ecx, ecx
		jz	short L296
		xor	eax, eax
		lea	ebx, _pal15_tbl

L295:
		mov	al, [esi]
		add	esi, 2
		mov	dx, [ebx+eax*2]
		mov	al, [esi-1]
		shl	edx, 10h
		mov	dx, [ebx+eax*2]
		rol	edx, 10h
		mov	[edi], edx
		add	edi, 4
		dec	ecx
		jnz	short L295

L296:
		mov	eax, _sf_WinGranPerSize
		add	[ebp-4], eax
		sub	edi, _sf_WinSize
		mov	bh, 0
		mov	bl, byte ptr _sf_WriteWin
		mov	edx, [ebp-4]
		call	_sf_SetBank
		pop	eax
		mov	ecx, [ebp-8]
		sub	ecx, eax
		or	ecx, ecx
		jz	short L298
		lea	ebx, _pal15_tbl
		xor	eax, eax

L297:
		mov	al, [esi]
		add	esi, 2
		mov	dx, [ebx+eax*2]
		mov	al, [esi-1]
		shl	edx, 10h
		mov	dx, [ebx+eax*2]
		rol	edx, 10h
		mov	[edi], edx
		add	edi, 4
		dec	ecx
		jnz	short L297

L298:
		add	esi, [ebp-0ch]
		add	edi, [ebp-14h]
		dec	dword ptr [ebp+20h]
		jnz	L289

L299:
		pop	ebx
		pop	edi
		pop	esi
		leave
		retn

PUBLIC _mve_sfShowFrameChg
_mve_sfShowFrameChg:
		push	ebp
		mov	ebp, esp
		add	esp, 0FFFFFFD4h
		push	esi
		push	edi
		push	ebx
		mov	ax, ds
		mov	es, ax
		mov	eax, [ebp+14h]
		shl	eax, 3
		mov	[ebp-4], eax
		xor	ebx, ebx
		mov	bl, _nf_fqty
		mov	eax, _nf_width
		mul	ebx
		mov	[ebp-8], eax
		imul	eax, 7
		mov	[ebp-10h], eax
		add	eax, [ebp-8]
		sub	eax, [ebp-4]
		mov	[ebp-18h], eax
		mov	eax, _sf_LineWidth
		mul	ebx
		mov	[ebp-0ch], eax
		imul	eax, 7
		mov	[ebp-14h], eax
		dec	eax
		mov	[ebp-1ch], eax
		mov	eax, [ebp-0ch]
		sub	eax, [ebp-4]
		inc	eax
		mov	[ebp-20h], eax
		mov	eax, [ebp-1ch]
		add	eax, [ebp-4]
		mov	[ebp-24h], eax
		cmp	[ebp+8], 0
		jz	short L300
		mov	esi, _nf_buf_prv
		jmp	short L301

L300:
		mov	esi, _nf_buf_cur

L301:
		mov	eax, [ebp+10h]
		shl	eax, 3
		mul	_nf_width
		add	esi, eax
		mov	eax, [ebp+0ch]
		shl	eax, 3
		add	esi, eax
		and	[ebp+20h], 0FFFFFFFCh
		mov	ebx, [ebp+1ch]
		mov	dx, 0
		mov	cl, _nf_fqty

L302:
		push	ecx
		push	esi
		mov	ecx, [ebp+18h]
		push	ebx
		push	edx
		mov	eax, _sf_LineWidth
		mul	dword ptr [ebp+24h]
		add	eax, [ebp+20h]
		mov	edx, 0
		div	_sf_WinGran
		mov	[ebp-28h], eax
		mov	edi, edx
		add	edi, _sf_WriteWinPtr
		cmp	_sf_SetBank, 0
		jz	short L303
		mov	bh, 0
		mov	bl, byte ptr _sf_WriteWin
		mov	edx, [ebp-28h]
		call	_sf_SetBank

L303:
		pop	edx
		pop	ebx

L304:
		push	ecx
		mov	eax, edi
		add	eax, [ebp-24h]
		sub	eax, _sf_WriteWinLimit
		jb	short L306
		jmp	L314

L305:
		pop	ecx
		add	esi, [ebp-18h]
		add	edi, [ebp-1ch]
		add	edi, [ebp-20h]
		loop	L304
		pop	esi
		pop	ecx
		add	esi, _nf_width
		inc	dword ptr [ebp+24h]
		dec	cl
		jnz	short L302
		jmp	L345

L306:
		mov	ecx, [ebp+14h]
		mov	eax, 0
		jmp	short L308

L307:
		mov	dx, [ebx]
		add	ebx, 2

L308:
		add	dx, dx
		jz	short L307
		jb	short L311
		add	esi, 8
		add	edi, 8
		loop	L308
		jmp	short L305

L309:
		mov	dx, [ebx]
		add	ebx, 2

L310:
		add	dx, dx
		ja	short L312
		jz	short L309

L311:
		add	eax, 2
		loop	L310
		call	L313
		jmp	short L305

L312:
		call	L313
		add	esi, 8
		add	edi, 8
		mov	eax, 0
		loop	L308
		jmp	short L305
		
L313:
		push	ebx
		push	ecx
		push	edx
		mov	ecx, eax
		shl	ecx, 2
		mov	ebx, [ebp-8]
		sub	ebx, ecx
		mov	edx, [ebp-0Ch]
		sub	edx, ecx
		mov	ecx, eax
		rep movsd
		add	esi, ebx
		add	edi, edx
		mov	ecx, eax
		rep movsd
		add	esi, ebx
		add	edi, edx
		mov	ecx, eax
		rep movsd
		add	esi, ebx
		add	edi, edx
		mov	ecx, eax
		rep movsd
		add	esi, ebx
		add	edi, edx
		mov	ecx, eax
		rep movsd
		add	esi, ebx
		add	edi, edx
		mov	ecx, eax
		rep movsd
		add	esi, ebx
		add	edi, edx
		mov	ecx, eax
		rep movsd
		add	esi, ebx
		add	edi, edx
		mov	ecx, eax
		rep movsd
		sub	esi, [ebp-10h]
		sub	edi, [ebp-14h]
		pop	edx
		pop	ecx
		pop	ebx
		retn

L314:
		push	ebx
		push	edx
		push	esi
		push	edi
		mov	ecx, [ebp+14h]
		mov	eax, 0
		jmp	short L316

L315:
		mov	dx, [ebx]
		add	ebx, 2

L316:
		add	dx, dx
		jz	short L315
		jb	short L319
		add	esi, 8
		add	edi, 8
		loop	L316
		jmp	L325

L317:
		mov	dx, [ebx]
		add	ebx, 2

L318:
		add	dx, dx
		ja	short L320
		jz	short L317

L319:
		add	eax, 2
		loop	L318
		call	L321
		jmp	L325

L320:
		call	L321
		add	esi, 8
		add	edi, 8
		mov	eax, 0
		loop	L316
		jmp	L325

L321:
		push	ebx
		push	ecx
		push	edx
		push	esi
		push	edi
		mov	ecx, eax
		shl	ecx, 2
		mov	ebx, [ebp-8]
		sub	ebx, ecx
		mov	edx, [ebp-0Ch]
		sub	edx, ecx
		sub	ecx, _sf_WriteWinLimit
		neg	ecx
		mov	[ebp-2Ch], ecx
		cmp	edi, [ebp-2Ch]
		jns	short L322
		mov	ecx, eax
		rep movsd
		add	esi, ebx
		add	edi, edx
		cmp	edi, [ebp-2Ch]
		jns	short L322
		mov	ecx, eax
		rep movsd
		add	esi, ebx
		add	edi, edx
		cmp	edi, [ebp-2Ch]
		jns	short L322
		mov	ecx, eax
		rep movsd
		add	esi, ebx
		add	edi, edx
		cmp	edi, [ebp-2Ch]
		jns	short L322
		mov	ecx, eax
		rep movsd
		add	esi, ebx
		add	edi, edx
		cmp	edi, [ebp-2Ch]
		jns	short L322
		mov	ecx, eax
		rep movsd
		add	esi, ebx
		add	edi, edx
		cmp	edi, [ebp-2Ch]
		jns	short L322
		mov	ecx, eax
		rep movsd
		add	esi, ebx
		add	edi, edx
		cmp	edi, [ebp-2Ch]
		jns	short L322
		mov	ecx, eax
		rep movsd
		add	esi, ebx
		add	edi, edx
		cmp	edi, [ebp-2Ch]
		jns	short L322
		mov	ecx, eax
		jmp	short L323

L322:
		mov	ecx, _sf_WriteWinLimit
		sub	ecx, edi
		js	short L324
		shr	ecx, 2

L323:
		rep movsd

L324:
		pop	edi
		pop	esi
		mov	ecx, eax
		shl	ecx, 2
		add	esi, ecx
		add	edi, ecx
		pop	edx
		pop	ecx
		pop	ebx
		retn
L325:
		pop	edi
		pop	esi
		mov	eax, _sf_WinGranPerSize
		add	[ebp-28h], eax
		sub	edi, _sf_WinSize
		cmp	_sf_SetBank, 0
		jz	short L326
		mov	bh, 0
		mov	bl, byte ptr _sf_WriteWin
		mov	edx, [ebp-28h]
		call	_sf_SetBank

L326:
		pop	edx
		pop	ebx
		mov	ecx, [ebp+14h]
		mov	eax, 0
		jmp	short L328

L327:
		mov	dx, [ebx]
		add	ebx, 2

L328:
		add	dx, dx
		jz	short L327
		jb	short L331
		add	esi, 8
		add	edi, 8
		loop	L328
		jmp	L305

L329:
		mov	dx, [ebx]
		add	ebx, 2

L330:
		add	dx, dx
		ja	short L332
		jz	short L329

L331:
		add	eax, 2
		loop	L330
		call	L333
		jmp	L305

L332:
		call	L333
		add	esi, 8
		add	edi, 8
		mov	eax, 0
		loop	L328
		jmp	L305

L333:
		push	ebx
		push	ecx
		push	edx
		mov	ecx, eax
		shl	ecx, 2
		neg	ecx
		mov	[ebp-2Ch], ecx
		mov	ebx, [ebp-8]
		mov	edx, [ebp-0Ch]
		sub	edi, _sf_WriteWinPtr
		mov	ecx, offset L336
		jns	L334
		cmp	[ebp-2Ch], edi
		js	L335
		add	esi, ebx
		add	edi, edx
		mov	ecx, offset L337
		jns	short L334
		cmp	[ebp-2Ch], edi
		js	short L335
		add	esi, ebx
		add	edi, edx
		mov	ecx, offset L338
		jns	short L334
		cmp	[ebp-2Ch], edi
		js	short L335
		add	esi, ebx
		add	edi, edx
		mov	ecx, offset L339
		jns	short L334
		cmp	[ebp-2Ch], edi
		js	short L335
		add	esi, ebx
		add	edi, edx
		mov	ecx, offset L340
		jns	short L334
		cmp	[ebp-2Ch], edi
		js	short L335
		add	esi, ebx
		add	edi, edx
		mov	ecx, offset L341
		jns	short L334
		cmp	[ebp-2Ch], edi
		js	short L335
		add	esi, ebx
		add	edi, edx
		mov	ecx, offset L342
		jns	short L334
		cmp	[ebp-2Ch], edi
		js	short L335
		add	esi, ebx
		add	edi, edx
		mov	ecx, offset L343
		jns	short L334
		cmp	[ebp-2Ch], edi
		js	short L335
		add	edi, _sf_WriteWinPtr
		shl	eax, 2
		add	esi, eax
		add	edi, eax
		jmp	short L344

L334:
		push	ecx
		mov	ecx, eax
		add	ebx, [ebp-2Ch]
		add	edx, [ebp-2Ch]
		add	edi, _sf_WriteWinPtr
		retn

L335:
		push	ecx
		mov	ecx, eax
		sub	esi, edi
		sar	edi, 2
		add	ecx, edi
		mov	edi, _sf_WriteWinPtr
		add	ebx, [ebp-2Ch]
		add	edx, [ebp-2Ch]
		retn

L336:
		rep movsd
		mov	ecx, eax
		add	esi, ebx
		add	edi, edx

L337:
		rep movsd
		mov	ecx, eax
		add	esi, ebx
		add	edi, edx

L338:
		rep movsd
		mov	ecx, eax
		add	esi, ebx
		add	edi, edx

L339:
		rep movsd
		mov	ecx, eax
		add	esi, ebx
		add	edi, edx

L340:
		rep movsd
		mov	ecx, eax
		add	esi, ebx
		add	edi, edx

L341:
		rep movsd
		mov	ecx, eax
		add	esi, ebx
		add	edi, edx

L342:
		rep movsd
		mov	ecx, eax
		add	esi, ebx
		add	edi, edx

L343:
		rep movsd

L344:
		sub	esi, [ebp-10h]
		sub	edi, [ebp-14h]
		pop	edx
		pop	ecx
		pop	ebx
		retn

L345:
		pop	ebx
		pop	edi
		pop	esi
		leave
		retn

PUBLIC _mve_sfHiColorShowFrameChg
_mve_sfHiColorShowFrameChg:
		push	ebp
		mov	ebp, esp
		add	esp, 0FFFFFFD4h
		push	esi
		push	edi
		push	ebx
		mov	ax, ds
		mov	es, ax
		mov	eax, [ebp+14h]
		shl	eax, 4
		mov	[ebp-4], eax
		xor	ebx, ebx
		mov	bl, _nf_fqty
		mov	eax, _nf_width
		mul	ebx
		mov	[ebp-8], eax
		imul	eax, 7
		mov	[ebp-10h], eax
		add	eax, [ebp-8]
		sub	eax, [ebp-4]
		mov	[ebp-18h], eax
		mov	eax, _sf_LineWidth
		mul	ebx
		mov	[ebp-0ch], eax
		imul	eax, 7
		mov	[ebp-14h], eax
		dec	eax
		mov	[ebp-1Ch], eax
		mov	eax, [ebp-0ch]
		sub	eax, [ebp-4]
		inc	eax
		mov	[ebp-20h], eax
		mov	eax, [ebp-1Ch]
		add	eax, [ebp-4]
		mov	[ebp-24h], eax
		cmp	[ebp+8], 0
		jz	short L346
		mov	esi, _nf_buf_prv
		jmp	short L347

L346:
		mov	esi, _nf_buf_cur

L347:
		mov	eax, [ebp+10h]
		shl	eax, 3
		mul	_nf_width
		add	esi, eax
		mov	eax, [ebp+0ch]
		shl	eax, 4
		add	esi, eax
		and	[ebp+20h], 0FFFFFFFCh
		mov	ebx, [ebp+1ch]
		mov	dx, 0
		mov	cl, _nf_fqty

L348:
		push	ecx
		push	esi
		mov	ecx, [ebp+18h]
		push	ebx
		push	edx
		mov	eax, _sf_LineWidth
		mul	dword ptr [ebp+24h]
		add	eax, [ebp+20h]
		mov	edx, 0
		div	_sf_WinGran
		mov	[ebp-28h], eax
		mov	edi, edx
		add	edi, _sf_WriteWinPtr
		cmp	_sf_SetBank, 0
		jz	short L349
		mov	bh, 0
		mov	bl, byte ptr _sf_WriteWin
		mov	edx, [ebp-28h]
		call	_sf_SetBank

L349:
		pop	edx
		pop	ebx

L350:
		push	ecx
		mov	eax, edi
		add	eax, [ebp-24h]
		sub	eax, _sf_WriteWinLimit
		jb	short L352
		jmp	L360

L351:
		pop	ecx
		add	esi, [ebp-18h]
		add	edi, [ebp-1Ch]
		add	edi, [ebp-20h]
		loop	L350
		pop	esi
		pop	ecx
		add	esi, _nf_width
		inc	dword ptr [ebp+24h]
		dec	cl
		jnz	short L348
		jmp	L391

L352:
		mov	ecx, [ebp+14h]
		mov	eax, 0
		jmp	short L354

L353:
		mov	dx, [ebx]
		add	ebx, 2

L354:
		add	dx, dx
		jz	short L353
		jb	short L357
		add	esi, 10h
		add	edi, 10h
		loop	L354
		jmp	short L351

L355:
		mov	dx, [ebx]
		add	ebx, 2

L356:
		add	dx, dx
		ja	short L358
		jz	short L355

L357:
		add	eax, 4
		loop	L356
		call	L359
		jmp	short L351

L358:
		call	L359
		add	esi, 10h
		add	edi, 10h
		mov	eax, 0
		loop	L354
		jmp	short L351

L359:
		push	ebx
		push	ecx
		push	edx
		mov	ecx, eax
		shl	ecx, 2
		mov	ebx, [ebp-8]
		sub	ebx, ecx
		mov	edx, [ebp-0Ch]
		sub	edx, ecx
		mov	ecx, eax
		rep movsd
		add	esi, ebx
		add	edi, edx
		mov	ecx, eax
		rep movsd
		add	esi, ebx
		add	edi, edx
		mov	ecx, eax
		rep movsd
		add	esi, ebx
		add	edi, edx
		mov	ecx, eax
		rep movsd
		add	esi, ebx
		add	edi, edx
		mov	ecx, eax
		rep movsd
		add	esi, ebx
		add	edi, edx
		mov	ecx, eax
		rep movsd
		add	esi, ebx
		add	edi, edx
		mov	ecx, eax
		rep movsd
		add	esi, ebx
		add	edi, edx
		mov	ecx, eax
		rep movsd
		sub	esi, [ebp-10h]
		sub	edi, [ebp-14h]
		pop	edx
		pop	ecx
		pop	ebx
		retn

L360:
		push	ebx
		push	edx
		push	esi
		push	edi
		mov	ecx, [ebp+14h]
		mov	eax, 0
		jmp	short L362

L361:
		mov	dx, [ebx]
		add	ebx, 2

L362:
		add	dx, dx
		jz	short L361
		jb	short L365
		add	esi, 10h
		add	edi, 10h
		loop	L362
		jmp	L371

L363:
		mov	dx, [ebx]
		add	ebx, 2

L364:
		add	dx, dx
		ja	short L366
		jz	short L363

L365:
		add	eax, 4
		loop	L364
		call	L367
		jmp	L371

L366:
		call	L367
		add	esi, 10h
		add	edi, 10h
		mov	eax, 0
		loop	L362
		jmp	L371

L367:
		push	ebx
		push	ecx
		push	edx
		push	esi
		push	edi
		mov	ecx, eax
		shl	ecx, 2
		mov	ebx, [ebp-8]
		sub	ebx, ecx
		mov	edx, [ebp-0Ch]
		sub	edx, ecx
		sub	ecx, _sf_WriteWinLimit
		neg	ecx
		mov	[ebp-2Ch], ecx
		cmp	edi, [ebp-2Ch]
		jns	short L368
		mov	ecx, eax
		rep movsd
		add	esi, ebx
		add	edi, edx
		cmp	edi, [ebp-2Ch]
		jns	short L368
		mov	ecx, eax
		rep movsd
		add	esi, ebx
		add	edi, edx
		cmp	edi, [ebp-2Ch]
		jns	short L368
		mov	ecx, eax
		rep movsd
		add	esi, ebx
		add	edi, edx
		cmp	edi, [ebp-2Ch]
		jns	short L368
		mov	ecx, eax
		rep movsd
		add	esi, ebx
		add	edi, edx
		cmp	edi, [ebp-2Ch]
		jns	short L368
		mov	ecx, eax
		rep movsd
		add	esi, ebx
		add	edi, edx
		cmp	edi, [ebp-2Ch]
		jns	short L368
		mov	ecx, eax
		rep movsd
		add	esi, ebx
		add	edi, edx
		cmp	edi, [ebp-2Ch]
		jns	short L368
		mov	ecx, eax
		rep movsd
		add	esi, ebx
		add	edi, edx
		cmp	edi, [ebp-2Ch]
		jns	short L368
		mov	ecx, eax
		jmp	short L369

L368:
		mov	ecx, _sf_WriteWinLimit
		sub	ecx, edi
		js	short L370
		shr	ecx, 2

L369:
		rep movsd

L370:
		pop	edi
		pop	esi
		mov	ecx, eax
		shl	ecx, 2
		add	esi, ecx
		add	edi, ecx
		pop	edx
		pop	ecx
		pop	ebx
		retn

L371:
		pop	edi
		pop	esi
		mov	eax, _sf_WinGranPerSize
		add	[ebp-28h], eax
		sub	edi, _sf_WinSize
		cmp	_sf_SetBank, 0
		jz	short L372
		mov	bh, 0
		mov	bl, byte ptr _sf_WriteWin
		mov	edx, [ebp-28h]
		call	_sf_SetBank

L372:
		pop	edx
		pop	ebx
		mov	ecx, [ebp+14h]
		mov	eax, 0
		jmp	short L374

L373:
		mov	dx, [ebx]
		add	ebx, 2

L374:
		add	dx, dx
		jz	short L373
		jb	short L377
		add	esi, 10h
		add	edi, 10h
		loop	L374
		jmp	L351

L375:
		mov	dx, [ebx]
		add	ebx, 2

L376:
		add	dx, dx
		ja	short L378
		jz	short L375

L377:
		add	eax, 4
		loop	L376
		call	L379
		jmp	L351

L378:
		call	L379
		add	esi, 10h
		add	edi, 10h
		mov	eax, 0
		loop	L374
		jmp	L351

L379:
		push	ebx
		push	ecx
		push	edx
		mov	ecx, eax
		shl	ecx, 2
		neg	ecx
		mov	[ebp-2Ch], ecx
		mov	ebx, [ebp-8]
		mov	edx, [ebp-0Ch]
		sub	edi, _sf_WriteWinPtr
		mov	ecx, offset L382
		jns	L380
		cmp	[ebp-2Ch], edi
		js	L381
		add	esi, ebx
		add	edi, edx
		mov	ecx, offset L383
		jns	short L380
		cmp	[ebp-2Ch], edi
		js	short L381
		add	esi, ebx
		add	edi, edx
		mov	ecx, offset L384
		jns	short L380
		cmp	[ebp-2Ch], edi
		js	short L381
		add	esi, ebx
		add	edi, edx
		mov	ecx, offset L385
		jns	short L380
		cmp	[ebp-2Ch], edi
		js	short L381
		add	esi, ebx
		add	edi, edx
		mov	ecx, offset L386
		jns	short L380
		cmp	[ebp-2Ch], edi
		js	short L381
		add	esi, ebx
		add	edi, edx
		mov	ecx, offset L387
		jns	short L380
		cmp	[ebp-2Ch], edi
		js	short L381
		add	esi, ebx
		add	edi, edx
		mov	ecx, offset L388
		jns	short L380
		cmp	[ebp-2Ch], edi
		js	short L381
		add	esi, ebx
		add	edi, edx
		mov	ecx, offset L389
		jns	short L380
		cmp	[ebp-2Ch], edi
		js	short L381
		add	edi, _sf_WriteWinPtr
		shl	eax, 2
		add	esi, eax
		add	edi, eax
		jmp	short L390

L380:
		push	ecx
		mov	ecx, eax
		add	ebx, [ebp-2Ch]
		add	edx, [ebp-2Ch]
		add	edi, _sf_WriteWinPtr
		retn

L381:
		push	ecx
		mov	ecx, eax
		sub	esi, edi
		sar	edi, 2
		add	ecx, edi
		mov	edi, _sf_WriteWinPtr
		add	ebx, [ebp-2Ch]
		add	edx, [ebp-2Ch]
		retn

L382:
		rep movsd
		mov	ecx, eax
		add	esi, ebx
		add	edi, edx

L383:
		rep movsd
		mov	ecx, eax
		add	esi, ebx
		add	edi, edx

L384:
		rep movsd
		mov	ecx, eax
		add	esi, ebx
		add	edi, edx

L385:
		rep movsd
		mov	ecx, eax
		add	esi, ebx
		add	edi, edx

L386:
		rep movsd
		mov	ecx, eax
		add	esi, ebx
		add	edi, edx

L387:
		rep movsd
		mov	ecx, eax
		add	esi, ebx
		add	edi, edx

L388:
		rep movsd
		mov	ecx, eax
		add	esi, ebx
		add	edi, edx

L389:
		rep movsd

L390:
		sub	esi, [ebp-10h]
		sub	edi, [ebp-14h]
		pop	edx
		pop	ecx
		pop	ebx
		retn

L391:
		pop	ebx
		pop	edi
		pop	esi
		leave
		retn

PUBLIC _MVE_SetPalette
_MVE_SetPalette:
		push	ebp
		mov	ebp, esp
		push	esi
		push	ebx
		mov	eax, [ebp+0ch]
		mov	ecx, [ebp+10h]
		mov	esi, [ebp+8]
		cmp	eax, 100h
		jb	short L392
		pop	ebx
		pop	esi
		leave
		retn

L392:
		lea	ebx, [eax+ecx]
		cmp	ebx, 100h
		jbe	short L393
		mov	ecx, 100h
		sub	ecx, eax

L393:
		add	esi, eax
		add	esi, eax
		add	esi, eax
		lea	ecx, [ecx+ecx*2]
		mov	edx, 3C8h
		out	dx, al
		inc	edx
		rep outsb
		pop	ebx
		pop	esi
		leave
		retn

PUBLIC _palLoadCompPalette
_palLoadCompPalette:
		push	ebp
		mov	ebp, esp
		push	esi
		push	edi
		mov	ax, ds
		mov	es, ax
		mov	cx, 20h
		mov	esi, [ebp+8]
		mov	edi, offset _pal_tbl

L394:
		lodsb
		or	al, al
		jnz	short L395
		add	edi, 18h
		loop	L394
		jmp	short L411

L395:
		test	al, 1
		jz	short L403
		movsw
		movsb
		test	al, 2
		jz	short L404

L396:
		movsw
		movsb
		test	al, 4
		jz	short L405

L397:
		movsw
		movsb
		test	al, 8
		jz	short L406

L398:
		movsw
		movsb
		test	al, 10h
		jz	short L407

L399:
		movsw
		movsb
		test	al, 20h
		jz	short L408

L400:
		movsw
		movsb
		test	al, 40h
		jz	short L409

L401:
		movsw
		movsb
		or	al, al
		jns	short L410

L402:
		movsw
		movsb
		loop	L394
		jmp	short L411

L403:
		add	edi, 3
		test	al, 2
		jnz	short L396

L404:
		add	edi, 3
		test	al, 4
		jnz	short L397

L405:
		add	edi, 3
		test	al, 8
		jnz	short L398

L406:
		add	edi, 3
		test	al, 10h
		jnz	short L399

L407:
		add	edi, 3
		test	al, 20h
		jnz	short L400

L408:
		add	edi, 3
		test	al, 40h
		jnz	short L401

L409:
		add	edi, 3
		or	al, al
		js	short L402

L410:
		add	edi, 3
		loop	L394

L411:
		pop	edi
		pop	esi
		leave
		retn

PUBLIC _gfxMode
_gfxMode:
		push	ebp
		mov	ebp, esp
		push	ebp
		push	esi
		push	edi
		push	ebx
		mov	eax, [ebp+8]
		int	10h
		pop	ebx
		pop	edi
		pop	esi
		pop	ebp
		leave
		retn

PUBLIC _gfxLoadCrtc
_gfxLoadCrtc:
		push	ebp
		mov	ebp, esp
		push	esi
		push	edi
		push	ebx
		mov	edx, 3C4h
		mov	al, 4
		mov	ah, [ebp+0ch]
		out	dx, ax
		mov	dx, 3DAh

L412:
		in	al, dx
		test	al, 8
		jnz	short L412

L413:
		in	al, dx
		test	al, 8
		jz	short L413
		cli
		mov	edx, 3C4h
		mov	eax, 100h
		out	dx, ax
		mov	edx, 3C2h
		mov	al, [ebp+10h]
		out	dx, al
		mov	edx, 3C4h
		mov	eax, 300h
		out	dx, ax
		mov	edx, 3D4h
		mov	esi, [ebp+8]
		mov	al, 11h
		mov	ah, [esi+11h]
		and	ah, 7Fh
		out	dx, ax
		mov	ecx, 18h
		mov	ebx, 0

L414:
		mov	al, bl
		mov	ah, [esi+ebx]
		out	dx, ax
		inc	bl
		loop	L414
		sti
		pop	ebx
		pop	edi
		pop	esi
		leave
		retn

PUBLIC _gfxGetCrtc
_gfxGetCrtc:
		push	ebp
		mov	ebp, esp
		push	esi
		push	ebx
		mov	edx, 3D4h
		mov	esi, [ebp+8]
		mov	ecx, 18h
		mov	ebx, 0

L415:
		mov	al, bl
		out	dx, al
		inc	dx
		in	al, dx
		dec	dx
		mov	[esi+ebx], al
		inc	bl
		loop	L415
		pop	ebx
		pop	esi
		leave
		retn

PUBLIC _gfxVres
_gfxVres:
		push	ebp
		mov	ebp, esp
		push	ebx
		mov	edx, 3DAh

L416:
		in	al, dx
		test	al, 8
		jnz	short L416

L417:
		in	al, dx
		test	al, 8
		jz	short L417
		cli
		mov	edx, 3C4h
		mov	eax, 100h
		out	dx, ax
		mov	edx, 3CCh
		in	al, dx
		and	al, 3Fh
		mov	edx, 3C2h
		and	byte ptr [ebp+8], 0C0h
		or	al, [ebp+8]
		out	dx, al
		mov	edx, 3C4h
		mov	eax, 300h
		out	dx, ax
		mov	edx, 3D4h
		mov	ebx, [ebp+0ch]
		mov	al, 11h
		out	dx, al
		inc	dx
		in	al, dx
		dec	dx
		mov	ah, al
		mov	al, 11h
		and	ah, 7Fh
		out	dx, ax
		mov	al, 3
		out	dx, al
		inc	dx
		in	al, dx
		dec	dx
		mov	ah, al
		mov	al, 3
		or	ah, 80h
		out	dx, ax
		mov	al, 6
		mov	ah, [ebx+6]
		out	dx, ax
		mov	al, 7
		out	dx, al
		inc	dx
		in	al, dx
		dec	dx
		mov	ah, al
		mov	al, 7
		and	ah, 10h
		or	ah, [ebx+7]
		out	dx, ax
		mov	al, 9
		out	dx, al
		inc	dx
		in	al, dx
		dec	dx
		mov	ah, al
		mov	al, 9
		and	ah, 40h
		or	ah, [ebx+9]
		out	dx, ax
		mov	al, 10h
		mov	ah, [ebx+10h]
		out	dx, ax
		mov	al, 11h
		out	dx, al
		inc	dx
		in	al, dx
		dec	dx
		mov	ah, al
		mov	al, 11h
		and	ah, 70h
		or	ah, [ebx+11h]
		or	ah, 80h
		out	dx, ax
		mov	al, 12h
		mov	ah, [ebx+12h]
		out	dx, ax
		mov	al, 15h
		mov	ah, [ebx+15h]
		out	dx, ax
		mov	al, 16h
		mov	ah, [ebx+16h]
		out	dx, ax
		sti
		pop	ebx
		leave
		retn

PUBLIC _MVE_gfxWaitRetrace
_MVE_gfxWaitRetrace:
		push	ebp
		mov	ebp, esp
		mov	edx, 3DAh
		mov	eax, [ebp+8]
		or	eax, eax
		jnz	short L419

L418:
		in	al, dx
		and	al, 8
		jnz	short L418
		leave
		retn

L419:
		in	al, dx
		and	al, 8
		jz	short L419
		leave
		retn

PUBLIC _MVE_gfxSetSplit
_MVE_gfxSetSplit:
		push	ebp
		mov	ebp, esp
		mov	edx, 3DAh

L420:
		in	al, dx
		and	al, 8
		jnz	short L420

L421:
		in	al, dx
		and	al, 8
		jz	short L421
		mov	edx, 3D4h
		mov	ecx, [ebp+8]
		shr	ecx, 4
		and	cl, 10h
		mov	al, 7
		out	dx, al
		inc	dx
		in	al, dx
		dec	dx
		mov	ah, al
		mov	al, 7
		and	ah, 0EFh
		or	ah, cl
		out	dx, ax
		mov	ecx, [ebp+8]
		shr	ecx, 3
		and	cl, 40h
		mov	al, 9
		out	dx, al
		inc	dx
		in	al, dx
		dec	dx
		mov	ah, al
		mov	al, 9
		and	ah, 0BFh
		or	ah, cl
		out	dx, ax
		mov	al, 18h
		mov	ah, byte ptr [ebp+8]
		out	dx, ax
		leave
		retn

_TEXT ENDS

END
