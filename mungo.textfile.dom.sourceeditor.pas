unit mungo.textfile.dom.sourceeditor;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,

  Graphics,

  SynHighlighterXML,
  SynHighlighterHTML,

  mungo.intf.filepointer,

  mungo.components.colors,
  mungo.textfile.sourceeditor;

type

  { TSourceEditorDOM }

  TSourceEditorDOM = class ( TSourceEditor )
    constructor Create(ARootControl: TObject; AFileInfo: TFilePointer); override; overload;
    class function FileMatch(AFileInfo: TFilePointer): Boolean; override;
  end;

implementation

constructor TSourceEditorDOM.Create(ARootControl: TObject; AFileInfo: TFilePointer);

  function CreateHighlighterXML: TSynXMLSyn;
  begin
    Result:= TSynXMLSyn.Create( Editor );

    Result.AttributeValueAttri.Foreground:= BlueGray600;
    Result.KeywordAttribute.Foreground:= Black;
    Result.SymbolAttri.Foreground:= Black;
    Result.SymbolAttri.Style:= [ fsBold ];
    Result.CommentAttribute.Foreground:= LightGreen600;
  end;

  function CreateHighlighterHTML: TSynHTMLSyn;
  begin
    Result:= TSynHTMLSyn.Create( Editor );

    Result.ValueAttri.Foreground:= Blue600;
//    Result.StringAttribute.Foreground:= BlueGray600;
    Result.SymbolAttri.Foreground:= Black;
    Result.SymbolAttri.Style:= [ fsBold ];
    Result.CommentAttribute.Foreground:= LightGreen600;
  end;

begin
  inherited Create(ARootControl, AFileInfo);
  if (( AFileInfo.Extension = '.xml' )
      or ( AFileInfo.Extension = '.lpk' )
      or ( AFileInfo.Extension = '.lps' )
      or ( AFileInfo.Extension = '.lpi' )) then
    Editor.Highlighter:= CreateHighlighterXML
  else
    Editor.Highlighter:= CreateHighlighterHTML;

  Editor.Gutter.Color:= White;
  Editor.Color:= White;
end;

class function TSourceEditorDOM.FileMatch(AFileInfo: TFilePointer): Boolean;
begin
  Result:= inherited;
  if ( Result ) then
    Result:= ( AFileInfo.Extension = '.xml' )
          or ( AFileInfo.Extension = '.lpk' )
          or ( AFileInfo.Extension = '.lpi' )
          or ( AFileInfo.Extension = '.lps' )
          or ( AFileInfo.Extension = '.html' )
          or ( AFileInfo.Extension = '.htm' );
end;

end.

