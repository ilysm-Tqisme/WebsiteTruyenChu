package model;

import java.util.Objects;

public class TruyenTheLoai {
    private int truyenId;
    private int theLoaiId;

    public TruyenTheLoai() {}

    public int getTruyenId() { return truyenId; }
    public void setTruyenId(int truyenId) { this.truyenId = truyenId; }

    public int getTheLoaiId() { return theLoaiId; }
    public void setTheLoaiId(int theLoaiId) { this.theLoaiId = theLoaiId; }

    @Override
public boolean equals(Object o) {
    if (this == o) return true;
    if (!(o instanceof TruyenTheLoai)) return false;
    TruyenTheLoai that = (TruyenTheLoai) o;
    return truyenId == that.truyenId && theLoaiId == that.theLoaiId;
}

    @Override
    public int hashCode() {
        return Objects.hash(truyenId, theLoaiId);
    }

    @Override
    public String toString() {
        return "TruyenTheLoai{" +
           "truyenId=" + truyenId +
           ", theLoaiId=" + theLoaiId +
           '}';
    }
}

