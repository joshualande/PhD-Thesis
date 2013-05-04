from matplotlib import rc
rc('ps',usedistiller='xpdf')
rc('text', usetex=True)
rc('font', family='serif', serif="Computer Modern Roman")

bw=False
#bw=True

from pylab import *
from lande_roi import *
roi=load("/nfs/slac/g/ki/ki03/lande/extended_catalog/2FGL/v17/followup_analysis/v2/standard_diffuse/spectral_emin_10000_v1/2FGL_J1632.4-4753c/v1/roi_Disk_2FGL_J1632.4-4753c.dat")


smooth=ROISmoothedBeforeAfter(roi,
                              which='2FGL J1632.4-4753c', title='', 
                              size=2.5, psf_size=0.6,
                              label_psf=False,
                              show_sources=False, show_extensions=False,
                              figsize=(6.5,3.5),
                              cmap=matplotlib.cm.gray if bw else colormaps.b)


smooth.show()

smooth.grid[0].add_inner_title("(a)", loc=2)
smooth.grid[1].add_inner_title("(b)", loc=2)

f = pyfits.open(e('$FERMI/hess/plane_survey/HESSJ1634-472_Map.fits'))
h = f[1].header
d = f[1].data
# Fix projection of HESS Image so that pywcs can read it.
h['CTYPE1'] = 'GLON-MER'
h['CTYPE2'] = 'GLAT-MER'
h['CUNIT1'] = 'deg'
h['CUNIT2'] = 'deg'


for ax,_h in zip(smooth.grid,smooth.h): # for both plots

    ax.locator_params(axis="x", nbins=3)
    ax.locator_params(axis="y", nbins=3)

    cont=ax[h].contour(d,linspace(20,100,8),colors="black" if bw else "lightblue", zorder=1)


    from uw.like.roi_catalogs import Catalog2FGL
    catalog=Catalog2FGL('$FERMI/catalogs/gll_psc_v04.fit',
                        latextdir='$FERMI/extended_archives/gll_psc_v05_templates/')

    # overlay background sources
    for name,kwargs in [['2FGL J1632.4-4753c', dict(color='black' if bw else 'red',    marker='^', markersize=7) ], # P72Y2540
                        ['2FGL J1634.4-4743c', dict(color='black' if bw else 'green',  marker='*', markersize=12) ],
                        ['2FGL J1636.3-4740c', dict(color='black' if bw else 'blue',   marker='o', markersize=7) ], # P72Y2550
                        ['2FGL J1635.4-4717c', dict(color='black' if bw else 'blue',   marker='o', markersize=7) ]]: # P72Y2547

        source=catalog.get_source(name)
        ax['gal'].plot([source.skydir.l()],[source.skydir.b()],'*',markeredgecolor='white', zorder=1.5, **kwargs)

    ROISmoothedSource.overlay_region(roi, ax, _h,
                                     extension_color='black' if bw else 'red',
                                     extension_zorder=1.25,
                                     override_kwargs = {
                                         '2FGL J1632.4-4753c': dict(color='black' if bw else 'red',marker='+', markersize=14, ),
                                         '2FGL J1635.4-4717c': dict(color='black' if bw else 'blue',marker='s', markersize=6, markeredgecolor='white'),
                                         '2FGL J1636.3-4740c': dict(color='black' if bw else 'blue',marker='s', markersize=6, markeredgecolor='white'),
                                     })

    if bw:
        savefig('source_HESS_J1632-478_bw.eps')
    else:
        savefig('source_HESS_J1632-478_color.eps')

