# About this repository
This repo is used for development of readme files in the Db2SystemServices section of the Db2ZTools public github repo:
https://github.com/IBM/Db2ZTools/tree/master/DevOps/Db2SystemServices

**Tip:** Clone this repo on your machine so that you can use your favorite editor to create and update the readme files.


## Creating APAR-specific readme files for updates to system provisioning templates


1. Create a new working branch for each APAR with subsystem parameter (zparm) changes that impact the provisioning templates. Name the branch your GitHub handle, the wall-of-work issue number for the MVP, and the APAR number. For example: `pamcwill-e491-ph26458`

2. In your new branch, add two readme files for the APAR.

    - For data sharing: `../db2z-provision-template-readme\Db2ProvisionSystemDS/ph24358_readme.md`
    - For non-DS: `../db2z-provision-template-readme\Db2ProvisionSystemNonDS/ph24358_readme.md`

3. In the main `readme.md` in each folder, locate the following step, and add a new item with a link to the readme new APAR: 

>4. Update the files in the template for changes to subsystem parameters in the following APARs.

4. To start the review, create a pull request and add the assigned reviewers.

5. When the review is approved, merge the working branch into master.

6. Delete your working branch.

7. After the PTF is built for the APAR, we'll copy the files into the public repo and commit the changes directly to the master branch.

## Updating the main readme files for a new template version

1. Create a new working branch.

2. In the main `readme.md` file in each folder, locate the following step.

>4. Update the files in the template for changes to subsystem parameters in the following APARs.

3. Remove the links to all readmes that are already applied in the new template version. These instructions are for clients downloading the new template, and they no longer need to apply these changes. However, do not delete the existing APAR-specific readme files from the folder. Clients who already downloaded the templates and are now applying an older APAR in their environment still need the older readme files. They will find the link in the ++HOLD. 

4. Create a PR when the changes are ready for review.

5. When the review is complete, merge the PR into the master branch.

6. Delete the working branch.

7. Copy the files into the external Github repo in the same commit as the new `.pax` files.
