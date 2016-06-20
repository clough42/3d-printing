

set OPENSCAD="c:\Program Files\OpenSCAD\openscad.exe"

for %%x IN (
	1,
	3,
	5,
	7,
	9,
	11,
	13,
	15,
	17,
	19,
	21,
	23,
	25,
	27,
	29,
	31
) DO %OPENSCAD% -o STL\Imperial\RadiusGauge-%%x-32-in.stl -Dnumber=%%x -Dscale=25.4/32 -Dunit=\"/32in\" RadiusGauge.scad

for %%x IN (
	1,
	3,
	5,
	7,
	9,
	11,
	13,
	15
) DO %OPENSCAD% -o STL\Imperial\RadiusGauge-%%x-16-in.stl -Dnumber=%%x -Dscale=25.4/16 -Dunit=\"/16in\" RadiusGauge.scad

for %%x IN (
	1,
	3,
	5,
	7,
) DO %OPENSCAD% -o STL\Imperial\RadiusGauge-%%x-8-in.stl -Dnumber=%%x -Dscale=25.4/8 -Dunit=\"/8in\" RadiusGauge.scad

for %%x IN (
	1,
	3
) DO %OPENSCAD% -o STL\Imperial\RadiusGauge-%%x-4-in.stl -Dnumber=%%x -Dscale=25.4/4 -Dunit=\"/4in\" RadiusGauge.scad

for %%x IN (
	1
) DO %OPENSCAD% -o STL\Imperial\RadiusGauge-%%x-2-in.stl -Dnumber=%%x -Dscale=25.4/2 -Dunit=\"/2in\" RadiusGauge.scad

for %%x IN (
	1
) DO %OPENSCAD% -o STL\Imperial\RadiusGauge-%%x-in.stl -Dnumber=%%x -Dscale=25.4 -Dunit=\"in\" RadiusGauge.scad

for %%x IN (
	1,
	1.5,
	2,
	2.5,
	3,
	3.5,
	4,
	4.5,
	5,
	5.5,
	6,
	6.5,
	7,
	7.5,
	8,
	8.5,
	9,
	9.5,
	10,
	10.5,
	11,
	11.5,
	12,
	12.5,
	13,
	13.5,
	14,
	14.5,
	15,
	15.5,
	16,
	16.5,
	17,
	17.5,
	18,
	18.5,
	19,
	19.5,
	20,
	20.5,
	21,
	21.5,
	22,
	22.5,
	23,
	23.5,
	24,
	24.5,
	25
) DO %OPENSCAD% -o STL\Metric\RadiusGauge-%%x-mm.stl -Dnumber=%%x -Dscale=1 -Dunit=\"mm\" RadiusGauge.scad







	