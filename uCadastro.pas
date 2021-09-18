unit uCadastro;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
    FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
    FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
    FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, Data.DB, Vcl.Grids,
    Vcl.DBGrids, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
    FireDAC.Phys.MongoDBDataSet, Vcl.StdCtrls, FireDAC.Phys.MongoDB,
    FireDAC.Phys.MongoDBDef, System.Rtti, System.JSON.Types, System.JSON.Readers,
    System.JSON.BSON, System.JSON.Builders, FireDAC.Phys.MongoDBWrapper,
    FireDAC.Comp.UI, FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef, FireDAC.DApt,
    FireDAC.Phys.ODBCBase, Vcl.ExtCtrls;

type
    TfrmCadastro = class(TForm)
        DBGrid1: TDBGrid;
        FDQuery1: TFDQuery;
        DataSource1: TDataSource;
        FDConnection1: TFDConnection;
        fdConexaoMssql: TFDConnection;
        FDMongoDataSet1: TFDMongoDataSet;
        DBGrid2: TDBGrid;
        FDQuery1AddressID: TFDAutoIncField;
        FDQuery1AddressLine1: TWideStringField;
        FDQuery1AddressLine2: TWideStringField;
        FDQuery1City: TWideStringField;
        FDQuery1StateProvinceID: TIntegerField;
        FDQuery1PostalCode: TWideStringField;
        FDQuery1SpatialLocation: TBlobField;
        FDQuery1rowguid: TGuidField;
        FDQuery1ModifiedDate: TSQLTimeStampField;
        DataSource2: TDataSource;
        lblMongo: TLabel;
        Label1: TLabel;
    Panel1: TPanel;
    btnDeleteMongo: TButton;
    btnInsertMongo: TButton;
    btnUpdateMongo: TButton;
    btnSelectMongo: TButton;
    btnAbrirMssql: TButton;
    btnFechar: TButton;
        procedure btnSelectMongoClick(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        procedure btnAbrirMssqlClick(Sender: TObject);
        procedure btnInsertMongoClick(Sender: TObject);
        procedure btnDeleteMongoClick(Sender: TObject);
        procedure btnUpdateMongoClick(Sender: TObject);
        procedure btnFecharClick(Sender: TObject);
        private
            { Private declarations }
        public
            { Public declarations }
            FMongoConn: TMongoConnection;
    end;

var
      frmCadastro: TfrmCadastro;

implementation

{$R *.dfm}


procedure TfrmCadastro.btnSelectMongoClick(Sender: TObject);
begin
    FDConnection1.Connected := True;
    FMongoConn := TMongoConnection(FDConnection1.CliObj);
    FDMongoDataSet1.Close;
    FDMongoDataSet1.Cursor := FMongoConn['AdventureWorks']['Address'].Find();
    { .Match()
      .Add('cidade', 'Seattle')
      .Project()
      .Field('endereco', True)
      .Field('cidade', True)
      .Field('_id', false)
      .&End; }
    FDMongoDataSet1.Open;

    frmCadastro.Caption := IntToStr(FDMongoDataSet1.RecordCount);
end;

procedure TfrmCadastro.btnAbrirMssqlClick(Sender: TObject);
begin
    FDQuery1.Close;
    FDQuery1.Open;
end;

procedure TfrmCadastro.btnInsertMongoClick(Sender: TObject);
begin

    FDQuery1.First;
    while not(FDQuery1.Eof) do
        begin
            FDConnection1.Connected := True;
            FMongoConn := TMongoConnection(FDConnection1.CliObj);
            FDMongoDataSet1.Close;
            FMongoConn['AdventureWorks']['Address'].Insert()
              .Values()
              .Add('endereco', FDQuery1AddressLine1.Value)
              .Add('cidade', FDQuery1City.Value)
              .Add('cep', FDQuery1PostalCode.Value)
              .&End
              .Exec;
            FDQuery1.Next;
        end;

    btnSelectMongo.click;
end;

procedure TfrmCadastro.btnUpdateMongoClick(Sender: TObject);
begin
    FMongoConn['AdventureWorks']['Address'].Update()
      .Match()
      .Add('cidade', 'Duque de Caxias')
      .&End
      .Modify()
      .&Set()
      .Field('cidade', 'Monroe')
      .&End
      .&End
      .Exec;

    btnSelectMongo.click;
end;

procedure TfrmCadastro.btnDeleteMongoClick(Sender: TObject);
begin
    FMongoConn['AdventureWorks']['Address'].Remove().Exec;
    { .Match()
      .Add('cidade', 'Portland')
      .&End
      .Exec; }

    btnSelectMongo.click;

end;

procedure TfrmCadastro.btnFecharClick(Sender: TObject);
begin
    Close;
end;

procedure TfrmCadastro.FormCreate(Sender: TObject);
begin
    fdConexaoMssql.Connected := True;
    FDConnection1.Connected := True;
    FMongoConn := TMongoConnection(FDConnection1.CliObj);
end;

end.
