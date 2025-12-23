-- Tạo bảng Yêu thích
CREATE TABLE YeuThich (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    NguoiDungID INT FOREIGN KEY REFERENCES NguoiDung(ID) ON DELETE CASCADE,
    TruyenID INT FOREIGN KEY REFERENCES Truyen(ID) ON DELETE CASCADE,
    NgayYeuThich DATETIME DEFAULT GETDATE(),
    CONSTRAINT UQ_YeuThich_NguoiDung_Truyen UNIQUE (NguoiDungID, TruyenID)
);

-- Tạo index để tối ưu performance
CREATE INDEX IX_YeuThich_NguoiDungID ON YeuThich(NguoiDungID);
CREATE INDEX IX_YeuThich_TruyenID ON YeuThich(TruyenID);
CREATE INDEX IX_YeuThich_NgayYeuThich ON YeuThich(NgayYeuThich);

-- Tạo bảng TuTruyen (nếu chưa có)
CREATE TABLE TuTruyen (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    NguoiDungID INT FOREIGN KEY REFERENCES NguoiDung(ID) ON DELETE CASCADE,
    TruyenID INT FOREIGN KEY REFERENCES Truyen(ID) ON DELETE CASCADE,
    NgayLuu DATETIME DEFAULT GETDATE(),
    CONSTRAINT UQ_TuTruyen_NguoiDung_Truyen UNIQUE (NguoiDungID, TruyenID)
);

-- Tạo index cho TuTruyen
CREATE INDEX IX_TuTruyen_NguoiDungID ON TuTruyen(NguoiDungID);
CREATE INDEX IX_TuTruyen_TruyenID ON TuTruyen(TruyenID);
CREATE INDEX IX_TuTruyen_NgayLuu ON TuTruyen(NgayLuu);
