# watcom 10.5, tasm 3.1

DCFLAGS = /3r /od /s
MCLFAGS = /4r /or /s

DOBJ = &
sosdrv.obj &
sosdata.obj &
sosload.obj &
sostimer.obj &
sosstart.obj &
sosinit.obj &
soscaps.obj &
sossys.obj &
soslock.obj &
soserr.obj &
sosdetec.obj &
mixmix.obj &
mixxfer.obj &
mixer.obj &
sostmr.obj &
soscntl.obj &
sosalloc.obj

MOBJ = &
sosmbrch.obj &
sosmchnl.obj &
sosmdata.obj &
sosmdlta.obj &
sosmevnt.obj &
sosminit.obj &
sosmins.obj &
sosmlock.obj &
sosmmap.obj &
sosmmute.obj &
sosmpaus.obj &
sosmplay.obj &
sosmsend.obj &
sosmsong.obj &
sosmsys.obj &
sosmtmpo.obj &
sosmtrck.obj &
sosmvol.obj &
sosmload.obj &
sosmdrv.obj &
sosmcbck.obj &
sosmdigi.obj &
sosmdq.obj &
sosmwave.obj &
sosmdep.obj


sosw1cr.lib : $(DOBJ) $(MOBJ)
	%make sos.lnk
	wlib sosw1cr.lib /n /b @sos.lnk

sos.lnk: makefile
	%create $^@
    for %i in ($(DOBJ)) do %append $^@ -+%i
    for %i in ($(MOBJ)) do %append $^@ -+%i
	
sosdata.obj: sosdata.c
	wcc386 $(DCFLAGS) sosdata
	
sosload.obj: sosload.c
	wcc386 $(DCFLAGS) sosload
	
sosstart.obj: sosstart.c
	wcc386 $(DCFLAGS) sosstart
	
sosinit.obj: sosinit.c
	wcc386 $(DCFLAGS) sosinit
	
soscaps.obj: soscaps.c
	wcc386 $(DCFLAGS) soscaps
	
sossys.obj: sossys.c
	wcc386 $(DCFLAGS) sossys
	
soslock.obj: soslock.c
	wcc386 $(DCFLAGS) soslock
	
soserr.obj: soserr.c
	wcc386 $(DCFLAGS) soserr
	
sosdetec.obj: sosdetec.c
	wcc386 $(DCFLAGS) sosdetec
	
sostmr.obj: sostmr.c
	wcc386 $(DCFLAGS) sostmr
	
soscntl.obj: soscntl.c
	wcc386 $(DCFLAGS) soscntl
	
sosalloc.obj: sosalloc.c
	wcc386 $(DCFLAGS) sosalloc

sosmbrch.obj: sosmbrch.c
	wcc386 $(MCFLAGS) sosmbrch
	
sosmchnl.obj: sosmchnl.c
	wcc386 $(MCFLAGS) sosmchnl
	
sosmdata.obj: sosmdata.c
	wcc386 $(MCFLAGS) sosmdata
	
sosmdlta.obj: sosmdlta.c
	wcc386 $(MCFLAGS) sosmdlta
	
sosmevnt.obj: sosmevnt.c
	wcc386 $(MCFLAGS) sosmevnt
	
sosminit.obj: sosminit.c
	wcc386 $(MCFLAGS) sosminit
	
sosmins.obj: sosmins.c
	wcc386 $(MCFLAGS) sosmins
	
sosmlock.obj: sosmlock.c
	wcc386 $(MCFLAGS) sosmlock
	
sosmmap.obj: sosmmap.c
	wcc386 $(MCFLAGS) sosmmap
	
sosmmute.obj: sosmmute.c
	wcc386 $(MCFLAGS) sosmmute
	
sosmpaus.obj: sosmpaus.c
	wcc386 $(MCFLAGS) sosmpaus
	
sosmplay.obj: sosmplay.c
	wcc386 $(MCFLAGS) sosmplay
	
sosmsend.obj: sosmsend.c
	wcc386 $(MCFLAGS) sosmsend
	
sosmsong.obj: sosmsong.c
	wcc386 $(MCFLAGS) sosmsong
	
sosmsys.obj: sosmsys.c
	wcc386 $(MCFLAGS) sosmsys
	
sosmtmpo.obj: sosmtmpo.c
	wcc386 $(MCFLAGS) sosmtmpo
	
sosmtrck.obj: sosmtrck.c
	wcc386 $(MCFLAGS) sosmtrck
	
sosmvol.obj: sosmvol.c
	wcc386 $(MCFLAGS) sosmvol
	
sosmload.obj: sosmload.c
	wcc386 $(MCFLAGS) sosmload
	
sosmcbck.obj: sosmcbck.c
	wcc386 $(MCFLAGS) sosmcbck
	
sosmdigi.obj: sosmdigi.c
	wcc386 $(MCFLAGS) sosmdigi
	
sosmdq.obj: sosmdq.c
	wcc386 $(MCFLAGS) sosmdq
	
sosmwave.obj: sosmwave.c
	wcc386 $(MCFLAGS) sosmwave
	
sosmdep.obj: sosmdep.c
	wcc386 $(MCFLAGS) sosmdep
	
.asm.obj :
	tasm /mx $[*
