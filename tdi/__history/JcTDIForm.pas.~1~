unit JcTDIForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Tabs, ComCtrls, Contnrs;

type

  TJcTDIForm = class;

  TFormInfo = class
  private
    FForm: TForm;
    FTDIForm: TJcTDIForm;
    FTabIndex: Integer;
    FFormClose: TCloseEvent;
    FFormKeyDown: TKeyEvent;
    procedure setForm(AForm: TForm);
    procedure setFormTabSet(AFormTabSet: TJcTDIForm);
  protected
    procedure formClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  public
    constructor Create(var AForm: TForm; AFormTabSet: TJcTDIForm);
    procedure createTab;
    function getForm: TForm;
    function getFormTabSet: TJcTDIForm;
    function getTabIndex: Integer;
    procedure setTabIndex(const Value: Integer);
  end;

  TBackgroundImage = class(TImage)
  public
    constructor Create(AOwner: TComponent); override;
  end;


  TJcTDIForm = class(TCustomPanel)
  private
    FTabSet: TTabSet;
    FDockPanel: TPanel;
    FBackgroundImage: TBackgroundImage;
    FForms: TObjectList;
    FBackgroundColor: TColor;
    FImageList: TImageList;
    FFormIndex: Integer;
    FNumForm: Integer;
                      
    EnableImageIndex: Integer;
    DisabledImageIndex: Integer;

    procedure IncForm(Value: Integer);
    procedure DecForm(Value: Integer);
    procedure setBackgroundColor(const Value: TColor);
    procedure setBackgroundImage(const Value: TBackgroundImage);
    procedure createDockPanel;
    procedure createFormList;
    procedure createImage(Owner: TComponent);
    procedure createImageList;
    procedure createTabSet;
    function getFormIndex(var AForm: TForm): Integer; overload;

    procedure tabSetChange(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure tabSetGetImageIndex(Sender: TObject; TabIndex: Integer;
      var ImageIndex: Integer);
    procedure  tabSetHitClose(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  protected
    procedure DoAddDockClient(Client: TControl; const ARect: TRect); override;
    function getTabSet: TTabSet;
    function getDockPanel: TPanel;
    function getBackgroundImage: TBackgroundImage;
    function getForms: TObjectList;
    function getBackgroundColor: TColor;
    function getImageList: TImageList;
    function getFormIndex: Integer; overload;
    procedure setFormIndex(Index: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function getFormNum: Integer;
    function addForm(AForm: TForm): Integer;
    function getForm(Index: Integer): TForm;
    function getFormName(AForm: TForm): Boolean;
    procedure removeForm(Index: Integer); overload;
    procedure removeForm(AForm: TForm); overload;
    property DockManager;
  published
    property NumForms: Integer read FNumForm Write FNumForm;
    property BackgroundImage: TBackgroundImage read FBackgroundImage write setBackgroundImage;
    property Align;
    property Alignment;
    property Anchors;
    property BiDiMode;
    property BackgroundColor: TColor read FBackgroundColor
      write setBackgroundColor;
    property Constraints;
    property Ctl3D;
    property Enabled;
    property ParentBiDiMode;
    property ParentBackground;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnCanResize;
    property OnClick;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDockDrop;
    property OnDockOver;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnGetSiteInfo;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

procedure Register;

implementation

{$R *.res}

{ TJcTDIForm }

procedure Register;
begin
  RegisterComponents('Jc Components', [TJcTDIForm]);
end;

function TJcTDIForm.addForm(AForm: TForm): Integer;
var
  FormInfo: TFormInfo;
  formIndex: Integer;
begin
  Result := -1;
  if getFormIndex >= 0 then
    TFormInfo(getForms[getFormIndex]).getForm.Hide;
  formIndex := getFormIndex(AForm);
  if formIndex >= 0 then
  begin
    getTabSet.TabIndex := TFormInfo(getForms[formIndex]).getTabIndex;
    AForm.Show;
    Abort;
  end  
  else
  begin
    if Align <> alClient then
      Align := alClient;
    FormInfo := TFormInfo.Create(AForm, Self);
    FormInfo.createTab;
    FormInfo.getForm.Position := poDesigned;
    FormInfo.getForm.Top := 0;
    FormInfo.getForm.Left := 0;
    FormInfo.getForm.Show;
    Result := getForms.Add(FormInfo);
    setFormIndex(Result);
    IncForm(1);
  end;
end;


constructor TJcTDIForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  createImageList;
  createTabSet;
  createDockPanel;
  createImage(getDockPanel);
  createFormList;

  BevelOuter := bvNone;
  Height := getTabSet.Height + 1;
  setBackgroundColor(clWhite);
  setFormIndex(-1);
  IncForm(0);
end;

procedure TJcTDIForm.createDockPanel;
begin
  FDockPanel := TPanel.Create(Self);
  FDockPanel.Parent := Self;
  FDockPanel.Color := clWhite;
  FDockPanel.BevelOuter := bvNone;
  FDockPanel.Height := 0;
  FDockPanel.AutoSize := True;
  FDockPanel.Align := alClient;
end;

procedure TJcTDIForm.createFormList;
begin
  FForms := TObjectList.Create;
end;

procedure TJcTDIForm.createImage(Owner: TComponent);
begin
  FBackgroundImage := TBackgroundImage.Create(Owner);
  FBackgroundImage.Parent := TWinControl(Owner);
  FBackgroundImage.Align := alClient;
end;

procedure TJcTDIForm.createImageList;
var
  BitmapClose: TBitmap;
begin
  FImageList := TImageList.Create(Self);
  BitmapClose := TBitmap.Create;
  try
  BitmapClose.LoadFromResourceName(HInstance, 'CLOSEH');
  EnableImageIndex :=
    FImageList.AddMasked(BitmapClose, clWhite);

  BitmapClose.LoadFromResourceName(HInstance, 'CLOSED');
  DisabledImageIndex :=
    FImageList.AddMasked(BitmapClose, clWhite);
  finally
    BitmapClose.Free;
  end;
end;

procedure TJcTDIForm.createTabSet;
begin
  FTabSet := TTabSet.Create(Self);
  FTabSet.Parent :=  Self;
  FTabSet.Align := alTop;
  FTabSet.DitherBackground := False;
  FTabSet.SelectedColor := getBackgroundColor;
  FTabSet.ParentBackground := True;
  FTabSet.Style := tsModernTabs;
  FTabSet.TabPosition := tpTop;
  FTabSet.Font.Name := 'Tahoma';
  FTabSet.Height := FTabSet.TabHeight + 6;
  FTabSet.Images := getImageList;
  FTabSet.OnChange := tabSetChange;
  FTabSet.OnGetImageIndex := tabSetGetImageIndex;
  FTabSet.OnMouseUp := tabSetHitClose;
end;

procedure TJcTDIForm.DecForm(Value: Integer);
begin
   if FNumForm > 0 then
     FNumForm := (FNumForm - Value);
end;

destructor TJcTDIForm.Destroy;
begin
  if Assigned(FForms) then
  begin
    FForms.Clear;
    FForms.Free;
  end;
  inherited;
end;

procedure TJcTDIForm.DoAddDockClient(Client: TControl; const ARect: TRect);
begin
  Abort;
end;

function TJcTDIForm.getBackgroundColor: TColor;
begin
  Result := FBackgroundColor;
end;

function TJcTDIForm.getBackgroundImage: TBackgroundImage;
begin
 Result := FBackgroundImage;
end;

function TJcTDIForm.getDockPanel: TPanel;
begin
  Result := FDockPanel;
end;

function TJcTDIForm.getForm(Index: Integer): TForm;
begin
  Result := TFormInfo(getForms[Index]).getForm;
end;

function TJcTDIForm.getFormName(AForm: TForm): Boolean;
var
  formIndex: Integer;
begin
  Result := False;
  formIndex := getFormIndex(AForm);
  if formIndex >= 0 then
  begin
    getTabSet.TabIndex := TFormInfo(getForms[formIndex]).getTabIndex;
    AForm.Show;
    Result := True;
    Abort;
  end;
end;

function TJcTDIForm.getFormNum: Integer;
begin
  Result := FNumForm;
end;

function TJcTDIForm.getFormIndex: Integer;
begin
  Result := FFormIndex;
end;

function TJcTDIForm.getForms: TObjectList;
begin
  Result := FForms;
end;

function TJcTDIForm.getImageList: TImageList;
begin
  Result := FImageList;
end;

function TJcTDIForm.getTabSet: TTabSet;
begin
  Result := FTabSet;
end;

function TJcTDIForm.getFormIndex(var AForm: TForm): Integer;
var
  i: Integer;
  FormInfo: TFormInfo;
begin
  Result := -1;
  for i := 0 to (getForms.Count - 1) do
  begin
    FormInfo := TFormInfo(getForms[i]);
    if (FormInfo.getForm = AForm) then
    begin
      Result := i;
      Break;
    end;  
  end;
end;

procedure TJcTDIForm.removeForm(Index: Integer);
var
  itemIndex, i: Integer;
begin
  itemIndex := TFormInfo(getForms[Index]).getTabIndex;
  getForms.Delete(Index);
  getTabSet.Tabs.Delete(itemIndex);
  for i := 0 to (getForms.Count - 1) do
  begin
    if TFormInfo(getForms[i]).getTabIndex > itemIndex then
      TFormInfo(getForms[i]).setTabIndex(
        TFormInfo(getForms[i]).getTabIndex - 1);
  end;

  if (itemIndex = 0) and (getTabSet.Tabs.Count > 0) then
    getTabSet.TabIndex := itemIndex
  else
    getTabSet.TabIndex := Pred(itemIndex);

  if (Index = 0) and (getForms.Count > 0)  then
    setFormIndex(Index)
  else
    setFormIndex(Pred(Index));

  if getFormIndex >= 0 then
    TFormInfo(getForms[getFormIndex]).getForm.Show;
end;

procedure TJcTDIForm.removeForm(AForm: TForm);
var
  i: Integer;
begin
  for i := 0 to (getForms.Count - 1) do
  begin
    if TFormInfo(getForms[i]).getForm = AForm then
    begin
      removeForm(i);
      DecForm(1);
      Break;
    end;  
  end;
end;

procedure TJcTDIForm.setBackgroundColor(const Value: TColor);
begin
  if FBackgroundColor <> Value then
  begin
    FBackgroundColor := Value;
    getDockPanel.Color := getBackgroundColor;
    getTabSet.SelectedColor := getBackgroundColor;
  end;
end;

procedure TJcTDIForm.setBackgroundImage(const Value: TBackgroundImage);
begin
  FBackgroundImage.Assign(Value);
end;

procedure TJcTDIForm.setFormIndex(Index: Integer);
begin
  FFormIndex := Index;
end;

procedure TJcTDIForm.IncForm(Value: Integer);
begin
   FNumForm := (FNumForm + Value); 
end;

procedure TJcTDIForm.tabSetChange(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
var
  i: Integer;
  FormInfo: TFormInfo;
begin
  for i := 0 to (getForms.Count - 1) do
  begin
    FormInfo := TFormInfo(getForms[i]);
    if FormInfo.getTabIndex = NewTab then
    begin
      TFormInfo(getForms[getFormIndex]).getForm.Hide;
      FormInfo.getForm.Show;
      setFormIndex(i);
    end;
  end;
end;

procedure TJcTDIForm.tabSetGetImageIndex(Sender: TObject; TabIndex: Integer;
  var ImageIndex: Integer);
begin
 if TabIndex = getTabSet.TabIndex then
   ImageIndex := EnableImageIndex
 else
   ImageIndex := DisabledImageIndex;
end;

procedure TJcTDIForm.tabSetHitClose(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  ItemIndex: Integer;
  TabRect: TRect;
  i: Integer;
  FormInfo: TFormInfo;
  Form: TForm;
begin
  ItemIndex := getTabSet.ItemAtPos(Point(X, Y));
  if (Button = mbLeft) and (ItemIndex >= 0) then
  begin
    TabRect := getTabSet.ItemRect(ItemIndex);
    TabRect := Rect((TabRect.Left + 2),(TabRect.Top), ((TabRect.Left + 2) + 11),
      (TabRect.Top + 11));
    if ((X > TabRect.Left) and (X < TabRect.Right)) and
       ((Y > TabRect.Top) and (Y < TabRect.Bottom)) then
    begin

      for i := 0 to (getForms.Count - 1) do
      begin
        FormInfo := TFormInfo(getForms[i]);
        if FormInfo.getTabIndex = ItemIndex then
        begin
          Form := FormInfo.getForm;
          Form.Close;
          Break;
        end;
      end;

    end;
  end;
end;

{ TFormInfo }

constructor TFormInfo.Create(var AForm: TForm;  AFormTabSet: TJcTDIForm);
begin
  setForm(AForm);
  FFormClose   := AForm.OnClose;
  FFormKeyDown := AForm.OnKeyDown;
  AForm.OnClose := formClose;
  AForm.OnKeyDown := FormKeyDown;
  setFormTabSet(AFormTabSet);
  setTabIndex(-1);
end;

procedure TFormInfo.createTab;
begin
  if getTabIndex = -1 then
  begin
    setTabIndex(getFormTabSet.getTabSet.Tabs.Add(FForm.Caption));
    getFormTabSet.getTabSet.TabIndex := getTabIndex;
  end;
  getForm.ManualDock(FTDIForm.getDockPanel);
end;

procedure TFormInfo.formClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(FFormClose) then
    FFormClose(Sender, Action);
  if Action <> caNone then
  begin
    if Sender is TForm then
    begin
      getFormTabSet.removeForm(TForm(Sender));
      TForm(Sender).OnClose := FFormClose;
    end;
  end;
end;

procedure TFormInfo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Assigned(FFormKeyDown) then
    FFormKeyDown(Sender, Key, Shift);
  if Sender is TForm then
    TForm(Sender).OnKeyDown := FFormKeyDown;
end;

function TFormInfo.getForm: TForm;
begin
  Result := FForm;
end;

function TFormInfo.getFormTabSet: TJcTDIForm;
begin
  Result := FTDIForm;
end;

function TFormInfo.getTabIndex: Integer;
begin
  Result := FTabIndex;
end;

procedure TFormInfo.setForm(AForm: TForm);
begin
  FForm := AForm;
end;

procedure TFormInfo.setFormTabSet(AFormTabSet: TJcTDIForm);
begin
  FTDIForm := AFormTabSet;
end;

procedure TFormInfo.setTabIndex(const Value: Integer);
begin
  FTabIndex := Value;
end;

{ TBackgroundImage }

constructor TBackgroundImage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SetSubComponent(True);
end;

end.
