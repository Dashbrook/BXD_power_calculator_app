## BXD power calculator

### Statement of need

The BXD power app (https://dashbrook1.shinyapps.io/bxd_power_calculator_app/) seeks to provide a quick and easy graphical interface for users to calculate the theortical power to detect an effect in a two parent recombinant inbred population. This GitHub provides the scripts which the app is based on. 
A power calculator such as this is needed as all grants require a calculation of the applications power to detect the effect of interest, and this app can provide values and figures for applicants to use. 

### Installation

Installation simply requires [server.R](server.R), [ui.R](ui.R) and [run_app.R](run_app.R) to be downloaded to the same folder, and the [run_app.R](run_app.R) script to be run. The user can specify the location of their directory with the setwd command in [run_app.R](run_app.R), if needed.

### Test

To test that the app is working correctly, open the app and wait for plots to appear. Set heritability to 0.4, locus effect size to 0.4, biological replicates between 2 and 10, and power threshold to 0.8, observing that the plots update after each user input. The main plot should now appear as shown below:

-![Figure 1](Figure_1.png) 

Now go to the table below, and click on "Total animals needed" to sort by the minimum number of animals needed. The table should now look like this:

-![Figure 2](Figure_2.JPG) 

Now return to the inputs, and alter the minimum number of biological replicates to 10. The figure to the left should now appear like this:


-![Figure 3](Figure_3.png) 



### Issues

Issues can be raised through the github issue tracker.

### Contributing 

Contribute to source code by forking the Github repository, and sending us pull requests.

Its also possible to just post comments on code / commits.

Or be a maintainer, and adopt a function

### Cite

Citation will be added, after publication. 

### License

The source code is released under the GNU GENERAL PUBLIC LICENSE Version 3 (GPLv3). See [LICENSE.txt](LICENSE.txt).

### Contact

Code managed by David Ashbrook - Department of Genetics, Genomics and Informatics, University of Tennessee Health Science Center, USA 