/**
 * Copyright (c) 2003-2012, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.html or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {

config.protectedSource.push( /<\?[\s\S]*?\?>/g );   // PHP code
config.protectedSource.push( /<%[\s\S]*?%>/g );   // ASP code
config.protectedSource.push( /(]+>[\s|\S]*?<\/asp:[^\>]+>)|(]+\/>)/gi );   // ASP.Net code

config.language = 'ru';

config.emailProtection = 'mt(NAME,DOMAIN,SUBJECT,BODY)';

config.removePlugins = 'scayt,menubutton,contextmenu';

config.toolbarCanCollapse = false;
config.disableNativeSpellChecker = false;
//config.browserContextMenuOnCtrl = false;
config.scayt_autoStartup = true;

config.autoParagraph = false;
config.autoUpdateElement = true;

config.filebrowserUploadUrl = '';

config.extraPlugins = 'jwplayer,syntaxhighlight,spoiler';

config.enterMode = CKEDITOR.ENTER_BR;
config.shiftEnterMode = CKEDITOR.ENTER_P;

config.toolbar_Big = [
  ['Source','-','Save'],
  ['Cut','Copy','Paste','PasteText','PasteWord'],
  ['Undo','Redo'],
  ['Bold','Italic','Underline','StrikeThrough'], '/',
  ['OrderedList','UnorderedList','-','Outdent','Indent','Blockquote','CreateDiv'],
  ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],['Link','Unlink','Anchor'], 
  ['Image','Flash','Table','Rule','SpecialChar'], 
  ['FontFormat','FontName','FontSize'],
  ['TextColor','BGColor','RemoveFormat'], 
  ['FitWindow','ShowBlocks'], 
  ['AnchorMore','PageBreak','linebreaks']
] ;

config.toolbar_Small = [
  ['Source','-','Save'],
  ['Cut','Copy','Paste','PasteText','PasteFromWord'],
  ['Undo','Redo'],
  ['Bold','Italic','Underline','StrikeThrough'],['OrderedList','UnorderedList'],
  ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],['NumberedList','BulletedList','Blockquote','CreateDiv','Table','Rule'],['Outdent','Indent'],
  ['Link','Unlink','Anchor','PageBreak'],['FontFormat','FontSize','TextColor','BGColor','RemoveFormat'],['Image','Flash','jwplayer'],['FitWindow','ShowBlocks'], ['Code','-','SpecialChar']
] ;

config.toolbar_Verysmall = [
   ['Source','-','Save'],['Cut','Copy','Paste','PasteText','PasteWord'],['Undo','Redo'],['Bold','Italic','Underline','StrikeThrough'],['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],['Link','Unlink']
] ;

config.autoGrow_minHeight = 300;

config.filebrowserLinkBrowseUrl = "../../../../admin/browser.php?typ=bild&mode=fck&target=link";
config.filebrowserImageBrowseUrl = "../../../../admin/browser.php?typ=bild&mode=fck&target=txtUrl";
config.filebrowserFlashBrowseUrl = "../../../../admin/browser.php?typ=bild&mode=fck&target=txtUrl";
config.filebrowserLinkUploadUrl = "../../../../admin/browser.php?typ=bild&mode=fck&target=link";
config.filebrowserImageUploadUrl = "../../../../admin/browser.php?typ=bild&mode=fck&target=txtUrl";

config.LinkUpload  = false ;
config.ImageUpload = false ;
config.FlashUpload = false ;
config.ImagesUpload = false ;
config.StyleUpload = false ;
config.CommentUpload = false ;
config.PlayUpload = false ;

config.toolbarCanCollapse = false;

config.skin = 'kama' ;

config.keystrokes =
[
    [ CKEDITOR.ALT + 121 /*F10*/, 'toolbarFocus' ],
    [ CKEDITOR.ALT + 122 /*F11*/, 'elementsPathFocus' ],

    [ CKEDITOR.SHIFT + 121 /*F10*/, 'contextMenu' ],

    [ CKEDITOR.CTRL + 90 /*Z*/, 'undo' ],
    [ CKEDITOR.CTRL + 89 /*Y*/, 'redo' ],
    [ CKEDITOR.CTRL + CKEDITOR.SHIFT + 90 /*Z*/, 'redo' ],

    [ CKEDITOR.CTRL + 76 /*L*/, 'link' ],

    [ CKEDITOR.CTRL + 66 /*B*/, 'bold' ],
    [ CKEDITOR.CTRL + 73 /*I*/, 'italic' ],
    [ CKEDITOR.CTRL + 85 /*U*/, 'underline' ],

    [ CKEDITOR.ALT + 109 /*-*/, 'toolbarCollapse' ]
];

};