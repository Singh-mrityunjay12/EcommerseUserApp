import '../../../../routes/routes.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../shop/models/banners_model.dart';
import '../../../shop/models/brand_category_model.dart';
import '../../../shop/models/brand_model.dart';
import '../../../shop/models/category_model.dart';
import '../../../shop/models/product_attribute_model.dart';
import '../../../shop/models/product_category_model.dart';
import '../../../shop/models/product_model.dart';
import '../../../shop/models/product_variation_model.dart';

class MDummyData {
  //Banners
  static final List<BannersModel> banners = [
    BannersModel(
        imageUrl: MImage.banners1,
        targetScreen: MRoutes.order,
        name: "Banner1",
        active: false),
    BannersModel(
        imageUrl: MImage.banners2,
        targetScreen: MRoutes.cart,
        name: "Banner2",
        active: true),
    BannersModel(
        imageUrl: MImage.banners3,
        targetScreen: MRoutes.wishlist,
        name: "Banner3",
        active: true),
    BannersModel(
        imageUrl: MImage.banners4,
        targetScreen: MRoutes.search,
        name: "Banner4",
        active: true),
    BannersModel(
        imageUrl: MImage.banners5,
        targetScreen: MRoutes.settings,
        name: "Banner5",
        active: true),
    BannersModel(
        imageUrl: MImage.banners6,
        targetScreen: MRoutes.userAddress,
        name: "Banner6",
        active: true),
    BannersModel(
        imageUrl: MImage.banners7,
        targetScreen: MRoutes.checkOut,
        name: "Banner7",
        active: false),
  ];

  //User
  //Cart
  //Order

  //List of all Categories

  final List<CategoryModel> categories = [
    CategoryModel(
        id: '1', name: 'Sports', image: MImage.sportIcon, isFeatured: true),
    CategoryModel(
        id: '5',
        name: 'Furniture',
        image: MImage.furnitureIcon,
        isFeatured: true),
    CategoryModel(
        id: '2',
        name: 'Electronics',
        image: MImage.electronicIcon,
        isFeatured: true),
    CategoryModel(
        id: '3', name: 'Clothes', image: MImage.clothsIcon, isFeatured: true),
    CategoryModel(
        id: '4', name: 'Animals', image: MImage.animalIcon, isFeatured: true),
    CategoryModel(
        id: '6', name: 'Shoes', image: MImage.productImages9, isFeatured: true),
    CategoryModel(
        id: '7',
        name: 'Cosmetics',
        image: MImage.cosmeticsIcon,
        isFeatured: true),
    CategoryModel(
        id: '14', name: 'Jewelry', image: MImage.jewelryIcon, isFeatured: true),

    //Subcategories
    CategoryModel(
        id: '8',
        name: 'Sport Shoes',
        image: MImage.sportIcon,
        parentId: '1',
        isFeatured: false),
    CategoryModel(
        id: '9',
        name: 'Track Suits',
        image: MImage.sportIcon,
        parentId: '1',
        isFeatured: false),
    CategoryModel(
        id: '10',
        name: 'Sports Equipments',
        image: MImage.sportIcon,
        parentId: '1',
        isFeatured: false),

    //furniture
    CategoryModel(
        id: '11',
        name: 'Bedroom furniture',
        image: MImage.furnitureIcon,
        parentId: '5',
        isFeatured: false),
    CategoryModel(
        id: '12',
        name: 'Kitchen furniture',
        image: MImage.furnitureIcon,
        parentId: '5',
        isFeatured: false),
    CategoryModel(
        id: '13',
        name: 'Office furniture',
        image: MImage.furnitureIcon,
        parentId: '5',
        isFeatured: false),

    //electronics
    CategoryModel(
        id: '14',
        name: 'Laptop',
        image: MImage.electronicIcon,
        parentId: '2',
        isFeatured: false),
    CategoryModel(
        id: '15',
        name: 'Mobile',
        image: MImage.electronicIcon,
        parentId: '2',
        isFeatured: false),
    CategoryModel(
        id: '16',
        name: 'Tablet',
        image: MImage.electronicIcon,
        parentId: '2',
        isFeatured: false),
  ];

