# DITA Community DITA 2 DOCX Open Toolkit Plugin

This plugin uses the Wordinator as the basis for a DITA-to-DOCX transform. It uses the base HTML5 transform to generate HTML that is then the input to the Wordinator DOCX generation process.

The plugin has been tested with OT versions 2.5.4 and 3.3. It depends on the base HTML5 transform and will use any global extensions to that transform.

This plugin uses the Wordinator (https://github.com/drmacro/wordinator) Java application, which in turn uses the Apache POI library (https://poi.apache.org/).

## Installation

The plugin is available from the Open Toolkit plugin repository:

```
dita --install org.dita-community.dita2docx
```

### Install from source

For OT 3.3+"

To install from source use the `deploy-plugin` ant target from the project's top-level build.xml file. Set the property `dita-ot-dir` either on the command line or in a file named `.build.properties` or `build.properties` in the project directory:

```
c:\projects\dita2docx> ant -Ddita-ot-dir=c:\apps\dita-ot-3.3 deploy-plugin
```

For OT 2.5.4:

Run the ant target `package`, which creates the plugin Zip file and then provide the filename to the `dita --install` command:

```
ekimber@Mako[develop]$ ant package
Buildfile: /Users/ekimber/workspace-dita-community/org.dita-community.dita2docx/build.xml

init:

build-plugin:
   [delete] Deleting directory /Users/ekimber/workspace-dita-community/org.dita-community.dita2docx/dist/org.dita-community.dita2docx
    [mkdir] Created dir: /Users/ekimber/workspace-dita-community/org.dita-community.dita2docx/dist/org.dita-community.dita2docx
     [copy] Copying 6 files to /Users/ekimber/workspace-dita-community/org.dita-community.dita2docx/dist/org.dita-community.dita2docx
     [copy] Copied 3 empty directories to 1 empty directory under /Users/ekimber/workspace-dita-community/org.dita-community.dita2docx/dist/org.dita-community.dita2docx
     [copy] Copying 1 file to /Users/ekimber/workspace-dita-community/org.dita-community.dita2docx/dist/org.dita-community.dita2docx/lib
     [copy] Copying 8 files to /Users/ekimber/workspace-dita-community/org.dita-community.dita2docx/dist/org.dita-community.dita2docx/xsl

check-wordinator-materials-uptodate:
     [echo] wordinator.materials.uptodate=true

get-dependencies:

package:
      [zip] Building zip: /Users/ekimber/workspace-dita-community/org.dita-community.dita2docx/dist/org.dita-community.dita2docx_0.1.0.zip

BUILD SUCCESSFUL
Total time: 1 second
ekimber@Mako[develop]$ dita --install /Users/ekimber/workspace-dita-community/org.dita-community.dita2docx/dist/org.dita-community.dita2docx_0.1.0.zip
ekimber@Mako[develop]$ 
```

Use `dita --uninstall org.dita-community.dita2docx` to remove the plugin if you need to update it. (For OT 3.x you use the `--force` parameter to the `--install` command to update an existing plugin.)

## Running the Transform

The transformation type is "dc-docx":

```
dita -f dc-docx -i my-publication.ditamap
```

Parameters:

* dc.dita2docx.dotx: Specifies the URI of the Word template (DOTX) file to use when constructing the result DOCX files. If not specified uses the built-in generic-dita.dotx file.
* dc.dita2docx.xsl: Specifies the URI of the HTML-to-SWPX transform to use in place of the built-in `dita2docx.xsl` transform.
* dc.dita2docx.chunkLevel: Sets the lowest level at which separate DOCX files (chunks) are generated. Default is "root".

You can also use any of the other HTML5 transformation parameters.

**NOTE:** The DOCX requires that the HTML be produced as a single file, so the dita2docx transform sets the `root-chunk-override` property to `to-content select-branch`. Do not change this value. 

### Running From Oxygen

You can run this transform by starting with the normal DITA HTML transformation scenario and changing the "transtype" parameter to "dc-docx".

For the output you can select "Other location" in the "Open in Browser/System Application" and set the file to open to:
```
${cfd}/out/html5/${cfn}.docx
```

Which should open the resulting DOCX file in Word if you have Word set as the default application to open .docx files.

## How It Works

The DOCX generation is a three-phase transformation:

1. Generate HTML5 or XHTML from your DITA source
1. Generate simple word processing XML (SWPX) from the HTML. The SWPX XML represents the content, structure, and styling details of the Word document to be generated.
1. Apply the Wordinator Java application to the SWPX XML and a separate Word DOTX template to generate the result DOCX document or documents. 

The HTML generated from step 1 must be a single HTML file.

The Wordinator Java application takes the HTML file as input and then performs steps 2 and 3:

In step 2, Wordinator uses the configured html2docx transform  to  SWPX XML files from the HTML, one for each resulting DOCX file (as controlled by the `chunkLevel` parameter to the Wordinator process). 

In step 3, Wordinator uses each SWPX file to generate DOCX files using the Apache POI ligrary, using the specified DOTX file to get the definitions of all the Word styles.

## Configuring the DOCX Generation

There are three main opportunities for configuration:

1. Definition of the DOTX Word template. This defines the visual details of the Word document and is the primary configuration mechanism. The built-in generic-dita.dotx file provides paragraph and character styles that correspond to base DITA elements that should result in paragraphs or character runs.
1. Modification of the base DITA-to-HTML5 transform to produce HTML that reflects how you want the DOCX files to look. This can be as simple as setting result `@class` values (for subsequent mapping to Word style names) or more involved reworking of the default HTML structures.
1. Modification of the base HTML-to-SWPX (`xsl/dita2docx.xsl`) to produce the SWPX markup you need. Usually this is just a matter of adjusting the mapping from `@class` values to Word style names but it can be more involved.

The `dita2docx.xsl` transform provides a normal DITA plugin extension point, `xsl.dc.dita2docx`, that you can use to add your own global extensions. You can also provide your own top-level transform replaces `dita2docx.xsl`. See the Wordinator project for details on how to extend and adapte the HTML-to-SWPX transform.

TBD: More information about how to adjust the `@class`-to-style mapping.

## Source Organization

The actual plugin source is in the `plugin` directory. Maven is used primarily to fetch the Wordinator jar so you must have have maven installed and available on your PATH to build the plugin from source.




