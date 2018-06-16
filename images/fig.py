#! /usr/bin/env python

from matplotlib.pyplot import *
import matplotlib

matplotlib.rcParams.update({'font.size': 16})
fs = 20

clf()
fig = gcf()
ax = fig.add_axes([0,0,1,1])
off = (5,8)

l = [-1, 7]

for p in 0,2,4,6:
    plot([p,p], l, 'k')
    plot(l, [p,p], 'k')

axis('image')
axis('off')

c  = 'b'
m  = 'o'
c2 = 'r'
m2 = 's'

p = (3, 0)
annotate(r'-$\delta_y$', xy=p, xytext=off, textcoords='offset points', color=c)
plot([p[0]], [p[1]], marker=m, color=c)

p = (3, 2)
annotate(r'-$\alpha_y$', xy=p, xytext=off, textcoords='offset points', color=c)
plot([p[0]], [p[1]], marker=m, color=c)

p = (3, 4)
annotate(r'$\alpha_y$', xy=p, xytext=off, textcoords='offset points', color=c)
plot([p[0]], [p[1]], marker=m, color=c)

p = (3, 6)
annotate(r'$\delta_y$', xy=p, xytext=off, textcoords='offset points', color=c)
plot([p[0]], [p[1]], marker=m, color=c)


p = (1, 2)
annotate(r'-$\beta_{yx}$', xy=p, xytext=off, textcoords='offset points', color=c)
plot([p[0]], [p[1]], marker=m, color=c)

p = (5, 2)
annotate(r'-$\beta_{yx}$', xy=p, xytext=off, textcoords='offset points', color=c)
plot([p[0]], [p[1]], marker=m, color=c)


p = (1, 4)
annotate(r'$\beta_{yx}$', xy=p, xytext=off, textcoords='offset points', color=c)
plot([p[0]], [p[1]], marker=m, color=c)

p = (5, 4)
annotate(r'$\beta_{yx}$', xy=p, xytext=off, textcoords='offset points', color=c)
plot([p[0]], [p[1]], marker=m, color=c)

p = (8, 5)
annotate(r'$E_x$', fontsize=fs, xy=p, xytext=off, textcoords='offset points', color=c, annotation_clip=False)
plot([p[0]], [p[1]], marker=m, color=c, clip_on=False)


c = c2
m = m2

p = (0, 3)
annotate(r'$\delta_x$', xy=p, xytext=off, textcoords='offset points', color=c)
plot([p[0]], [p[1]], marker=m, color=c)

p = (2, 3)
annotate(r'$\alpha_x$', xy=p, xytext=off, textcoords='offset points', color=c)
plot([p[0]], [p[1]], marker=m, color=c)

p = (4, 3)
annotate(r'-$\alpha_x$', xy=p, xytext=off, textcoords='offset points', color=c)
plot([p[0]], [p[1]], marker=m, color=c)

p = (6, 3)
annotate(r'-$\delta_x$', xy=p, xytext=off, textcoords='offset points', color=c)
plot([p[0]], [p[1]], marker=m, color=c)


p = (2, 1)
annotate(r'$\beta_{xy}$', xy=p, xytext=off, textcoords='offset points', color=c)
plot([p[0]], [p[1]], marker=m, color=c)

p = (2, 5)
annotate(r'$\beta_{xy}$', xy=p, xytext=off, textcoords='offset points', color=c)
plot([p[0]], [p[1]], marker=m, color=c)


p = (4, 1)
annotate(r'-$\beta_{xy}$', xy=p, xytext=off, textcoords='offset points', color=c)
plot([p[0]], [p[1]], marker=m, color=c)

p = (4, 5)
annotate(r'-$\beta_{xy}$', xy=p, xytext=off, textcoords='offset points', color=c)
plot([p[0]], [p[1]], marker=m, color=c)

p = (8, 4)
annotate(r'$E_y$', fontsize=fs, xy=p, xytext=off, textcoords='offset points', color=c, annotation_clip=False)
plot([p[0]], [p[1]], marker=m, color=c, clip_on=False)

#ax.figure.texts.append(ax.texts.pop())


c = 'k'
p = (3, 3)
m = 'o'
annotate(r'$B_z$', fontsize=fs, xy=p, xytext=off, textcoords='offset points', color=c)
plot([p[0]], [p[1]], marker=m, color=c)

setp(ax.lines, linewidth=1)

subplots_adjust(top=1, bottom=0, right=1, left=0, hspace=0, wspace=0)
margins(0,0)
gca().xaxis.set_major_locator(NullLocator())
gca().yaxis.set_major_locator(NullLocator())
savefig('stencil.pdf', bbox_inches='tight', pad_inches=0)