  //List of Brands
  static final List<BrandModel> brands = [
    BrandModel(
        id: '1',
        name: 'Nike',
        image: MImage.nikeBrand,
        isFeatured: true,
        productsCount: 18),
    BrandModel(
        id: '2',
        name: 'Acer',
        image: MImage.acerBrand,
        isFeatured: true,
        productsCount: 102),
    BrandModel(
        id: '3',
        name: 'Adidas',
        image: MImage.adidasBrand,
        isFeatured: true,
        productsCount: 40),
    BrandModel(
        id: '4',
        name: 'Apple',
        image: MImage.appleBrand,
        isFeatured: true,
        productsCount: 32),
    BrandModel(
        id: '5',
        name: 'Herman',
        image: MImage.hermanBrand,
        isFeatured: false,
        productsCount: 13),
    BrandModel(
        id: '6',
        name: 'Ikea',
        image: MImage.ikeaBrand,
        isFeatured: false,
        productsCount: 21),
    BrandModel(
        id: '7',
        name: 'Jordan',
        image: MImage.jordanBrand,
        isFeatured: true,
        productsCount: 10),
    BrandModel(
        id: '8',
        name: 'Kenwood',
        image: MImage.kenwoodBrand,
        isFeatured: false,
        productsCount: 0),
    BrandModel(
        id: '9',
        name: 'Puma',
        image: MImage.pumaBrand,
        isFeatured: true,
        productsCount: 36),
    BrandModel(
        id: '10',
        name: 'Zara',
        image: MImage.zaraBrand,
        isFeatured: true,
        productsCount: 25),
  ];

  //List of all Products

