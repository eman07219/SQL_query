select * from PortfolioProject..NashvilleHousing;

--This changes the format of the SaleDate attribute to look cleaner
select SaleDate, convert(Date, SaleDate) as SaleDateNew
From PortfolioProject..NashvilleHousing


--This adds a new attribute to the table
ALTER TABLE PortfolioProject..NashvilleHousing
ADD SaleDateCoverted Date;

--Deletes an the attribute if exists
ALTER TABLE PortfolioProject..NashvilleHousing
DROP COLUMN SaleDateCoverted;

--This will show which UniqueID values have a NULL for the PropertyAddress
select PropertyAddress , [UniqueID ]
from PortfolioProject..NashVilleHousing
where PropertyAddress is null;


--This is a join of two tables sharing similar 
select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
from PortfolioProject..NashvilleHousing a
join PortfolioProject..NashvilleHousing b
 on a.ParcelID = b.ParcelID
 AND a.[UniqueID] <> b.[UniqueID]
 where a.PropertyAddress is null;


 select PropertyAddress from PortfolioProject..NashvilleHousing

 --This will select the first half of the ',' and also select the last half of the ','
 select 
 SUBSTRING(PropertyAddress,1 ,CHARINDEX(',', PropertyAddress)-1) as Address
 ,SUBSTRING( PropertyAddress,CHARINDEX(',', PropertyAddress)+1, len(PropertyAddress)) as Address
 from PortfolioProject..NashvilleHousing



 ALTER TABLE PortfolioProject..NashvilleHousing
ADD PropertySplitAddress Nvarchar(255);

--Adds the first half of the ',' to the attribute PropertySplitAddress
UPDATE PortfolioProject..NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress,1 ,CHARINDEX(',', PropertyAddress)-1)


ALTER TABLE PortfolioProject..NashvilleHousing
ADD PropertySplitCity Nvarchar(255)

--Adds the second half of the ',' to PropertySplitCity
UPDATE PortfolioProject..NashvilleHousing
SET PropertySplitCity = SUBSTRING( PropertyAddress,CHARINDEX(',', PropertyAddress)+1, len(PropertyAddress))


select PropertySplitCity, PropertySplitAddress  from PortfolioProject..NashvilleHousing
