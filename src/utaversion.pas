{
   This code is stolen from Double Commander source
   under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.
}
unit utaVersion;

{$mode objfpc}{$H+}

interface

uses
  LCLVersion;

{$I tarevision.inc} // ffmpegGUIta revision number
{$I revision.inc} // Lazarus revision number

const
  taVersion   = '0.1.1';
  taBuildDate = {$I %DATE%};
  lazVersion  = lcl_version;         // Lazarus version (major.minor.micro)
  lazRevision = RevisionStr;         // Lazarus SVN revision
  fpcVersion  = {$I %FPCVERSION%};   // FPC version (major.minor.micro)
  TargetCPU   = {$I %FPCTARGETCPU%}; // Target CPU of FPC
  TargetOS    = {$I %FPCTARGETOS%};  // Target Operating System of FPC

implementation

end.