  static final List<ProductModel> products = [
    ProductModel(
        id: '001',
        title: 'Green Nike sports shoe',
        stock: 15,
        price: 135,
        isFeatured: true,
        thumbnail: MImage.productImages12,
        description: 'Green Nike sports shoe',
        brand: BrandModel(
            id: '1',
            name: 'Nike',
            image: MImage.nikeLogo,
            productsCount: 256,
            isFeatured: true),
        images: [
          MImage.productImages12,
          MImage.productImages10,
          MImage.productImages9,
          MImage.productImages13,
          MImage.productImages11
        ],
        salePrice: 30,
        sku: 'ABR4568',
        categoryId: '1',
        productAttributes: [
          ProductAttributeModel(
              name: 'Color', values: ['Green', 'Black', 'Red']),
          ProductAttributeModel(
              name: 'Size', values: ['EU 30', 'EU 32', 'EU 34']),
        ],
        productVariations: [
          ProductVariationModel(
              id: '1',
              stock: 34,
              price: 134,
              salePrice: 122.6,
              image: MImage.productImages12,
              description:
                  'This is a Product description for Green Nike sport shoe.',
              attributeValues: {'Color': 'Green', 'Size': 'EU 34'}),
          ProductVariationModel(
              id: '2',
              stock: 15,
              price: 132,
              image: MImage.productImages9,
              description:
                  'This is a Product description for Black Nike sport shoe.',
              attributeValues: {'Color': 'Black', 'Size': 'EU 32'}),
          ProductVariationModel(
              id: '3',
              stock: 0,
              price: 234,
              image: MImage.productImages9,
              attributeValues: {'Color': 'Black', 'Size': 'EU 34'}),
          ProductVariationModel(
              id: '4',
              stock: 222,
              price: 232,
              image: MImage.productImages12,
              attributeValues: {'Color': 'Green', 'Size': 'EU 32'}),
          ProductVariationModel(
              id: '5',
              stock: 0,
              price: 334,
              image: MImage.productImages10,
              attributeValues: {'Color': 'Red', 'Size': 'EU 34'}),
          ProductVariationModel(
              id: '6',
              stock: 11,
              price: 332,
              image: MImage.productImages10,
              attributeValues: {'Color': 'Red', 'Size': 'EU 32'}),
        ],
        productType: 'ProductType.variable'),
    ProductModel(
        id: '002',
        title: 'Green T-shirt for all ages',
        stock: 15,
        price: 35,
        isFeatured: true,
        thumbnail: MImage.productImages25,
        description:
            'This is Product description for Green Nike Sleave less vest. There are more things that can added but i am just practicing and nothing else.',
        brand: BrandModel(id: '10', name: 'Zara', image: MImage.zaraLogo),
        images: [
          MImage.productImages25,
          MImage.productImages15,
          MImage.productImages16
        ],
        salePrice: 30,
        sku: 'ABR4568',
        categoryId: '3',
        productAttributes: [
          ProductAttributeModel(
              name: 'Color', values: ['Green', 'Red', 'Blue']),
          ProductAttributeModel(
            name: 'Size',
            values: ['EU 34', 'EU 32'],
          ),
        ],
        productType: 'ProductType.single'),
    ProductModel(
        id: '003',
        title: 'Leather brown Jacket',
        stock: 15,
        price: 3800,
        thumbnail: MImage.productImages19,
        description:
            'This is Product description for Leather brown Jacket. There are more things that can added but i am just practicing and nothing else.',
        brand: BrandModel(id: '10', name: 'Zara', image: MImage.zaraLogo),
        images: [
          MImage.productImages19,
          MImage.productImages20,
          MImage.productImages21,
          MImage.productImages22
        ],
        salePrice: 30,
        sku: 'ABR4568',
        categoryId: '4',
        productAttributes: [
          ProductAttributeModel(
              name: 'Color', values: ['Green', 'Red', 'Blue']),
          ProductAttributeModel(
            name: 'Size',
            values: ['EU 34', 'EU 32'],
          ),
        ],
        productType: 'ProductType.single'),
    ProductModel(
        id: '004',
        title: '4 Color collar t-shirt dry fit ',
        stock: 15,
        price: 335,
        isFeatured: false,
        thumbnail: MImage.productImages15,
        description:
            'This is Product description for 4 color collar t-shirt dry fit. There are more things that can added but i am just practicing and nothing else.',
        brand: BrandModel(id: '10', name: 'Zara', image: MImage.zaraLogo),
        images: [
          MImage.productImages15,
          MImage.productImages25,
          MImage.product4,
          MImage.productImages23,
        ],
        salePrice: 30,
        sku: 'ABR4568',
        categoryId: '4',
        productAttributes: [
          ProductAttributeModel(
              name: 'Color', values: ['Red', 'Yellow', 'Green', 'Blue']),
          ProductAttributeModel(
            name: 'Size',
            values: ['EU 34', 'EU 32'],
          ),
        ],
        productVariations: [
          ProductVariationModel(
              id: '1',
              stock: 34,
              price: 134,
              salePrice: 122.6,
              image: MImage.productImages15,
              description:
                  'This is a Product descriptions for 4 Color collar t-shirt dry-fit',
              attributeValues: {'Color': 'Red', 'Size': 'EU 34'}),
          ProductVariationModel(
              id: '2',
              stock: 15,
              price: 134,
              image: MImage.productImages15,
              attributeValues: {'Color': 'Red', 'Size': 'EU 32'}),
          ProductVariationModel(
              id: '3',
              stock: 0,
              price: 234,
              image: MImage.productImages25,
              attributeValues: {'Color': 'Yellow', 'Size': 'EU 34'}),
          ProductVariationModel(
              id: '4',
              stock: 10,
              price: 139,
              image: MImage.productImages25,
              attributeValues: {'Color': 'Yellow', 'Size': 'EU 32'}),
          ProductVariationModel(
              id: '5',
              stock: 0,
              price: 334,
              image: MImage.product4,
              attributeValues: {'Color': 'Green', 'Size': 'EU 34'}),
          ProductVariationModel(
              id: '6',
              stock: 11,
              price: 332,
              image: MImage.product4,
              attributeValues: {'Color': 'Green', 'Size': 'EU 30'}),
          ProductVariationModel(
              id: '7',
              stock: 0,
              price: 334,
              image: MImage.productImages23,
              attributeValues: {'Color': 'Blue', 'Size': 'EU 34'}),
          ProductVariationModel(
              id: '8',
              stock: 11,
              price: 332,
              image: MImage.productImages23,
              attributeValues: {'Color': 'Blue', 'Size': 'EU 30'}),
        ],
        productType: 'ProductType.variable'),
    ProductModel(
        id: '005',
        title: 'Football Fun, Second to None',
        stock: 10,
        price: 2470,
        thumbnail: MImage.footballLogo,
        description:
            'This is Product description for Football Sport. There are more things that can added but i am just practicing and nothing else.',
        brand: BrandModel(id: '3', name: 'Adidas', image: MImage.adidasBrand),
        images: [
          MImage.footballLogo1,
          MImage.footballLogo2,
          MImage.footballLogo3
        ],
        salePrice: 2310,
        sku: 'ABR4568',
        categoryId: '5',
        productAttributes: [
          ProductAttributeModel(
              name: 'Color', values: ['Green', 'Red', 'Blue']),
          ProductAttributeModel(
            name: 'Size',
            values: ['EU 34', 'EU 32'],
          ),
        ],
        productType: 'ProductType.single'),
    ProductModel(
        id: '006',
        title: "Baseball-It's Not Just A Game",
        stock: 23,
        price: 1470,
        thumbnail: MImage.baseballLogo,
        description:
            'This is Product description for BasBall Sport. There are more things that can added but i am just practicing and nothing else.',
        brand: BrandModel(id: '3', name: 'Adidas', image: MImage.adidasBrand),
        images: [
          MImage.baseballLogo1,
          MImage.baseballLogo2,
          MImage.baseballLogo3
        ],
        salePrice: 1300,
        sku: 'ABR4568',
        categoryId: '5',
        productAttributes: [
          ProductAttributeModel(
              name: 'Color', values: ['Green', 'Red', 'Blue']),
          ProductAttributeModel(
            name: 'Size',
            values: ['EU 34', 'EU 32'],
          ),
        ],
        productType: 'ProductType.single'),
    ProductModel(
        id: '007',
        title:
            "Cricket has several exciting formats, each bringing a unique flavor and thrill",
        stock: 10,
        price: 1999,
        thumbnail: MImage.cricketBatLogo,
        description:
            'This is Product description for Cricket Sport. There are more things that can added but i am just practicing and nothing else.',
        brand: BrandModel(id: '3', name: 'Adidas', image: MImage.adidasBrand),
        images: [
          MImage.cricketBatLogo1,
          MImage.cricketBatLogo2,
          MImage.cricketBatLogo3
        ],
        salePrice: 1899,
        sku: 'ABR4568',
        categoryId: '6',
        productAttributes: [
          ProductAttributeModel(
              name: 'Color', values: ['Green', 'Red', 'Blue']),
          ProductAttributeModel(
            name: 'Size',
            values: ['EU 34', 'EU 32'],
          ),
        ],
        productType: 'ProductType.single'),
    ProductModel(
        id: '008',
        title: "Nike Sport shoes...",
        stock: 10,
        price: 2150,
        thumbnail: MImage.nikeSportShoes,
        description:
            'This is Product description for Nike Sport shoes. There are more things that can added but i am just practicing and nothing else.',
        brand: BrandModel(id: '1', name: 'Nike', image: MImage.nikeBrand),
        images: [
          MImage.nikeSportShoes1,
          MImage.productImages13,
          MImage.productImages11
        ],
        salePrice: 2100,
        sku: 'ABR4568',
        categoryId: '6',
        productAttributes: [
          ProductAttributeModel(
              name: 'Color', values: ['Green', 'Red', 'Blue']),
          ProductAttributeModel(
            name: 'Size',
            values: ['EU 34', 'EU 32'],
          ),
        ],
        productType: 'ProductType.single'),
    ProductModel(
        id: '009',
        title: "Nike Sport shoes...",
        stock: 13,
        price: 2050,
        thumbnail: MImage.nikeSportShoes1,
        description:
            'This is Product description for Nike Sport shoes. There are more things that can added but i am just practicing and nothing else.',
        brand: BrandModel(id: '1', name: 'Nike', image: MImage.nikeBrand),
        images: [
          MImage.productImages12,
          MImage.productImages10,
          MImage.productImages13,
        ],
        salePrice: 2000,
        sku: 'ABR4568',
        categoryId: '7',
        productAttributes: [
          ProductAttributeModel(
              name: 'Color', values: ['Green', 'Red', 'Blue']),
          ProductAttributeModel(
            name: 'Size',
            values: ['EU 34', 'EU 32'],
          ),
        ],
        productType: 'ProductType.single'),
    ProductModel(
        id: '010',
        title: "Modern Classic Furnishings....",
        stock: 13,
        price: 46450,
        thumbnail: MImage.bedRoomProduct1,
        description:
            'This is Product description for Classical Bedroom. There are more things that can added but i am just practicing and nothing else.',
        brand: BrandModel(id: '6', name: 'IKEA', image: MImage.ikeaBrand),
        images: [
          MImage.bedRoomProduct2,
          MImage.bedRoomProduct3,
          MImage.bedRoomProduct4,
          MImage.bedRoomProduct5
        ],
        salePrice: 41450,
        sku: 'ABR4568',
        categoryId: '8',
        productAttributes: [
          ProductAttributeModel(
              name: 'Color', values: ['Black', 'Red', 'Grey', 'Brown']),
          ProductAttributeModel(
            name: 'Size',
            values: ['120 SQ', '224 SQ', '144 SQ'],
          ),
        ],
        productType: 'ProductType.single'),
    ProductModel(
        id: '011',
        title: "Night Glow Ambiance....",
        stock: 13,
        price: 1899,
        thumbnail: MImage.bedRoomLamp1,
        description:
            'This is Product description for IKEA Bedroom Lamps. There are more things that can added but i am just practicing and nothing else.',
        brand: BrandModel(id: '6', name: 'IKEA', image: MImage.ikeaBrand),
        images: [
          MImage.bedRoomLamp2,
          MImage.bedRoomLamp3,
          MImage.bedRoomLamp4,
        ],
        salePrice: 1499,
        sku: 'ABR4568',
        categoryId: '8',
        productAttributes: [
          ProductAttributeModel(
              name: 'Color', values: ['Brown', 'White', 'Grey']),
          ProductAttributeModel(
            name: 'Size',
            values: ['35.5x20x21.5 cms', '37.5x21x20.5 cms'],
          ),
        ],
        productType: 'ProductType.single'),
    ProductModel(
        id: '012',
        title: "Ikea Bedroom door...",
        stock: 10,
        price: 37330,
        thumbnail: MImage.bedRoomDoor1,
        description:
            'This is Product description for Ikea Brand classical Bedroom door . There are more things that can added but i am just practicing and nothing else.',
        brand: BrandModel(id: '6', name: 'IKEA', image: MImage.ikeaBrand),
        images: [
          MImage.bedRoomDoor2,
          MImage.bedRoomDoor3,
          MImage.bedRoomDoor4,
        ],
        salePrice: 30120,
        sku: 'ABR4568',
        categoryId: '9',
        productAttributes: [
          ProductAttributeModel(
              name: 'Color', values: ['Grey', 'Brown', 'White']),
          ProductAttributeModel(
            name: 'Size',
            values: ['7 * 5 ft', '6.5 * 5 ft'],
          ),
        ],
        productType: 'ProductType.single'),
    ProductModel(
        id: '013',
        title: "Acer Gaming Laptop....",
        stock: 20,
        price: 54990,
        thumbnail: MImage.acerLaptop1,
        description:
            'This is Product description for Acer Gaming Laptop. There are more things that can added but i am just practicing and nothing else.',
        brand: BrandModel(id: '2', name: 'Nike', image: MImage.acerBrand),
        images: [
          MImage.acerLaptop2,
          MImage.acerLaptop3,
          MImage.acerLaptop4,
        ],
        salePrice: 50054,
        sku: 'ABR4568',
        categoryId: '9',
        productAttributes: [
          ProductAttributeModel(
              name: 'Color', values: ['Red', 'Brown', 'White', 'Black']),
          ProductAttributeModel(
            name: 'Size',
            values: ['15.6 Inch', '15.9 Inch'],
          ),
        ],
        productType: 'ProductType.single'),
    ProductModel(
        id: '014',
        title: "Apple Classical Phone....",
        stock: 20,
        price: 45200,
        thumbnail: MImage.applePhone1,
        description:
            'This is Product description for Apple Phone. There are more things that can added but i am just practicing and nothing else.',
        brand: BrandModel(id: '4', name: 'Apple', image: MImage.appleBrand),
        images: [
          MImage.applePhone2,
          MImage.applePhone3,
          MImage.applePhone4,
        ],
        salePrice: 40010,
        sku: 'ABR4568',
        categoryId: '10',
        productAttributes: [
          ProductAttributeModel(
              name: 'Color', values: ['Red', 'Brown', 'White', 'Black']),
          ProductAttributeModel(
            name: 'Size',
            values: ['6.1 Inch', '5.9 Inch'],
          ),
        ],
        productType: 'ProductType.single'),
  ];

