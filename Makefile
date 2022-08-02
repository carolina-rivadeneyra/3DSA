
.PHONY: p
.PHONY: s
.PHONY: loc

all:
	@echo "Use one of the following options:"
	@echo ""
	@echo "  make p   :: To prepare files for P-wave readings"
	@echo "  make s   :: To prepare files for S-wave readings"
	@echo "  make loc :: To run the location procedure"
	@echo "  make fig :: Make final figure"
	@echo ""


model/guyana.P.mod.buf:
	@echo "\nComputing SLOWNESS grids for P-waves"
	Vel2Grid3D guyana_p.in
	@rm -f vgrids.in interfaces.in propgrid.in


p: model/guyana.P.mod.buf
	@echo "\nComputing time grids for each station"
	@[ $$(ls -1 time/time.P.*.time.buf 2> /dev/null | wc -l) -eq 0 ] && Grid2Time guyana_p.in || echo "Grid times exists for P-wave, to recompute erase all!"
	@rm -vf time/time.P.mod.*


model/guyana.S.mod.buf:
	@echo "\nComputing SLOWNESS grids for S-waves"
	Vel2Grid3D guyana_s.in
	@rm vgrids.in propgrid.in interfaces.in


s: model/guyana.S.mod.buf
	@echo "\nComputing time grids for each station"
	@[ $$(ls -1 time/time.S.*.time.buf 2> /dev/null | wc -l) -eq 0 ] && Grid2Time guyana_s.in || echo "Grid times exists for S-wave, to recompute erase all!"
	@rm -vf time/time.S.mod.*

loc/last.hyp: p s
	@echo "\nPerforming location ... "
	@NLLoc guyana_location.in 2>&1 | awk '{print " ",$$0}'
	@echo ""

loc: loc/last.hyp
	@echo "\nModel files uses: $$(du -hs model | awk '{print $$1}')"
	@echo "Time files uses: $$(du -hs time | awk '{print $$1}')"	
	@echo ""
	@echo "Final Location Residuals\n"
	@awk 'NR>17 && substr($$0,1,3) != "END" && $$18 > 0.0 {printf "  >> %5s %8.4f s\n",$$1, $$17}' loc/last.hyp
	@echo ""

fig: loc
	Grid2GMT guyana_location.in loc/last loc/ L S
	gv loc/last.LS.ps
