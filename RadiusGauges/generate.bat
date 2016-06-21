

set OPENSCAD="c:\Program Files\OpenSCAD\openscad.exe"


mkdir STL\Imperial\Small
mkdir STL\Imperial\Large
mkdir STL\Metric\Small
mkdir STL\Metric\Large




FOR /F "tokens=1-3" %%x IN (imperialSizes.txt) DO %OPENSCAD% -o STL\Imperial\%%z\RadiusGauge-%%x-%%y-in.stl -DRadiusNumerator=%%x -DRadiusDenominator=%%y RadiusGauge-Inch.scad

FOR /F "tokens=1-2" %%x IN (metricSizes.txt) DO %OPENSCAD% -o STL\Metric\%%y\RadiusGauge-%%x-mm.stl -DRadius=%%x RadiusGauge-MM.scad