  //Category & Brand relationship

  static final List<BrandCategoryModel> brandCategory = [
    BrandCategoryModel(brandId: '1', categoryId: '1'),
    BrandCategoryModel(brandId: '3', categoryId: '1'),
    BrandCategoryModel(brandId: '10', categoryId: '2'),
    BrandCategoryModel(brandId: '3', categoryId: '2'),
    BrandCategoryModel(brandId: '1', categoryId: '3'),
    BrandCategoryModel(brandId: '3', categoryId: '3'),
    BrandCategoryModel(brandId: '10', categoryId: '4'),
    BrandCategoryModel(brandId: '3', categoryId: '4'),
    BrandCategoryModel(brandId: '1', categoryId: '5'),
    BrandCategoryModel(brandId: '3', categoryId: '5'),
    BrandCategoryModel(brandId: '10', categoryId: '6'),
    BrandCategoryModel(brandId: '3', categoryId: '6'),
    BrandCategoryModel(brandId: '1', categoryId: '7'),
    BrandCategoryModel(brandId: '3', categoryId: '7'),
    BrandCategoryModel(brandId: '10', categoryId: '8'),
    BrandCategoryModel(brandId: '3', categoryId: '8'),
  ];

  //Category & Product relationship

  static final List<ProductCategoryModel> productCategory = [
    //Category 1
    ProductCategoryModel(productId: '001', categoryId: '1'),
    ProductCategoryModel(productId: '003', categoryId: '1'),
    ProductCategoryModel(productId: '005', categoryId: '1'),
    ProductCategoryModel(productId: '006', categoryId: '1'),
    ProductCategoryModel(productId: '007', categoryId: '1'),
    ProductCategoryModel(productId: '008', categoryId: '1'),
    ProductCategoryModel(productId: '009', categoryId: '1'),

    //Category 2
    ProductCategoryModel(productId: '005', categoryId: '2'),
    ProductCategoryModel(productId: '006', categoryId: '2'),
    ProductCategoryModel(productId: '007', categoryId: '2'),
    ProductCategoryModel(productId: '008', categoryId: '2'),
    ProductCategoryModel(productId: '009', categoryId: '2'),

    //Category 3
    ProductCategoryModel(productId: '001', categoryId: '3'),
    ProductCategoryModel(productId: '003', categoryId: '3'),
    ProductCategoryModel(productId: '005', categoryId: '3'),
    ProductCategoryModel(productId: '006', categoryId: '3'),
    ProductCategoryModel(productId: '007', categoryId: '3'),

    //Category 4
    ProductCategoryModel(productId: '001', categoryId: '4'),
    ProductCategoryModel(productId: '002', categoryId: '4'),
    ProductCategoryModel(productId: '005', categoryId: '4'),
    ProductCategoryModel(productId: '006', categoryId: '4'),
    ProductCategoryModel(productId: '007', categoryId: '4'),

    //Category5
    ProductCategoryModel(productId: '001', categoryId: '5'),
    ProductCategoryModel(productId: '002', categoryId: '5'),
    ProductCategoryModel(productId: '005', categoryId: '5'),
    ProductCategoryModel(productId: '006', categoryId: '5'),
    ProductCategoryModel(productId: '007', categoryId: '5'),

    //Category 6
    ProductCategoryModel(productId: '005', categoryId: '6'),
    ProductCategoryModel(productId: '006', categoryId: '6'),
    ProductCategoryModel(productId: '007', categoryId: '6'),
    ProductCategoryModel(productId: '008', categoryId: '6'),
    ProductCategoryModel(productId: '009', categoryId: '6'),

    //Category 7
    ProductCategoryModel(productId: '001', categoryId: '7'),
    ProductCategoryModel(productId: '002', categoryId: '7'),
    ProductCategoryModel(productId: '005', categoryId: '7'),
    ProductCategoryModel(productId: '006', categoryId: '7'),
    ProductCategoryModel(productId: '007', categoryId: '7'),

    //Category 8
    ProductCategoryModel(productId: '001', categoryId: '8'),
    ProductCategoryModel(productId: '008', categoryId: '8'),
    ProductCategoryModel(productId: '009', categoryId: '8'),
    ProductCategoryModel(productId: '002', categoryId: '8'),

    //Category 9
    ProductCategoryModel(productId: '002', categoryId: '9'),
    ProductCategoryModel(productId: '003', categoryId: '9'),
    ProductCategoryModel(productId: '004', categoryId: '9'),
    ProductCategoryModel(productId: '006', categoryId: '9'),

    //Category 10
    ProductCategoryModel(productId: '005', categoryId: '10'),
    ProductCategoryModel(productId: '006', categoryId: '10'),
    ProductCategoryModel(productId: '007', categoryId: '10'),
    ProductCategoryModel(productId: '003', categoryId: '10'),

    //Category 11
    ProductCategoryModel(productId: '010', categoryId: '11'),
    ProductCategoryModel(productId: '011', categoryId: '11'),
    ProductCategoryModel(productId: '012', categoryId: '11'),
    ProductCategoryModel(productId: '013', categoryId: '11'),

    //Category 12
    ProductCategoryModel(productId: '011', categoryId: '12'),
    ProductCategoryModel(productId: '012', categoryId: '12'),
    ProductCategoryModel(productId: '013', categoryId: '12'),
    ProductCategoryModel(productId: '014', categoryId: '12'),

    //Category 13
    ProductCategoryModel(productId: '011', categoryId: '13'),
    ProductCategoryModel(productId: '012', categoryId: '13'),
    ProductCategoryModel(productId: '013', categoryId: '13'),
    ProductCategoryModel(productId: '014', categoryId: '13'),

    //Category 13
    ProductCategoryModel(productId: '011', categoryId: '13'),
    ProductCategoryModel(productId: '012', categoryId: '13'),
    ProductCategoryModel(productId: '013', categoryId: '13'),
    ProductCategoryModel(productId: '014', categoryId: '13'),

    //Category 14
    ProductCategoryModel(productId: '014', categoryId: '14'),
    ProductCategoryModel(productId: '006', categoryId: '14'),
    ProductCategoryModel(productId: '007', categoryId: '14'),
    ProductCategoryModel(productId: '013', categoryId: '14'),

    //Category 15
    ProductCategoryModel(productId: '014', categoryId: '15'),
    ProductCategoryModel(productId: '013', categoryId: '15'),
    ProductCategoryModel(productId: '012', categoryId: '15'),
    ProductCategoryModel(productId: '011', categoryId: '15'),

    //Category 16
    ProductCategoryModel(productId: '011', categoryId: '16'),
    ProductCategoryModel(productId: '013', categoryId: '16'),
    ProductCategoryModel(productId: '012', categoryId: '16'),
    ProductCategoryModel(productId: '014', categoryId: '16'),
  ];
}
