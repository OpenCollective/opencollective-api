toc.dat                                                                                             0000600 0004000 0002000 00000175305 13174451173 0014460 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        PGDMP       
                	    u           wwcode_test    9.6.5    10.0 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false         �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false         �           1262    1631700    wwcode_test    DATABASE     }   CREATE DATABASE wwcode_test WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';
    DROP DATABASE wwcode_test;
             opencollective    false                     2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false         �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    4                     3079    12655    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false         �           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1                     3079    1631701    postgis 	   EXTENSION     ;   CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;
    DROP EXTENSION postgis;
                  false    4         �           0    0    EXTENSION postgis    COMMENT     g   COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';
                       false    2         1           1247    1633674    enum_Groups_membership_type    TYPE     i   CREATE TYPE "enum_Groups_membership_type" AS ENUM (
    'donation',
    'monthlyfee',
    'yearlyfee'
);
 0   DROP TYPE public."enum_Groups_membership_type";
       public       aseem    false    4         4           1247    1633682    enum_UserGroups_role    TYPE     X   CREATE TYPE "enum_UserGroups_role" AS ENUM (
    'admin',
    'writer',
    'viewer'
);
 )   DROP TYPE public."enum_UserGroups_role";
       public       aseem    false    4         �            1259    1633689 
   Activities    TABLE     �   CREATE TABLE "Activities" (
    id integer NOT NULL,
    type character varying(255),
    data json,
    "createdAt" timestamp with time zone,
    "CollectiveId" integer,
    "UserId" integer,
    "TransactionId" integer
);
     DROP TABLE public."Activities";
       public         opencollective    false    4         �            1259    1633695    Activities_id_seq    SEQUENCE     u   CREATE SEQUENCE "Activities_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."Activities_id_seq";
       public       opencollective    false    4    201         �           0    0    Activities_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE "Activities_id_seq" OWNED BY "Activities".id;
            public       opencollective    false    202         �            1259    1633710    PaymentMethods    TABLE     �  CREATE TABLE "PaymentMethods" (
    id integer NOT NULL,
    name character varying(255),
    token character varying(255),
    "customerId" character varying(255),
    service character varying(255) DEFAULT 'stripe'::character varying,
    data json,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "confirmedAt" timestamp with time zone,
    "deletedAt" timestamp with time zone,
    "CreatedByUserId" integer,
    "expiryDate" timestamp with time zone,
    uuid uuid,
    "CollectiveId" integer,
    "archivedAt" timestamp with time zone,
    "monthlyLimitPerMember" integer,
    "primary" boolean DEFAULT false,
    currency character varying(3)
);
 $   DROP TABLE public."PaymentMethods";
       public         opencollective    false    4         �            1259    1633717    Cards_id_seq    SEQUENCE     p   CREATE SEQUENCE "Cards_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public."Cards_id_seq";
       public       opencollective    false    203    4         �           0    0    Cards_id_seq    SEQUENCE OWNED BY     <   ALTER SEQUENCE "Cards_id_seq" OWNED BY "PaymentMethods".id;
            public       opencollective    false    204         �            1259    1633771    CollectiveHistories    TABLE       CREATE TABLE "CollectiveHistories" (
    id integer,
    name character varying(255),
    description character varying(255),
    currency character varying(255),
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "deletedAt" timestamp with time zone,
    "isActive" boolean,
    "longDescription" text,
    image character varying(255),
    slug character varying(255),
    website character varying(255),
    "twitterHandle" character varying(255),
    mission character varying(255),
    "backgroundImage" character varying(255),
    "hostFeePercent" double precision,
    settings json,
    data json,
    tags character varying(255)[],
    "isSupercollective" boolean,
    "LastEditedByUserId" integer,
    hid bigint NOT NULL,
    "archivedAt" timestamp with time zone NOT NULL,
    "CreatedByUserId" integer,
    "HostCollectiveId" integer,
    "ParentCollectiveId" integer,
    type character varying(255) DEFAULT 'COLLECTIVE'::character varying,
    "startsAt" timestamp with time zone,
    "endsAt" timestamp with time zone,
    "locationName" character varying(255),
    address character varying(255),
    timezone character varying(255),
    "maxAmount" integer,
    "maxQuantity" integer,
    "geoLocationLatLong" geometry(Point)
);
 )   DROP TABLE public."CollectiveHistories";
       public         opencollective    false    2    4    2    4    2    4    2    4    2    4    2    4    2    4    2    4    4         �            1259    1633779    Collectives    TABLE     �  CREATE TABLE "Collectives" (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    currency character varying(255) DEFAULT 'USD'::character varying,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "deletedAt" timestamp with time zone,
    "isActive" boolean DEFAULT false,
    "longDescription" text,
    image character varying(255),
    slug character varying(255),
    website character varying(255),
    "twitterHandle" character varying(255),
    mission character varying(128),
    "backgroundImage" character varying(255),
    "hostFeePercent" double precision,
    settings json,
    data json,
    tags character varying(255)[],
    "isSupercollective" boolean DEFAULT false,
    "LastEditedByUserId" integer,
    "CreatedByUserId" integer,
    "HostCollectiveId" integer,
    "ParentCollectiveId" integer,
    type character varying(255) DEFAULT 'COLLECTIVE'::character varying,
    "startsAt" timestamp with time zone,
    "endsAt" timestamp with time zone,
    "locationName" character varying(255),
    address character varying(255),
    timezone character varying(255),
    "maxAmount" integer,
    "maxQuantity" integer,
    "geoLocationLatLong" geometry(Point)
);
 !   DROP TABLE public."Collectives";
       public         opencollective    false    4    2    4    2    4    2    4    2    4    2    4    2    4    2    4    2    4         �            1259    1633727    ConnectedAccounts    TABLE     �  CREATE TABLE "ConnectedAccounts" (
    id integer NOT NULL,
    service character varying(255),
    username character varying(255),
    "clientId" character varying(255),
    token character varying(255),
    data json,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "deletedAt" timestamp with time zone,
    "CreatedByUserId" integer,
    "CollectiveId" integer,
    "refreshToken" character varying(255)
);
 '   DROP TABLE public."ConnectedAccounts";
       public         opencollective    false    4         �            1259    1633733    ConnectedAccounts_id_seq    SEQUENCE     |   CREATE SEQUENCE "ConnectedAccounts_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public."ConnectedAccounts_id_seq";
       public       opencollective    false    4    205         �           0    0    ConnectedAccounts_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE "ConnectedAccounts_id_seq" OWNED BY "ConnectedAccounts".id;
            public       opencollective    false    206         �            1259    1633735    Orders    TABLE     q  CREATE TABLE "Orders" (
    id integer NOT NULL,
    "CreatedByUserId" integer,
    "CollectiveId" integer,
    currency character varying(255) DEFAULT 'USD'::character varying,
    "totalAmount" integer,
    description character varying(255),
    "SubscriptionId" integer,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "deletedAt" timestamp with time zone,
    "PaymentMethodId" integer,
    "processedAt" timestamp with time zone,
    "privateMessage" text,
    "TierId" integer,
    "FromCollectiveId" integer,
    "publicMessage" character varying(255),
    quantity integer
);
    DROP TABLE public."Orders";
       public         opencollective    false    4         �            1259    1633743    Donations_id_seq    SEQUENCE     t   CREATE SEQUENCE "Donations_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public."Donations_id_seq";
       public       opencollective    false    4    207         �           0    0    Donations_id_seq    SEQUENCE OWNED BY     8   ALTER SEQUENCE "Donations_id_seq" OWNED BY "Orders".id;
            public       opencollective    false    208         �            1259    1633754    ExpenseHistories    TABLE     �  CREATE TABLE "ExpenseHistories" (
    id integer,
    "UserId" integer,
    "CollectiveId" integer,
    currency character varying(255),
    amount integer,
    description character varying(255),
    "payoutMethod" character varying(255),
    "privateMessage" text,
    attachment character varying(255),
    category character varying(255),
    vat integer,
    "lastEditedById" integer,
    status character varying(255),
    "incurredAt" timestamp with time zone,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "deletedAt" timestamp with time zone,
    hid bigint NOT NULL,
    "archivedAt" timestamp with time zone NOT NULL
);
 &   DROP TABLE public."ExpenseHistories";
       public         opencollective    false    4         �            1259    1633760    ExpenseHistories_hid_seq    SEQUENCE     |   CREATE SEQUENCE "ExpenseHistories_hid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public."ExpenseHistories_hid_seq";
       public       opencollective    false    209    4         �           0    0    ExpenseHistories_hid_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE "ExpenseHistories_hid_seq" OWNED BY "ExpenseHistories".hid;
            public       opencollective    false    210         �            1259    1633762    Expenses    TABLE     �  CREATE TABLE "Expenses" (
    id integer NOT NULL,
    "UserId" integer NOT NULL,
    "CollectiveId" integer NOT NULL,
    currency character varying(255) NOT NULL,
    amount integer NOT NULL,
    description character varying(255) NOT NULL,
    "privateMessage" text,
    attachment character varying(255),
    category character varying(255),
    vat integer,
    "lastEditedById" integer NOT NULL,
    status character varying(255) DEFAULT 'PENDING'::character varying NOT NULL,
    "incurredAt" timestamp with time zone NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "deletedAt" timestamp with time zone,
    "payoutMethod" character varying(255) NOT NULL
);
    DROP TABLE public."Expenses";
       public         opencollective    false    4         �            1259    1633769    Expenses_id_seq    SEQUENCE     s   CREATE SEQUENCE "Expenses_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public."Expenses_id_seq";
       public       opencollective    false    211    4         �           0    0    Expenses_id_seq    SEQUENCE OWNED BY     9   ALTER SEQUENCE "Expenses_id_seq" OWNED BY "Expenses".id;
            public       opencollective    false    212         �            1259    1633777    GroupHistories_hid_seq    SEQUENCE     z   CREATE SEQUENCE "GroupHistories_hid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public."GroupHistories_hid_seq";
       public       opencollective    false    213    4         �           0    0    GroupHistories_hid_seq    SEQUENCE OWNED BY     L   ALTER SEQUENCE "GroupHistories_hid_seq" OWNED BY "CollectiveHistories".hid;
            public       opencollective    false    214         �            1259    1633788    Groups_id_seq    SEQUENCE     q   CREATE SEQUENCE "Groups_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public."Groups_id_seq";
       public       opencollective    false    4    215         �           0    0    Groups_id_seq    SEQUENCE OWNED BY     :   ALTER SEQUENCE "Groups_id_seq" OWNED BY "Collectives".id;
            public       opencollective    false    216         �            1259    1633862    Members    TABLE     �  CREATE TABLE "Members" (
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "deletedAt" timestamp with time zone,
    "CreatedByUserId" integer NOT NULL,
    "CollectiveId" integer NOT NULL,
    role character varying(255) DEFAULT 'MEMBER'::character varying NOT NULL,
    id integer NOT NULL,
    description character varying(255),
    "MemberCollectiveId" integer,
    "TierId" integer
);
    DROP TABLE public."Members";
       public         opencollective    false    4         �            1259    1633790    Notifications    TABLE     r  CREATE TABLE "Notifications" (
    id integer NOT NULL,
    channel character varying(255) DEFAULT 'email'::character varying,
    type character varying(255),
    active boolean DEFAULT true,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "UserId" integer,
    "CollectiveId" integer,
    "webhookUrl" character varying(255)
);
 #   DROP TABLE public."Notifications";
       public         opencollective    false    4         �            1259    1633815    SequelizeMeta    TABLE     K   CREATE TABLE "SequelizeMeta" (
    name character varying(255) NOT NULL
);
 #   DROP TABLE public."SequelizeMeta";
       public         opencollective    false    4         �            1259    1633818    Sessions    TABLE     �   CREATE TABLE "Sessions" (
    sid character varying(32) NOT NULL,
    expires timestamp with time zone,
    data text,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
    DROP TABLE public."Sessions";
       public         opencollective    false    4         �            1259    1633832    Subscriptions    TABLE       CREATE TABLE "Subscriptions" (
    id integer NOT NULL,
    amount integer,
    currency character varying(255) DEFAULT 'USD'::character varying,
    "interval" character varying(8) DEFAULT NULL::character varying,
    "isActive" boolean DEFAULT false,
    data json,
    "stripeSubscriptionId" character varying(255),
    "activatedAt" timestamp with time zone,
    "deactivatedAt" timestamp with time zone,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "deletedAt" timestamp with time zone
);
 #   DROP TABLE public."Subscriptions";
       public         opencollective    false    4         �            1259    1633840    Subscriptions_id_seq    SEQUENCE     x   CREATE SEQUENCE "Subscriptions_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public."Subscriptions_id_seq";
       public       opencollective    false    217    4         �           0    0    Subscriptions_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE "Subscriptions_id_seq" OWNED BY "Notifications".id;
            public       opencollective    false    221         �            1259    1633842    Subscriptions_id_seq1    SEQUENCE     y   CREATE SEQUENCE "Subscriptions_id_seq1"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public."Subscriptions_id_seq1";
       public       opencollective    false    4    220         �           0    0    Subscriptions_id_seq1    SEQUENCE OWNED BY     D   ALTER SEQUENCE "Subscriptions_id_seq1" OWNED BY "Subscriptions".id;
            public       opencollective    false    222         �            1259    1633844    Tiers    TABLE       CREATE TABLE "Tiers" (
    id integer NOT NULL,
    name character varying(255),
    description character varying(510),
    amount integer,
    currency character varying(255) DEFAULT 'USD'::character varying,
    "maxQuantity" integer,
    password character varying(255),
    "startsAt" timestamp with time zone,
    "endsAt" timestamp with time zone,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "deletedAt" timestamp with time zone,
    slug character varying(255),
    "maxQuantityPerUser" integer,
    goal integer,
    type character varying(255) DEFAULT 'TICKET'::character varying,
    "CollectiveId" integer,
    "interval" character varying(8) DEFAULT NULL::character varying,
    button character varying(255),
    presets json
);
    DROP TABLE public."Tiers";
       public         opencollective    false    4         �            1259    1633851    Tiers_id_seq    SEQUENCE     p   CREATE SEQUENCE "Tiers_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public."Tiers_id_seq";
       public       opencollective    false    223    4         �           0    0    Tiers_id_seq    SEQUENCE OWNED BY     3   ALTER SEQUENCE "Tiers_id_seq" OWNED BY "Tiers".id;
            public       opencollective    false    224         �            1259    1633853    Transactions    TABLE     �  CREATE TABLE "Transactions" (
    id integer NOT NULL,
    type character varying(255),
    description character varying(255),
    amount integer,
    currency character varying(255) DEFAULT 'USD'::character varying,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone NOT NULL,
    "CollectiveId" integer,
    "CreatedByUserId" integer,
    "PaymentMethodId" integer,
    "deletedAt" timestamp with time zone,
    data json,
    "OrderId" integer,
    "platformFeeInHostCurrency" integer,
    "hostFeeInHostCurrency" integer,
    "paymentProcessorFeeInHostCurrency" integer,
    "hostCurrency" character varying(255),
    "hostCurrencyFxRate" double precision,
    "amountInHostCurrency" integer,
    "netAmountInCollectiveCurrency" integer,
    "ExpenseId" integer,
    uuid uuid,
    "FromCollectiveId" integer,
    "HostCollectiveId" integer,
    "TransactionGroup" uuid
);
 "   DROP TABLE public."Transactions";
       public         opencollective    false    4         �            1259    1633860    Transactions_id_seq    SEQUENCE     w   CREATE SEQUENCE "Transactions_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public."Transactions_id_seq";
       public       opencollective    false    225    4         �           0    0    Transactions_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE "Transactions_id_seq" OWNED BY "Transactions".id;
            public       opencollective    false    226         �            1259    1633866    UserGroups_id_seq    SEQUENCE     u   CREATE SEQUENCE "UserGroups_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."UserGroups_id_seq";
       public       opencollective    false    227    4         �           0    0    UserGroups_id_seq    SEQUENCE OWNED BY     :   ALTER SEQUENCE "UserGroups_id_seq" OWNED BY "Members".id;
            public       opencollective    false    228         �            1259    1633868    Users    TABLE     4  CREATE TABLE "Users" (
    id integer NOT NULL,
    email character varying(255),
    _salt character varying(255) DEFAULT '$2a$10$JqAcT6sBbBs5pO9FkwqLEu'::character varying,
    refresh_token character varying(255) DEFAULT '$2a$10$IHs8e8FdK1.bqjvZxr4Zvu'::character varying,
    password_hash character varying(255),
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "seenAt" timestamp with time zone,
    "deletedAt" timestamp with time zone,
    "paypalEmail" character varying(255),
    "resetPasswordTokenHash" character varying(255),
    "resetPasswordSentAt" timestamp with time zone,
    "firstName" character varying(128),
    "lastName" character varying(128),
    "billingAddress" character varying(255),
    "isHost" boolean DEFAULT false,
    "CollectiveId" integer
);
    DROP TABLE public."Users";
       public         opencollective    false    4         �            1259    1633879    Users_id_seq    SEQUENCE     p   CREATE SEQUENCE "Users_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public."Users_id_seq";
       public       opencollective    false    229    4         �           0    0    Users_id_seq    SEQUENCE OWNED BY     3   ALTER SEQUENCE "Users_id_seq" OWNED BY "Users".id;
            public       opencollective    false    230         �           0    0    geography_columns    ACL     8   GRANT ALL ON TABLE geography_columns TO opencollective;
            public       aseem    false    189         �           0    0    geometry_columns    ACL     7   GRANT ALL ON TABLE geometry_columns TO opencollective;
            public       aseem    false    190         �           0    0    raster_columns    ACL     5   GRANT ALL ON TABLE raster_columns TO opencollective;
            public       aseem    false    199         �           0    0    raster_overviews    ACL     7   GRANT ALL ON TABLE raster_overviews TO opencollective;
            public       aseem    false    200         �           0    0    spatial_ref_sys    ACL     �   REVOKE ALL ON TABLE spatial_ref_sys FROM aseem;
REVOKE SELECT ON TABLE spatial_ref_sys FROM PUBLIC;
GRANT ALL ON TABLE spatial_ref_sys TO opencollective;
GRANT SELECT ON TABLE spatial_ref_sys TO PUBLIC;
            public       opencollective    false    187         �           2604    1633881    Activities id    DEFAULT     d   ALTER TABLE ONLY "Activities" ALTER COLUMN id SET DEFAULT nextval('"Activities_id_seq"'::regclass);
 >   ALTER TABLE public."Activities" ALTER COLUMN id DROP DEFAULT;
       public       opencollective    false    202    201         �           2604    1633889    CollectiveHistories hid    DEFAULT     s   ALTER TABLE ONLY "CollectiveHistories" ALTER COLUMN hid SET DEFAULT nextval('"GroupHistories_hid_seq"'::regclass);
 H   ALTER TABLE public."CollectiveHistories" ALTER COLUMN hid DROP DEFAULT;
       public       opencollective    false    214    213         �           2604    1633890    Collectives id    DEFAULT     a   ALTER TABLE ONLY "Collectives" ALTER COLUMN id SET DEFAULT nextval('"Groups_id_seq"'::regclass);
 ?   ALTER TABLE public."Collectives" ALTER COLUMN id DROP DEFAULT;
       public       opencollective    false    216    215         �           2604    1633884    ConnectedAccounts id    DEFAULT     r   ALTER TABLE ONLY "ConnectedAccounts" ALTER COLUMN id SET DEFAULT nextval('"ConnectedAccounts_id_seq"'::regclass);
 E   ALTER TABLE public."ConnectedAccounts" ALTER COLUMN id DROP DEFAULT;
       public       opencollective    false    206    205         �           2604    1633887    ExpenseHistories hid    DEFAULT     r   ALTER TABLE ONLY "ExpenseHistories" ALTER COLUMN hid SET DEFAULT nextval('"ExpenseHistories_hid_seq"'::regclass);
 E   ALTER TABLE public."ExpenseHistories" ALTER COLUMN hid DROP DEFAULT;
       public       opencollective    false    210    209         �           2604    1633888    Expenses id    DEFAULT     `   ALTER TABLE ONLY "Expenses" ALTER COLUMN id SET DEFAULT nextval('"Expenses_id_seq"'::regclass);
 <   ALTER TABLE public."Expenses" ALTER COLUMN id DROP DEFAULT;
       public       opencollective    false    212    211         �           2604    1633899 
   Members id    DEFAULT     a   ALTER TABLE ONLY "Members" ALTER COLUMN id SET DEFAULT nextval('"UserGroups_id_seq"'::regclass);
 ;   ALTER TABLE public."Members" ALTER COLUMN id DROP DEFAULT;
       public       opencollective    false    228    227         �           2604    1633891    Notifications id    DEFAULT     j   ALTER TABLE ONLY "Notifications" ALTER COLUMN id SET DEFAULT nextval('"Subscriptions_id_seq"'::regclass);
 A   ALTER TABLE public."Notifications" ALTER COLUMN id DROP DEFAULT;
       public       opencollective    false    221    217         �           2604    1633885 	   Orders id    DEFAULT     _   ALTER TABLE ONLY "Orders" ALTER COLUMN id SET DEFAULT nextval('"Donations_id_seq"'::regclass);
 :   ALTER TABLE public."Orders" ALTER COLUMN id DROP DEFAULT;
       public       opencollective    false    208    207         �           2604    1633893    PaymentMethods id    DEFAULT     c   ALTER TABLE ONLY "PaymentMethods" ALTER COLUMN id SET DEFAULT nextval('"Cards_id_seq"'::regclass);
 B   ALTER TABLE public."PaymentMethods" ALTER COLUMN id DROP DEFAULT;
       public       opencollective    false    204    203         �           2604    1633896    Subscriptions id    DEFAULT     k   ALTER TABLE ONLY "Subscriptions" ALTER COLUMN id SET DEFAULT nextval('"Subscriptions_id_seq1"'::regclass);
 A   ALTER TABLE public."Subscriptions" ALTER COLUMN id DROP DEFAULT;
       public       opencollective    false    222    220         �           2604    1633897    Tiers id    DEFAULT     Z   ALTER TABLE ONLY "Tiers" ALTER COLUMN id SET DEFAULT nextval('"Tiers_id_seq"'::regclass);
 9   ALTER TABLE public."Tiers" ALTER COLUMN id DROP DEFAULT;
       public       opencollective    false    224    223         �           2604    1633898    Transactions id    DEFAULT     h   ALTER TABLE ONLY "Transactions" ALTER COLUMN id SET DEFAULT nextval('"Transactions_id_seq"'::regclass);
 @   ALTER TABLE public."Transactions" ALTER COLUMN id DROP DEFAULT;
       public       opencollective    false    226    225         �           2604    1633900    Users id    DEFAULT     Z   ALTER TABLE ONLY "Users" ALTER COLUMN id SET DEFAULT nextval('"Users_id_seq"'::regclass);
 9   ALTER TABLE public."Users" ALTER COLUMN id DROP DEFAULT;
       public       opencollective    false    230    229         �          0    1633689 
   Activities 
   TABLE DATA               g   COPY "Activities" (id, type, data, "createdAt", "CollectiveId", "UserId", "TransactionId") FROM stdin;
    public       opencollective    false    201       4001.dat �          0    1633771    CollectiveHistories 
   TABLE DATA               �  COPY "CollectiveHistories" (id, name, description, currency, "createdAt", "updatedAt", "deletedAt", "isActive", "longDescription", image, slug, website, "twitterHandle", mission, "backgroundImage", "hostFeePercent", settings, data, tags, "isSupercollective", "LastEditedByUserId", hid, "archivedAt", "CreatedByUserId", "HostCollectiveId", "ParentCollectiveId", type, "startsAt", "endsAt", "locationName", address, timezone, "maxAmount", "maxQuantity", "geoLocationLatLong") FROM stdin;
    public       opencollective    false    213       4013.dat �          0    1633779    Collectives 
   TABLE DATA               �  COPY "Collectives" (id, name, description, currency, "createdAt", "updatedAt", "deletedAt", "isActive", "longDescription", image, slug, website, "twitterHandle", mission, "backgroundImage", "hostFeePercent", settings, data, tags, "isSupercollective", "LastEditedByUserId", "CreatedByUserId", "HostCollectiveId", "ParentCollectiveId", type, "startsAt", "endsAt", "locationName", address, timezone, "maxAmount", "maxQuantity", "geoLocationLatLong") FROM stdin;
    public       opencollective    false    215       4015.dat �          0    1633727    ConnectedAccounts 
   TABLE DATA               �   COPY "ConnectedAccounts" (id, service, username, "clientId", token, data, "createdAt", "updatedAt", "deletedAt", "CreatedByUserId", "CollectiveId", "refreshToken") FROM stdin;
    public       opencollective    false    205       4005.dat �          0    1633754    ExpenseHistories 
   TABLE DATA                 COPY "ExpenseHistories" (id, "UserId", "CollectiveId", currency, amount, description, "payoutMethod", "privateMessage", attachment, category, vat, "lastEditedById", status, "incurredAt", "createdAt", "updatedAt", "deletedAt", hid, "archivedAt") FROM stdin;
    public       opencollective    false    209       4009.dat �          0    1633762    Expenses 
   TABLE DATA               �   COPY "Expenses" (id, "UserId", "CollectiveId", currency, amount, description, "privateMessage", attachment, category, vat, "lastEditedById", status, "incurredAt", "createdAt", "updatedAt", "deletedAt", "payoutMethod") FROM stdin;
    public       opencollective    false    211       4011.dat �          0    1633862    Members 
   TABLE DATA               �   COPY "Members" ("createdAt", "updatedAt", "deletedAt", "CreatedByUserId", "CollectiveId", role, id, description, "MemberCollectiveId", "TierId") FROM stdin;
    public       opencollective    false    227       4027.dat �          0    1633790    Notifications 
   TABLE DATA                  COPY "Notifications" (id, channel, type, active, "createdAt", "updatedAt", "UserId", "CollectiveId", "webhookUrl") FROM stdin;
    public       opencollective    false    217       4017.dat �          0    1633735    Orders 
   TABLE DATA                 COPY "Orders" (id, "CreatedByUserId", "CollectiveId", currency, "totalAmount", description, "SubscriptionId", "createdAt", "updatedAt", "deletedAt", "PaymentMethodId", "processedAt", "privateMessage", "TierId", "FromCollectiveId", "publicMessage", quantity) FROM stdin;
    public       opencollective    false    207       4007.dat �          0    1633710    PaymentMethods 
   TABLE DATA               �   COPY "PaymentMethods" (id, name, token, "customerId", service, data, "createdAt", "updatedAt", "confirmedAt", "deletedAt", "CreatedByUserId", "expiryDate", uuid, "CollectiveId", "archivedAt", "monthlyLimitPerMember", "primary", currency) FROM stdin;
    public       opencollective    false    203       4003.dat �          0    1633815    SequelizeMeta 
   TABLE DATA               (   COPY "SequelizeMeta" (name) FROM stdin;
    public       opencollective    false    218       4018.dat �          0    1633818    Sessions 
   TABLE DATA               K   COPY "Sessions" (sid, expires, data, "createdAt", "updatedAt") FROM stdin;
    public       opencollective    false    219       4019.dat �          0    1633832    Subscriptions 
   TABLE DATA               �   COPY "Subscriptions" (id, amount, currency, "interval", "isActive", data, "stripeSubscriptionId", "activatedAt", "deactivatedAt", "createdAt", "updatedAt", "deletedAt") FROM stdin;
    public       opencollective    false    220       4020.dat �          0    1633844    Tiers 
   TABLE DATA               �   COPY "Tiers" (id, name, description, amount, currency, "maxQuantity", password, "startsAt", "endsAt", "createdAt", "updatedAt", "deletedAt", slug, "maxQuantityPerUser", goal, type, "CollectiveId", "interval", button, presets) FROM stdin;
    public       opencollective    false    223       4023.dat �          0    1633853    Transactions 
   TABLE DATA               �  COPY "Transactions" (id, type, description, amount, currency, "createdAt", "updatedAt", "CollectiveId", "CreatedByUserId", "PaymentMethodId", "deletedAt", data, "OrderId", "platformFeeInHostCurrency", "hostFeeInHostCurrency", "paymentProcessorFeeInHostCurrency", "hostCurrency", "hostCurrencyFxRate", "amountInHostCurrency", "netAmountInCollectiveCurrency", "ExpenseId", uuid, "FromCollectiveId", "HostCollectiveId", "TransactionGroup") FROM stdin;
    public       opencollective    false    225       4025.dat �          0    1633868    Users 
   TABLE DATA                  COPY "Users" (id, email, _salt, refresh_token, password_hash, "createdAt", "updatedAt", "seenAt", "deletedAt", "paypalEmail", "resetPasswordTokenHash", "resetPasswordSentAt", "firstName", "lastName", "billingAddress", "isHost", "CollectiveId") FROM stdin;
    public       opencollective    false    229       4029.dat �          0    1631998    spatial_ref_sys 
   TABLE DATA               Q   COPY spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
    public       opencollective    false    187       3752.dat �           0    0    Activities_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('"Activities_id_seq"', 27901, true);
            public       opencollective    false    202         �           0    0    Cards_id_seq    SEQUENCE SET     8   SELECT pg_catalog.setval('"Cards_id_seq"', 3023, true);
            public       opencollective    false    204         �           0    0    ConnectedAccounts_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('"ConnectedAccounts_id_seq"', 1026, true);
            public       opencollective    false    206         �           0    0    Donations_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('"Donations_id_seq"', 2912, true);
            public       opencollective    false    208         �           0    0    ExpenseHistories_hid_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('"ExpenseHistories_hid_seq"', 1607, true);
            public       opencollective    false    210         �           0    0    Expenses_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('"Expenses_id_seq"', 1159, true);
            public       opencollective    false    212         �           0    0    GroupHistories_hid_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('"GroupHistories_hid_seq"', 31393, true);
            public       opencollective    false    214         �           0    0    Groups_id_seq    SEQUENCE SET     8   SELECT pg_catalog.setval('"Groups_id_seq"', 857, true);
            public       opencollective    false    216         �           0    0    Subscriptions_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('"Subscriptions_id_seq"', 17102, true);
            public       opencollective    false    221         �           0    0    Subscriptions_id_seq1    SEQUENCE SET     A   SELECT pg_catalog.setval('"Subscriptions_id_seq1"', 2214, true);
            public       opencollective    false    222         �           0    0    Tiers_id_seq    SEQUENCE SET     7   SELECT pg_catalog.setval('"Tiers_id_seq"', 128, true);
            public       opencollective    false    224         �           0    0    Transactions_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('"Transactions_id_seq"', 11354, true);
            public       opencollective    false    226         �           0    0    UserGroups_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('"UserGroups_id_seq"', 4728, true);
            public       opencollective    false    228         �           0    0    Users_id_seq    SEQUENCE SET     8   SELECT pg_catalog.setval('"Users_id_seq"', 4973, true);
            public       opencollective    false    230         �           2606    1633904    Activities Activities_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY "Activities"
    ADD CONSTRAINT "Activities_pkey" PRIMARY KEY (id);
 H   ALTER TABLE ONLY public."Activities" DROP CONSTRAINT "Activities_pkey";
       public         opencollective    false    201         �           2606    1633910    PaymentMethods Cards_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY "PaymentMethods"
    ADD CONSTRAINT "Cards_pkey" PRIMARY KEY (id);
 G   ALTER TABLE ONLY public."PaymentMethods" DROP CONSTRAINT "Cards_pkey";
       public         opencollective    false    203         �           2606    1633914 (   ConnectedAccounts ConnectedAccounts_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY "ConnectedAccounts"
    ADD CONSTRAINT "ConnectedAccounts_pkey" PRIMARY KEY (id);
 V   ALTER TABLE ONLY public."ConnectedAccounts" DROP CONSTRAINT "ConnectedAccounts_pkey";
       public         opencollective    false    205         �           2606    1633916    Orders Donations_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY "Orders"
    ADD CONSTRAINT "Donations_pkey" PRIMARY KEY (id);
 C   ALTER TABLE ONLY public."Orders" DROP CONSTRAINT "Donations_pkey";
       public         opencollective    false    207         �           2606    1633920 &   ExpenseHistories ExpenseHistories_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY "ExpenseHistories"
    ADD CONSTRAINT "ExpenseHistories_pkey" PRIMARY KEY (hid);
 T   ALTER TABLE ONLY public."ExpenseHistories" DROP CONSTRAINT "ExpenseHistories_pkey";
       public         opencollective    false    209         �           2606    1633922    Expenses Expenses_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY "Expenses"
    ADD CONSTRAINT "Expenses_pkey" PRIMARY KEY (id);
 D   ALTER TABLE ONLY public."Expenses" DROP CONSTRAINT "Expenses_pkey";
       public         opencollective    false    211         �           2606    1633924 '   CollectiveHistories GroupHistories_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY "CollectiveHistories"
    ADD CONSTRAINT "GroupHistories_pkey" PRIMARY KEY (hid);
 U   ALTER TABLE ONLY public."CollectiveHistories" DROP CONSTRAINT "GroupHistories_pkey";
       public         opencollective    false    213         �           2606    1633926    Collectives Groups_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY "Collectives"
    ADD CONSTRAINT "Groups_pkey" PRIMARY KEY (id);
 E   ALTER TABLE ONLY public."Collectives" DROP CONSTRAINT "Groups_pkey";
       public         opencollective    false    215         �           2606    1633934     SequelizeMeta SequelizeMeta_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY "SequelizeMeta"
    ADD CONSTRAINT "SequelizeMeta_pkey" PRIMARY KEY (name);
 N   ALTER TABLE ONLY public."SequelizeMeta" DROP CONSTRAINT "SequelizeMeta_pkey";
       public         opencollective    false    218         �           2606    1633936    Sessions Sessions_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY "Sessions"
    ADD CONSTRAINT "Sessions_pkey" PRIMARY KEY (sid);
 D   ALTER TABLE ONLY public."Sessions" DROP CONSTRAINT "Sessions_pkey";
       public         opencollective    false    219         �           2606    1633940     Notifications Subscriptions_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY "Notifications"
    ADD CONSTRAINT "Subscriptions_pkey" PRIMARY KEY (id);
 N   ALTER TABLE ONLY public."Notifications" DROP CONSTRAINT "Subscriptions_pkey";
       public         opencollective    false    217         �           2606    1633942 !   Subscriptions Subscriptions_pkey1 
   CONSTRAINT     \   ALTER TABLE ONLY "Subscriptions"
    ADD CONSTRAINT "Subscriptions_pkey1" PRIMARY KEY (id);
 O   ALTER TABLE ONLY public."Subscriptions" DROP CONSTRAINT "Subscriptions_pkey1";
       public         opencollective    false    220         �           2606    1633944    Tiers Tiers_pkey 
   CONSTRAINT     K   ALTER TABLE ONLY "Tiers"
    ADD CONSTRAINT "Tiers_pkey" PRIMARY KEY (id);
 >   ALTER TABLE ONLY public."Tiers" DROP CONSTRAINT "Tiers_pkey";
       public         opencollective    false    223         �           2606    1633946    Transactions Transactions_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY "Transactions"
    ADD CONSTRAINT "Transactions_pkey" PRIMARY KEY (id);
 L   ALTER TABLE ONLY public."Transactions" DROP CONSTRAINT "Transactions_pkey";
       public         opencollective    false    225         �           2606    1633948    Members UserGroups_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY "Members"
    ADD CONSTRAINT "UserGroups_pkey" PRIMARY KEY (id);
 E   ALTER TABLE ONLY public."Members" DROP CONSTRAINT "UserGroups_pkey";
       public         opencollective    false    227         �           2606    1633950    Users Users_email_key 
   CONSTRAINT     N   ALTER TABLE ONLY "Users"
    ADD CONSTRAINT "Users_email_key" UNIQUE (email);
 C   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key";
       public         opencollective    false    229         �           2606    1633952    Users Users_pkey 
   CONSTRAINT     K   ALTER TABLE ONLY "Users"
    ADD CONSTRAINT "Users_pkey" PRIMARY KEY (id);
 >   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_pkey";
       public         opencollective    false    229         �           2606    1633956    Users email_unique_idx 
   CONSTRAINT     M   ALTER TABLE ONLY "Users"
    ADD CONSTRAINT email_unique_idx UNIQUE (email);
 B   ALTER TABLE ONLY public."Users" DROP CONSTRAINT email_unique_idx;
       public         opencollective    false    229         �           1259    1634322    CollectiveId    INDEX     E   CREATE INDEX "CollectiveId" ON "Users" USING btree ("CollectiveId");
 "   DROP INDEX public."CollectiveId";
       public         opencollective    false    229         �           1259    1634323 "   CollectiveId-FromCollectiveId-type    INDEX     �   CREATE INDEX "CollectiveId-FromCollectiveId-type" ON "Transactions" USING btree ("CollectiveId", "FromCollectiveId", "deletedAt");
 8   DROP INDEX public."CollectiveId-FromCollectiveId-type";
       public         opencollective    false    225    225    225         �           1259    1634325    CollectiveId-deletedAt    INDEX     \   CREATE INDEX "CollectiveId-deletedAt" ON "Tiers" USING btree ("CollectiveId", "deletedAt");
 ,   DROP INDEX public."CollectiveId-deletedAt";
       public         opencollective    false    223    223         �           1259    1634321    CollectiveId-role    INDEX     R   CREATE INDEX "CollectiveId-role" ON "Members" USING btree ("CollectiveId", role);
 '   DROP INDEX public."CollectiveId-role";
       public         opencollective    false    227    227         �           1259    1634324    CollectiveId-type    INDEX     W   CREATE INDEX "CollectiveId-type" ON "Transactions" USING btree ("CollectiveId", type);
 '   DROP INDEX public."CollectiveId-type";
       public         opencollective    false    225    225         �           1259    1634176 
   DonationId    INDEX     E   CREATE INDEX "DonationId" ON "Transactions" USING btree ("OrderId");
     DROP INDEX public."DonationId";
       public         opencollective    false    225         �           1259    1634320 $   MemberCollectiveId-CollectiveId-role    INDEX     {   CREATE INDEX "MemberCollectiveId-CollectiveId-role" ON "Members" USING btree ("MemberCollectiveId", "CollectiveId", role);
 :   DROP INDEX public."MemberCollectiveId-CollectiveId-role";
       public         opencollective    false    227    227    227         �           1259    1634319    ParentCollectiveId    INDEX     W   CREATE INDEX "ParentCollectiveId" ON "Collectives" USING btree ("ParentCollectiveId");
 (   DROP INDEX public."ParentCollectiveId";
       public         opencollective    false    215         �           1259    1633957    Transactions_GroupId    INDEX     a   CREATE INDEX "Transactions_GroupId" ON "Transactions" USING btree ("CollectiveId", "deletedAt");
 *   DROP INDEX public."Transactions_GroupId";
       public         opencollective    false    225    225         �           1259    1633959    UniqueSlugIndex    INDEX     K   CREATE UNIQUE INDEX "UniqueSlugIndex" ON "Collectives" USING btree (slug);
 %   DROP INDEX public."UniqueSlugIndex";
       public         opencollective    false    215         �           1259    1633961 %   subscriptions_type__group_id__user_id    INDEX     {   CREATE UNIQUE INDEX subscriptions_type__group_id__user_id ON "Notifications" USING btree (type, "CollectiveId", "UserId");
 9   DROP INDEX public.subscriptions_type__group_id__user_id;
       public         opencollective    false    217    217    217         �           1259    1634190    transactions_uuid    INDEX     L   CREATE UNIQUE INDEX transactions_uuid ON "Transactions" USING btree (uuid);
 %   DROP INDEX public.transactions_uuid;
       public         opencollective    false    225         �           1259    1634318 	   type-tags    INDEX     D   CREATE INDEX "type-tags" ON "Collectives" USING btree (type, tags);
    DROP INDEX public."type-tags";
       public         opencollective    false    215    215         �           2606    1633963 "   Activities Activities_GroupId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "Activities"
    ADD CONSTRAINT "Activities_GroupId_fkey" FOREIGN KEY ("CollectiveId") REFERENCES "Collectives"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 P   ALTER TABLE ONLY public."Activities" DROP CONSTRAINT "Activities_GroupId_fkey";
       public       opencollective    false    215    3805    201                     2606    1633968 (   Activities Activities_TransactionId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "Activities"
    ADD CONSTRAINT "Activities_TransactionId_fkey" FOREIGN KEY ("TransactionId") REFERENCES "Transactions"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 V   ALTER TABLE ONLY public."Activities" DROP CONSTRAINT "Activities_TransactionId_fkey";
       public       opencollective    false    3826    225    201                    2606    1633973 !   Activities Activities_UserId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "Activities"
    ADD CONSTRAINT "Activities_UserId_fkey" FOREIGN KEY ("UserId") REFERENCES "Users"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 O   ALTER TABLE ONLY public."Activities" DROP CONSTRAINT "Activities_UserId_fkey";
       public       opencollective    false    229    201    3836                    2606    1633988     PaymentMethods Cards_UserId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "PaymentMethods"
    ADD CONSTRAINT "Cards_UserId_fkey" FOREIGN KEY ("CreatedByUserId") REFERENCES "Users"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 N   ALTER TABLE ONLY public."PaymentMethods" DROP CONSTRAINT "Cards_UserId_fkey";
       public       opencollective    false    3836    203    229                    2606    1634227 <   CollectiveHistories CollectiveHistories_CreatedByUserId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "CollectiveHistories"
    ADD CONSTRAINT "CollectiveHistories_CreatedByUserId_fkey" FOREIGN KEY ("CreatedByUserId") REFERENCES "Users"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 j   ALTER TABLE ONLY public."CollectiveHistories" DROP CONSTRAINT "CollectiveHistories_CreatedByUserId_fkey";
       public       opencollective    false    3836    213    229                    2606    1634237 =   CollectiveHistories CollectiveHistories_HostCollectiveId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "CollectiveHistories"
    ADD CONSTRAINT "CollectiveHistories_HostCollectiveId_fkey" FOREIGN KEY ("HostCollectiveId") REFERENCES "Collectives"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 k   ALTER TABLE ONLY public."CollectiveHistories" DROP CONSTRAINT "CollectiveHistories_HostCollectiveId_fkey";
       public       opencollective    false    3805    215    213                    2606    1634242 ?   CollectiveHistories CollectiveHistories_ParentCollectiveId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "CollectiveHistories"
    ADD CONSTRAINT "CollectiveHistories_ParentCollectiveId_fkey" FOREIGN KEY ("ParentCollectiveId") REFERENCES "Collectives"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 m   ALTER TABLE ONLY public."CollectiveHistories" DROP CONSTRAINT "CollectiveHistories_ParentCollectiveId_fkey";
       public       opencollective    false    3805    215    213                    2606    1634201 ,   Collectives Collectives_CreatedByUserId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "Collectives"
    ADD CONSTRAINT "Collectives_CreatedByUserId_fkey" FOREIGN KEY ("CreatedByUserId") REFERENCES "Users"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 Z   ALTER TABLE ONLY public."Collectives" DROP CONSTRAINT "Collectives_CreatedByUserId_fkey";
       public       opencollective    false    229    215    3836                    2606    1634206 -   Collectives Collectives_HostCollectiveId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "Collectives"
    ADD CONSTRAINT "Collectives_HostCollectiveId_fkey" FOREIGN KEY ("HostCollectiveId") REFERENCES "Collectives"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 [   ALTER TABLE ONLY public."Collectives" DROP CONSTRAINT "Collectives_HostCollectiveId_fkey";
       public       opencollective    false    215    3805    215                    2606    1634211 /   Collectives Collectives_ParentCollectiveId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "Collectives"
    ADD CONSTRAINT "Collectives_ParentCollectiveId_fkey" FOREIGN KEY ("ParentCollectiveId") REFERENCES "Collectives"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 ]   ALTER TABLE ONLY public."Collectives" DROP CONSTRAINT "Collectives_ParentCollectiveId_fkey";
       public       opencollective    false    3805    215    215                    2606    1634008 0   ConnectedAccounts ConnectedAccounts_GroupId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "ConnectedAccounts"
    ADD CONSTRAINT "ConnectedAccounts_GroupId_fkey" FOREIGN KEY ("CollectiveId") REFERENCES "Collectives"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 ^   ALTER TABLE ONLY public."ConnectedAccounts" DROP CONSTRAINT "ConnectedAccounts_GroupId_fkey";
       public       opencollective    false    205    3805    215                    2606    1634013 /   ConnectedAccounts ConnectedAccounts_UserId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "ConnectedAccounts"
    ADD CONSTRAINT "ConnectedAccounts_UserId_fkey" FOREIGN KEY ("CreatedByUserId") REFERENCES "Users"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 ]   ALTER TABLE ONLY public."ConnectedAccounts" DROP CONSTRAINT "ConnectedAccounts_UserId_fkey";
       public       opencollective    false    205    229    3836                    2606    1634018    Orders Donations_GroupId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "Orders"
    ADD CONSTRAINT "Donations_GroupId_fkey" FOREIGN KEY ("CollectiveId") REFERENCES "Collectives"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 K   ALTER TABLE ONLY public."Orders" DROP CONSTRAINT "Donations_GroupId_fkey";
       public       opencollective    false    3805    215    207                    2606    1634023 %   Orders Donations_PaymentMethodId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "Orders"
    ADD CONSTRAINT "Donations_PaymentMethodId_fkey" FOREIGN KEY ("PaymentMethodId") REFERENCES "PaymentMethods"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 S   ALTER TABLE ONLY public."Orders" DROP CONSTRAINT "Donations_PaymentMethodId_fkey";
       public       opencollective    false    207    203    3793         	           2606    1634033 $   Orders Donations_SubscriptionId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "Orders"
    ADD CONSTRAINT "Donations_SubscriptionId_fkey" FOREIGN KEY ("SubscriptionId") REFERENCES "Subscriptions"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 R   ALTER TABLE ONLY public."Orders" DROP CONSTRAINT "Donations_SubscriptionId_fkey";
       public       opencollective    false    207    3817    220         
           2606    1634038    Orders Donations_UserId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "Orders"
    ADD CONSTRAINT "Donations_UserId_fkey" FOREIGN KEY ("CreatedByUserId") REFERENCES "Users"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 J   ALTER TABLE ONLY public."Orders" DROP CONSTRAINT "Donations_UserId_fkey";
       public       opencollective    false    207    3836    229                    2606    1634058    Expenses Expenses_GroupId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "Expenses"
    ADD CONSTRAINT "Expenses_GroupId_fkey" FOREIGN KEY ("CollectiveId") REFERENCES "Collectives"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 L   ALTER TABLE ONLY public."Expenses" DROP CONSTRAINT "Expenses_GroupId_fkey";
       public       opencollective    false    215    211    3805                    2606    1634063    Expenses Expenses_UserId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "Expenses"
    ADD CONSTRAINT "Expenses_UserId_fkey" FOREIGN KEY ("UserId") REFERENCES "Users"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 K   ALTER TABLE ONLY public."Expenses" DROP CONSTRAINT "Expenses_UserId_fkey";
       public       opencollective    false    211    3836    229                    2606    1634068 %   Expenses Expenses_lastEditedById_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "Expenses"
    ADD CONSTRAINT "Expenses_lastEditedById_fkey" FOREIGN KEY ("lastEditedById") REFERENCES "Users"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 S   ALTER TABLE ONLY public."Expenses" DROP CONSTRAINT "Expenses_lastEditedById_fkey";
       public       opencollective    false    211    3836    229                    2606    1634073 *   Collectives Groups_lastEditedByUserId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "Collectives"
    ADD CONSTRAINT "Groups_lastEditedByUserId_fkey" FOREIGN KEY ("LastEditedByUserId") REFERENCES "Users"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 X   ALTER TABLE ONLY public."Collectives" DROP CONSTRAINT "Groups_lastEditedByUserId_fkey";
       public       opencollective    false    3836    215    229                     2606    1634308 '   Members Members_MemberCollectiveId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "Members"
    ADD CONSTRAINT "Members_MemberCollectiveId_fkey" FOREIGN KEY ("MemberCollectiveId") REFERENCES "Collectives"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 U   ALTER TABLE ONLY public."Members" DROP CONSTRAINT "Members_MemberCollectiveId_fkey";
       public       opencollective    false    215    3805    227         !           2606    1634313    Members Members_TierId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "Members"
    ADD CONSTRAINT "Members_TierId_fkey" FOREIGN KEY ("TierId") REFERENCES "Tiers"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 I   ALTER TABLE ONLY public."Members" DROP CONSTRAINT "Members_TierId_fkey";
       public       opencollective    false    227    223    3820                    2606    1634265 #   Orders Orders_FromCollectiveId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "Orders"
    ADD CONSTRAINT "Orders_FromCollectiveId_fkey" FOREIGN KEY ("FromCollectiveId") REFERENCES "Collectives"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 Q   ALTER TABLE ONLY public."Orders" DROP CONSTRAINT "Orders_FromCollectiveId_fkey";
       public       opencollective    false    207    215    3805                    2606    1634260    Orders Orders_TierId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "Orders"
    ADD CONSTRAINT "Orders_TierId_fkey" FOREIGN KEY ("TierId") REFERENCES "Tiers"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 G   ALTER TABLE ONLY public."Orders" DROP CONSTRAINT "Orders_TierId_fkey";
       public       opencollective    false    207    3820    223                    2606    1634326 /   PaymentMethods PaymentMethods_CollectiveId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "PaymentMethods"
    ADD CONSTRAINT "PaymentMethods_CollectiveId_fkey" FOREIGN KEY ("CollectiveId") REFERENCES "Collectives"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 ]   ALTER TABLE ONLY public."PaymentMethods" DROP CONSTRAINT "PaymentMethods_CollectiveId_fkey";
       public       opencollective    false    3805    203    215                    2606    1634103 (   Notifications Subscriptions_GroupId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "Notifications"
    ADD CONSTRAINT "Subscriptions_GroupId_fkey" FOREIGN KEY ("CollectiveId") REFERENCES "Collectives"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 V   ALTER TABLE ONLY public."Notifications" DROP CONSTRAINT "Subscriptions_GroupId_fkey";
       public       opencollective    false    3805    215    217                    2606    1634108 '   Notifications Subscriptions_UserId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "Notifications"
    ADD CONSTRAINT "Subscriptions_UserId_fkey" FOREIGN KEY ("UserId") REFERENCES "Users"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 U   ALTER TABLE ONLY public."Notifications" DROP CONSTRAINT "Subscriptions_UserId_fkey";
       public       opencollective    false    3836    229    217                    2606    1634185    Tiers Tiers_GroupId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "Tiers"
    ADD CONSTRAINT "Tiers_GroupId_fkey" FOREIGN KEY ("CollectiveId") REFERENCES "Collectives"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 F   ALTER TABLE ONLY public."Tiers" DROP CONSTRAINT "Tiers_GroupId_fkey";
       public       opencollective    false    215    3805    223                    2606    1634118 %   Transactions Transactions_CardId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "Transactions"
    ADD CONSTRAINT "Transactions_CardId_fkey" FOREIGN KEY ("PaymentMethodId") REFERENCES "PaymentMethods"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 S   ALTER TABLE ONLY public."Transactions" DROP CONSTRAINT "Transactions_CardId_fkey";
       public       opencollective    false    3793    225    203                    2606    1634123 )   Transactions Transactions_DonationId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "Transactions"
    ADD CONSTRAINT "Transactions_DonationId_fkey" FOREIGN KEY ("OrderId") REFERENCES "Orders"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 W   ALTER TABLE ONLY public."Transactions" DROP CONSTRAINT "Transactions_DonationId_fkey";
       public       opencollective    false    225    207    3797                    2606    1634128 (   Transactions Transactions_ExpenseId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "Transactions"
    ADD CONSTRAINT "Transactions_ExpenseId_fkey" FOREIGN KEY ("ExpenseId") REFERENCES "Expenses"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 V   ALTER TABLE ONLY public."Transactions" DROP CONSTRAINT "Transactions_ExpenseId_fkey";
       public       opencollective    false    225    3801    211                    2606    1634276 /   Transactions Transactions_FromCollectiveId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "Transactions"
    ADD CONSTRAINT "Transactions_FromCollectiveId_fkey" FOREIGN KEY ("FromCollectiveId") REFERENCES "Collectives"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 ]   ALTER TABLE ONLY public."Transactions" DROP CONSTRAINT "Transactions_FromCollectiveId_fkey";
       public       opencollective    false    3805    225    215                    2606    1634133 &   Transactions Transactions_GroupId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "Transactions"
    ADD CONSTRAINT "Transactions_GroupId_fkey" FOREIGN KEY ("CollectiveId") REFERENCES "Collectives"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 T   ALTER TABLE ONLY public."Transactions" DROP CONSTRAINT "Transactions_GroupId_fkey";
       public       opencollective    false    225    215    3805                    2606    1634281 /   Transactions Transactions_HostCollectiveId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "Transactions"
    ADD CONSTRAINT "Transactions_HostCollectiveId_fkey" FOREIGN KEY ("HostCollectiveId") REFERENCES "Collectives"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 ]   ALTER TABLE ONLY public."Transactions" DROP CONSTRAINT "Transactions_HostCollectiveId_fkey";
       public       opencollective    false    215    225    3805                    2606    1634143 %   Transactions Transactions_UserId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "Transactions"
    ADD CONSTRAINT "Transactions_UserId_fkey" FOREIGN KEY ("CreatedByUserId") REFERENCES "Users"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 S   ALTER TABLE ONLY public."Transactions" DROP CONSTRAINT "Transactions_UserId_fkey";
       public       opencollective    false    3836    225    229         "           2606    1634148    Members UserGroups_GroupId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "Members"
    ADD CONSTRAINT "UserGroups_GroupId_fkey" FOREIGN KEY ("CollectiveId") REFERENCES "Collectives"(id);
 M   ALTER TABLE ONLY public."Members" DROP CONSTRAINT "UserGroups_GroupId_fkey";
       public       opencollective    false    3805    227    215         #           2606    1634153    Members UserGroups_UserId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "Members"
    ADD CONSTRAINT "UserGroups_UserId_fkey" FOREIGN KEY ("CreatedByUserId") REFERENCES "Users"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 L   ALTER TABLE ONLY public."Members" DROP CONSTRAINT "UserGroups_UserId_fkey";
       public       opencollective    false    3836    227    229         $           2606    1634255    Users Users_CollectiveId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "Users"
    ADD CONSTRAINT "Users_CollectiveId_fkey" FOREIGN KEY ("CollectiveId") REFERENCES "Collectives"(id) ON UPDATE CASCADE ON DELETE SET NULL;
 K   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_CollectiveId_fkey";
       public       opencollective    false    3805    229    215                                                                                                                                                                                                                                                                                                                                   4001.dat                                                                                            0000600 0004000 0002000 00000000005 13174451173 0014237 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           4013.dat                                                                                            0000600 0004000 0002000 00000000005 13174451173 0014242 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           4015.dat                                                                                            0000600 0004000 0002000 00000472446 13174451173 0014272 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        292	WWCode Vinnytsia	WWCode is a global non-profit organization that inspires women to excel in technology careers.	USD	2016-09-29 14:30:08.953-04	2016-12-28 11:27:20.161-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Vinnytsia**](https://www.womenwhocode.com/vinnytsia). \n\n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSd0I08q3ZAM8fRBchvB1oG9-8I5J3PlUwGcZreDWvtu2uSulg/viewform)\n\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSd0I08q3ZAM8fRBchvB1oG9-8I5J3PlUwGcZreDWvtu2uSulg/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSd0I08q3ZAM8fRBchvB1oG9-8I5J3PlUwGcZreDWvtu2uSulg/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodevinnytsia#support) to support WWCode Vinnytsia \n\nQuestions? Email us at global@womenwhocode.com.  \n	https://opencollective-production.s3-us-west-1.amazonaws.com/fcac9e50-a51b-11e6-b4fe-6966ef500b6b.png	wwcodevinnytsia	\N	WWCodeVinnytsia	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
510	Women Who Code Richmond	\N	USD	2017-02-21 11:25:28.328-05	2017-02-21 11:25:28.5-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur programs include hack nights, technical study groups, lightning talks, product demos, and leadership development. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow!	\N	wwcoderichmond	\N	\N	WWCode is a non-profit organization that inspires women to excel in technology careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
283	WWCode Paris	WWCode is a global non-profit organization that inspires women to excel in technology careers.	EUR	2016-09-29 14:16:17.095-04	2016-12-27 13:09:21.598-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Paris**](https://www.womenwhocode.com/paris). \n\n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLScDi0VhEDuM3nMheBFIV7F-b0tjG6SIFTXAg7FtkeVJK_P1fw/viewform)\n\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLScDi0VhEDuM3nMheBFIV7F-b0tjG6SIFTXAg7FtkeVJK_P1fw/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLScDi0VhEDuM3nMheBFIV7F-b0tjG6SIFTXAg7FtkeVJK_P1fw/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodeparis#support) to support WWCode Paris \n\nQuestions? Email us at global@womenwhocode.com.  \n	https://opencollective-production.s3-us-west-1.amazonaws.com/17525ef0-9d44-11e6-9116-db595ff259df.png	wwcodeparis	\N	\N	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
584	WWCode Edinburgh	\N	GBP	2017-04-03 12:22:45.923-04	2017-04-03 12:22:46-04	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur programs include hack nights, technical study groups, lightning talks, product demos, and leadership development. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow!\n\n\n# Contribute\n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSczqJwa2qByhFFHXavunDYPzXRh1p0lOVa8nfyMSvCCySkd0Q/viewform)\n[**Attend**](https://www.womenwhocode.com/edinburgh) 	\N	wwcodeedinburgh	\N	\N	WWCode is a non-profit organization that inspires women to excel in technology careers.\n\n\n	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3206	3206	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
48	WWCode Twin Cities	WWCode is a non-profit organization that inspires women to excel in technology careers.	USD	2016-03-06 19:00:00-05	2016-12-28 11:23:57.622-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in the Twin Cities**](https://www.womenwhocode.com/twin-cities). \n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSf9BXBmwX87irE9Xmvf9EntZG8Wb-VbY0xm2EOosPiMMSFP5g/viewform)\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSf9BXBmwX87irE9Xmvf9EntZG8Wb-VbY0xm2EOosPiMMSFP5g/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSf9BXBmwX87irE9Xmvf9EntZG8Wb-VbY0xm2EOosPiMMSFP5g/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodetwincities#support) to support WWCode Twin Cities \n\nQuestions? Email us at global@womenwhocode.com.  \n\n[**Sponsors**](https://drive.google.com/file/d/0ByjnHHy83oCsS3hjMjRNZktkYmM/view?usp=sharing)\n      	https://opencollective-production.s3-us-west-1.amazonaws.com/079974c0-cd1a-11e6-a033-c553d2fe46df.png	wwcodetwincities	https://www.womenwhocode.com/twin-cities	wwcodetc	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	\N	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
51	Women Who Code	WWCode is a global non-profit organization dedicated 	USD	2015-10-31 20:00:00-04	2017-05-22 15:33:15.968-04	\N	t	Women Who Code (WWCode) is a global 501(c)(3) non-profit dedicated to inspiring women to excel in technology careers. We connect amazing women with other like-minded women around the globe who unite under one simple notion – the world of technology is better with women in it. \n\nWe work hard every day to inspire engineers to advance their careers. We strongly believe in the value of diversity, and envision a world where women are representative as technical executives, founders, venture capitalists, board members, and software engineers. \n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events**](https://www.womenwhocode.com/events). \n\n[**Get Involved:**](https://docs.google.com/forms/d/e/1FAIpQLSfIho8JwdkT05STQ6q_1c_cv3kVBsO1I1udKVgf2XaAU5Tnfw/viewform)\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSfIho8JwdkT05STQ6q_1c_cv3kVBsO1I1udKVgf2XaAU5Tnfw/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSfIho8JwdkT05STQ6q_1c_cv3kVBsO1I1udKVgf2XaAU5Tnfw/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Support**](https://opencollective.com/wwcode#support) WWCode financially by making a donation below\n\nYour donations are critical in supporting this catalytic movement. Donations received here directly support our programs. A small amount also supports global development so that we can bring innovative program to cities around the world, ensuring that more women everywhere have the opportunity to excel in technology careers.\n\nQuestions? Email us at contact@womenwhocode.com. 	https://opencollective-production.s3-us-west-1.amazonaws.com/50bd4ad0-769b-11e6-90e1-0dd449fe12b2.png	wwcode	http://womenwhocode.com	wwcode	We are on a mission to inspire women to excel in tech careers.	\N	10	{"HostId": 3, "lang":"wwcode","superCollectiveTag":"wwcode","githubOrg":"wwcode","style":{"hero": {"cover":{"background":"black"}}}}	{"UserId":3}	{wwcode,meetup,"diversity in tech"}	t	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
261	WWCode Al-Jazair	WWCode is a global non-profit organization that inspires women to excel in technology careers.	USD	2016-09-29 13:49:43.012-04	2016-12-23 11:44:45.61-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Al-Jaza'ir**](https://www.womenwhocode.com/al-jaza-ir-algeria). \n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSfOOP_9i3fvCk5qLWvXgQFbCRUSdTaWKt020uhR4XKrVDO8kQ/viewform)\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSfOOP_9i3fvCk5qLWvXgQFbCRUSdTaWKt020uhR4XKrVDO8kQ/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSfOOP_9i3fvCk5qLWvXgQFbCRUSdTaWKt020uhR4XKrVDO8kQ/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodealjazair#support) to support WWCode Al-Jaza'ir\n\nQuestions? Email us at global@womenwhocode.com.  \n\n	https://opencollective-production.s3-us-west-1.amazonaws.com/5cc6b9c0-9562-11e6-add0-93faa9a7296f.png	wwcodealjazair	\N	\N	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
59	WWCode Portland	We are women who code: in any framework with any level of experience from any size of company for any reason (even just for fun)!	USD	2016-03-18 20:00:00-04	2017-05-22 15:33:20.319-04	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Portland**](https://www.womenwhocode.com/portland). \n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLScxNQfvu1iPbMjG52ufF21MfgnTY9F5f_SAFAR23q1RUIg55g/viewform)\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLScxNQfvu1iPbMjG52ufF21MfgnTY9F5f_SAFAR23q1RUIg55g/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLScxNQfvu1iPbMjG52ufF21MfgnTY9F5f_SAFAR23q1RUIg55g/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodeportland#support) to support WWCode Portland \n\nQuestions? Email us at global@womenwhocode.com.  \n	https://cldup.com/WoL-XXTWSH.png	wwcodeportland	https://www.womenwhocode.com/portland	WWCodePortland	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode","githubOrg":"wwcodeportland"}	{"githubContributors":{"caterinasworld":380,"rk101288":5,"jminnier":1,"sajoy":12,"cynful":12,"aliaward":8,"Tradcliffe":5,"thejensen":1,"morganpdx":8,"Ksan8":2},"repos":{"networking-nights":{"stars":1},"wwc-speaker-series":{"stars":1},"iot-hackathon-2016":{"stars":0},"study-nights":{"stars":32},"wwcodeportland.github.io":{"stars":7},"about-us":{"stars":1},"workshops":{"stars":0}}}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
273	WWCode Greenville	WWCode is a global non-profit organization that inspires women to excel in technology careers.	USD	2016-09-29 14:06:00.939-04	2016-12-27 11:48:30.075-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Greenville**](https://www.womenwhocode.com/greenville). \n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSfWyfd359XuZOQpkrxOaCmrHL7KG26wpwC68qplJ6iJNuLtwg/viewform)\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSfWyfd359XuZOQpkrxOaCmrHL7KG26wpwC68qplJ6iJNuLtwg/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSfWyfd359XuZOQpkrxOaCmrHL7KG26wpwC68qplJ6iJNuLtwg/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodegreenville#support) to support WWCode Greenville \n\nQuestions? Email us at global@womenwhocode.com. 	https://opencollective-production.s3-us-west-1.amazonaws.com/d1719000-8fd7-11e6-b320-5125b901f984.png	wwcodegreenville	\N	wwcodegville	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
274	WWCode Gujarat	WWCode is a global non-profit organization that inspires women to excel in technology careers.	USD	2016-09-29 14:06:44.732-04	2016-12-27 11:50:50.189-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Gujarat**](https://www.womenwhocode.com/gujarat). \n\n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSfKPlXR-We8gxAKHZUh6eZ2cZDhSUcwDTDepFfquKPHax63mA/viewform)\n\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSfKPlXR-We8gxAKHZUh6eZ2cZDhSUcwDTDepFfquKPHax63mA/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSfKPlXR-We8gxAKHZUh6eZ2cZDhSUcwDTDepFfquKPHax63mA/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodegujarat#support) to support WWCode Gujarat\n\nQuestions? Email us at global@womenwhocode.com.  \n	https://opencollective-production.s3-us-west-1.amazonaws.com/52506d70-9c78-11e6-a3da-b7d8fa4b13cd.png	wwcodegujarat	\N	\N	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
195	WWCode Boston	WWCode is a global non-profit organization that inspires women to excel in technology careers. 	USD	2015-12-12 19:14:54.028-05	2016-12-23 12:29:46.034-05	\N	t	Women Who Code (WWCode) is a global 501(c)(3) non-profit dedicated to inspiring women to excel in technology careers. We connect amazing women with other like-minded women around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 50,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Boston**](https://www.womenwhocode.com/boston). \n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSeaXQzj8paXy2_359fBuU2ZeztJLTRGI6coQQ99dI6K1CHiXg/viewform)\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSeaXQzj8paXy2_359fBuU2ZeztJLTRGI6coQQ99dI6K1CHiXg/viewform) an upcoming event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSeaXQzj8paXy2_359fBuU2ZeztJLTRGI6coQQ99dI6K1CHiXg/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodeboston#support) to support WWCode Boston \n\nQuestions?  Email global@womenwhocode.com	https://cldup.com/E6Hx_qyE9A.png	wwcodeboston	https://www.womenwhocode.com/boston	wwcboston	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	\N	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
266	WWCode Brisbane	WWCode is a global non-profit organization that inspires women to excel in technology careers.	AUD	2016-09-29 13:59:15.405-04	2016-12-23 12:39:30.07-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Brisbane**](https://www.womenwhocode.com/brisbane). \n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSeGniU6iD6vig-CTBWj9EVRLPCxz5ZrdLGoprkDZlGSVHZgOg/viewform)\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSeGniU6iD6vig-CTBWj9EVRLPCxz5ZrdLGoprkDZlGSVHZgOg/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSeGniU6iD6vig-CTBWj9EVRLPCxz5ZrdLGoprkDZlGSVHZgOg/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodebrisbane#support) to support WWCode Brisbane\n\nQuestions? Email us at global@womenwhocode.com.  \n\n	https://opencollective-production.s3-us-west-1.amazonaws.com/abcc78e0-c936-11e6-9af0-47fca5e686db.png	wwcodebrisbane	\N	wwcodebrisbane	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
267	WWCode Bristol 	WWCode is a global non-profit organization that inspires women to excel in technology careers.	GBP	2016-09-29 14:00:01.773-04	2016-12-23 12:54:17.915-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Bristol**](https://www.womenwhocode.com/bristol). \n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSeUCObM0_rq9q-EVLkiiYGCkSXaRVQyiM5bVNGBUHBvQhCeig/viewform)\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSeUCObM0_rq9q-EVLkiiYGCkSXaRVQyiM5bVNGBUHBvQhCeig/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSeUCObM0_rq9q-EVLkiiYGCkSXaRVQyiM5bVNGBUHBvQhCeig/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodebristol#support) to support WWCode Bristol \n\nQuestions? Email us at global@womenwhocode.com.  \n\n	https://opencollective-production.s3-us-west-1.amazonaws.com/bea58950-c938-11e6-9af0-47fca5e686db.png	wwcodebristol	\N	wwcbristol	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
10	WWCode Mexico City	Nos dedicamos a inspirar inspirar a más mujeres a ser parte y destacar en carreras del mundo tecnológico.	MXN	2016-01-08 19:22:34.216-05	2016-12-27 12:59:26.298-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Mexico City**](https://www.womenwhocode.com/df). \n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSfM35OQcwHB2moghLk3ZC1Vs-chWz_NkDdbEo984Sx1sa3Trg/viewform)\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSfM35OQcwHB2moghLk3ZC1Vs-chWz_NkDdbEo984Sx1sa3Trg/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSfM35OQcwHB2moghLk3ZC1Vs-chWz_NkDdbEo984Sx1sa3Trg/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodedf#support) to support WWCode Mexico City \n\n\nQuestions? Email us at global@womenwhocode.com.  \n	https://cldup.com/XMv1EFIxek.png	wwcodedf	http://www.meetup.com/Women-Who-Code-Mexico-City/	wwcodedf	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	\N	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
284	WWCode Phoenix	WWCode is a global non-profit organization that inspires women to excel in technology careers.	USD	2016-09-29 14:16:52.055-04	2016-12-27 13:33:28.693-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Phoenix**](https://www.womenwhocode.com/phoenix). \n\n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLScqaw9PNkcI8jaxCbAlvRF-xUQ75PBpHeRoOwI9zz87DRJHsg/viewform)\n\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLScqaw9PNkcI8jaxCbAlvRF-xUQ75PBpHeRoOwI9zz87DRJHsg/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLScqaw9PNkcI8jaxCbAlvRF-xUQ75PBpHeRoOwI9zz87DRJHsg/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodephoenix#support) to support WWCode Phoenix \n\n\nQuestions? Email us at global@womenwhocode.com.  \n	https://opencollective-production.s3-us-west-1.amazonaws.com/dd27b4d0-9d45-11e6-9116-db595ff259df.png	wwcodephoenix	\N	wwcodephoenix	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
3	WWCode New York	WWCode is a non-profit organization that inspires women to excel in technology careers.	USD	2015-12-12 19:14:54.028-05	2016-12-27 13:05:42.126-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in New York City**](https://www.womenwhocode.com/nyc). \n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSc7votVvy_Q06MsZNEjAbjI0c9WmQugN-YxRKOlLW4nu9DKtg/viewform)\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSc7votVvy_Q06MsZNEjAbjI0c9WmQugN-YxRKOlLW4nu9DKtg/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSc7votVvy_Q06MsZNEjAbjI0c9WmQugN-YxRKOlLW4nu9DKtg/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodenyc#support) to support WWCode New York City \n\nQuestions? Email us at global@womenwhocode.com.  \n	https://cldup.com/sjus3sm9uv.png	wwcodenyc	http://www.meetup.com/WomenWhoCodeNYC/	wwcodenyc	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	\N	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
289	WWCode Shanghai	WWCode is a global non-profit organization that inspires women to excel in technology careers.	USD	2016-09-29 14:26:35.114-04	2016-12-28 10:51:25.097-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Shanghai**](https://www.womenwhocode.com/shanghai). \n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSeaXQzj8paXy2_359fBuU2ZeztJLTRGI6coQQ99dI6K1CHiXg/viewform)\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSeaXQzj8paXy2_359fBuU2ZeztJLTRGI6coQQ99dI6K1CHiXg/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSeaXQzj8paXy2_359fBuU2ZeztJLTRGI6coQQ99dI6K1CHiXg/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodeshanghai#support) to support WWCode Shanghai\n\nQuestions? Email us at global@womenwhocode.com.	https://opencollective-production.s3-us-west-1.amazonaws.com/7be08da0-cd15-11e6-a033-c553d2fe46df.png	wwcodeshanghai	\N	\N	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
285	WWCode Reno/Tahoe	WWCode is a global non-profit organization that inspires women to excel in technology careers.	USD	2016-09-29 14:17:47.232-04	2016-12-27 14:29:59.63-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Reno/Tahoe**](https://www.womenwhocode.com/reno). \n\n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSdyKO3Q1OUzIokwJp2D0yb8C_Chkjf66O3WaQAWoiAnRegk_w/viewform)\n\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSdyKO3Q1OUzIokwJp2D0yb8C_Chkjf66O3WaQAWoiAnRegk_w/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSdyKO3Q1OUzIokwJp2D0yb8C_Chkjf66O3WaQAWoiAnRegk_w/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcoderenotahoe#support) to support WWCode Reno/Tahoe\n\n\nQuestions? Email us at global@womenwhocode.com.  \n	https://opencollective-production.s3-us-west-1.amazonaws.com/caae3800-a2be-11e6-b669-1f602f2f2eec.png	wwcoderenotahoe	\N	WWCodeRenoTahoe	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
686	Michelle Sun	\N	USD	2016-09-29 14:08:19.492-04	\N	\N	t	\N	\N	michellesun	\N	\N	\N	\N	\N	\N	{"UserId":1328}	{user}	f	\N	1328	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
687	Dana Dalling	\N	USD	2016-09-29 14:09:42.785-04	\N	\N	t	\N	\N	danadalling	\N	\N	\N	\N	\N	\N	{"UserId":1329}	{user}	f	\N	1329	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
271	WWCode Dallas	WWCode is a global non-profit organization that inspires women to excel in technology careers.	USD	2016-09-29 14:03:46.779-04	2016-12-27 11:14:29.745-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Dallas/Fort Worth**](https://www.womenwhocode.com/dfw). \n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSew2j5mt6negxggie47RRMNuerQSFs5T5IXVIFqrcsRyClWCg/viewform)\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSew2j5mt6negxggie47RRMNuerQSFs5T5IXVIFqrcsRyClWCg/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSew2j5mt6negxggie47RRMNuerQSFs5T5IXVIFqrcsRyClWCg/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodedallas#support) to support WWCode Dallas/Fort Worth\n\nQuestions? Email us at global@womenwhocode.com.  \n\n	https://opencollective-production.s3-us-west-1.amazonaws.com/f1679990-9a18-11e6-8650-f92e594d5de8.png	wwcodedallas	\N	wwcodedfw	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
688	Xavier Damman	Entrepreneur sharing ideas in copyleft	USD	2015-11-05 08:44:30.93-05	\N	\N	t	Tell us more about you, why you are on OpenCollective, what types of collectives you would love to contribute to, etc.\n\nProtip: you can use [markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet);	https://opencollective-production.s3-us-west-1.amazonaws.com/5c825534ad62223ae6a539f6a5076d3cjpeg_1699f6e0-917c-11e6-a567-3f53b7b5f95c.jpeg	xdamman	http://xdamman.com	xdamman	\N	\N	\N	\N	{"UserId":2}	{user}	f	\N	2	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
689	MakerSquare	\N	USD	2016-03-02 16:31:50.497-05	\N	\N	t	\N	https://course_report_production.s3.amazonaws.com/rich/rich_files/rich_files/268/s300/makersquare-logo.png	makersquare	http://www.makersquare.com	MakerSquareATX	\N	\N	\N	\N	{"UserId":129}	{user}	f	\N	129	\N	\N	ORGANIZATION	\N	\N	\N	\N	\N	\N	\N	\N
690	WWCode	\N	USD	2017-02-21 11:55:29.631-05	\N	\N	t	\N	\N	global	\N	\N	\N	\N	\N	\N	{"UserId":3206}	{user}	f	\N	3206	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
691	Pia Mancini	\N	USD	2016-01-09 16:31:01.954-05	\N	\N	t	\N	https://opencollective-production.s3-us-west-1.amazonaws.com/9EflVQqM_400x400jpg_2aee92e0-858d-11e6-9fd7-73dd31eb7c0c.jpeg	piamancini	\N	piamancini	\N	\N	\N	\N	{"UserId":30}	{user}	f	\N	30	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
692	Anne Brown	\N	USD	2017-04-11 22:05:32.736-04	\N	\N	t	\N	https://opencollective-production.s3-us-west-1.amazonaws.com/92dd7480-1f24-11e7-9a73-15e29bd9381e.png	abrown1411	\N	\N	\N	\N	\N	\N	{"UserId":4173}	{user}	f	\N	4173	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
693	androidchick88	\N	USD	2017-02-01 12:30:43.176-05	\N	\N	t	\N	\N	androidchick88	\N	\N	\N	\N	\N	\N	{"UserId":2906}	{user}	f	\N	2906	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
694	Georgia Andrews	\N	USD	\N	\N	\N	t	\N	\N	georgia	\N	\N	\N	\N	\N	\N	{"UserId":577}	{user}	f	\N	577	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
695	Chee Yim Goh	 I am generalist who are curious about a lot of things and often find myself dabble in both technical and management.	USD	2016-09-29 14:10:43.391-04	\N	\N	t	\N	https://opencollective-production.s3-us-west-1.amazonaws.com/b06d105a90d849daae3cee823078ffbc_4c27ac00-0dcb-11e7-92a0-730911003b33.jpeg	cheeyimgoh	\N	\N	\N	\N	\N	\N	{"UserId":1331}	{user}	f	\N	1331	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
696	Sarah Olson	Director of Women Who Code Twin Cities	USD	2016-03-07 04:51:08.328-05	\N	\N	t	I'm a Senior Software Engineer, currently working on the iOS app at Trello. I'm the Director of Women Who Code Twin Cities.	https://opencollective-production.s3-us-west-1.amazonaws.com/306b9860-dd87-11e6-aabd-af731cff2f24.jpeg	saraholson	https://www.linkedin.com/in/saraheolson	\N	\N	\N	\N	\N	{"UserId":142}	{user}	f	\N	142	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
697	Tamouse Temple	\N	USD	2017-01-18 08:49:53.082-05	\N	\N	t	\N	https://opencollective-production.s3-us-west-1.amazonaws.com/8e79f1498f3e4a4ab53bec89d5dfc1e5_43f16060-dd85-11e6-bf52-5b99c6274a65.jpeg	tamouse1	http://www.tamouse.org	tamouse	\N	\N	\N	\N	{"UserId":2594}	{user}	f	\N	2594	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
698	Karina	I am web developer, Director WWcode Recife - Brazil	USD	2016-09-29 14:19:11.45-04	\N	\N	t	\N	https://opencollective-production.s3-us-west-1.amazonaws.com/a6711e2eef3c42dbaa7b9e658670e44e_65470050-13c0-11e7-8edd-59205a885cb5.jpeg	karinamachado	\N	\N	\N	\N	\N	\N	{"UserId":1344}	{user}	f	\N	1344	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
699	Amanda Folson	\N	USD	2017-01-16 13:03:53.479-05	\N	\N	t	\N	https://d1ts43dypk8bqh.cloudfront.net/v1/avatars/2150894e-87e2-4dab-8ffa-894342f0336b	ambassadorawsum	http://amandafolson.net/about/#twitter	AmbassadorAwsum	\N	\N	\N	\N	{"UserId":2561}	{user}	f	\N	2561	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
700	Cameron 🐳✨	\N	USD	2016-12-18 20:41:26.473-05	\N	\N	t	\N	\N	cameron1	\N	\N	\N	\N	\N	\N	{"UserId":2220}	{user}	f	\N	2220	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
701	Portland Modern Manufacturing Collective	\N	USD	2016-11-22 10:22:35.912-05	\N	\N	t	\N	https://opencollective-production.s3-us-west-1.amazonaws.com/8cb68090-b0c7-11e6-8d75-191d15208aa9.png	mrlnmarce	http://www.uncorkedstudios.com	mrlnmarce	\N	\N	\N	\N	{"UserId":1846}	{user}	f	\N	1846	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
702	Shirley Hicks	Network director, Women Who Code Birmingham	USD	2016-09-29 13:43:14.052-04	\N	\N	t	\N	https://opencollective-production.s3-us-west-1.amazonaws.com/7d7b2ba6c0a24e269f7853f4eb9fdced_72776110-b138-11e6-afe2-6129fbf4c498.png	shirleyhicks	\N	\N	\N	\N	\N	\N	{"UserId":1303}	{user}	f	\N	1303	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
703	Nataliia Ilchenko	WWCode Kyiv Director	USD	2017-01-03 19:00:00-05	\N	\N	t	\N	/public/images/users/avatar-04.svg	nataliia	\N	\N	\N	\N	\N	\N	{"UserId":2431}	{user}	f	\N	2431	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
704	Alaina Percival	\N	USD	2016-03-01 23:41:59.905-05	\N	\N	t	\N	https://d1ts43dypk8bqh.cloudfront.net/v1/avatars/fb1f0fd9-4da7-4c66-847b-0eaaf5fe88e9	alaina	http://womenwhocode.com	alaina	\N	\N	\N	\N	{"UserId":126}	{user}	f	\N	126	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
705	Afia Owusu-Forfie	\N	USD	2016-09-29 13:44:40.419-04	\N	\N	t	\N	\N	afiaowusu-forfie	\N	\N	\N	\N	\N	\N	{"UserId":1304}	{user}	f	\N	1304	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
706	Snehal Patil	\N	USD	2016-09-29 14:41:11.059-04	\N	\N	t	\N	https://opencollective-production.s3-us-west-1.amazonaws.com/eea1cd90-adc6-11e6-97ba-67ed1cda3697.png	snehalpatil	\N	\N	\N	\N	\N	\N	{"UserId":1374}	{user}	f	\N	1374	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
707	Wooga	\N	USD	2016-11-29 05:03:21.301-05	\N	\N	t	\N	https://opencollective-production.s3-us-west-1.amazonaws.com/24be6ad0-b61b-11e6-9f3b-115a2450f71e.jpg	maikesteinweller	http://www.wooga.com	wooga	\N	\N	\N	\N	{"UserId":1908}	{user}	f	\N	1908	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
708	Rigado	\N	USD	2016-11-17 12:43:26.15-05	\N	\N	t	\N	https://logo.clearbit.com/rigado.com	christinepechette	https://www.rigado.com/	RigadoLLC	\N	\N	\N	\N	{"UserId":1808}	{user}	f	\N	1808	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
709	Kelly Erickson	\N	USD	2017-01-03 15:59:33.995-05	\N	\N	t	\N	\N	kellyerickson	\N	\N	\N	\N	\N	\N	{"UserId":2416}	{user}	f	\N	2416	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
710	Maddy Lau	\N	USD	2016-11-30 11:11:38.749-05	\N	\N	t	\N	https://logo.clearbit.com/nycda.com	maddylau	http://nycda.com	nycodedesign	\N	\N	\N	\N	{"UserId":1957}	{user}	f	\N	1957	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
711	Kristine Paas	\N	USD	2017-05-09 01:59:11.628-04	\N	\N	t	\N	\N	kjcpaas	\N	\N	\N	\N	\N	\N	{"UserId":4711}	{user}	f	\N	4711	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
712	Wei-Juin Lin	\N	USD	2016-10-07 12:49:14.297-04	\N	\N	t	\N	\N	wei-juinlin	\N	\N	\N	\N	\N	\N	{"UserId":1446}	{user}	f	\N	1446	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
713	Hector Torres	\N	USD	2016-10-06 14:36:34.986-04	\N	\N	t	\N	https://opencollective-production.s3-us-west-1.amazonaws.com/7aOKGnA1_normaljpg_f6ea41c0-8bf3-11e6-8916-b3b1b8ac2e00.jpeg	hectortorres	http://summit.ulahealth.me	ulahealth	\N	\N	\N	\N	{"UserId":1438}	{user}	f	\N	1438	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
714	Britten Kuckelman	\N	USD	2016-09-29 14:32:00.979-04	\N	\N	t	\N	\N	brittenkuckelman	\N	\N	\N	\N	\N	\N	{"UserId":1357}	{user}	f	\N	1357	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
715	Ksenia Barshchyk	\N	USD	2016-09-29 14:30:08.971-04	\N	\N	t	\N	\N	kseniabarshchyk	\N	\N	\N	\N	\N	\N	{"UserId":1354}	{user}	f	\N	1354	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
716	Sarrah Vesselov	\N	USD	2016-09-29 14:28:08.475-04	\N	\N	t	\N	\N	sarrahvesselov	\N	\N	\N	\N	\N	\N	{"UserId":1352}	{user}	f	\N	1352	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
717	Grain	\N	USD	2016-09-20 16:58:49.633-04	\N	\N	t	\N	https://opencollective-production.s3-us-west-1.amazonaws.com/grainappio_20c2d740-7f75-11e6-998a-b5046561186d.png	grain_app	https://grainapp.io	grain_app	\N	\N	\N	\N	{"UserId":1244}	{user}	f	\N	1244	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
718	Travis Swicegood	\N	USD	2016-05-19 15:24:40.738-04	\N	\N	t	\N	https://opencollective-production.s3-us-west-1.amazonaws.com/03134eb6a2764594808716e5c3f0dc6c_690fce70-1df7-11e6-b09a-bd4f4a904ffe.jpeg	tswicegood	http://www.travisswicegood.com	tswicegood	\N	\N	\N	\N	{"UserId":392}	{user}	f	\N	392	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
719	Ria Riaz	\N	USD	2016-09-29 14:28:54.276-04	\N	\N	t	\N	\N	riariaz	\N	\N	\N	\N	\N	\N	{"UserId":1353}	{user}	f	\N	1353	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
720	Dinah Shi	\N	USD	2016-09-29 14:30:54.244-04	\N	\N	t	\N	\N	dinahshi	\N	\N	\N	\N	\N	\N	{"UserId":1356}	{user}	f	\N	1356	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
721	Kathy Trammell	\N	USD	2016-09-29 14:28:08.47-04	\N	\N	t	\N	\N	kathytrammell	\N	\N	\N	\N	\N	\N	{"UserId":1351}	{user}	f	\N	1351	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
722	Yoka Liu	\N	USD	2016-09-29 14:26:35.139-04	\N	\N	t	\N	\N	yokaliu	\N	\N	\N	\N	\N	\N	{"UserId":1350}	{user}	f	\N	1350	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
727	Ashma Sethi	\N	USD	2016-09-29 14:24:17.802-04	\N	\N	t	\N	\N	ashmasethi	\N	\N	\N	\N	\N	\N	{"UserId":1345}	{user}	f	\N	1345	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
730	Veronica Cannon	\N	USD	2016-09-29 14:17:47.289-04	\N	\N	t	\N	\N	veronicacannon	\N	\N	\N	\N	\N	\N	{"UserId":1342}	{user}	f	\N	1342	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
731	Emily Reese	\N	USD	2016-09-29 14:16:17.115-04	\N	\N	t	\N	\N	emilyreese	\N	\N	\N	\N	\N	\N	{"UserId":1340}	{user}	f	\N	1340	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
736	Vinita Khandelwal Rathi	\N	USD	2016-09-29 14:11:53.843-04	\N	\N	t	\N	\N	vinitakhandelwalrathi	\N	\N	\N	\N	\N	\N	{"UserId":1334}	{user}	f	\N	1334	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
745	Maira Bejamin	\N	USD	2016-09-29 14:05:19.073-04	\N	\N	t	\N	\N	mairabejamin	\N	\N	\N	\N	\N	\N	{"UserId":1323}	{user}	f	\N	1323	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
751	Amber Houle	\N	USD	2016-09-29 14:02:54.546-04	\N	\N	t	\N	\N	amberhoule	\N	\N	\N	\N	\N	\N	{"UserId":1320}	{user}	f	\N	1320	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
752	Candice Haddad	\N	USD	2016-09-29 14:02:54.555-04	\N	\N	t	\N	\N	candicehaddad	\N	\N	\N	\N	\N	\N	{"UserId":1321}	{user}	f	\N	1321	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
756	Marisol Acuna	\N	USD	2016-09-29 14:25:21.95-04	\N	\N	t	\N	\N	marisolacuna	\N	\N	\N	\N	\N	\N	{"UserId":1347}	{user}	f	\N	1347	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
761	Isabella Oliveira	\N	USD	2016-09-29 13:58:16.63-04	\N	\N	t	\N	\N	isabellaoliveira	\N	\N	\N	\N	\N	\N	{"UserId":1315}	{user}	f	\N	1315	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
766	Sandra	\N	USD	2016-01-11 13:53:43.73-05	\N	\N	t	\N	https://media.licdn.com/media/p/1/000/056/1e1/1c4c4e1.jpg	sandrawwc	\N	\N	\N	\N	\N	\N	{"UserId":31}	{user}	f	\N	31	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
773	Elizabeth Ferrao	\N	USD	2016-01-29 18:19:22.243-05	\N	\N	t	\N	https://d1ts43dypk8bqh.cloudfront.net/v1/avatars/0addaf63-25c3-4f61-85bd-9ddec639dbaa	musingmurmurs	\N	MusingMurmurs	\N	\N	\N	\N	{"UserId":72}	{user}	f	\N	72	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
778	Fanya	\N	USD	2016-01-29 18:20:00.061-05	\N	\N	t	\N	\N	fanya	\N	\N	\N	\N	\N	\N	{"UserId":78}	{user}	f	\N	78	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
786	Carola Nitz	\N	USD	2016-09-29 14:43:49.157-04	\N	\N	t	\N	\N	carolanitz	\N	\N	\N	\N	\N	\N	{"UserId":1376}	{user}	f	\N	1376	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
790	Irina Muchnik	\N	USD	2016-09-29 14:12:58.838-04	\N	\N	t	\N	\N	irinamuchnik	\N	\N	\N	\N	\N	\N	{"UserId":1335}	{user}	f	\N	1335	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
794	data.world Swider	\N	USD	2016-09-28 17:47:14.881-04	\N	\N	t	\N	https://opencollective-production.s3-us-west-1.amazonaws.com/dataworld_6f037d50-85c5-11e6-9fd7-73dd31eb7c0c.png	gabrielaswider	http://data.world	datadotworld	\N	\N	\N	\N	{"UserId":1299}	{user}	f	\N	1299	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
799	Brian Vinci	\N	USD	2017-05-15 08:07:56.682-04	\N	\N	t	\N	https://opencollective-production.s3-us-west-1.amazonaws.com/4fc0a750-3967-11e7-955e-43d656f05f49.jpg	brian1	http://expeditionhacks.com/seattle	expeditionhacks	\N	\N	\N	\N	{"UserId":4834}	{user}	f	\N	4834	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
811	Laura Uzcátegui	\N	USD	2016-09-29 14:37:07.337-04	\N	\N	t	\N	\N	laurauzcátegui	\N	\N	\N	\N	\N	\N	{"UserId":1365}	{user}	f	\N	1365	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
818	Aya Nakagawa	\N	USD	2016-09-29 14:33:37.088-04	\N	\N	t	\N	\N	ayanakagawa	\N	\N	\N	\N	\N	\N	{"UserId":1360}	{user}	f	\N	1360	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
819	Aseem Sood	Cofounder, Open Collective.	USD	2015-11-30 15:20:11.257-05	\N	\N	t	Tell us more about you, why you are on OpenCollective, what types of collectives you would love to contribute to, etc.\n\nProtip: you can use [markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)	https://opencollective-production.s3-us-west-1.amazonaws.com/jMoeGBOJjpg_d83f6890-a13d-11e6-a8af-411ab4a2c609.jpeg	aseem	\N	AseemSood_	\N	\N	\N	\N	{"UserId":8}	{user}	f	\N	8	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
820	Bonsai.io	\N	USD	2016-04-13 12:46:07.217-04	\N	\N	t	\N	https://img.stackshare.io/service/228/c0daef6c2bf692d268e53a799111789c.png	bonsai	https://bonsai.io/	bonsaisearch	\N	\N	\N	\N	{"UserId":224}	{user}	f	\N	224	\N	\N	ORGANIZATION	\N	\N	\N	\N	\N	\N	\N	\N
824	Dev Bootcamp 	\N	USD	2016-04-28 11:01:14.69-04	\N	\N	t	\N	https://logo.clearbit.com/devbootcamp.com	devbootcamp	http://www.devbootcamp.com	devbootcamp 	\N	\N	\N	\N	{"UserId":283}	{user}	f	\N	283	\N	\N	ORGANIZATION	\N	\N	\N	\N	\N	\N	\N	\N
825	Viv Del Rio	\N	USD	2016-09-29 14:38:54.951-04	\N	\N	t	\N	\N	vivdelrio	\N	\N	\N	\N	\N	\N	{"UserId":1370}	{user}	f	\N	1370	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
829	Anouk Ruhaak	\N	USD	2016-09-29 14:43:49.04-04	\N	\N	t	\N	\N	anoukruhaak	\N	\N	\N	\N	\N	\N	{"UserId":1375}	{user}	f	\N	1375	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
833	Laura Scholl	\N	USD	2016-09-29 14:32:00.983-04	\N	\N	t	\N	\N	laurascholl	\N	\N	\N	\N	\N	\N	{"UserId":1358}	{user}	f	\N	1358	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
835	Karen Farzam	\N	USD	2016-09-29 14:08:19.487-04	\N	\N	t	\N	\N	karenfarzam	\N	\N	\N	\N	\N	\N	{"UserId":1327}	{user}	f	\N	1327	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
840	Craft CMS	Content-first. Faceless like Jaqen.	USD	2017-04-20 05:34:08.219-04	\N	\N	t	Craft is a content-first CMS that aims to make life enjoyable for developers and content managers alike. It’s the tool of choice for thousands of [remarkably attractive](https://craftcms.com/community) web professionals around the world.	https://opencollective-production.s3-us-west-1.amazonaws.com/8e9cfe00-25ae-11e7-8c00-677620cd0201.png	craftcms	https://craftcms.com	craftcms	\N	\N	\N	\N	{"UserId":4348}	{user}	f	\N	4348	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
841	Erin Spiceland	\N	USD	2017-03-07 14:01:52.704-05	\N	\N	t	\N	https://d1ts43dypk8bqh.cloudfront.net/v1/avatars/4dedad77-5def-4d84-8e72-47bf0051649c	erin	\N	\N	\N	\N	\N	\N	{"UserId":3419}	{user}	f	\N	3419	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
723	Qianyi Zheng	\N	USD	2016-09-29 14:26:35.133-04	\N	\N	t	\N	\N	qianyizheng	\N	\N	\N	\N	\N	\N	{"UserId":1349}	{user}	f	\N	1349	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
728	Andreza Leite	\N	USD	2016-09-29 14:19:11.446-04	\N	\N	t	\N	\N	andrezaleite	\N	\N	\N	\N	\N	\N	{"UserId":1343}	{user}	f	\N	1343	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
735	Tiffany Andrews	\N	USD	2016-09-29 14:12:58.852-04	\N	\N	t	\N	\N	tiffanyandrews	\N	\N	\N	\N	\N	\N	{"UserId":1336}	{user}	f	\N	1336	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
741	Ellevest	\N	USD	2016-05-23 16:27:26.092-04	\N	\N	t	\N	https://opencollective-production.s3-us-west-1.amazonaws.com/ellevestcom_0882df80-2125-11e6-9a76-e98f5a4a50b6.png	ellevest	http://www.ellevest.com	Ellevest	\N	\N	\N	\N	{"UserId":426}	{user}	f	\N	426	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
742	Shahnaz Kamberi	\N	USD	2016-06-06 20:53:44.829-04	\N	\N	t	\N	https://opencollective-production.s3-us-west-1.amazonaws.com/dcacmorg_5f260cb0-2c4a-11e6-80e4-310475aa5f5c.png	dcacm	http://dcacm.org	dcacm	\N	\N	\N	\N	{"UserId":555}	{user}	f	\N	555	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
746	Casey Gruppioni	\N	USD	2016-08-02 20:00:00-04	\N	\N	t	\N	\N	casey	\N	\N	\N	\N	\N	\N	{"UserId":898}	{user}	f	\N	898	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
754	Polson & Polson, P.C.	\N	USD	2017-03-09 13:29:51.939-05	\N	\N	t	\N	https://opencollective-production.s3-us-west-1.amazonaws.com/9R0XXM9_normalpng_75889240-04f6-11e7-8ab4-9b0a3890c09e.png	nalini	http://www.polsonlawfirm.com/	\N	\N	\N	\N	\N	{"UserId":3442}	{user}	f	\N	3442	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
763	Eileen C	\N	USD	2017-01-14 12:11:39.224-05	\N	\N	t	\N	https://opencollective-production.s3-us-west-1.amazonaws.com/7be57fdf74ce40868c36ec561b515b9d_8a6a4900-da7c-11e6-af11-676b2b71a93b.jpeg	eileenc	\N	\N	\N	\N	\N	\N	{"UserId":2549}	{user}	f	\N	2549	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
764	Sheree Atcheson	\N	USD	2016-09-29 13:54:53.462-04	\N	\N	t	\N	\N	shereeatcheson	\N	\N	\N	\N	\N	\N	{"UserId":1314}	{user}	f	\N	1314	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
769	Oksana Denesiuk	\N	USD	2016-09-29 14:30:08.978-04	\N	\N	t	\N	\N	oksanadenesiuk	\N	\N	\N	\N	\N	\N	{"UserId":1355}	{user}	f	\N	1355	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
772	Shwetha Lakshman Rao	\N	USD	2016-09-29 13:51:29.333-04	\N	\N	t	\N	\N	shwethalakshmanrao	\N	\N	\N	\N	\N	\N	{"UserId":1309}	{user}	f	\N	1309	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
777	Racha Bella	\N	USD	2016-09-29 13:49:43.061-04	\N	\N	t	\N	\N	rachabella	\N	\N	\N	\N	\N	\N	{"UserId":1308}	{user}	f	\N	1308	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
785	Lacey Reinoehl	\N	USD	2017-05-01 13:13:32.139-04	\N	\N	t	\N	https://d1ts43dypk8bqh.cloudfront.net/v1/avatars/8207c9a5-55ed-41a7-a238-4ef4d22a6059	laceyreinoehl	\N	\N	\N	\N	\N	\N	{"UserId":4550}	{user}	f	\N	4550	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
797	Saranya Karuppusamy	\N	USD	2016-01-11 13:54:33.296-05	\N	\N	t	\N	https://opencollective-production.s3-us-west-1.amazonaws.com/35f74ebjpg_d2d1c140-35a4-11e7-8caa-3b6f8e012814.jpeg	saranyawwc	\N	\N	\N	\N	\N	\N	{"UserId":32}	{user}	f	\N	32	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
801	ericalucaterochapman	\N	USD	2017-02-01 10:16:17.461-05	\N	\N	t	\N	\N	ericalucaterochapman	\N	\N	\N	\N	\N	\N	{"UserId":2898}	{user}	f	\N	2898	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
806	Erica	\N	USD	2016-01-11 13:59:41.948-05	\N	\N	t	\N	https://pbs.twimg.com/profile_images/672467424273395712/m0VtgmYQ.jpg	estanley	\N	\N	\N	\N	\N	\N	{"UserId":35}	{user}	f	\N	35	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
807	Vicky Twomey-Lee	\N	USD	2016-09-29 14:37:07.344-04	\N	\N	t	\N	\N	vickytwomey-lee	\N	\N	\N	\N	\N	\N	{"UserId":1366}	{user}	f	\N	1366	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
817	Kaylyn	\N	USD	2016-01-11 13:57:18.467-05	\N	\N	t	\N	https://res.cloudinary.com/opencollective/image/upload/v1483039249/i8n9dw-4_vxdyyi.jpg	kgibilterra	\N	\N	\N	\N	\N	\N	{"UserId":33}	{user}	f	\N	33	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
830	Gen Ashley	Director, Women Who Code London	USD	2016-09-29 14:11:53.842-04	\N	\N	t	\N	https://opencollective-production.s3-us-west-1.amazonaws.com/f739ff80-86fd-11e6-9561-f9be8e5da60b.jpeg	genashley	\N	\N	\N	\N	\N	\N	{"UserId":1333}	{user}	f	\N	1333	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
831	Jecelyn	\N	USD	2016-09-29 14:10:43.392-04	\N	\N	t	\N	https://opencollective-production.s3-us-west-1.amazonaws.com/8146ec1d435a48c9a5f9d45600963c05_98566490-0ab0-11e7-85e3-cf8c26b6ca26.jpeg	jecelynyeen	\N	\N	\N	\N	\N	\N	{"UserId":1332}	{user}	f	\N	1332	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
724	Roxane Castelein	\N	USD	2016-09-29 14:25:21.969-04	\N	\N	t	\N	\N	roxanecastelein	\N	\N	\N	\N	\N	\N	{"UserId":1348}	{user}	f	\N	1348	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
729	Jennifer Hoover	\N	USD	2016-09-29 14:16:52.099-04	\N	\N	t	\N	\N	jenniferhoover	\N	\N	\N	\N	\N	\N	{"UserId":1341}	{user}	f	\N	1341	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
734	Isabel Yepes	\N	USD	2016-09-29 14:13:48.772-04	\N	\N	t	\N	\N	isabelyepes	\N	\N	\N	\N	\N	\N	{"UserId":1337}	{user}	f	\N	1337	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
739	Jane Shih	\N	USD	2016-09-07 18:13:23.624-04	\N	\N	t	\N	\N	janeshih	\N	\N	\N	\N	\N	\N	{"UserId":1145}	{user}	f	\N	1145	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
747	Elijah Van Der Giessen	\N	USD	2017-05-10 19:45:43.307-04	\N	\N	t	\N	https://d1ts43dypk8bqh.cloudfront.net/v1/avatars/d7d17c0e-20b0-40ae-a128-eaf85a311f0c	eli	\N	\N	\N	\N	\N	\N	{"UserId":4749}	{user}	f	\N	4749	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
750	New York Code + Design Academy (Austin)	\N	USD	2016-08-01 11:55:23.132-04	\N	\N	t	\N	https://opencollective-production.s3-us-west-1.amazonaws.com/rlc8ysokffcsnalr5jav_normalgif_7ff2c640-5800-11e6-a2a8-bb3ee7158535.gif	nycda	http://nycda.com/austin	atxcodedesign	\N	\N	\N	\N	{"UserId":884}	{user}	f	\N	884	\N	\N	ORGANIZATION	\N	\N	\N	\N	\N	\N	\N	\N
753	Neha Kaura	\N	USD	2016-09-29 14:01:49.703-04	\N	\N	t	\N	\N	nehakaura	\N	\N	\N	\N	\N	\N	{"UserId":1319}	{user}	f	\N	1319	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
758	Amber Joyner	\N	USD	2016-09-29 14:01:04.636-04	\N	\N	t	\N	\N	amberjoyner	\N	\N	\N	\N	\N	\N	{"UserId":1317}	{user}	f	\N	1317	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
760	Mia Zhu	\N	USD	2016-09-29 13:59:15.428-04	\N	\N	t	\N	\N	miazhu	\N	\N	\N	\N	\N	\N	{"UserId":1316}	{user}	f	\N	1316	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
762	beth laing	\N	USD	2016-01-29 18:18:53.83-05	\N	\N	t	\N	\N	beth	\N	\N	\N	\N	\N	\N	{"UserId":70}	{user}	f	\N	70	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
768	Maru Lango	\N	USD	2016-02-02 11:52:02.222-05	\N	\N	t	\N	https://res.cloudinary.com/opencollective/image/upload/v1483038929/8vJ-Prbe_imotym.png	marulango	http://maruma.ru	Marulango	\N	\N	\N	\N	{"UserId":80}	{user}	f	\N	80	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
770	Smitha Radhakrishnan	\N	USD	2016-09-29 13:51:29.334-04	\N	\N	t	\N	\N	smitharadhakrishnan	\N	\N	\N	\N	\N	\N	{"UserId":1310}	{user}	f	\N	1310	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
774	Zoe Madden-Wood	\N	USD	2016-01-29 18:19:53.922-05	\N	\N	t	\N	\N	zoemadden-wood	\N	\N	\N	\N	\N	\N	{"UserId":77}	{user}	f	\N	77	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
784	Rose THERESA	\N	USD	2016-01-29 18:19:47.116-05	\N	\N	t	\N	\N	rosetheresa	\N	\N	\N	\N	\N	\N	{"UserId":76}	{user}	f	\N	76	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
788	Google Fiber	\N	USD	2016-09-13 00:15:01.959-04	\N	\N	t	\N	\N	googlefiber	http://fiber.google.com	googlefiber	\N	\N	\N	\N	{"UserId":1178}	{user}	f	\N	1178	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
796	Radhika Rayadu	\N	USD	2016-09-29 14:41:11.058-04	\N	\N	t	\N	\N	radhikarayadu	\N	\N	\N	\N	\N	\N	{"UserId":1372}	{user}	f	\N	1372	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
802	Erika Aguayo	\N	USD	2016-09-29 14:38:54.935-04	\N	\N	t	\N	\N	erikaaguayo	\N	\N	\N	\N	\N	\N	{"UserId":1369}	{user}	f	\N	1369	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
815	Lucy Bain	\N	USD	2016-09-29 14:34:59.504-04	\N	\N	t	\N	\N	lucybain	\N	\N	\N	\N	\N	\N	{"UserId":1363}	{user}	f	\N	1363	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
816	Brenda	\N	USD	2016-01-29 18:19:12.899-05	\N	\N	t	\N	\N	brenda	\N	\N	\N	\N	\N	\N	{"UserId":71}	{user}	f	\N	71	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
821	Marcela Lango	\N	USD	2015-11-19 05:09:51.192-05	\N	\N	t	\N	https://pbs.twimg.com/profile_images/445400536569749504/8vJ-Prbe.png	maru	\N	\N	\N	\N	\N	\N	{"UserId":7}	{user}	f	\N	7	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
822	Fernanda	\N	USD	2016-01-11 14:02:41.058-05	\N	\N	t	\N	https://media.licdn.com/media/AAEAAQAAAAAAAAJzAAAAJGZiYzM3MzEyLTVkYzgtNDg2Mi04Yzg3LWI1NDM0NDhhZjRhNQ.jpg	fsantander	\N	\N	\N	\N	\N	\N	{"UserId":37}	{user}	f	\N	37	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
827	Caterina Paun	Director, WWCode Portland	USD	2016-03-19 18:11:53.101-04	\N	\N	t	\N	https://opencollective-production.s3-us-west-1.amazonaws.com/7446276v3s466_4d6a9940-90b9-11e6-a134-f381d4cd2713.png	cpaun	\N	\N	\N	\N	\N	\N	{"UserId":171}	{user}	f	\N	171	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
837	Sue Sinclair	\N	USD	2017-02-27 19:25:15.503-05	\N	\N	t	\N	https://d1ts43dypk8bqh.cloudfront.net/v1/avatars/c50d2350-ae0b-4347-9e9b-3b51d55fd22d	sue	\N	\N	\N	\N	\N	\N	{"UserId":3301}	{user}	f	\N	3301	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
838	Flock: Accelerating Women In Tech	\N	USD	2017-02-09 15:42:02.01-05	\N	\N	t	\N	https://opencollective-production.s3-us-west-1.amazonaws.com/findmyflockcom_b7503b70-efb0-11e6-bcba-ed56440ee54a.png	kate	http://www.findmyflock.com	FindMyFlock	\N	\N	\N	\N	{"UserId":3053}	{user}	f	\N	3053	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
839	Rackspace	\N	USD	2016-08-01 11:54:10.844-04	\N	\N	t	\N	https://opencollective-production.s3-us-west-1.amazonaws.com/rackspacecom_a7d669f0-5800-11e6-a2a8-bb3ee7158535.png	rackspace	https://www.rackspace.com/	rackspace	\N	\N	\N	\N	{"UserId":883}	{user}	f	\N	883	\N	\N	ORGANIZATION	\N	\N	\N	\N	\N	\N	\N	\N
846	Nicole Giannone	\N	USD	2017-05-09 14:14:19.572-04	\N	\N	t	\N	https://d1ts43dypk8bqh.cloudfront.net/v1/avatars/5bd8eb7d-65e2-482e-b9dd-ff7f33bf804b	nicole1	\N	\N	\N	\N	\N	\N	{"UserId":4720}	{user}	f	\N	4720	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
525	Women Who Code Pune	\N	USD	2017-02-21 15:16:59.055-05	2017-02-21 15:18:19.484-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur programs include hack nights, technical study groups, lightning talks, product demos, and leadership development. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow!\n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLScJkMSAeQ1r0L6uAFd-QO4-sHwEJ8BuD3tTdHSYzOkRkZGIhQ/viewform)\n\n[**Attend**](https://www.womenwhocode.com/pune) an event \n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLScJkMSAeQ1r0L6uAFd-QO4-sHwEJ8BuD3tTdHSYzOkRkZGIhQ/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLScJkMSAeQ1r0L6uAFd-QO4-sHwEJ8BuD3tTdHSYzOkRkZGIhQ/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodepune#support) to support WWCode Pune \n\nQuestions? Email us at global@womenwhocode.com.\n\n	\N	wwcodepune	\N	\N	WWCode is a non-profit organization that inspires women to excel in technology careers.\n	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
725	Barbara	\N	USD	2016-01-29 18:19:28.648-05	\N	\N	t	\N	\N	barbara	\N	\N	\N	\N	\N	\N	{"UserId":73}	{user}	f	\N	73	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
733	Grisel Ancona	\N	USD	2016-09-29 14:15:23.931-04	\N	\N	t	\N	\N	griselancona	\N	\N	\N	\N	\N	\N	{"UserId":1339}	{user}	f	\N	1339	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
738	thirteen23	\N	USD	2016-09-01 10:41:33.243-04	\N	\N	t	\N	https://opencollective-production.s3-us-west-1.amazonaws.com/thirteen23com_805f0980-7052-11e6-8e5a-492f532f3a40.png	thirteen23	http://www.thirteen23.com	thirteen23	\N	\N	\N	\N	{"UserId":1094}	{user}	f	\N	1094	\N	\N	ORGANIZATION	\N	\N	\N	\N	\N	\N	\N	\N
744	Candace Lazarou	\N	USD	2016-09-29 14:05:19.079-04	\N	\N	t	\N	\N	candacelazarou	\N	\N	\N	\N	\N	\N	{"UserId":1324}	{user}	f	\N	1324	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
749	Carole Bennett	\N	USD	2016-09-29 14:03:46.798-04	\N	\N	t	\N	\N	carolebennett	\N	\N	\N	\N	\N	\N	{"UserId":1322}	{user}	f	\N	1322	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
757	Sally Kingston	\N	USD	2016-09-29 14:01:04.636-04	\N	\N	t	\N	\N	sallykingston	\N	\N	\N	\N	\N	\N	{"UserId":1318}	{user}	f	\N	1318	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
767	Xinhui Li	\N	USD	2016-09-29 13:53:00.503-04	\N	\N	t	\N	\N	xinhuili	\N	\N	\N	\N	\N	\N	{"UserId":1312}	{user}	f	\N	1312	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
771	Lindsey Barrett	\N	USD	2016-06-22 16:09:43.896-04	\N	\N	t	\N	\N	lindseybarrett	\N	\N	\N	\N	\N	\N	{"UserId":646}	{user}	f	\N	646	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
775	Joey Rosenberg	\N	USD	2016-06-21 12:02:52.874-04	\N	\N	t	\N	https://opencollective-production.s3-us-west-1.amazonaws.com/IndianVisa_RosenbergJPG_17d93090-37ca-11e6-90ee-0555971b7ddd.JPG	joeycrose	\N	joeycrose	\N	\N	\N	\N	{"UserId":642}	{user}	f	\N	642	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
779	Gabriela Adamova	\N	USD	2016-01-29 18:19:43.713-05	\N	\N	t	\N	\N	gabrielaadamova	\N	\N	\N	\N	\N	\N	{"UserId":75}	{user}	f	\N	75	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
780	Fatma Djoudjou	\N	USD	2016-09-29 13:49:43.051-04	\N	\N	t	\N	\N	fatmadjoudjou	\N	\N	\N	\N	\N	\N	{"UserId":1307}	{user}	f	\N	1307	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
782	Silvia Pina	\N	USD	2016-09-29 14:43:49.189-04	\N	\N	t	\N	\N	silviapina	\N	\N	\N	\N	\N	\N	{"UserId":1377}	{user}	f	\N	1377	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
787	Nupur Kapoor	\N	USD	2016-01-29 18:16:09.038-05	\N	\N	t	\N	https://d1ts43dypk8bqh.cloudfront.net/v1/avatars/572a82f0-a28a-4e61-ba19-a0f09f1e812b	kapoornupur	\N	kapoornupur	\N	\N	\N	\N	{"UserId":67}	{user}	f	\N	67	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
791	Sonia Prabhu	\N	USD	2016-09-29 14:41:11.058-04	\N	\N	t	\N	\N	soniaprabhu	\N	\N	\N	\N	\N	\N	{"UserId":1373}	{user}	f	\N	1373	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
792	Isaac Potoczny-Jones	\N	USD	2016-09-22 21:07:06.058-04	\N	\N	t	\N	https://opencollective-production.s3-us-west-1.amazonaws.com/466bd3a0-812a-11e6-8430-9f6ee94192cb.png	tozny	https://tozny.com	Tozny	\N	\N	\N	\N	{"UserId":1263}	{user}	f	\N	1263	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
793	Glenna Buford	\N	USD	2016-09-29 14:43:49.205-04	\N	\N	t	\N	https://opencollective-production.s3-us-west-1.amazonaws.com/8a3d40b0-8fed-11e6-b320-5125b901f984.jpg	glennabuford	\N	\N	\N	\N	\N	\N	{"UserId":1378}	{user}	f	\N	1378	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
798	Cisco	\N	USD	2016-04-29 14:46:16.143-04	\N	\N	t	\N	https://opencollective-production.s3-us-west-1.amazonaws.com/dAmHQYgjpg_6d4cc930-1130-11e6-9815-b7ee6884387f.jpg	cisco	http://cisco.com	cisco	\N	\N	\N	\N	{"UserId":308}	{user}	f	\N	308	\N	\N	ORGANIZATION	\N	\N	\N	\N	\N	\N	\N	\N
803	pkmass	\N	USD	2016-07-01 18:31:42.541-04	\N	\N	t	\N	\N	pkmass	\N	\N	\N	\N	\N	\N	{"UserId":686}	{user}	f	\N	686	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
804	Ana Castro	\N	USD	2016-09-29 14:38:54.934-04	\N	\N	t	\N	\N	anacastro	\N	\N	\N	\N	\N	\N	{"UserId":1368}	{user}	f	\N	1368	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
813	Emily Heist Moss	\N	USD	2016-02-18 14:54:08.5-05	\N	\N	t	\N	https://d1ts43dypk8bqh.cloudfront.net/v1/avatars/18b8dbe9-bc4b-4e82-b6db-b41eff9ca2e5	emilyheistmoss	\N	EmilyHeistMoss	\N	\N	\N	\N	{"UserId":108}	{user}	f	\N	108	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
814	Daphne Chong	\N	USD	2016-09-29 14:34:59.499-04	\N	\N	t	\N	\N	daphnechong	\N	\N	\N	\N	\N	\N	{"UserId":1362}	{user}	f	\N	1362	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
823	Kelly	\N	USD	2016-01-11 13:58:47.796-05	\N	\N	t	\N	https://pbs.twimg.com/profile_images/523157919999602688/00l1ZQIf.jpeg	kshuster	\N	\N	\N	\N	\N	\N	{"UserId":34}	{user}	f	\N	34	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
834	Alicia	\N	USD	2016-01-29 18:18:47.287-05	\N	\N	t	\N	\N	alicia	\N	\N	\N	\N	\N	\N	{"UserId":69}	{user}	f	\N	69	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
842	Nikko Patten	\N	USD	2017-04-10 21:09:47.41-04	\N	\N	t	\N	https://d1ts43dypk8bqh.cloudfront.net/v1/avatars/2e150bf7-d054-400f-8f23-35dab9acf9c9	nikko	https://twitter.com/NikkoPatten	NikkoPatten	\N	\N	\N	\N	{"UserId":4153}	{user}	f	\N	4153	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
847	Holly	\N	USD	2015-12-21 11:34:26.053-05	\N	\N	t	\N	https://media.licdn.com/media/AAEAAQAAAAAAAAUUAAAAJDVjMTAxNGYxLWZhZmUtNDQ4Yi1hMzFjLWIzYmU3MTZjNGYxNA.jpg	ogibson	\N	\N	\N	\N	\N	\N	{"UserId":28}	{user}	f	\N	28	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
726	Shruti Sethi	\N	USD	2016-09-29 14:24:17.81-04	\N	\N	t	\N	\N	shrutisethi	\N	\N	\N	\N	\N	\N	{"UserId":1346}	{user}	f	\N	1346	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
732	Princy James	\N	USD	2016-09-29 14:14:46.606-04	\N	\N	t	\N	\N	princyjames	\N	\N	\N	\N	\N	\N	{"UserId":1338}	{user}	f	\N	1338	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
737	Pieceofr	\N	USD	2016-09-09 23:42:48.933-04	\N	\N	t	\N	https://opencollective-production.s3-us-west-1.amazonaws.com/2c8df290-7709-11e6-a96a-b97f0af14723.jpg	pieceofr	\N	\N	\N	\N	\N	\N	{"UserId":1158}	{user}	f	\N	1158	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
740	FJ Genus	\N	USD	2016-09-29 14:09:42.794-04	\N	\N	t	\N	\N	fjgenus	\N	\N	\N	\N	\N	\N	{"UserId":1330}	{user}	f	\N	1330	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
743	KeSha Shah	\N	USD	2016-09-29 14:06:44.745-04	\N	\N	t	\N	\N	keshashah	\N	\N	\N	\N	\N	\N	{"UserId":1326}	{user}	f	\N	1326	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
748	Radhika Malik	\N	USD	2016-08-02 20:00:00-04	\N	\N	t	\N	\N	radhikam	\N	\N	\N	\N	\N	\N	{"UserId":897}	{user}	f	\N	897	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
755	Rylee	\N	USD	2016-01-29 18:18:13.688-05	\N	\N	t	\N	\N	rylee	\N	\N	\N	\N	\N	\N	{"UserId":68}	{user}	f	\N	68	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
759	Geoff Domoracki	\N	USD	2016-08-03 13:47:13.173-04	\N	\N	t	\N	\N	geoffdomoracki	\N	\N	\N	\N	\N	\N	{"UserId":896}	{user}	f	\N	896	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
765	Gillian Colan-O'Leary	\N	USD	2016-09-29 13:54:53.45-04	\N	\N	t	\N	\N	gilliancolan-o'leary	\N	\N	\N	\N	\N	\N	{"UserId":1313}	{user}	f	\N	1313	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
776	Christina Lynch	\N	USD	2016-09-29 14:37:07.344-04	\N	\N	t	\N	\N	christinalynch	\N	\N	\N	\N	\N	\N	{"UserId":1367}	{user}	f	\N	1367	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
781	Allison Canestaro	\N	USD	2016-06-06 15:04:33.418-04	\N	\N	t	\N	\N	allisoncanestaro	\N	\N	\N	\N	\N	\N	{"UserId":551}	{user}	f	\N	551	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
783	Judith Agbotse	\N	USD	2016-09-29 13:44:40.429-04	\N	\N	t	\N	\N	judithagbotse	\N	\N	\N	\N	\N	\N	{"UserId":1305}	{user}	f	\N	1305	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
789	Lucy Shang	\N	USD	2016-09-29 13:53:00.502-04	\N	\N	t	\N	\N	lucyshang	\N	\N	\N	\N	\N	\N	{"UserId":1311}	{user}	f	\N	1311	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
795	Guiti Nabavi	\N	USD	2016-09-29 14:41:11.052-04	\N	\N	t	\N	\N	guitinabavi	\N	\N	\N	\N	\N	\N	{"UserId":1371}	{user}	f	\N	1371	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
800	Aleksandra Gavriloska	\N	USD	2016-09-29 14:43:49.211-04	\N	\N	t	\N	\N	aleksandragavriloska	\N	\N	\N	\N	\N	\N	{"UserId":1379}	{user}	f	\N	1379	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
805	RigUp	\N	USD	2016-03-25 11:11:02.011-04	\N	\N	t	\N	https://a2.mzstatic.com/us/r30/Purple7/v4/23/90/cc/2390cca9-c82f-6700-4f13-f1cb4ca15991/icon350x350.jpeg	rigup	https://www.rigup.com	deepinsand	\N	\N	\N	\N	{"UserId":192}	{user}	f	\N	192	\N	\N	ORGANIZATION	\N	\N	\N	\N	\N	\N	\N	\N
808	The Human Geo Group	\N	USD	2016-04-29 09:51:16.619-04	\N	\N	t	\N	https://logo.clearbit.com/thehumangeo.com	thehumangeo	\N	\N	\N	\N	\N	\N	{"UserId":303}	{user}	f	\N	303	\N	\N	ORGANIZATION	\N	\N	\N	\N	\N	\N	\N	\N
809	Paige Hubbell	\N	USD	2016-03-19 18:11:44.881-04	\N	\N	t	\N	\N	phubbell	\N	\N	\N	\N	\N	\N	{"UserId":170}	{user}	f	\N	170	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
810	Jamie Lu	\N	USD	2016-11-28 10:33:11.726-05	\N	\N	t	\N	https://logo.clearbit.com/narrativescience.com	jamielu	http://www.narrativescience.com	\N	\N	\N	\N	\N	{"UserId":1890}	{user}	f	\N	1890	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
812	Peggy Kuo	\N	USD	2016-09-29 14:34:59.505-04	\N	\N	t	\N	\N	peggykuo	\N	\N	\N	\N	\N	\N	{"UserId":1364}	{user}	f	\N	1364	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
826	Dayra	\N	USD	2016-01-11 14:01:43.411-05	\N	\N	t	\N	https://media.licdn.com/media/p/6/005/04f/283/2b9ae46.jpg	dchiu	\N	\N	\N	\N	\N	\N	{"UserId":36}	{user}	f	\N	36	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
828	Himi Sato	\N	USD	2016-09-29 14:33:37.087-04	\N	\N	t	\N	\N	himisato	\N	\N	\N	\N	\N	\N	{"UserId":1359}	{user}	f	\N	1359	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
832	Mami Enomoto	\N	USD	2016-09-29 14:33:37.095-04	\N	\N	t	\N	\N	mamienomoto	\N	\N	\N	\N	\N	\N	{"UserId":1361}	{user}	f	\N	1361	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
836	Allie Winkelman	\N	USD	2017-04-04 15:51:02.718-04	\N	\N	t	\N	\N	lwinkelman	\N	\N	\N	\N	\N	\N	{"UserId":3999}	{user}	f	\N	3999	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
843	Pamela Wood Browne	\N	USD	2016-09-29 14:06:00.962-04	\N	\N	t	\N	https://opencollective-production.s3-us-west-1.amazonaws.com/f08e3667929b4091bb398793543c458b_3c79dff0-89a8-11e6-b81f-a9802cdb670c.jpeg	pamelawoode-browne	\N	\N	\N	\N	\N	\N	{"UserId":1325}	{user}	f	\N	1325	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
844	Jigyasa Grover	\N	USD	2016-03-07 04:50:58.721-05	\N	\N	t	\N	https://res.cloudinary.com/opencollective/image/upload/v1483042743/ext_a8caeh.jpg	jigyasagrover	https://www.linkedin.com/in/jigyasagrover	\N	\N	\N	\N	\N	{"UserId":141}	{user}	f	\N	141	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
845	Chantal	\N	USD	2016-01-29 18:19:36.407-05	\N	\N	t	\N	\N	chantal	\N	\N	\N	\N	\N	\N	{"UserId":74}	{user}	f	\N	74	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
276	WWCode Kingston	WWCode is a global non-profit organization that inspires women to excel in technology careers.	USD	2016-09-29 14:09:42.765-04	2016-12-27 11:58:14.247-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Kingston**](https://www.womenwhocode.com/kingston). \n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSeaXQzj8paXy2_359fBuU2ZeztJLTRGI6coQQ99dI6K1CHiXg/viewform)\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSeaXQzj8paXy2_359fBuU2ZeztJLTRGI6coQQ99dI6K1CHiXg/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSeaXQzj8paXy2_359fBuU2ZeztJLTRGI6coQQ99dI6K1CHiXg/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodeboston#support) to support WWCode Kingston \n\nQuestions? Email us at global@womenwhocode.com.	https://opencollective-production.s3-us-west-1.amazonaws.com/a7236520-cc55-11e6-be07-3dfc36c6d12c.png	wwcodekingston	\N	wwcodekingston	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
294	WWCode Wichita	WWCode is a global non-profit organization that inspires women to excel in technology careers.	USD	2016-09-29 14:32:00.962-04	2016-12-28 11:31:16.784-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Wichita**](https://www.womenwhocode.com/wichita). \n\n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSduY4sClbMfcDUnUl1_ZYK_HwA-ui81pWBcXF40sEuGL8bdTw/viewform)\n\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSduY4sClbMfcDUnUl1_ZYK_HwA-ui81pWBcXF40sEuGL8bdTw/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSduY4sClbMfcDUnUl1_ZYK_HwA-ui81pWBcXF40sEuGL8bdTw/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodewichita#support) to support WWCode Wichita \n\nQuestions? Email us at global@womenwhocode.com.  \n\n	https://opencollective-production.s3-us-west-1.amazonaws.com/6cae1920-a6d6-11e6-bdef-45bfa9f9c1b0.png	wwcodewichita	\N	wwcodewichita	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
299	WWCode Colima	WWCode is a global non-profit organization that inspires women to excel in technology careers.	MXN	2016-09-29 14:38:52.23-04	2016-12-27 11:09:39.74-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Colima**](https://www.womenwhocode.com/colima). \n\n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLScHuzUYo7CGFNBBEWJEBEimY4ARGF4rpmyTtJ2K00dy8f-XiQ/viewform)\n\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLScHuzUYo7CGFNBBEWJEBEimY4ARGF4rpmyTtJ2K00dy8f-XiQ/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLScHuzUYo7CGFNBBEWJEBEimY4ARGF4rpmyTtJ2K00dy8f-XiQ/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodecolima#support) to support WWCode Colima \n\nQuestions? Email us at global@womenwhocode.com.  \n	https://opencollective-production.s3-us-west-1.amazonaws.com/a02c3dc0-9ba2-11e6-84fe-5d5e57220970.png	wwcodecolima	\N	\N	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
848	MakerSquare	\N	USD	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	{"UserId":129}	\N	f	\N	129	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
849	thirteen23	\N	USD	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	{"UserId":1094}	\N	f	\N	1094	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
850	New York Code + Design Academy (Austin)	\N	USD	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	{"UserId":884}	\N	f	\N	884	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
851	Cisco	\N	USD	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	{"UserId":308}	\N	f	\N	308	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
852	RigUp	\N	USD	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	{"UserId":192}	\N	f	\N	192	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
853	The Human Geo Group	\N	USD	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	{"UserId":303}	\N	f	\N	303	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
854	Bonsai.io	\N	USD	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	{"UserId":224}	\N	f	\N	224	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
855	Dev Bootcamp 	\N	USD	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	{"UserId":283}	\N	f	\N	283	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
856	Rackspace	\N	USD	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	{"UserId":883}	\N	f	\N	883	\N	\N	USER	\N	\N	\N	\N	\N	\N	\N	\N
47	WWCode Delhi	WWCode inspires women to excel in technology careers.	USD	2016-03-06 19:00:00-05	2016-12-27 11:24:21.89-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Delhi**](https://www.womenwhocode.com/delhi). \n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSeIWjjfybWImspAgeEVa_K6bnuV-3jqSt951M2x5VTrp1ymZw/viewform)\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSeIWjjfybWImspAgeEVa_K6bnuV-3jqSt951M2x5VTrp1ymZw/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSeIWjjfybWImspAgeEVa_K6bnuV-3jqSt951M2x5VTrp1ymZw/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodedelhi#support) to support WWCode Delhi \n\nQuestions? Email us at global@womenwhocode.com.  \n	https://cldup.com/MFUk1nU_IQ.png	wwcodedelhi	https://www.womenwhocode.com/dc	wwcode_delhi	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	\N	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
522	Women Who Code Vancouver	\N	CAD	2017-02-21 14:45:19.101-05	2017-02-21 14:48:46.905-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur programs include hack nights, technical study groups, lightning talks, product demos, and leadership development. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow!\n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSd1osMiiyVCoIUO3ZK8qcap7tFhhzGLvJAKO37CuLN0-eGTjg/viewform)\n\n[**Attend**](https://www.womenwhocode.com/vancouver) an event \n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSd1osMiiyVCoIUO3ZK8qcap7tFhhzGLvJAKO37CuLN0-eGTjg/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSd1osMiiyVCoIUO3ZK8qcap7tFhhzGLvJAKO37CuLN0-eGTjg/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodevancouver#support) to support WWCode Vancouver \n\nQuestions? Email us at global@womenwhocode.com.\n\n	\N	wwcodevancouver	\N	\N	WWCode is a non-profit organization that inspires women to excel in technology careers.\n	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
857	Women Who Code org	WWCode is a global non-profit organization dedicated 	USD	2015-10-31 20:00:00-04	2017-05-22 15:33:15.968-04	\N	t	Women Who Code (WWCode) is a global 501(c)(3) non-profit dedicated to inspiring women to excel in technology careers. We connect amazing women with other like-minded women around the globe who unite under one simple notion – the world of technology is better with women in it. \n\nWe work hard every day to inspire engineers to advance their careers. We strongly believe in the value of diversity, and envision a world where women are representative as technical executives, founders, venture capitalists, board members, and software engineers. \n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events**](https://www.womenwhocode.com/events). \n\n[**Get Involved:**](https://docs.google.com/forms/d/e/1FAIpQLSfIho8JwdkT05STQ6q_1c_cv3kVBsO1I1udKVgf2XaAU5Tnfw/viewform)\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSfIho8JwdkT05STQ6q_1c_cv3kVBsO1I1udKVgf2XaAU5Tnfw/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSfIho8JwdkT05STQ6q_1c_cv3kVBsO1I1udKVgf2XaAU5Tnfw/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Support**](https://opencollective.com/wwcode#support) WWCode financially by making a donation below\n\nYour donations are critical in supporting this catalytic movement. Donations received here directly support our programs. A small amount also supports global development so that we can bring innovative program to cities around the world, ensuring that more women everywhere have the opportunity to excel in technology careers.\n\nQuestions? Email us at contact@womenwhocode.com. 	https://opencollective-production.s3-us-west-1.amazonaws.com/50bd4ad0-769b-11e6-90e1-0dd449fe12b2.png	wwcode Org	http://womenwhocode.com	wwcode	We are on a mission to inspire women to excel in tech careers.	\N	10	\N	{"UserId":3}	\N	f	3	3	\N	\N	ORGANIZATION	\N	\N	\N	\N	\N	\N	\N	\N
262	WWCode Bangalore	WWCode is a global non-profit organization that inspires women to excel in technology careers.	USD	2016-09-29 13:51:29.29-04	2016-12-23 11:55:34.516-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Bangalore**](https://www.womenwhocode.com/bangalore). \n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSeKojMYDN0UYJdAZSfFteESv9WL0i2Jen4zYQpsXYJOorAjIw/viewform)\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSeKojMYDN0UYJdAZSfFteESv9WL0i2Jen4zYQpsXYJOorAjIw/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSeKojMYDN0UYJdAZSfFteESv9WL0i2Jen4zYQpsXYJOorAjIw/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodebangalore#support) to support WWCode Bangalore\n\nQuestions? Email us at global@womenwhocode.com.  \n	https://opencollective-production.s3-us-west-1.amazonaws.com/fe02eee0-961a-11e6-a6e9-23ce753be86b.png	wwcodebangalore	\N	wwcodebangalore	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
280	WWCode Medellín 	WWCode is a global non-profit organization that inspires women to excel in technology careers.	USD	2016-09-29 14:13:48.754-04	2016-12-27 12:47:24.671-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Medellin**](https://www.womenwhocode.com/medellin). \n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSeaXQzj8paXy2_359fBuU2ZeztJLTRGI6coQQ99dI6K1CHiXg/viewform)\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSeaXQzj8paXy2_359fBuU2ZeztJLTRGI6coQQ99dI6K1CHiXg/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSeaXQzj8paXy2_359fBuU2ZeztJLTRGI6coQQ99dI6K1CHiXg/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodeboston#support) to support WWCode Medellin \n\nQuestions? Email us at global@womenwhocode.com.	https://opencollective-production.s3-us-west-1.amazonaws.com/85a55000-cc5c-11e6-be07-3dfc36c6d12c.png	wwcodemedellin	\N	\N	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
286	WWCode Recife	WWCode is a global non-profit organization that inspires women to excel in technology careers.	USD	2016-09-29 14:19:11.423-04	2016-12-27 13:40:34.452-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Recife**](https://www.womenwhocode.com/recife). \n\n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLScE5aeYUYx6Qxflg5CT30PgMk5zqvZl5PkKiJHgcyOmL3VTAg/viewform)\n\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLScE5aeYUYx6Qxflg5CT30PgMk5zqvZl5PkKiJHgcyOmL3VTAg/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLScE5aeYUYx6Qxflg5CT30PgMk5zqvZl5PkKiJHgcyOmL3VTAg/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcoderecife#support) to support WWCode Recife \n\n\nQuestions? Email us at global@womenwhocode.com.  \n	https://opencollective-production.s3-us-west-1.amazonaws.com/cc234080-9d47-11e6-9116-db595ff259df.png	wwcoderecife	\N	WWCode_Recife	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
515	Women Who Code Philadelphia	\N	USD	2017-02-21 13:49:14.309-05	2017-02-21 13:55:30.087-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur programs include hack nights, technical study groups, lightning talks, product demos, and leadership development. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow!\n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLScOnXC5YWNaq0a4WzrYDTAhTFNmWyFGgpMJaoanAVxIQHoEIQ/viewform)\n\n[**Attend**](https://www.womenwhocode.com/philadelphia) an event \n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLScOnXC5YWNaq0a4WzrYDTAhTFNmWyFGgpMJaoanAVxIQHoEIQ/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLScOnXC5YWNaq0a4WzrYDTAhTFNmWyFGgpMJaoanAVxIQHoEIQ/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodephiladelphia#support) to support WWCode Philadelphia \n\nQuestions? Email us at global@womenwhocode.com.\n\n	\N	wwcodephiladelphia	\N	\N	WWCode is a non-profit organization that inspires women to excel in technology careers.\n	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
14	WWCode Seattle	WWCode is a non-profit organization that inspires women to excel in technology careers.	USD	2016-01-10 19:00:00-05	2016-12-27 14:51:31.023-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Seattle**](https://www.womenwhocode.com/seattle). \n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSfRpz1uqBWm1MVnVTTSK1EvAAwBzLFreVS5qyDV1y6Wrxi9HQ/viewform)\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSfRpz1uqBWm1MVnVTTSK1EvAAwBzLFreVS5qyDV1y6Wrxi9HQ/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSfRpz1uqBWm1MVnVTTSK1EvAAwBzLFreVS5qyDV1y6Wrxi9HQ/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcode-seattle#support) to support WWCode Seattle \n\n\nQuestions? Email us at global@womenwhocode.com.  \n	https://opencollective-production.s3-us-west-1.amazonaws.com/48297200-90a8-11e6-a134-f381d4cd2713.png	wwcodeseattle	https://www.womenwhocode.com/seattle	wwcode-seattle	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	\N	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
520	Women Who Code San Diego	\N	USD	2017-02-21 14:34:46.927-05	2017-02-21 14:36:23.416-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur programs include hack nights, technical study groups, lightning talks, product demos, and leadership development. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow!\n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSdBi2chRGnaQrBG5-f1g2_aLxwpviZDmqgGluf0rJ3t_Uyi1Q/viewform)\n\n[**Attend**](https://www.womenwhocode.com/sandiego) an event \n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSdBi2chRGnaQrBG5-f1g2_aLxwpviZDmqgGluf0rJ3t_Uyi1Q/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSdBi2chRGnaQrBG5-f1g2_aLxwpviZDmqgGluf0rJ3t_Uyi1Q/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodesandiego#support) to support WWCode San Diego\n\nQuestions? Email us at global@womenwhocode.com.\n\n\n\n	\N	wwcodesandiego	\N	\N	WWCode is a non-profit organization that inspires women to excel in technology careers.\n\n	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
519	Women Who Code Cleveland	\N	USD	2017-02-21 14:25:28.662-05	2017-02-21 14:28:23.116-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur programs include hack nights, technical study groups, lightning talks, product demos, and leadership development. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow!\n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSdReC87KXP-eOhEI_mk0iPL0ovyADL1gnIGbzUvjt90NGCupw/viewform)\n\n[**Attend**](https://www.womenwhocode.com/cleveland) an event \n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSdReC87KXP-eOhEI_mk0iPL0ovyADL1gnIGbzUvjt90NGCupw/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSdReC87KXP-eOhEI_mk0iPL0ovyADL1gnIGbzUvjt90NGCupw/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodecleveland#support) to support WWCode Cleveland \n\nQuestions? Email us at global@womenwhocode.com.\n	\N	wwcodecleveland	\N	\N	WWCode is a non-profit organization that inspires women to excel in technology careers.\n	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
517	Women Who Code Manila	\N	USD	2017-02-21 14:07:25.163-05	2017-02-21 14:09:27.391-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reWWCode is a non-profit organization that inspires women to excel in technology careers.\nach, and continue to push women to the forefront in the technology space.  \n\nOur programs include hack nights, technical study groups, lightning talks, product demos, and leadership development. We have garnered a member\n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSdFBYTGWumG1PbY65unD1atkWRgBhG2bArurTMwpE6xpnHNYQ/viewform)\n\n[**Attend**](https://www.womenwhocode.com/manila) an event \n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSdFBYTGWumG1PbY65unD1atkWRgBhG2bArurTMwpE6xpnHNYQ/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSdFBYTGWumG1PbY65unD1atkWRgBhG2bArurTMwpE6xpnHNYQ/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodemanila#support) to support WWCode Manila \n\nQuestions? Email us at global@womenwhocode.com.\n	\N	wwcodemanila	\N	\N	WWCode is a non-profit organization that inspires women to excel in technology careers.\n	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
511	Women Who Code Monterrey	\N	MXN	2017-02-21 11:55:29.596-05	2017-02-21 12:26:29.52-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur programs include hack nights, technical study groups, lightning talks, product demos, and leadership development. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow!\n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSeKBYnRkINdl2_FjUOTp0hd11bK3RQnOdaEJzFDI6tlv5ntkA/viewform)\n\n[**Attend**](https://www.womenwhocode.com/monterrey) an event \n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSeKBYnRkINdl2_FjUOTp0hd11bK3RQnOdaEJzFDI6tlv5ntkA/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSeKBYnRkINdl2_FjUOTp0hd11bK3RQnOdaEJzFDI6tlv5ntkA/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodemonterrey#support) to support WWCode Boston \n\n\n\n\n	https://opencollective-production.s3-us-west-1.amazonaws.com/d32e97d0-f85a-11e6-aebb-a9d659d01ec2.png	wwcodemonterrey	\N	\N	WWCode is a non-profit organization that inspires women to excel in technology careers.\n	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3206	3206	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
272	WWCode East Bay	WWCode is a global non-profit organization that inspires women to excel in technology careers.	USD	2016-09-29 14:05:19.056-04	2016-12-27 11:38:30.14-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Oakland/East Bay**](https://www.womenwhocode.com/east-bay). \n\n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSeId0Km3sYr0AEQHjzzKsxoiDfn-HhIFPXBzg0V-t8F440Olg/viewform)\n\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSeId0Km3sYr0AEQHjzzKsxoiDfn-HhIFPXBzg0V-t8F440Olg/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSeId0Km3sYr0AEQHjzzKsxoiDfn-HhIFPXBzg0V-t8F440Olg/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodeeastbay#support) to support WWCode Oakland/East Bay \n\nQuestions? Email us at global@womenwhocode.com.  \n	https://opencollective-production.s3-us-west-1.amazonaws.com/d9a7fc70-9c5f-11e6-84fe-5d5e57220970.png	wwcodeeastbay	\N	wwcode_eastbay	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
263	WWCode Beijing	WWCode is a global non-profit organization that inspires women to excel in technology careers.	USD	2016-09-29 13:53:00.452-04	2016-12-23 11:58:56.927-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Beijing**](https://www.womenwhocode.com/beijing). \n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSd7966PGrpuX1wfVL07PwwpupzTIrIi_T2WhJUe8nB4iK60dQ/viewform)\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSd7966PGrpuX1wfVL07PwwpupzTIrIi_T2WhJUe8nB4iK60dQ/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSd7966PGrpuX1wfVL07PwwpupzTIrIi_T2WhJUe8nB4iK60dQ/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodebeijing#support) to support WWCode Beijing\n\n	https://opencollective-production.s3-us-west-1.amazonaws.com/f6793200-961b-11e6-a6e9-23ce753be86b.png	wwcodebeijing	\N	\N	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
277	WWCode Kuala Lumpur	WWCode is a global non-profit organization that inspires women to excel in technology careers.	USD	2016-09-29 14:10:43.356-04	2016-12-27 12:02:13.485-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Kuala Lumpur**](https://www.womenwhocode.com/kl). \n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSeaXQzj8paXy2_359fBuU2ZeztJLTRGI6coQQ99dI6K1CHiXg/viewform)\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSeaXQzj8paXy2_359fBuU2ZeztJLTRGI6coQQ99dI6K1CHiXg/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSeaXQzj8paXy2_359fBuU2ZeztJLTRGI6coQQ99dI6K1CHiXg/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodekualalumpur#support) to support WWCode Kuala Lumpur\n\nQuestions? Email us at global@womenwhocode.com.	https://opencollective-production.s3-us-west-1.amazonaws.com/35b70760-cc56-11e6-be07-3dfc36c6d12c.png	wwcodekualalumpur	\N	\N	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
241	WWCode Taipei	WWCode is a global non-profit organization that inspires women to excel in technology careers.	USD	2016-09-07 18:13:23.305-04	2016-12-28 10:57:33.798-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Taipei**](https://www.womenwhocode.com/taipei). \n\n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSc9XHX8FbeC1w6cKAZ_XjnVzC4cBb0hbvASXJ05soQA0SOlTA/viewform)\n\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSc9XHX8FbeC1w6cKAZ_XjnVzC4cBb0hbvASXJ05soQA0SOlTA/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSc9XHX8FbeC1w6cKAZ_XjnVzC4cBb0hbvASXJ05soQA0SOlTA/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodetaipei#support) to support WWCode Taipei \n\n\nQuestions? Email us at global@womenwhocode.com.  \n	https://cldup.com/lGiwq5JAPy.png	wwcodetaipei	\N	wwcodetaipei	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	\N	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
301	WWCode Berlin	WWCode is a global non-profit organization that inspires women to excel in technology careers.	EUR	2016-09-29 14:43:48.834-04	2016-12-23 12:11:29.559-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Berlin**](https://www.womenwhocode.com/berlin). \n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSdJ94P4XoVzynK8rqZ4O5UaoenMUEtDlgJidbGvq5ed4yHBNg/viewform)\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSdJ94P4XoVzynK8rqZ4O5UaoenMUEtDlgJidbGvq5ed4yHBNg/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSdJ94P4XoVzynK8rqZ4O5UaoenMUEtDlgJidbGvq5ed4yHBNg/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodeberlin#support) to support WWCode Berlin \n\nQuestions? Email us at global@womenwhocode.com.  \n	https://opencollective-production.s3-us-west-1.amazonaws.com/81940c10-8fd8-11e6-b320-5125b901f984.png	wwcodeberlin	\N	wwcodeberlin	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
297	WWCode Sydney	WWCode is a global non-profit organization that inspires women to excel in technology careers.	AUD	2016-09-29 14:34:59.472-04	2016-12-28 10:55:06.005-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Sydney**](https://www.womenwhocode.com/sydney-australia). \n\n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLScZnIDanwBEgvSarNoteC9emDTvctZYwySJBJUKL2fcj9K-8Q/viewform)\n\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLScZnIDanwBEgvSarNoteC9emDTvctZYwySJBJUKL2fcj9K-8Q/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLScZnIDanwBEgvSarNoteC9emDTvctZYwySJBJUKL2fcj9K-8Q/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodesydney#support) to support WWCode Sydney \n\nQuestions? Email us at global@womenwhocode.com.  \n	https://opencollective-production.s3-us-west-1.amazonaws.com/405f1180-a514-11e6-b4fe-6966ef500b6b.png	wwcodesydney	\N	wwcsyd	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
259	WWCode Birmingham	WWCode is a global non-profit organization that inspires women to excel in technology careers.	USD	2016-09-29 13:43:14.021-04	2016-12-23 12:19:36.878-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Birmingham**](https://www.womenwhocode.com/birmingham). \n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSeOLUr8i4gqKg09Wt9ExEh_m4rnhZHR0BZFDodXc953DZ_NjQ/viewform)\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSeOLUr8i4gqKg09Wt9ExEh_m4rnhZHR0BZFDodXc953DZ_NjQ/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSeOLUr8i4gqKg09Wt9ExEh_m4rnhZHR0BZFDodXc953DZ_NjQ/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodebirmingham#support) to WWCode Birmingham financially by making a donation below\n\nQuestions? Email us at global@womenwhocode.com.  \n\n	https://opencollective-production.s3-us-west-1.amazonaws.com/f9d834f0-c933-11e6-9af0-47fca5e686db.png	wwcodebirmingham	\N	wwcbirmingham	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
12	Women Who Code Atlanta	WWCode is a non-profit organization that inspires women to excel in technology careers.	USD	2016-01-10 19:00:00-05	2016-12-23 11:56:56.09-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Atlanta**](https://www.womenwhocode.com/atl). \n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSdkKQPrNlXYI2XDQcYK8rpW9PwXHzEZPrcyLq074-GmTJtxJg/viewform)\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSdkKQPrNlXYI2XDQcYK8rpW9PwXHzEZPrcyLq074-GmTJtxJg/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSdkKQPrNlXYI2XDQcYK8rpW9PwXHzEZPrcyLq074-GmTJtxJg/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodeatl#support) to support WWCode Atlanta\n\nQuestions? Email us at global@womenwhocode.com.  \n	https://cldup.com/NzLkW4RcED.png	wwcodeatl	\N	wwcodeatl	We are on a mission to inspire women to excel in tech careers.	\N	25	{"lang":"wwcode"}	\N	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
278	WWCode London	WWCode is a global non-profit organization that inspires women to excel in technology careers.	GBP	2016-09-29 14:11:53.804-04	2016-12-27 12:29:43.796-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in London**](https://www.womenwhocode.com/london). \n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSfksXAlw11lW_lHn5JMK3pLFTWY3f_LQn9zTBajKH4JHGmUEw/viewform)\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSfksXAlw11lW_lHn5JMK3pLFTWY3f_LQn9zTBajKH4JHGmUEw/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSfksXAlw11lW_lHn5JMK3pLFTWY3f_LQn9zTBajKH4JHGmUEw/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodelondon#support) WWCode London \n\nQuestions? Email us at global@womenwhocode.com.  \n	https://opencollective-production.s3-us-west-1.amazonaws.com/8df462c0-9091-11e6-a134-f381d4cd2713.png	wwcodelondon	\N	wwclondon	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
2	WWCode Austin	WWCode is a global non-profit organization that inspires women to excel in technology careers. 	USD	2015-12-12 19:14:54.028-05	2016-12-23 10:30:21.805-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Austin**](https://www.womenwhocode.com/austin). \n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSeAl3dRRR312S1CcQonYE72JDumGhpuh6G9INhyrJxOM1w16g/viewform)\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSeAl3dRRR312S1CcQonYE72JDumGhpuh6G9INhyrJxOM1w16g/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSeAl3dRRR312S1CcQonYE72JDumGhpuh6G9INhyrJxOM1w16g/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodeaustin#support) to support WWCode Austin \n\n\nQuestions? Email us at global@womenwhocode.com.  \n	https://cldup.com/mX6wUEonFH.png	wwcodeaustin	\N	\N	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	\N	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
281	WWCode Melbourne	WWCode is a global non-profit organization that inspires women to excel in technology careers.	AUD	2016-09-29 14:14:46.59-04	2016-12-27 12:51:32.497-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Melbourne**](https://www.womenwhocode.com/melbourne). \n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSeaXQzj8paXy2_359fBuU2ZeztJLTRGI6coQQ99dI6K1CHiXg/viewform)\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSeaXQzj8paXy2_359fBuU2ZeztJLTRGI6coQQ99dI6K1CHiXg/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSeaXQzj8paXy2_359fBuU2ZeztJLTRGI6coQQ99dI6K1CHiXg/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodemelbourne#support) to support WWCode Melbourne\n\nQuestions? Email us at global@womenwhocode.com.	https://opencollective-production.s3-us-west-1.amazonaws.com/19756e50-cc5d-11e6-be07-3dfc36c6d12c.png	wwcodemelbourne	\N	WWCodeMelbourne	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
270	WWCode Chicago	WWCode is a global non-profit organization that inspires women to excel in technology careers.	USD	2016-09-29 14:02:54.513-04	2016-12-23 14:48:12.132-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Chicago**](https://www.womenwhocode.com/chicago). \n\n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSe4Vang3taPJd47st_fHZyaQLG7jst0g9fjS7h8FbBpitGUNA/viewform)\n\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSe4Vang3taPJd47st_fHZyaQLG7jst0g9fjS7h8FbBpitGUNA/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSe4Vang3taPJd47st_fHZyaQLG7jst0g9fjS7h8FbBpitGUNA/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodechicago#support) to support WWCode Chicago \n\nQuestions? Email us at global@womenwhocode.com.  \n	https://opencollective-production.s3-us-west-1.amazonaws.com/aef68840-9b9a-11e6-b592-e7f426067276.png	wwcodechicago	\N	\N	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
268	WWCode Charleston	WWCode is a global non-profit organization that inspires women to excel in technology careers.	USD	2016-09-29 14:01:04.477-04	2016-12-23 14:37:13.42-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Charleston**](https://www.womenwhocode.com/charleston). \n\n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSfJBAX-EQdRtOiWJWxVJhKNKTiA2Hc09jduycgYjfSLH2U7Ig/viewform)\n\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSfJBAX-EQdRtOiWJWxVJhKNKTiA2Hc09jduycgYjfSLH2U7Ig/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSfJBAX-EQdRtOiWJWxVJhKNKTiA2Hc09jduycgYjfSLH2U7Ig/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodecharleston#support) to support WWCode Charleston\n\nQuestions? Email us at global@womenwhocode.com.  \n	https://opencollective-production.s3-us-west-1.amazonaws.com/a185ed40-9b95-11e6-b592-e7f426067276.png	wwcodecharleston	\N	\N	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
4	WWCode San Francisco	WWCode is a non-profit organization that inspires women to excel in technology careers.	USD	2015-12-12 19:14:54.028-05	2016-12-27 14:54:09.597-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in San Francisco**](https://www.womenwhocode.com/sf). \n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSebpozJA-r33FvptTT2XFNoV66gxMm0NZn1oVDV64A1VeW0GQ/viewform)\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSebpozJA-r33FvptTT2XFNoV66gxMm0NZn1oVDV64A1VeW0GQ/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSebpozJA-r33FvptTT2XFNoV66gxMm0NZn1oVDV64A1VeW0GQ/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodesf#support) to support WWCode San Francisco\n\n\nQuestions? Email us at global@womenwhocode.com.  \n	https://cldup.com/6kFcX-6H5l.png	wwcodesf	http://www.meetup.com/Women-Who-Code-SF	wwcodesf	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	\N	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
291	WWCode Toronto	WWCode is a global non-profit organization that inspires women to excel in technology careers.	CAD	2016-09-29 14:28:54.255-04	2016-12-28 11:20:52.347-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Toronto**](https://www.womenwhocode.com/toronto). \n\n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSeEolspLAcmEXAfO8zKWGeTV1AIUXpI5KVKpTEGVwBol8J0bA/viewform)\n\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSeEolspLAcmEXAfO8zKWGeTV1AIUXpI5KVKpTEGVwBol8J0bA/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSeEolspLAcmEXAfO8zKWGeTV1AIUXpI5KVKpTEGVwBol8J0bA/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Global**](https://opencollective.com/wwcodetoronto#support) to support WWCode Toronto \n\n\nQuestions? Email us at global@womenwhocode.com.  \n	https://opencollective-production.s3-us-west-1.amazonaws.com/6dbdcea0-a519-11e6-b4fe-6966ef500b6b.png	wwcodetoronto	\N	womenwhocodeto	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
13	WWCode Washington DC	WWCode is a non-profit organization that inspires women to excel in technology careers.	USD	2016-01-10 19:00:00-05	2016-12-27 11:21:52.463-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Washington D.C.**](https://www.womenwhocode.com/dc). \n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSfQTzXxQVzlXSGnqhaMVNhxtfPid3fMiQt5rSISqGy8FbNtIg/viewform)\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSfQTzXxQVzlXSGnqhaMVNhxtfPid3fMiQt5rSISqGy8FbNtIg/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSfQTzXxQVzlXSGnqhaMVNhxtfPid3fMiQt5rSISqGy8FbNtIg/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodedc#support) to support WWCode Washington D.C. \n\nQuestions? Email us at global@womenwhocode.com.  \n	https://cldup.com/rhyrbLvkli.png	wwcodedc	https://www.womenwhocode.com/dc	wwcodedc	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	\N	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
524	Women Who Code Barcelona	\N	EUR	2017-02-21 15:11:44.714-05	2017-02-21 15:13:31.987-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur programs include hack nights, technical study groups, lightning talks, product demos, and leadership development. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow!\n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSfyIV5MJgha1rYTlKdJ9frxSrFW55jGltiYpumAdsqCE8heKQ/viewform)\n\n[**Attend**](https://www.womenwhocode.com/barcelona) an event \n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSfyIV5MJgha1rYTlKdJ9frxSrFW55jGltiYpumAdsqCE8heKQ/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSfyIV5MJgha1rYTlKdJ9frxSrFW55jGltiYpumAdsqCE8heKQ/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodebarcelona#support) to support WWCode Barcelona\n\nQuestions? Email us at global@womenwhocode.com.\n\n	\N	wwcodebarcelona	\N	\N	WWCode is a non-profit organization that inspires women to excel in technology careers.\n	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
290	WWCode Tampa	WWCode is a global non-profit organization that inspires women to excel in technology careers.	USD	2016-09-29 14:28:08.446-04	2016-11-07 13:27:01.762-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Tampa**](https://www.womenwhocode.com/tampa). \n\n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSeSfKMAT2KWgG0kArwZhSAAYMwtAVyUGGK4l2Yfq3soxxLJnA/viewform)\n\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSeSfKMAT2KWgG0kArwZhSAAYMwtAVyUGGK4l2Yfq3soxxLJnA/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSeSfKMAT2KWgG0kArwZhSAAYMwtAVyUGGK4l2Yfq3soxxLJnA/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Support**](https://opencollective.com/wwcodetampa#support) WWCode Tampa financially by making a donation below\n\n\nYour donations are critical in supporting this catalytic movement. Donations received here directly support our programs. A small amount also supports global development so that we can bring innovative program to cities around the world, ensuring that more women everywhere have the opportunity to excel in technology careers.\n\n\nQuestions? Email us at contact@womenwhocode.com.  \n	https://opencollective-production.s3-us-west-1.amazonaws.com/638dcdc0-a516-11e6-b4fe-6966ef500b6b.png	wwcodetampa	\N	wwcodetampa	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
288	WWCode Santiago	WWCode is a global non-profit organization that inspires women to excel in technology careers.	USD	2016-09-29 14:25:21.912-04	2016-12-27 14:48:06.766-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Santiago**](https://www.womenwhocode.com/santiago). \n\n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSdu79lAU0f0kKoLdUHsazwlPaiVRDO9SP5v9swDGHv00Nwqaw/viewform)\n\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSdu79lAU0f0kKoLdUHsazwlPaiVRDO9SP5v9swDGHv00Nwqaw/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSdu79lAU0f0kKoLdUHsazwlPaiVRDO9SP5v9swDGHv00Nwqaw/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodesantiago#support) to support WWCode Santiago \n\n\nQuestions? Email us at global@womenwhocode.com.  \n	https://opencollective-production.s3-us-west-1.amazonaws.com/595593e0-a2c0-11e6-b669-1f602f2f2eec.png	wwcodesantiago	\N	\N	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
275	WWCode Hong Kong 	WWCode is a global non-profit organization that inspires women to excel in technology careers.	USD	2016-09-29 14:08:19.455-04	2016-12-27 11:53:38.119-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Hong Kong**](https://www.womenwhocode.com/hk). \n\n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSdg4XdtRKCzgpTopZtXsshtrXO1XRrUSlWo3ga29vxAAh_AtA/viewform)\n\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSdg4XdtRKCzgpTopZtXsshtrXO1XRrUSlWo3ga29vxAAh_AtA/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSdg4XdtRKCzgpTopZtXsshtrXO1XRrUSlWo3ga29vxAAh_AtA/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodehongkong#support) to support WWCode Hong Kong \n\n\nQuestions? Email us at global@womenwhocode.com.  \n	https://opencollective-production.s3-us-west-1.amazonaws.com/adea85b0-9c7a-11e6-a3da-b7d8fa4b13cd.png	wwcodehongkong	\N	\N	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
300	WWCode Silicon Valley	WWCode is a global non-profit organization that inspires women to excel in technology careers.	USD	2016-09-29 14:41:11.03-04	2016-12-28 10:46:08.715-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Silicon Valley**](https://www.womenwhocode.com/sv). \n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSfGn_wwztPhhOYJ4LqYvswg0y0ZpagWZkXA-a81y3WKLOW0nQ/viewform)\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSfGn_wwztPhhOYJ4LqYvswg0y0ZpagWZkXA-a81y3WKLOW0nQ/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSfGn_wwztPhhOYJ4LqYvswg0y0ZpagWZkXA-a81y3WKLOW0nQ/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodesv#support) to support WWCode Silicon Valley \n\nQuestions? Email us at global@womenwhocode.com.  \n	https://opencollective-production.s3-us-west-1.amazonaws.com/cc80e4c0-90ad-11e6-a134-f381d4cd2713.png	wwcodesv	\N	wwcodesv	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
521	Women Who Code Raleigh Durham	\N	USD	2017-02-21 14:39:46.205-05	2017-02-21 14:41:19.26-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur programs include hack nights, technical study groups, lightning talks, product demos, and leadership development. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow!\n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSf0bA8m8nAIKsVtnstXcG1fYydPvvu_sHm-zm-FzTngTAQvzg/viewform)\n\n[**Attend**](https://www.womenwhocode.com/raleigh) an event \n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSf0bA8m8nAIKsVtnstXcG1fYydPvvu_sHm-zm-FzTngTAQvzg/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSf0bA8m8nAIKsVtnstXcG1fYydPvvu_sHm-zm-FzTngTAQvzg/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcoderaleigh#support) to support WWCode Raleigh Durham \n\nQuestions? Email us at global@womenwhocode.com.\n\n	\N	wwcoderaleigh	\N	\N	WWCode is a non-profit organization that inspires women to excel in technology careers.\n	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
295	WWCode Tokyo	WWCode is a global non-profit organization that inspires women to excel in technology careers.	USD	2016-09-29 14:33:36.887-04	2016-12-28 11:00:36.071-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Tokyo**](https://www.womenwhocode.com/tokyo). \n\n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLScKx7EivU4MO7pQbVNjLObcYqr0lt1W5az41EDV15bbGtJUSg/viewform)\n\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLScKx7EivU4MO7pQbVNjLObcYqr0lt1W5az41EDV15bbGtJUSg/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLScKx7EivU4MO7pQbVNjLObcYqr0lt1W5az41EDV15bbGtJUSg/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodetokyo#support) to support WWCode Tokyo \n\nQuestions? Email us at global@womenwhocode.com.  \n	https://opencollective-production.s3-us-west-1.amazonaws.com/bf15e4a0-a518-11e6-b4fe-6966ef500b6b.png	wwcodetokyo	\N	wwcode_tokyo	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
264	WWCode Belfast	WWCode is a global non-profit organization that inspires women to excel in technology careers.	GBP	2016-09-29 13:54:53.422-04	2016-12-23 12:01:33.569-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Belfast**](https://www.womenwhocode.com/belfast). \n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSfRGOc9xuV0n4ltXd1p3xvb_TU_VaxEXxOYex6SVZQpJmH6Aw/viewform)\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSfRGOc9xuV0n4ltXd1p3xvb_TU_VaxEXxOYex6SVZQpJmH6Aw/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSfRGOc9xuV0n4ltXd1p3xvb_TU_VaxEXxOYex6SVZQpJmH6Aw/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodebelfast#support) to support WWCode Belfast\n\nQuestions? Email us at global@womenwhocode.com.  \n\n	https://opencollective-production.s3-us-west-1.amazonaws.com/e1bb8200-96e8-11e6-baa3-69f47ab52eed.png	wwcodebelfast	\N	WWCBelfast	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
269	WWCode Chennai	WWCode is a global non-profit organization that inspires women to excel in technology careers.	USD	2016-09-29 14:01:49.683-04	2016-12-23 14:40:22.493-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Chennai**](https://www.womenwhocode.com/chennai). \n\n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLScl5ZvmRS9Owt5CfCPbGa6Y8WnJvau5v77p-jgsto_UaeAc_A/viewform)\n\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLScl5ZvmRS9Owt5CfCPbGa6Y8WnJvau5v77p-jgsto_UaeAc_A/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLScl5ZvmRS9Owt5CfCPbGa6Y8WnJvau5v77p-jgsto_UaeAc_A/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodechennai#support) to WWCode Chennai \n\nQuestions? Email us at global@womenwhocode.com.  \n	https://opencollective-production.s3-us-west-1.amazonaws.com/f50c62b0-9b99-11e6-b592-e7f426067276.png	wwcodechennai	\N	\N	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
15	WWCode Boulder/Denver	WWCode is a non-profit organization that inspires women to excel in technology careers.	USD	2016-01-10 19:00:00-05	2016-12-27 11:29:26.21-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Boulder/Denver**](https://www.womenwhocode.com/boulder). \n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSf8Ot4bmuje76glYnrfKKepl2EphH2Feojg9_CfbwhgmG5NAw/viewform)\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSf8Ot4bmuje76glYnrfKKepl2EphH2Feojg9_CfbwhgmG5NAw/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSf8Ot4bmuje76glYnrfKKepl2EphH2Feojg9_CfbwhgmG5NAw/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodebd#support) to support WWCode Boulder/Denver \n\nQuestions? Email us at global@womenwhocode.com.  \n	https://cldup.com/OSosQI7_aV.png	wwcodebd	\N	wwcodebd	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	\N	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
298	WWCode Dublin	WWCode is a global non-profit organization that inspires women to excel in technology careers.	EUR	2016-09-29 14:37:07.255-04	2016-12-27 11:33:19.532-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Dublin**](https://www.womenwhocode.com/wwcode-dublin). \n\n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSdwrnolSbTtRkhg26WVios4q-3GxchiTiK1SNA24d-9qtMOjw/viewform)\n\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSdwrnolSbTtRkhg26WVios4q-3GxchiTiK1SNA24d-9qtMOjw/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSdwrnolSbTtRkhg26WVios4q-3GxchiTiK1SNA24d-9qtMOjw/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodedublin#support) to support WWCode Dublin \n\nQuestions? Email us at global@womenwhocode.com.  \n	https://opencollective-production.s3-us-west-1.amazonaws.com/70bbbe00-9ba5-11e6-84fe-5d5e57220970.png	wwcodedublin	\N	wwcodedublin	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
260	WWCode Accra	WWCode is a global non-profit organization that inspires women to excel in technology careers.	USD	2016-09-29 13:44:40.394-04	2016-12-23 10:39:43.815-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Accra**](https://www.womenwhocode.com/accra). \n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLScZq_QiHPiSwhxYe74MsWt1OiscXVo41DndphmDOTYR7cEK1w/viewform)\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLScZq_QiHPiSwhxYe74MsWt1OiscXVo41DndphmDOTYR7cEK1w/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLScZq_QiHPiSwhxYe74MsWt1OiscXVo41DndphmDOTYR7cEK1w/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodeaccra#support) to support WWCode Accra\n\nQuestions? Email us at global@womenwhocode.com.  	https://opencollective-production.s3-us-west-1.amazonaws.com/c4810040-8a89-11e6-9ae7-452ac38279da.png	wwcodeaccra	\N	wwcodeaccra	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
513	Women Who Code Fort Collins	\N	USD	2017-02-21 13:35:34.492-05	2017-02-21 13:37:34.054-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur programs include hack nights, technical study groups, lightning talks, product demos, and leadership development. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow!\n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSeaU7dnlAb9cneVM1fDsuNGhNfYtOTYR0UGwGploHd70ZXaLg/viewform)\n\n[**Attend**](https://www.womenwhocode.com/fortcollins) an event \n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSeaU7dnlAb9cneVM1fDsuNGhNfYtOTYR0UGwGploHd70ZXaLg/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSeaU7dnlAb9cneVM1fDsuNGhNfYtOTYR0UGwGploHd70ZXaLg/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodefortcollins#support) to support WWCode Fort Collins \n\nQuestions? Email us at global@womenwhocode.com.\n	\N	wwcodefortcollins	\N	\N	WWCode is a non-profit organization that inspires women to excel in technology careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
287	WWCode Sacramento 	WWCode is a global non-profit organization that inspires women to excel in technology careers.	USD	2016-09-29 14:24:17.771-04	2016-12-27 14:44:07.667-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Sacramento**](https://www.womenwhocode.com/sacramento). \n\n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSeZ9UntJll03ZeVwFkVGMc-JFd4Y1GLXpuJzRpi-JaMa30uYQ/viewform)\n\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSeZ9UntJll03ZeVwFkVGMc-JFd4Y1GLXpuJzRpi-JaMa30uYQ/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSeZ9UntJll03ZeVwFkVGMc-JFd4Y1GLXpuJzRpi-JaMa30uYQ/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodesacramento#support) to support WWCode Sacramento \n\nQuestions? Email us at global@womenwhocode.com.  \n	https://opencollective-production.s3-us-west-1.amazonaws.com/dca653c0-a2bf-11e6-b669-1f602f2f2eec.png	wwcodesacramento	\N	\N	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
282	WWCode Merida	WWCode is a global non-profit organization that inspires women to excel in technology careers.	USD	2016-09-29 14:15:23.91-04	2016-12-27 12:55:44.4-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Merida**](https://www.womenwhocode.com/merida). \n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSeaXQzj8paXy2_359fBuU2ZeztJLTRGI6coQQ99dI6K1CHiXg/viewform)\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSeaXQzj8paXy2_359fBuU2ZeztJLTRGI6coQQ99dI6K1CHiXg/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSeaXQzj8paXy2_359fBuU2ZeztJLTRGI6coQQ99dI6K1CHiXg/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodemerida#support) to support WWCode Merida \n\nQuestions? Email us at global@womenwhocode.com.	https://opencollective-production.s3-us-west-1.amazonaws.com/af808880-cc5d-11e6-be07-3dfc36c6d12c.png	wwcodemerida	\N	\N	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
293	WWCode Waterloo	WWCode is a global non-profit organization that inspires women to excel in technology careers.	CAD	2016-09-29 14:30:54.225-04	2016-12-28 11:29:14.91-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Waterloo**](https://www.womenwhocode.com/waterloo). \n\n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSfIMqJl5wn5hDsoRQBrehopXdebDkIZBYLjrrOMNIH9M8O47A/viewform)\n\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSfIMqJl5wn5hDsoRQBrehopXdebDkIZBYLjrrOMNIH9M8O47A/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSfIMqJl5wn5hDsoRQBrehopXdebDkIZBYLjrrOMNIH9M8O47A/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodewaterloo#support) to support WWCode Waterloo\n\nQuestions? Email us at global@womenwhocode.com.  \n	https://opencollective-production.s3-us-west-1.amazonaws.com/485e6710-a6d5-11e6-bdef-45bfa9f9c1b0.png	wwcodewaterloo	\N	womenwhocodekw	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
279	WWCode Los Angeles	WWCode is a global non-profit organization that inspires women to excel in technology careers.	USD	2016-09-29 14:12:58.808-04	2016-12-27 12:24:20.031-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Los Angeles**](https://www.womenwhocode.com/la). \n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSdc86zv5cSb-LuQlyA4qgmhZXjmN81qn-NAnbwNKidSrEST6g/viewform)\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSdc86zv5cSb-LuQlyA4qgmhZXjmN81qn-NAnbwNKidSrEST6g/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSdc86zv5cSb-LuQlyA4qgmhZXjmN81qn-NAnbwNKidSrEST6g/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodelosangeles#support) WWCode Los Angeles \n\nQuestions? Email us at global@womenwhocode.com.  \n\n	https://opencollective-production.s3-us-west-1.amazonaws.com/f55b4680-9097-11e6-a134-f381d4cd2713.png	wwcodelosangeles	\N	\N	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
265	WWCode Belo Horizonte	WWCode is a global non-profit organization that inspires women to excel in technology careers.	USD	2016-09-29 13:58:16.617-04	2016-12-23 12:07:51.328-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Belo Horizonte**](https://www.womenwhocode.com/belo-horizonte). \n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLScQkF3yoa0K-EGz_ALcWXlGbWACzliOUG2k19B-kjDnAc9E-A/viewform)\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLScQkF3yoa0K-EGz_ALcWXlGbWACzliOUG2k19B-kjDnAc9E-A/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLScQkF3yoa0K-EGz_ALcWXlGbWACzliOUG2k19B-kjDnAc9E-A/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodebelohorizonte#support) to support WWCode Belo Horizonte \n\nQuestions? Email us at global@womenwhocode.com.  \n\n	\N	wwcodebelohorizonte	\N	\N	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
430	WWCode Kyiv	WWCode is a global non-profit organization that inspires women to excel in technology careers.	USD	2017-01-03 19:00:00-05	2017-01-04 14:36:29.052-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur program avenues include in-person events, leadership, and our weekly publication, the CODE Review. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow! [**Explore upcoming events in Kyiv**](https://www.womenwhocode.com/kyiv). \n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSdSGUMDGoRoh5mNYBxjxgH8Y4zBpu_BmtIr7fBiaSSGP1l-DA/viewform)\n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSdSGUMDGoRoh5mNYBxjxgH8Y4zBpu_BmtIr7fBiaSSGP1l-DA/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSdSGUMDGoRoh5mNYBxjxgH8Y4zBpu_BmtIr7fBiaSSGP1l-DA/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodekyiv#support) to support WWCode Kyiv \n\nQuestions? Email us at global@womenwhocode.com.  \n	\N	wwcodekyiv	\N	\N	We are on a mission to inspire women to excel in tech careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
518	Women Who Code Singapore	\N	USD	2017-02-21 14:13:03.341-05	2017-02-21 14:19:36.571-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur programs include hack nights, technical study groups, lightning talks, product demos, and leadership development. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow!\n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLScjlltFEdGKQPEmz-VgLXm-yYaT1K8RqGqbAt-I7ozlLH4D-Q/viewform)\n\n[**Attend**](https://www.womenwhocode.com/singapore) an event \n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLScjlltFEdGKQPEmz-VgLXm-yYaT1K8RqGqbAt-I7ozlLH4D-Q/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLScjlltFEdGKQPEmz-VgLXm-yYaT1K8RqGqbAt-I7ozlLH4D-Q/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodesingapore#support) to support WWCode Singapore\n\nQuestions? Email us at global@womenwhocode.com.\n	\N	wwcodesingapore	\N	\N	WWCode is a non-profit organization that inspires women to excel in technology careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
512	Women Who Code Cincinnati	\N	USD	2017-02-21 13:11:30.741-05	2017-02-21 13:14:42.695-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur programs include hack nights, technical study groups, lightning talks, product demos, and leadership development. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow!\n\n[**Attend**](https://www.womenwhocode.com/cincinnati) an event \n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLScMYZSUklxgo7irAfTbcOrz06jjuibholjPNS-rBoSvWLHGow/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLScMYZSUklxgo7irAfTbcOrz06jjuibholjPNS-rBoSvWLHGow/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodecincinnati#support) to support WWCode Cincinnati \n\nQuestions? Email us at global@womenwhocode.com.\n\n\n	\N	wwcodecincinnati	\N	\N	WWCode is a non-profit organization that inspires women to excel in technology careers.	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
516	Women Who Code Huntsville	\N	USD	2017-02-21 14:02:21.542-05	2017-02-21 14:05:00.852-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur programs include hack nights, technical study groups, lightning talks, product demos, and leadership development. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow!\n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLScu1IeDDh0ZqcKEMxfMGPgrdr1bnDKsiC94diR7AfR7LQIU6g/viewform)\n\n[**Attend**](https://www.womenwhocode.com/philadelphia) an event \n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLScu1IeDDh0ZqcKEMxfMGPgrdr1bnDKsiC94diR7AfR7LQIU6g/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLScu1IeDDh0ZqcKEMxfMGPgrdr1bnDKsiC94diR7AfR7LQIU6g/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodephiladelphia#support) to support WWCode Philadelphia\n\nQuestions? Email us at global@womenwhocode.com.\n\n	\N	wwcodehuntsville	\N	\N	WWCode is a non-profit organization that inspires women to excel in technology careers.\n	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
523	Women Who Code Sofia	\N	EUR	2017-02-21 15:04:48.889-05	2017-02-21 15:06:29.574-05	\N	t	WWCode connects amazing women engineers around the globe who unite under one simple notion – the world of technology is better with women in it. We work hard everyday to increase our impact, expand our reach, and continue to push women to the forefront in the technology space.  \n\nOur programs include hack nights, technical study groups, lightning talks, product demos, and leadership development. We have garnered a membership of 80,000 tech women across 60 cities and 20 countries, and continue to grow!\n\n[**Get Involved**](https://docs.google.com/forms/d/e/1FAIpQLSeqyQYDNUIJRIt8q9SuZdzqOu2c2PV1oxPdtmG0D5r0fEbcwA/viewform)\n\n[**Attend**](https://www.womenwhocode.com/sofia) an event \n\n[**Host**](https://docs.google.com/forms/d/e/1FAIpQLSeqyQYDNUIJRIt8q9SuZdzqOu2c2PV1oxPdtmG0D5r0fEbcwA/viewform) an event at your company's office  \n[**Volunteer**](https://docs.google.com/forms/d/e/1FAIpQLSeqyQYDNUIJRIt8q9SuZdzqOu2c2PV1oxPdtmG0D5r0fEbcwA/viewform) to support network leadership  \n[**Share**](https://www.womenwhocode.com/jobs/about) a job opportunity with our community  \n[**Donate**](https://opencollective.com/wwcodesofia#support) to support WWCode Sofia \n\nQuestions? Email us at global@womenwhocode.com	\N	wwcodesofia	\N	\N	WWCode is a non-profit organization that inspires women to excel in technology careers.\n	\N	10	{"lang":"wwcode"}	{}	{wwcode,meetup,"diversity in tech"}	f	3	3	857	51	COLLECTIVE	\N	\N	\N	\N	\N	\N	\N	\N
\.


                                                                                                                                                                                                                          4005.dat                                                                                            0000600 0004000 0002000 00000000751 13174451173 0014253 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        7	github	piamancini	*****	*****	\N	2016-05-23 13:23:51.553-04	2016-05-23 13:24:25.036-04	\N	30	\N	\N
3	github	asood123	*****	*****	\N	2016-05-23 13:14:54.648-04	2016-08-13 07:56:21.771-04	\N	8	\N	\N
4	github	xdamman	*****	*****	\N	2016-05-23 13:19:57.6-04	2017-05-03 10:31:33.249-04	\N	2	\N	\N
1026	stripe	acct_xxxxxxxxxxxxxxxx	\N	sk_test_Hcsz2JJdMzEsU2xxxxxxxxxx	{"publishableKey":"pk_test_OSQ8IaRSyLe9FVxxxxxxxxxx"}	2017-10-26 17:24:10.068-04	2017-10-26 17:24:10.068-04	\N	\N	51	\N
\.


                       4009.dat                                                                                            0000600 0004000 0002000 00000000005 13174451173 0014247 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           4011.dat                                                                                            0000600 0004000 0002000 00000131127 13174451173 0014252 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        737	171	59	USD	2439	Event supplies for Leads	\N	******	Leadership Supplies	\N	3	PAID	2017-01-20 15:05:09.337-05	2017-01-21 15:30:22.616-05	2017-02-07 13:38:15.924-05	\N	paypal
57	28	2	USD	15316	Mar 7 Lightning Talks	\N	******	Lightning Talks	\N	3	PAID	2016-03-20 14:06:09.887-04	2016-03-20 14:06:09.887-04	2017-03-14 13:21:29.439-04	\N	paypal
887	3	282	MXN	50616	Leadership Development	\N	******	Conference	\N	3	PAID	2017-03-06 16:54:10.307-05	2017-03-07 08:02:11.16-05	2017-03-14 14:17:52.017-04	\N	manual
907	70	12	USD	20000	payment to artists (spoken word) for performance at IWD event	\N	******	Other WWCode Event	\N	3	PAID	2017-03-11 19:06:03.02-05	2017-03-12 14:10:39.133-04	2017-03-27 08:47:26.687-04	\N	paypal
101	3	13	USD	100	Global Development	\N	\N	Global Development	\N	3	PAID	2016-04-26 23:56:08.086-04	2016-04-26 23:56:08.086-04	2016-06-14 14:14:21.062-04	\N	manual
653	3	284	USD	6000	Meetup Fee	\N	******	Fees	\N	3	PAID	2016-12-27 13:13:06.365-05	2016-12-27 13:34:55.519-05	2016-12-27 13:35:08.976-05	\N	manual
650	3	282	MXN	6000	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-27 12:56:16.269-05	2016-12-27 12:57:29.639-05	2016-12-27 12:57:54.703-05	\N	manual
648	3	280	USD	6000	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-27 12:48:20.364-05	2016-12-27 12:49:26.92-05	2016-12-27 12:49:40.165-05	\N	manual
649	3	281	AUD	6000	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-27 12:52:26.758-05	2016-12-27 12:53:15.394-05	2016-12-27 12:54:01.244-05	\N	manual
652	3	283	EUR	5700	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-27 13:10:37.485-05	2016-12-27 13:11:36.927-05	2016-12-27 13:11:52.22-05	\N	manual
651	3	10	MXN	6000	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-27 12:58:18.741-05	2016-12-27 13:00:31.933-05	2016-12-27 13:01:07.996-05	\N	manual
654	3	59	USD	6000	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-27 13:35:56.094-05	2016-12-27 13:38:25.72-05	2016-12-27 13:38:47.561-05	\N	manual
655	3	287	USD	6000	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-27 14:33:09.199-05	2016-12-27 14:46:38.03-05	2016-12-27 14:46:51.448-05	\N	manual
656	3	288	USD	6000	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-27 14:47:27.946-05	2016-12-27 14:49:57.05-05	2016-12-27 14:50:17.29-05	\N	manual
657	3	14	USD	6000	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-27 14:51:59.27-05	2016-12-27 14:52:56.386-05	2016-12-27 14:53:07.813-05	\N	manual
658	3	4	USD	6000	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-27 14:53:23.261-05	2016-12-27 14:55:42.961-05	2016-12-28 10:44:45.209-05	\N	manual
659	3	300	USD	6000	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-28 10:46:39.253-05	2016-12-28 10:49:03.856-05	2016-12-28 10:49:16.715-05	\N	manual
660	3	289	USD	6000	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-28 10:51:51.23-05	2016-12-28 10:52:34.697-05	2016-12-28 10:53:06.333-05	\N	manual
661	3	297	AUD	6000	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-28 10:54:27.49-05	2016-12-28 10:56:08.504-05	2016-12-28 10:56:29.497-05	\N	manual
662	3	241	USD	6000	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-28 10:56:55.397-05	2016-12-28 10:58:20.587-05	2016-12-28 10:58:50.601-05	\N	manual
663	3	291	CAD	6000	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-28 11:20:10.433-05	2016-12-28 11:21:39.298-05	2016-12-28 11:21:52.881-05	\N	manual
664	3	48	USD	6000	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-28 11:24:24.058-05	2016-12-28 11:25:18.14-05	2016-12-28 11:25:49.763-05	\N	manual
665	3	292	USD	6000	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-28 11:26:41.188-05	2016-12-28 11:28:01.61-05	2016-12-28 11:28:16.458-05	\N	manual
736	171	59	USD	4431	Printing WWCODE pamphlets for Camas STEM Fair for middle-school girls (organized by OHSU).	\N	******	Other	\N	3	PAID	2017-01-20 15:05:09.337-05	2017-01-21 15:28:40.38-05	2017-02-07 13:40:28.327-05	\N	paypal
790	171	59	USD	9050	Food for 2017 Planning Meeting w/ leadership team (Jan. 22)	\N	******	Leadership Development	\N	3	PAID	2017-02-01 17:40:18.153-05	2017-02-01 18:46:50.968-05	2017-02-07 13:40:50.169-05	\N	paypal
80	3	59	USD	10000	Global Development	\N	\N	Global Development	\N	3	PAID	2016-04-12 14:52:16.188-04	2016-04-12 14:52:16.188-04	2016-06-14 14:14:21.052-04	\N	manual
86	3	13	USD	100	Global Development	\N	\N	Global Development	\N	3	PAID	2016-04-15 13:29:50.291-04	2016-04-15 13:29:50.291-04	2016-06-14 14:14:21.055-04	\N	manual
195	3	48	USD	3418	FedEx Office	\N	\N	Leadership Supplies	\N	3	PAID	2016-01-24 19:00:00-05	2016-01-24 19:00:00-05	2016-06-14 14:14:21.118-04	\N	manual
888	69	12	USD	54783	Plaques for IWD awards ceremony​ 	\N	******	Other WWCode Event	\N	3	PAID	2017-03-06 16:54:10.307-05	2017-03-07 10:45:43.298-05	2017-03-15 09:57:14.51-04	\N	paypal
814	142	48	USD	25700	Movie screening for "She Started It"	\N	******	Other WWCode Event	\N	3	PAID	2017-02-09 21:26:00.889-05	2017-02-10 19:22:48.586-05	2017-03-14 13:59:53.192-04	\N	paypal
74	3	14	USD	11815	Reimbursement to Kamila for coffee purchased for volunteers at CONNECT 2016	\N	\N	Conference	\N	3	PAID	2016-04-05 15:44:01.338-04	2016-04-05 15:44:01.338-04	2016-06-14 14:14:21.046-04	\N	manual
190	3	48	USD	20000	Conference Grant - Sarah Olson	\N	\N	Scholarship	\N	3	PAID	2016-05-25 12:39:09.882-04	2016-05-25 12:39:09.882-04	2016-06-14 14:14:21.116-04	\N	manual
75	3	59	USD	6500	Reimburse Caterina for travel expenses to CONNECT 2016	\N	\N	Scholarship	\N	3	PAID	2016-04-05 15:44:01.338-04	2016-04-05 15:44:01.338-04	2016-06-14 14:14:21.047-04	\N	manual
82	3	4	USD	163	Meetup Transaction Fee	\N	\N	Transaction Fees	\N	3	REJECTED	2016-04-12 14:52:16.188-04	2016-04-12 14:52:16.188-04	2016-06-14 14:14:21.052-04	\N	manual
97	3	13	USD	100	Global Developement	\N	\N	Global Development	\N	3	REJECTED	2016-04-17 18:19:12.094-04	2016-04-17 18:19:12.094-04	2016-06-14 14:14:21.06-04	\N	manual
156	3	48	USD	110000	Conference Grant - Sarah Olson	Conference Grant - Airfare/Board	\N	Scholarship	\N	3	PAID	2016-05-10 15:19:21.785-04	2016-05-10 15:19:21.785-04	2016-06-14 14:14:21.099-04	\N	manual
95	3	13	USD	125	WePay fee	Jasna	\N	Transaction Fees	\N	3	PAID	2016-04-17 18:19:12.094-04	2016-04-17 18:19:12.094-04	2016-06-14 14:14:21.06-04	\N	manual
189	3	3	USD	100000	Conference Grant	Google Event - Elizabeth	\N	Scholarship	\N	3	PAID	2016-05-24 15:42:50.307-04	2016-05-24 15:42:50.307-04	2016-06-14 14:14:21.116-04	\N	manual
175	3	12	USD	120000	Conference Grant	Alicia V Carr - Conference Grant	\N	Scholarship	\N	3	PAID	2016-05-19 15:07:13.723-04	2016-05-19 15:07:13.723-04	2016-06-14 14:14:21.109-04	\N	manual
136	68	15	USD	1115	Mile High Agile outreach- supplies	\N	\N	Leadership Supplies	\N	68	PAID	2016-04-02 20:00:00-04	2016-04-02 20:00:00-04	2016-06-14 14:14:21.091-04	\N	paypal
194	3	48	USD	12700	A Small Orange	\N	\N	Other WWCode Event	\N	3	PAID	2016-02-01 19:00:00-05	2016-02-01 19:00:00-05	2016-06-14 14:14:21.119-04	\N	manual
774	31	14	USD	6100	Travel to attend internal leads meeting to finalize plans for upcoming 2017 events	\N	******	Other	\N	3	PAID	2017-01-28 09:06:40.223-05	2017-01-28 18:49:43.515-05	2017-02-22 10:27:02.688-05	\N	paypal
889	3419	516	USD	14630	Stickers	\N	******	Leadership Supplies	\N	3	PAID	2017-03-06 16:54:10.307-05	2017-03-07 14:01:52.82-05	2017-04-07 08:58:45.571-04	\N	paypal
815	142	48	USD	33412	Wearable Clothing Workshop	\N	******	Workshop	\N	3	PAID	2017-02-09 21:26:00.889-05	2017-02-10 19:23:45.137-05	2017-03-14 14:00:11.49-04	\N	paypal
198	3	13	USD	80000	CONFERENCE GRANT	\N	\N	Scholarship	\N	3	PAID	2016-05-31 13:47:01.276-04	2016-05-31 13:47:01.276-04	2016-06-14 14:14:21.121-04	\N	manual
218	31	14	USD	5161	May expense: Travel and expense costs for mentoring at StartUp Weekend, Meeting w Northeeastern University for future WWC events 	\N	\N	Leadership Development	\N	3	PAID	2016-06-06 20:21:31.531-04	2016-06-06 20:21:31.531-04	2016-06-14 14:14:21.131-04	\N	paypal
79	3	4	USD	150	Global Developement	\N	\N	Global Development	\N	3	PAID	2016-04-12 14:46:49.263-04	2016-04-12 14:46:49.263-04	2016-06-14 14:14:21.05-04	\N	manual
99	3	14	USD	2452	CONNECT 2016	Reimbursement for Sara Adineh	\N	Conference	\N	3	PAID	2016-04-25 20:00:00-04	2016-04-25 20:00:00-04	2016-06-14 14:14:21.061-04	\N	manual
104	3	48	USD	400	WePay Fee	For Andrea and Leslie donation 	\N	Transaction Fees	\N	3	PAID	2016-04-10 20:00:00-04	2016-04-10 20:00:00-04	2016-06-14 14:14:21.064-04	\N	manual
92	3	15	USD	2322	Stacey Schipper Reimbursement	April 6, 2016 Expense	\N	Other WWCode Event	\N	3	REJECTED	2016-04-17 18:19:12.094-04	2016-04-17 18:19:12.094-04	2016-06-14 14:14:21.058-04	\N	paypal
164	3	10	MXN	50000	Conference Grant	Conference Grant - Elsa Balderrama	\N	Scholarship	\N	3	PAID	2016-05-16 10:49:37.27-04	2016-05-16 10:49:37.27-04	2016-06-14 14:14:21.102-04	\N	manual
188	3	13	USD	15000	Conference Grant	Grant to Udisha 	\N	Scholarship	\N	3	PAID	2016-05-24 15:42:50.307-04	2016-05-24 15:42:50.307-04	2016-06-14 14:14:21.115-04	\N	manual
193	3	48	USD	65000	Photographer: Mike Ross	 	\N	Conference	\N	3	PAID	2016-01-05 19:00:00-05	2016-01-05 19:00:00-05	2016-06-14 14:14:21.118-04	\N	manual
224	3	59	USD	9995	Reimburse Caterina Paun for Program Expenses	Gift cards and thank you notes for workshop presenters	\N	Other WWCode Event	\N	3	PAID	2016-02-24 19:00:00-05	2016-02-24 19:00:00-05	2016-06-14 14:14:21.134-04	\N	manual
81	3	4	USD	163	Meetup Donation Transaction Fee	\N	\N	Transaction Fees	\N	3	PAID	2016-04-12 14:52:16.188-04	2016-04-12 14:52:16.188-04	2016-06-14 14:14:21.051-04	\N	manual
96	3	48	USD	250	Global Development	\N	\N	Global Development	\N	3	PAID	2016-04-17 18:19:12.094-04	2016-04-17 18:19:12.094-04	2016-06-14 14:14:21.06-04	\N	manual
225	3	59	USD	5504	Reimburse Caterina Paun for supplies and mailing expenses	\N	\N	Leadership Supplies	\N	3	PAID	2015-12-14 19:00:00-05	2015-12-14 19:00:00-05	2016-06-14 14:14:21.135-04	\N	manual
196	3	59	USD	50000	CONFERENCE GRANT	\N	\N	Scholarship	\N	3	PAID	2016-05-10 20:00:00-04	2016-05-10 20:00:00-04	2016-06-14 14:14:21.12-04	\N	manual
775	31	14	USD	5458	Lunch w Saranya during leads meeting. I lost the paper copy of the receipt so including the credit card statement 	\N	******	Other	\N	3	PAID	2017-01-28 09:06:40.223-05	2017-01-28 18:56:09.32-05	2017-02-22 10:27:45.559-05	\N	paypal
103	3	48	USD	150	Global Development	\N	\N	Global Development	\N	3	PAID	2016-04-27 12:21:00.228-04	2016-04-27 12:21:00.228-04	2016-06-14 14:14:21.063-04	\N	manual
145	3	13	USD	50000	Conference Grant	Conference Grant: Udisha	\N	Scholarship	\N	3	PAID	2016-05-04 17:14:39.136-04	2016-05-04 17:14:39.136-04	2016-06-14 14:14:21.094-04	\N	manual
227	3	59	USD	5000	Global Development	Nike Donation	\N	Global Development	\N	3	PAID	2016-02-21 19:00:00-05	2016-02-21 19:00:00-05	2016-06-14 14:14:21.135-04	\N	manual
76	3	59	USD	3798	Reimburse Caterina for program materials	\N	\N	Other WWCode Event	\N	3	PAID	2016-04-05 15:44:01.338-04	2016-04-05 15:44:01.338-04	2016-06-14 14:14:21.048-04	\N	manual
93	3	4	USD	150	Global Development	\N	\N	Global Development	\N	3	PAID	2016-04-17 18:19:12.094-04	2016-04-17 18:19:12.094-04	2016-07-08 23:52:41.064-04	\N	manual
255	31	14	USD	10294	Monthly core team lunch with Sandra Saranya Sara CiCi Tori (5 members) ; on boarding new core member Tori!	\N	******	Leadership Development	\N	31	PAID	2016-07-02 20:00:00-04	2016-07-04 16:23:49.309-04	2016-08-02 09:38:06.274-04	\N	paypal
374	171	59	USD	2077	Event Food	\N	******	Hack Night	\N	3	PAID	2016-09-27 22:15:48.098-04	2016-09-27 22:46:35.645-04	2016-10-05 12:43:29.036-04	\N	paypal
293	142	48	USD	10212	STEM Toys for Coding with Kids Event	\N	******	Other WWCode Event	\N	3	PAID	2016-07-16 20:00:00-04	2016-07-20 16:35:52.294-04	2016-08-16 10:58:32.981-04	\N	paypal
192	3	48	USD	2698	Leadership Tools (director tees)	Sarah Olson	\N	Leadership Supplies	\N	3	PAID	2015-12-14 19:00:00-05	2015-12-14 19:00:00-05	2016-06-14 14:14:21.117-04	\N	manual
294	142	48	USD	8496	STEM Toys for Coding with Kids Event	\N	******	Other WWCode Event	\N	3	PAID	2016-07-16 20:00:00-04	2016-07-20 16:41:41.183-04	2016-08-16 10:58:02.246-04	\N	paypal
318	142	48	USD	1500	Coding books for our study groups (Humble Bundle -- Joy of Coding)	\N	******	Technical Study Group	\N	3	PAID	2016-08-18 08:03:51.47-04	2016-08-18 08:07:07.685-04	2016-08-19 16:58:55.155-04	\N	paypal
346	171	59	USD	3224	Event food	\N	******	Food & Beverage	\N	3	PAID	2016-09-09 12:56:27.706-04	2016-09-09 12:56:59.265-04	2016-09-13 10:57:05.808-04	\N	paypal
345	171	59	USD	2911	Event food	\N	******	Supplies & materials	\N	3	PAID	2016-09-09 12:47:46.738-04	2016-09-09 12:56:23.297-04	2016-09-15 20:09:43.894-04	\N	paypal
366	142	48	USD	4898	Two VR headsets for our AR/VR event at Best Buy.	\N	******	Supplies & materials	\N	3	PAID	2016-09-21 16:21:09.898-04	2016-09-21 16:23:17.18-04	2016-09-27 15:31:43.772-04	\N	paypal
367	142	48	USD	2500	My coworker donated his evening to giving demos of his personal Oculus Rift for our AR/VR event, so I sent him a gift card to thank him for his help with the event.	\N	******	Other	\N	3	PAID	2016-09-22 11:22:21.436-04	2016-09-22 11:24:30.617-04	2016-09-27 15:33:54.695-04	\N	paypal
256	31	14	USD	749	Transportation for Sandra and Cici to get to meeting location with core team members	\N	******	Leadership Development	\N	31	PAID	2016-07-02 20:00:00-04	2016-07-04 16:25:35.824-04	2016-08-02 09:39:16.46-04	\N	paypal
197	3	59	USD	34750	CONFERENCE GRANT	\N	\N	Scholarship	\N	3	PAID	2016-05-26 15:05:53.771-04	2016-05-26 15:05:53.771-04	2016-06-14 14:14:21.121-04	\N	manual
222	3	4	USD	150	Global Development 	\N	\N	Global Development	\N	3	PAID	2016-06-09 14:38:16.857-04	2016-06-09 14:38:16.857-04	2016-06-14 14:14:21.133-04	\N	manual
307	31	14	USD	11757	Leadership team dinner - Sondry interview	\N	******	Scholarship	\N	31	PAID	2016-08-02 09:42:02.991-04	2016-08-02 09:43:29.423-04	2016-08-02 09:44:04.899-04	\N	paypal
333	142	48	USD	53720	Conference Travel	\N	******	Conference	\N	3	PAID	2016-08-26 20:03:45.469-04	2016-08-26 20:13:37.309-04	2016-11-03 17:27:23.523-04	\N	paypal
319	142	48	USD	13526	Dinner for last night's HackNight	\N	******	Hack Night	\N	3	PAID	2016-08-18 09:17:48.926-04	2016-08-18 09:19:12.087-04	2016-08-19 16:58:34.842-04	\N	paypal
375	171	59	USD	2715	Event supplies	\N	******	Leadership Supplies	\N	3	PAID	2016-09-27 22:46:42.795-04	2016-09-27 22:53:14.232-04	2016-10-05 12:44:00.917-04	\N	paypal
500	171	59	USD	2374	We Code Hackathon 2016	\N	******	Sponsorship	\N	3	PAID	2016-11-20 15:26:33.118-05	2016-11-20 15:29:20.497-05	2016-12-06 11:50:36.397-05	\N	paypal
158	3	48	USD	8320	Conference Expense	Sarah Olson	\N	Conference	\N	3	REJECTED	2016-05-10 15:19:21.785-04	2016-05-10 15:19:21.785-04	2016-06-14 14:14:21.1-04	\N	manual
178	3	3	USD	70000	Conference Grant	Sara Morsi Conference Grant	\N	Scholarship	\N	3	PAID	2016-05-19 15:07:13.723-04	2016-05-19 15:07:13.723-04	2016-06-14 14:14:21.11-04	\N	manual
378	171	59	USD	7167	Event Food	\N	******	Hack Night	\N	3	PAID	2016-09-27 22:55:23.801-04	2016-09-27 22:58:27.408-04	2016-10-05 12:44:48.383-04	\N	paypal
376	171	59	USD	2475	Marketing Materials	\N	******	Other	\N	3	PAID	2016-09-27 22:53:17.638-04	2016-09-27 22:54:27.309-04	2016-10-05 12:45:15.524-04	\N	paypal
377	171	59	USD	6471	Event Food	\N	******	Other WWCode Event	\N	3	PAID	2016-09-27 22:54:30.186-04	2016-09-27 22:55:20.669-04	2016-11-03 15:43:51.901-04	\N	paypal
372	142	48	USD	2200	Website - Domain Name	\N	******	Other	\N	3	PAID	2016-09-26 18:46:40.46-04	2016-09-26 18:48:04.38-04	2016-12-22 17:19:53.18-05	\N	paypal
395	3	15	USD	32000	90/10 split: Hackathon donation	\N	******	Global Development	\N	3	PAID	2016-07-14 20:00:00-04	2016-10-04 18:04:41.846-04	2016-10-04 18:05:23.579-04	\N	manual
389	3	12	USD	100000	90/10 split: AT&T Sponsorship (April 2015)	 	******	Global Development	\N	3	PAID	2016-10-04 11:40:50.076-04	2016-10-04 11:44:06.971-04	2016-10-04 11:44:29.326-04	\N	manual
387	3	12	USD	10000	Google I/O: Alicia Carr	\N	******	Scholarship	\N	3	PAID	2016-05-25 20:00:00-04	2016-10-04 11:31:40.439-04	2016-10-04 11:44:36.611-04	\N	manual
393	3	12	USD	500	90/10 split: Turner matching donation	\N	******	Global Development	\N	3	PAID	2016-10-04 11:52:24.157-04	2016-10-04 11:53:03.718-04	2016-10-04 12:06:02.71-04	\N	manual
391	3	12	USD	500	90/10 split: Beth Laing	\N	******	Global Development	\N	3	PAID	2016-10-04 11:50:56.293-04	2016-10-04 11:51:48.623-04	2016-10-04 12:06:11.584-04	\N	manual
392	3	12	USD	500	90/10 split: Beth Laing	\N	******	Global Development	\N	3	PAID	2016-10-04 11:50:56.293-04	2016-10-04 11:51:59.211-04	2016-10-04 12:06:17.663-04	\N	manual
390	3	12	USD	250	90/10 split: Syema Ailia	\N	******	Global Development	\N	3	PAID	2016-10-04 11:49:30.068-04	2016-10-04 11:50:45.734-04	2016-10-04 12:06:24.611-04	\N	manual
394	3	2	USD	56266	Net budget balance pre-Open Collective	\N	******	Other WWCode Event	\N	3	PAID	2016-01-14 19:00:00-05	2016-10-04 17:41:43.853-04	2016-10-04 17:57:46.063-04	\N	manual
411	3	59	USD	31950	WWCode Portland Stickers	\N	******	Leadership Supplies	\N	3	PAID	2016-10-10 16:10:50.586-04	2016-10-10 16:11:36.293-04	2016-10-10 16:12:34.385-04	\N	manual
412	3	195	USD	1000	Test	\N	******	Fees	\N	3	REJECTED	2016-10-11 12:11:05.021-04	2016-10-11 12:13:18.686-04	2016-10-11 12:17:02.494-04	\N	paypal
413	3	195	USD	1000	Test	\N	******	Fees	\N	3	PAID	2016-10-11 12:17:09.527-04	2016-10-11 12:18:10.423-04	2016-10-11 12:18:39.64-04	\N	manual
401	31	14	USD	3080	Monthly core team meeting. Beverages with dinner for six members 	\N	******	Other WWCode Event	\N	3	PAID	2016-10-04 23:13:51.147-04	2016-10-04 23:14:45.394-04	2016-10-31 13:59:54.551-04	\N	paypal
409	70	12	USD	2838	food/drink for organizers of NODE workshop (had to buy from on-site snack bar)	\N	******	Workshop	\N	3	PAID	2016-10-08 11:03:22.819-04	2016-10-08 11:11:18.293-04	2016-11-03 17:13:32.781-04	\N	paypal
400	31	14	USD	3323	Monthly team meeting w core six members. Food/pizza	\N	******	Other WWCode Event	\N	3	PAID	2016-10-04 23:12:18.236-04	2016-10-04 23:13:43.629-04	2016-10-31 17:02:17.181-04	\N	paypal
402	31	14	USD	729	Transportation to get to GeekWire Summit social event 	\N	******	Conference	\N	3	PAID	2016-10-04 23:14:49.674-04	2016-10-04 23:17:22.898-04	2016-11-01 12:16:03.421-04	\N	paypal
396	3	272	USD	25000	DIANA A. SCHOLARSHIP GOOGLE I/O	\N	******	Conference	\N	3	PAID	2016-10-04 18:22:45.384-04	2016-10-04 18:23:45.863-04	2016-11-21 17:59:44.22-05	\N	manual
417	1371	300	USD	48435	Costco breakfast, lunch, drinks, plates, cups, utensils, snacks, deserts ...	\N	******	Hackathon	\N	3	PAID	2016-10-12 15:47:17.894-04	2016-10-12 15:50:24.464-04	2016-10-31 17:08:49.808-04	\N	paypal
416	1371	300	USD	51962	500 gift cards, 19.62 printed awards	\N	******	Hackathon	\N	3	PAID	2016-10-12 15:45:46.133-04	2016-10-12 15:47:13.682-04	2016-10-31 17:09:12.082-04	\N	paypal
415	1371	300	USD	70000	pre payment for dinner catering	\N	******	Hackathon	\N	3	APPROVED	2016-10-12 15:44:25.684-04	2016-10-12 15:45:38.031-04	2016-10-27 17:05:29.785-04	2016-11-02 20:00:00-04	paypal
418	1371	300	USD	64978	lunch ordered at Costco	\N	******	Hackathon	\N	3	PAID	2016-10-12 15:50:37.851-04	2016-10-12 15:52:06.282-04	2016-10-28 17:31:00.087-04	\N	paypal
427	31	14	USD	1305	Google DevFest event that WWC sponsored and attended. Two large banners. Table cloth. Plus my luggage since I went directly from airport. 	\N	******	Workshop	\N	3	PAID	2016-10-15 18:59:26.409-04	2016-10-15 19:01:05.534-04	2016-10-31 13:52:13.785-04	\N	paypal
420	32	14	USD	2700	WWCode Seattle planning lunch with Sara	\N	******	Other	\N	3	PAID	2016-10-13 13:26:11.421-04	2016-10-13 13:30:27.473-04	2016-10-31 13:52:45.81-04	\N	paypal
419	171	59	USD	1446	Food for JavaScript Study Night - Oct. 11th	\N	******	Study Group	\N	3	PAID	2016-10-12 16:24:40.763-04	2016-10-12 16:48:15.148-04	2016-10-31 14:19:13.146-04	\N	paypal
453	28	2	USD	35000	DJ (ATXDivHack)	\N	******	Hackathon	\N	3	PAID	2016-10-26 00:34:19.335-04	2016-10-26 00:34:51.547-04	2016-10-27 17:08:49.13-04	\N	paypal
450	28	2	USD	6497	September Ruby Tuesday	\N	******	Study Group	\N	3	PAID	2016-10-25 23:53:42.508-04	2016-10-25 23:54:47.132-04	2016-10-31 17:11:37.246-04	\N	paypal
452	28	2	USD	26800	May AI Workshop	\N	******	Workshop	\N	3	PAID	2016-10-26 00:06:16.475-04	2016-10-26 00:07:27.314-04	2016-10-31 17:10:54.78-04	\N	paypal
447	28	2	USD	5518	Drinks for Happy Hour (ATXDivHack)	\N	******	Hackathon	\N	3	PAID	2016-10-25 20:40:29.898-04	2016-10-25 20:41:14.743-04	2016-10-31 17:13:40.764-04	\N	paypal
451	28	2	USD	20568	June South Hack Night	\N	******	Hack Night	\N	3	PAID	2016-10-25 23:57:37.783-04	2016-10-25 23:59:03.214-04	2016-10-31 17:11:21.759-04	\N	paypal
449	28	2	USD	75932	Drinks and snacks (ATXDivHack)	\N	******	Hackathon	\N	3	PAID	2016-10-25 23:43:46.209-04	2016-10-25 23:50:39.086-04	2016-10-31 17:13:06.494-04	\N	paypal
448	28	2	USD	2108	Markers, pens, sticky notes (ATXDivHack)	\N	******	Hackathon	\N	3	PAID	2016-10-25 20:41:19.411-04	2016-10-25 20:42:15.042-04	2016-10-31 17:13:20.6-04	\N	paypal
446	28	2	USD	1192	Almond milk for coffee (ATXDivHack)	\N	******	Hackathon	\N	3	PAID	2016-10-25 20:39:05.875-04	2016-10-25 20:40:23.911-04	2016-10-31 17:13:54.099-04	\N	paypal
445	28	2	USD	1136	Painters tape for signs  	\N	******	Hackathon	\N	3	PAID	2016-10-25 20:18:03.746-04	2016-10-25 20:39:01.083-04	2016-10-31 17:14:52.301-04	\N	paypal
470	1379	301	EUR	1019	Leadership Event in Sofia	\N	******	Other WWCode Event	\N	3	PAID	2016-11-09 15:01:53.197-05	2016-11-09 15:15:40.819-05	2016-12-07 16:30:48.755-05	\N	paypal
414	1371	300	USD	76800	second half of dinner catering	\N	******	Hackathon	\N	3	APPROVED	2016-10-12 15:28:23.372-04	2016-10-12 15:44:15.333-04	2016-10-27 17:07:24.861-04	2016-11-02 20:00:00-04	paypal
467	28	2	USD	339421	Food (ATXDivHack)	\N	******	Hackathon	\N	3	PAID	2016-11-02 18:10:25.089-04	2016-11-02 18:11:15.724-04	2016-11-21 10:23:08.924-05	\N	manual
464	3	14	USD	60000	Matthews Group - Leadership Development for Seattle team	Paid via PayPal	******	Leadership Development	\N	3	PAID	2016-10-31 18:03:17.783-04	2016-10-31 18:05:08.929-04	2016-11-29 16:46:31.974-05	\N	manual
466	28	2	USD	119954	Food (ATXDivHack)	\N	******	Hackathon	\N	3	PAID	2016-11-02 18:08:55.076-04	2016-11-02 18:10:20.431-04	2016-11-18 16:01:44.79-05	\N	paypal
494	1378	301	EUR	4728	European Leadership Development Workshop -- Transportation, Flight	\N	******	Leadership Development	\N	3	PAID	2016-09-30 20:00:00-04	2016-11-19 08:21:57.651-05	2016-11-22 17:07:58.565-05	\N	manual
498	171	59	USD	4874	Thank you cards, Christmas cards, stamps (for hackathon and all 2016 sponsors)	\N	******	Hackathon	\N	3	PAID	2016-11-20 15:18:30.305-05	2016-11-20 15:20:36.467-05	2016-11-22 16:55:11.103-05	\N	paypal
493	1378	301	EUR	4400	European Leadership Development Workshop -- Transportation, Taxi	\N	******	Leadership Development	\N	3	PAID	2016-10-26 20:00:00-04	2016-11-19 08:13:48.078-05	2016-11-22 17:07:41.878-05	\N	manual
471	1379	301	EUR	6444	Leadership Event in Sofia	\N	******	Other WWCode Event	\N	3	PAID	2016-11-09 15:15:46.133-05	2016-11-09 15:16:50.117-05	2016-12-07 16:38:07.749-05	\N	paypal
483	1325	273	USD	4351	Food for monthly hack night from Antonino Bertolo's Pizza & Wine Bar.	\N	******	Hack Night	\N	3	PAID	2016-08-31 20:00:00-04	2016-11-16 19:12:31.06-05	2016-12-06 12:58:42.358-05	\N	manual
484	1325	273	USD	7773	Food for October Hack Night.	\N	******	Hack Night	\N	3	PAID	2016-10-05 20:00:00-04	2016-11-16 19:29:48.238-05	2016-12-06 12:56:13.801-05	\N	manual
501	171	59	USD	1700	Thank you gift to an amazing sponsor!	\N	******	Hackathon	\N	3	PAID	2016-11-20 15:29:28.692-05	2016-11-20 15:34:51.872-05	2016-11-22 07:31:01.064-05	\N	paypal
499	171	59	USD	8181	Thank you bags (16) for hackathon speakers and judges, and for pre-hackathon events volunteers and sponsors.  Each bag contains a WWCode Portland coffee mug, a chocolate bar, ghirardellis squares, and a thank you card.	\N	******	Hackathon	\N	3	PAID	2016-11-20 15:20:40.018-05	2016-11-20 15:26:02.323-05	2016-11-22 16:54:34.067-05	\N	paypal
506	1333	278	GBP	6000	Food/Drinks for Leadership Team Meeting - Gen, Claire, Halima - Sept 2016	\N	******	Leadership Development	\N	3	PAID	2016-09-10 20:00:00-04	2016-11-22 15:36:49.712-05	2016-11-29 16:17:33.829-05	\N	manual
502	171	59	USD	1082	Marketing for IoT Hackathon	\N	******	Hackathon	\N	3	PAID	2016-11-20 15:36:16.598-05	2016-11-20 15:36:41.928-05	2016-12-06 11:50:57.444-05	\N	paypal
508	171	59	USD	3918	Supplies	\N	******	Hackathon	\N	3	PAID	2016-11-22 19:39:47.569-05	2016-11-22 20:16:59.692-05	2016-12-06 11:51:21.271-05	\N	paypal
509	171	59	USD	2698	T-shirt order - Design Lead	\N	******	Leadership Supplies	\N	3	PAID	2016-11-22 20:17:03.111-05	2016-11-22 20:18:21.842-05	2016-12-06 11:51:55.906-05	\N	paypal
507	1333	278	GBP	4000	Food/Drinks for Leadership Team Meeting - Gen, Claire - Oct 2016	\N	******	Leadership Development	\N	3	PAID	2016-10-01 20:00:00-04	2016-11-22 15:39:49.327-05	2016-11-29 16:17:22.193-05	\N	manual
474	31	14	USD	227646	Lodging and meals for our WWC Seattle 7 team members leadership development retreat. Under approved budget!	\N	******	Leadership Development	\N	3	PAID	2016-11-15 10:52:03.936-05	2016-11-15 10:54:05.532-05	2016-11-29 16:46:42.977-05	\N	manual
639	3	273	USD	6000	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-27 11:49:03.664-05	2016-12-27 11:49:52.742-05	2016-12-27 11:50:06.731-05	\N	manual
573	171	59	USD	1058	Goodie Bags	\N	******	Hackathon	\N	3	PAID	2016-12-06 22:01:09.941-05	2016-12-06 22:01:33.246-05	2016-12-07 15:49:56.687-05	\N	paypal
485	1325	273	USD	1106	October Hack Night Drinks/Food.	\N	******	Hack Night	\N	3	PAID	2016-10-05 20:00:00-04	2016-11-16 19:45:56.588-05	2016-12-06 12:58:10.939-05	\N	manual
486	1325	273	USD	4444	Food/Drinks for Anniversary Reception with guest WWCode Directors!	\N	******	Other WWCode Event	\N	3	PAID	2016-10-27 20:00:00-04	2016-11-16 20:08:09.48-05	2016-11-22 17:21:43.596-05	\N	manual
492	1325	273	USD	713	Food for Anniversary Reception	\N	******	Other WWCode Event	\N	3	PAID	2016-10-27 20:00:00-04	2016-11-17 15:36:37.444-05	2016-12-06 12:55:40.485-05	\N	manual
591	142	48	USD	30496	3D Printer & Supplies	\N	******	Hack Night	\N	3	PAID	2016-12-13 13:22:16.435-05	2016-12-13 15:33:52.789-05	2016-12-14 08:03:22.881-05	\N	paypal
602	142	48	USD	9240	Leadership - Planning for 2017 - Dinner	\N	******	Leadership Development	\N	3	PAID	2016-12-18 16:03:11.586-05	2016-12-18 16:03:54.509-05	2016-12-19 13:45:09.955-05	\N	paypal
604	142	48	USD	20397	Robotics: Coding with Your Kids HackNight Supplies	\N	******	Hack Night	\N	3	PAID	2016-12-18 16:04:48.665-05	2016-12-18 16:05:52.891-05	2016-12-19 11:20:41.101-05	\N	paypal
601	142	48	USD	1175	Leadership - Planning for 2017 - Afternoon Coffee	\N	******	Leadership Development	\N	3	PAID	2016-12-18 15:54:41.356-05	2016-12-18 16:03:08.099-05	2016-12-19 13:42:59.885-05	\N	paypal
613	3	260	USD	6000	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-23 11:32:39.612-05	2016-12-23 11:35:32.89-05	2016-12-23 11:37:59.658-05	\N	manual
603	142	48	USD	875	Leadership - Planning for 2017 - Evening Coffee	\N	******	Leadership Development	\N	3	PAID	2016-12-18 16:03:57.719-05	2016-12-18 16:04:44.175-05	2016-12-19 13:43:54.758-05	\N	paypal
605	1374	300	USD	46419	Mugs for WWCode-SV	\N	******	Global Development	\N	3	PAID	2016-12-19 17:19:05.439-05	2016-12-19 17:20:00.599-05	2016-12-20 13:57:28.737-05	\N	paypal
607	3	2	USD	6000	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-21 13:50:58.117-05	2016-12-21 13:53:15.213-05	2016-12-21 13:53:47.768-05	\N	manual
608	3	3	USD	6000	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-21 13:51:15.967-05	2016-12-21 13:54:08.982-05	2016-12-21 13:54:31.514-05	\N	manual
619	3	265	USD	6000	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-23 12:06:10.893-05	2016-12-23 12:09:46.554-05	2016-12-23 12:10:35.083-05	\N	manual
614	3	261	USD	6000	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-23 11:45:31.739-05	2016-12-23 11:48:42.88-05	2016-12-23 11:49:17.798-05	\N	manual
617	3	263	USD	6000	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-23 11:58:06.292-05	2016-12-23 12:00:11.888-05	2016-12-23 12:00:26.307-05	\N	manual
615	3	12	USD	6000	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-23 11:51:12.278-05	2016-12-23 11:52:04.132-05	2016-12-23 11:52:23.784-05	\N	manual
616	3	262	USD	6000	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-23 11:52:52.588-05	2016-12-23 11:55:02.457-05	2016-12-23 11:56:04.914-05	\N	manual
618	3	264	GBP	4900	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-23 12:03:12.871-05	2016-12-23 12:05:23.588-05	2016-12-23 12:05:42.262-05	\N	manual
621	3	259	USD	6000	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-23 12:20:24.371-05	2016-12-23 12:21:36.713-05	2016-12-23 12:21:53.364-05	\N	manual
620	3	301	EUR	5700	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-23 12:13:56.172-05	2016-12-23 12:14:45.703-05	2016-12-23 12:15:16.44-05	\N	manual
622	3	195	USD	6000	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-23 12:26:09.212-05	2016-12-23 12:32:25.111-05	2016-12-23 12:32:56.293-05	\N	manual
623	3	266	AUD	6000	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-23 12:41:23.136-05	2016-12-23 12:42:05.736-05	2016-12-23 12:42:19.013-05	\N	manual
624	3	267	GBP	4900	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-23 12:43:55.758-05	2016-12-23 12:58:18.148-05	2016-12-23 13:04:06.163-05	\N	manual
626	3	268	USD	6000	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-23 14:36:30.003-05	2016-12-23 14:38:32.584-05	2016-12-23 14:38:47.127-05	\N	manual
644	3	279	USD	6000	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-27 12:25:07.236-05	2016-12-27 12:26:20.227-05	2016-12-27 12:27:10.046-05	\N	manual
627	3	269	USD	6000	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-23 14:39:34.326-05	2016-12-23 14:41:36.646-05	2016-12-23 14:41:48.635-05	\N	manual
628	3	270	USD	6000	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-23 14:47:22.609-05	2016-12-23 14:49:40.181-05	2016-12-23 14:50:08.905-05	\N	manual
632	3	299	MXN	6000	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-27 11:10:47.262-05	2016-12-27 11:12:04.183-05	2016-12-27 11:12:26.594-05	\N	manual
633	3	271	USD	6000	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-27 11:13:47.179-05	2016-12-27 11:15:24.708-05	2016-12-27 11:16:27.404-05	\N	manual
640	3	274	USD	6000	Meetup Fee	\N	******	Fees	\N	3	PAID	2016-12-27 11:51:06.223-05	2016-12-27 11:52:25.022-05	2016-12-27 11:52:46.541-05	\N	manual
634	3	13	USD	6000	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-27 11:22:16.78-05	2016-12-27 11:23:20.484-05	2016-12-27 11:23:36.529-05	\N	manual
636	3	15	USD	6000	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-27 11:30:20.153-05	2016-12-27 11:31:33.602-05	2016-12-27 11:31:59.233-05	\N	manual
637	3	298	EUR	5700	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-27 11:35:19.064-05	2016-12-27 11:35:50.321-05	2016-12-27 11:36:05.685-05	\N	manual
641	3	275	USD	6000	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-27 11:54:08.966-05	2016-12-27 11:54:50.244-05	2016-12-27 11:55:07.749-05	\N	manual
638	3	272	USD	6000	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-27 11:39:04.447-05	2016-12-27 11:41:02.05-05	2016-12-27 11:41:27.62-05	\N	manual
642	3	276	USD	6000	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-27 11:58:36.204-05	2016-12-27 11:59:15.911-05	2016-12-27 11:59:34.226-05	\N	manual
647	3	278	GBP	4900	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-27 12:28:20.017-05	2016-12-27 12:33:16.816-05	2016-12-27 12:34:46.927-05	\N	manual
643	3	277	USD	6000	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-27 12:02:39.037-05	2016-12-27 12:03:12.312-05	2016-12-27 12:03:23.471-05	\N	manual
666	3	293	CAD	6000	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-28 11:28:38.36-05	2016-12-28 11:30:00.14-05	2016-12-28 11:30:16.798-05	\N	manual
667	3	294	USD	6000	Meetup Fees	\N	******	Fees	\N	3	PAID	2016-12-28 11:30:41.349-05	2016-12-28 11:32:05.407-05	2016-12-28 11:32:19.79-05	\N	manual
62	31	14	USD	1000	Nike Dinner	Ride home after Nike dinner. Shared ride with Sara Adineh. 	******	Conference	\N	31	PAID	2016-03-17 20:00:00-04	2016-03-17 20:00:00-04	2016-06-14 14:14:21.031-04	\N	paypal
72	32	14	USD	6800	Connect 2016 event setup day dinner	\N	******	Conference	\N	32	PAID	2016-03-17 20:00:00-04	2016-03-17 20:00:00-04	2016-06-14 14:14:21.044-04	\N	paypal
635	3	47	INR	6000	Meetup Fees	\N	******	Fees	\N	141	APPROVED	2016-12-27 11:24:45.938-05	2016-12-27 11:25:59.379-05	2017-01-11 05:50:47.014-05	\N	manual
724	142	48	USD	2093	Drinks (La Croix water) for Jan HackNight	\N	******	Hack Night	\N	3	PAID	2017-01-15 19:34:19.312-05	2017-01-16 15:30:30.683-05	2017-01-25 13:41:34.763-05	\N	paypal
725	142	48	USD	22137	Amazon Echo Dot devices for HackNight and first book for our book club.	\N	******	Hack Night	\N	3	PAID	2017-01-15 19:34:19.312-05	2017-01-16 15:32:05.491-05	2017-01-25 13:44:34.015-05	\N	paypal
743	70	12	USD	30000	travel to NY for bell ringing at NYSE	\N	******	Other WWCode Event	\N	3	PAID	2017-01-23 16:57:02.837-05	2017-01-23 21:35:07.349-05	2017-01-25 13:20:55.157-05	\N	paypal
167	31	14	USD	2948	Connect Conference video footage review	Date is 4/28/2016	******	Conference	\N	31	PAID	2016-05-16 20:31:54.682-04	2016-05-16 20:31:54.682-04	2016-06-14 14:14:21.103-04	\N	paypal
768	3	278	GBP	40970	Travel Scholarship for WWCode Director	\N	******	Leadership Development	\N	3	PAID	2017-01-26 18:23:43.983-05	2017-01-27 10:34:47.447-05	2017-04-17 18:32:02.795-04	\N	manual
46	68	15	USD	14000	Food for March Boulder, CO event	\N	******	Other WWCode Event	\N	68	PAID	2016-03-17 14:48:54.413-04	2016-03-17 14:48:54.413-04	2016-06-14 14:14:21.021-04	\N	paypal
53	28	2	USD	10284	Feb 4 hack night	\N	******	Hack Night	\N	28	PAID	2016-03-20 14:06:09.887-04	2016-03-20 14:06:09.887-04	2016-06-14 14:14:21.026-04	\N	paypal
55	28	2	USD	4951	Mar 3 hack night	\N	******	Hack Night	\N	28	PAID	2016-03-20 14:06:09.887-04	2016-03-20 14:06:09.887-04	2016-06-14 14:14:21.026-04	\N	paypal
785	3	47	INR	6000	Meetup Fees	\N	******	Leadership Development	\N	3	REJECTED	2017-01-30 18:17:44.823-05	2017-01-31 11:46:45.519-05	2017-02-14 16:17:53.548-05	\N	manual
497	171	59	USD	1798	Domain name for hackathon and study night projects	\N	******	Fees	\N	3	PAID	2016-11-20 15:00:51.642-05	2016-11-20 15:06:26.088-05	2017-02-20 15:53:02.93-05	\N	paypal
56	28	2	USD	22568	Feb 1, Lightning Talks	\N	******	Lightning Talks	\N	28	PAID	2016-03-20 14:06:09.887-04	2016-03-20 14:06:09.887-04	2016-06-14 14:14:21.027-04	\N	paypal
137	68	15	USD	14100	WWC Boulder- April event's food	\N	******	Other WWCode Event	\N	3	PAID	2016-04-06 20:00:00-04	2016-04-06 20:00:00-04	2016-06-14 14:14:21.09-04	\N	paypal
138	68	15	USD	7000	WWC Stickers	\N	******	Network supplies	\N	68	REJECTED	2016-03-17 20:00:00-04	2016-03-17 20:00:00-04	2016-06-14 14:14:21.091-04	\N	paypal
184	28	2	USD	8979	May 2 Lightning Talks	\N	******	Lightning Talks	\N	28	PAID	2016-05-22 19:46:04.647-04	2016-05-22 19:46:04.647-04	2016-06-14 14:14:21.113-04	\N	paypal
183	28	2	USD	13315	April 4 Lightning Talks	\N	******	Lightning Talks	\N	28	PAID	2016-05-22 19:46:04.647-04	2016-05-22 19:46:04.647-04	2016-06-14 14:14:21.113-04	\N	paypal
180	28	2	USD	5037	April 7 South Hack Night	\N	******	Hack Night	\N	28	PAID	2016-05-22 19:46:04.647-04	2016-05-22 19:46:04.647-04	2016-06-14 14:14:21.112-04	\N	paypal
181	28	2	USD	5325	May 5 South Hack Night	\N	******	Hack Night	\N	28	PAID	2016-05-22 19:46:04.647-04	2016-05-22 19:46:04.647-04	2016-06-14 14:14:21.112-04	\N	paypal
147	32	14	USD	14000	Quarterly planning meeting	\N	******	Leadership Development	\N	32	PAID	2016-05-05 20:18:43.265-04	2016-05-05 20:18:43.265-04	2016-06-14 14:14:21.095-04	\N	paypal
211	28	2	USD	20000	6/2/16 Fireside Chat at Orange Coworking	\N	******	Fireside Chat	\N	3	PAID	2016-06-04 17:37:03.991-04	2016-06-04 17:37:03.991-04	2016-06-14 14:14:21.127-04	\N	paypal
186	28	2	USD	30000	05-21-16 AI workshop	\N	******	Workshop	\N	3	PAID	2016-05-22 20:26:36.061-04	2016-05-22 20:26:36.061-04	2016-10-31 17:16:10.268-04	\N	paypal
213	28	2	USD	2400	3/30/16 Python Gameathon prize - Udemy course	\N	******	Hackathon	\N	3	PAID	2016-06-04 17:37:03.991-04	2016-06-04 17:37:03.991-04	2016-06-14 14:14:21.128-04	\N	paypal
48	68	15	USD	7800	Order for stickers of our official WWC Boulder/Denver chapter logo	We'll include these at our booth at the Mile High Agile conference in two weeks.	******	Leadership Supplies	\N	3	PAID	2016-03-17 23:23:34.628-04	2016-03-17 23:23:34.628-04	2016-11-03 15:45:25.209-04	\N	paypal
59	31	14	USD	4656	WwConnect planning meeting	Seattle team ordered in an evening meal to continue planning meeting	******	Conference	\N	31	PAID	2016-03-10 19:00:00-05	2016-03-10 19:00:00-05	2016-06-14 14:14:21.029-04	\N	paypal
60	31	14	USD	2519	WwConnect Planning Meeting	Two bottles of beverage for the Seattle team to have dinner brought in while working	******	Conference	\N	31	PAID	2016-03-10 19:00:00-05	2016-03-10 19:00:00-05	2016-06-14 14:14:21.03-04	\N	paypal
61	31	14	USD	709	WwConnect Conference Set Up Day 1	Cab ride to get on location	******	Conference	\N	31	PAID	2016-03-18 20:00:00-04	2016-03-18 20:00:00-04	2016-06-14 14:14:21.03-04	\N	paypal
64	31	14	USD	1025	WwConnect2016	Coffee for team. Day2	******	Conference	\N	31	PAID	2016-03-19 20:00:00-04	2016-03-19 20:00:00-04	2016-06-14 14:14:21.032-04	\N	paypal
34	7	10	MXN	166080	IVA Libretas Hackathon	Impuesto por la factura para las libretas	******	Hackathon	\N	3	REJECTED	2016-02-16 13:58:04.663-05	2016-02-16 13:58:04.663-05	2016-08-16 11:05:09.996-04	\N	paypal
63	31	14	USD	658	WwConnect Conference	Morning coffee day 2	******	Conference	\N	31	PAID	2016-03-19 20:00:00-04	2016-03-19 20:00:00-04	2016-06-14 14:14:21.032-04	\N	paypal
33	7	10	MXN	1038000	Libretas Hackathon	Pago entero para libretas de Hack for Equality	******	Hackathon	\N	3	REJECTED	2016-02-16 13:56:17.216-05	2016-02-16 13:56:17.216-05	2016-08-16 11:05:15.471-04	\N	paypal
776	31	14	USD	59040	Last minute (less than 7 day advance purchase) airline price purchase from SFO to JFK. Emailed Joey to alert of higher fare. 	\N	******	Other WWCode Event	\N	3	PAID	2017-01-28 09:06:40.223-05	2017-01-28 18:59:18.982-05	2017-02-07 13:32:49.378-05	\N	paypal
820	28	2	USD	10680	February Lightning Talks food	\N	******	Lightning Talks	\N	3	PAID	2017-02-11 22:22:39.341-05	2017-02-12 22:04:37.319-05	2017-03-14 13:17:54.1-04	\N	paypal
899	70	12	USD	20950	meetup with speaker, Heather VanCura, in conjunction with DevNexus conference	\N	******	Other WWCode Event	\N	3	PAID	2017-03-08 23:15:52.943-05	2017-03-09 00:17:56.148-05	2017-03-14 13:22:10.775-04	\N	paypal
900	70	12	USD	9732	IWD event -- wine for event	\N	******	Other WWCode Event	\N	3	PAID	2017-03-08 23:15:52.943-05	2017-03-09 00:20:17.878-05	2017-03-14 13:22:31.507-04	\N	paypal
858	171	59	USD	5798	Supplies for Agile workshop (2/26)	\N	******	Workshop	\N	3	PAID	2017-02-25 16:41:40.394-05	2017-02-26 16:29:05.754-05	2017-03-14 14:16:43.254-04	\N	paypal
886	3	511	MXN	14915	Leadership Development	\N	******	Conference	\N	3	PAID	2017-03-06 16:54:10.307-05	2017-03-07 07:57:52.472-05	2017-03-14 14:18:46.39-04	\N	manual
924	1332	277	USD	100000	To redeem travel stipend to Google I/O	\N	******	Conference	\N	3	PAID	2017-03-16 16:16:54.952-04	2017-03-16 21:25:25.526-04	2017-03-20 11:39:23.558-04	\N	paypal
926	1333	278	GBP	85000	Travel Stipend for Google I/O, now that I have secured my I/O Ticket via Google - see enclosed I/O Ticket Receipt)	\N	******	Scholarship	\N	3	PAID	2017-03-16 16:16:54.952-04	2017-03-17 02:43:54.949-04	2017-03-27 12:01:27.361-04	\N	paypal
935	1331	277	USD	100000	To redeem travel stipend to Google I/O	\N	******	Conference	\N	3	PAID	2017-03-20 15:19:06.997-04	2017-03-20 20:17:43.895-04	2017-03-27 13:54:16.852-04	\N	paypal
952	69	12	USD	50000	Google I/O	\N	******	Conference	\N	3	PAID	2017-03-26 12:01:07.917-04	2017-03-27 09:44:34.926-04	2017-03-27 13:11:39.352-04	\N	paypal
949	69	12	USD	37500	Google I/O ticket	\N	******	Conference	\N	3	PAID	2017-03-25 09:46:14.921-04	2017-03-25 11:06:03.662-04	2017-03-27 13:12:00.205-04	\N	paypal
965	1344	286	USD	37500	Google I/O Ticket  2017	\N	******	Leadership Development	\N	1344	APPROVED	2017-03-29 13:01:30.368-04	2017-03-29 16:36:36.032-04	2017-03-31 09:27:39.284-04	\N	paypal
966	171	59	USD	3405	Snacks for Unity 101 workshop.	\N	******	Workshop	\N	171	APPROVED	2017-03-29 13:01:30.368-04	2017-03-29 22:17:35.707-04	2017-03-29 22:19:03.184-04	\N	manual
967	171	59	USD	2085	Small thank you gifts for workshop instructors,	\N	******	Workshop	\N	171	APPROVED	2017-03-29 13:01:30.368-04	2017-03-29 22:21:03.723-04	2017-03-29 22:21:29.532-04	\N	manual
962	1344	286	USD	100000	Travel stipend to attend the Google I/O 2017 Conference.	\N	******	Conference	\N	3	PAID	2017-03-28 12:31:20.932-04	2017-03-29 12:18:26.633-04	2017-03-31 18:33:59.762-04	\N	paypal
974	3	286	USD	20000	Leadership Development: Conference Support: Karina M. 	\N	******	Conference	\N	1344	APPROVED	2017-03-31 13:33:05.687-04	2017-03-31 18:54:08.585-04	2017-03-31 21:11:20.009-04	\N	manual
988	3	295	USD	6000	Meetup Fees	\N	******	Leadership Development	\N	3	PAID	2017-04-05 10:08:17.838-04	2017-04-05 10:18:18.821-04	2017-04-05 10:19:21.382-04	\N	manual
998	3	12	USD	235699	Atlanta IWD Event	\N	******	Other WWCode Event	\N	3	PAID	2017-04-07 10:53:35.266-04	2017-04-07 16:27:41.491-04	2017-04-17 15:17:23.077-04	\N	manual
1001	171	59	USD	2891	Hackathon 2017 planning meeting	\N	******	Hackathon	\N	3	PAID	2017-04-09 11:46:01.525-04	2017-04-09 18:04:51.227-04	2017-04-11 15:15:09.869-04	\N	paypal
1002	171	59	USD	1527	Event supplies	\N	******	Leadership Supplies	\N	3	PAID	2017-04-09 11:46:01.525-04	2017-04-09 18:37:03.724-04	2017-04-11 15:13:28.739-04	\N	paypal
1016	1333	278	GBP	85000	WWCode CONNECT Conference Travel Stipend	\N	******	Conference	\N	3	PAID	2017-04-11 17:35:01.731-04	2017-04-12 10:42:51.103-04	2017-04-17 17:18:35.71-04	\N	paypal
1003	171	59	USD	3306	Event supplies	\N	******	Leadership Supplies	\N	171	APPROVED	2017-04-09 11:33:04.72-04	2017-04-09 18:37:53.717-04	2017-04-09 18:38:34.586-04	\N	manual
1007	142	48	USD	11948	Business cards and stickers	\N	******	Leadership Supplies	\N	3	PAID	2017-04-10 12:14:55.686-04	2017-04-10 17:31:17.015-04	2017-05-16 18:00:30.445-04	\N	manual
1027	3	270	USD	100000	Network Development: Attend CapOne WIT 2017 Kickoff to announce partnership for re-launch	\N	******	Other WWCode Event	\N	3	PAID	2017-04-17 15:15:50.71-04	2017-04-17 18:11:05.461-04	2017-04-17 18:12:23.057-04	\N	manual
1028	3	430	USD	100000	Google I/O Travel Grant: Yelyzaveta\tL.	Reimbursed via Western Union	******	Conference	\N	3	APPROVED	2017-04-17 15:15:52.793-04	2017-04-17 18:41:52.852-04	2017-04-17 18:42:06.121-04	2017-05-04 20:00:00-04	manual
1054	171	59	USD	2390	Planning meetings - Unity + VR workshops	\N	******	Workshop	\N	171	APPROVED	2017-04-24 18:33:05.343-04	2017-04-24 22:53:38.096-04	2017-04-24 23:08:41.521-04	\N	manual
1056	171	59	USD	33534	Hotel - Connect 2017	\N	******	Conference	\N	171	APPROVED	2017-04-24 18:31:39.131-04	2017-04-24 22:55:35.127-04	2017-04-24 23:08:38.705-04	\N	manual
1055	171	59	USD	13896	Flights for Connect 2017	\N	******	Conference	\N	171	APPROVED	2017-04-24 18:31:39.131-04	2017-04-24 22:54:40.938-04	2017-04-24 23:08:40.259-04	\N	manual
1084	142	48	USD	1554	Snacks and batteries for our robots	\N	******	Hack Night	\N	3	PAID	2017-04-18 20:00:00-04	2017-05-02 14:26:59.045-04	2017-05-16 18:00:04.484-04	\N	manual
1070	171	59	USD	1785	Tech Summit Lunch	\N	******	Conference	\N	171	APPROVED	2017-04-28 19:37:09.548-04	2017-04-29 17:42:39.653-04	2017-04-29 17:42:52.753-04	\N	manual
1093	171	59	USD	6513	Transportation - Connect 2017	\N	******	Conference	\N	171	APPROVED	2017-05-02 20:47:33.174-04	2017-05-03 16:05:13.476-04	2017-05-03 16:15:30.301-04	\N	manual
1099	3	430	USD	101200	Google i/o travel stipend for Yelyzaveta (plus $12 transfer fees)	\N	******	Scholarship	\N	3	PAID	2017-05-03 21:36:17.701-04	2017-05-04 15:05:15.03-04	2017-05-04 15:06:09.066-04	\N	manual
1085	142	48	USD	9777	Supplies for decorating our robots	\N	******	Hack Night	\N	3	PAID	2017-04-18 20:00:00-04	2017-05-02 14:28:49.091-04	2017-05-16 18:00:15.589-04	\N	manual
1086	142	48	USD	2989	Leadership meeting	\N	******	Leadership Development	\N	3	PAID	2017-04-21 20:00:00-04	2017-05-02 14:29:43.581-04	2017-05-16 17:59:48.244-04	\N	manual
1088	142	48	USD	100000	Google I/O Travel Stipend	\N	******	Conference	\N	3	PAID	2017-03-14 20:00:00-04	2017-05-02 14:34:08.158-04	2017-05-16 18:00:40.397-04	\N	manual
1092	171	59	USD	1950	Transportation - Connect 2017	\N	******	Conference	\N	171	APPROVED	2017-05-02 21:02:09.827-04	2017-05-03 15:52:47.919-04	2017-05-03 16:15:31.455-04	\N	manual
1137	171	59	USD	2680	Nametags	\N	******	Leadership Supplies	\N	171	APPROVED	2017-05-16 15:37:26.124-04	2017-05-16 18:26:29.898-04	2017-05-16 18:30:08.546-04	\N	paypal
1120	1378	301	EUR	2700	Regional Leadership Event: Barcelona	\N	******	Workshop	\N	1378	PENDING	2017-05-08 20:00:00-04	2017-05-10 16:08:43.707-04	2017-05-10 16:08:43.707-04	\N	paypal
1121	1378	301	EUR	2505	Regional Leadership Event: Barcelona	\N	******	Workshop	\N	1378	PENDING	2017-05-08 20:00:00-04	2017-05-10 16:09:17.149-04	2017-05-10 16:09:17.149-04	\N	paypal
1119	32	14	USD	11500	Farewell lunch for Clarissa + Welcome lunch for Pranoti 	\N	******	Other	\N	3	PAID	2017-05-10 06:03:37.039-04	2017-05-10 13:19:29.682-04	2017-05-16 17:55:26.77-04	\N	manual
1138	171	59	USD	3450	Color printing - flyers and signage for events. 	\N	******	Other	\N	171	APPROVED	2017-05-16 15:37:26.124-04	2017-05-16 18:41:15.044-04	2017-05-16 18:42:18.673-04	\N	paypal
1122	1378	301	EUR	19398	Regional Leadership Event: Barcelona	\N	******	Workshop	\N	3	PAID	2017-05-10 01:18:16.903-04	2017-05-10 16:10:54.588-04	2017-05-16 17:49:07.922-04	\N	manual
1123	3206	12	USD	500000	Deposit- We Rise Conference Hosting Location	\N	******	Conference	\N	3	PAID	2017-05-10 01:18:16.903-04	2017-05-10 21:32:36.838-04	2017-05-16 17:51:10.633-04	\N	manual
1143	32	14	USD	19017	Intro to Docker workshop food for attendees	\N	******	Workshop	\N	32	PENDING	2017-05-18 16:25:06.712-04	2017-05-19 00:24:00.964-04	2017-05-19 00:24:00.964-04	\N	paypal
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                         4027.dat                                                                                            0000600 0004000 0002000 00000051060 13174451173 0014256 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        2016-01-18 18:54:06.501-05	2016-01-18 18:54:06.501-05	\N	2	10	BACKER	61	\N	688	\N
2016-01-29 17:23:53.527-05	2016-01-29 17:23:53.527-05	\N	30	12	BACKER	87	\N	691	\N
2016-01-08 19:22:34.641-05	2016-01-08 19:22:34.64-05	\N	3	10	HOST	27	\N	51	\N
2016-01-12 19:00:00-05	\N	\N	3	12	HOST	29	\N	51	\N
2016-01-12 19:00:00-05	\N	\N	3	13	HOST	30	\N	51	\N
2016-09-20 16:58:51.903-04	2016-09-20 16:58:51.903-04	\N	1244	4	BACKER	1544	\N	717	\N
2016-09-09 23:42:51.435-04	2016-09-09 23:42:51.435-04	\N	1158	241	BACKER	1471	\N	737	\N
2016-02-02 11:52:02.312-05	2016-02-02 11:52:02.312-05	\N	80	10	BACKER	102	\N	768	\N
2016-06-21 12:02:55.799-04	2016-06-21 12:02:55.799-04	\N	642	12	BACKER	841	\N	775	\N
2016-06-21 12:05:00.99-04	2016-06-21 12:05:00.99-04	\N	642	4	BACKER	842	\N	775	\N
2016-06-21 12:06:05.21-04	2016-06-21 12:06:05.21-04	\N	642	48	BACKER	843	\N	775	\N
2016-07-01 18:31:46.068-04	2016-07-01 18:31:46.068-04	\N	686	2	BACKER	894	\N	803	\N
2016-02-02 16:46:44.979-05	2016-02-02 16:46:44.979-05	\N	8	14	BACKER	108	\N	819	\N
2016-06-09 13:28:14.08-04	2016-06-09 13:28:14.08-04	\N	8	3	BACKER	717	\N	819	\N
2016-03-02 16:31:50.622-05	2016-03-02 16:31:50.622-05	\N	129	2	BACKER	178	\N	689	54
2016-08-01 11:55:26.732-04	2016-08-01 11:55:26.732-04	\N	884	2	BACKER	1131	\N	750	54
2016-06-22 16:09:46.034-04	2016-06-22 16:09:46.034-04	\N	646	2	BACKER	846	\N	771	54
2016-06-06 15:04:36.955-04	2016-06-06 15:04:36.955-04	\N	551	2	BACKER	702	\N	781	54
2016-09-28 17:47:19.401-04	2016-09-28 17:47:19.401-04	\N	1299	2	BACKER	1634	\N	794	54
2016-09-13 00:15:05.534-04	2016-09-13 00:15:05.534-04	\N	1178	2	BACKER	1494	\N	788	54
2016-05-03 09:07:28-04	2016-05-03 09:07:28-04	\N	308	2	BACKER	437	\N	798	54
2016-06-06 20:53:47.104-04	2016-06-06 20:53:47.104-04	\N	555	13	BACKER	708	\N	742	61
2016-04-29 09:51:18.812-04	2016-04-29 09:51:18.812-04	\N	303	13	BACKER	425	\N	808	61
2016-04-28 11:01:17.535-04	2016-04-28 11:01:17.535-04	\N	283	13	BACKER	407	\N	824	61
2016-08-01 11:54:14.068-04	2016-08-01 11:54:14.068-04	\N	883	2	BACKER	1130	\N	839	54
2016-04-13 12:46:10.223-04	2016-04-13 12:46:10.223-04	\N	224	2	BACKER	330	\N	820	54
2016-02-18 14:54:08.738-05	2016-02-18 14:54:08.738-05	\N	108	2	BACKER	138	\N	813	54
2016-08-03 13:47:17.3-04	2016-08-03 13:47:17.3-04	\N	896	4	BACKER	1147	\N	759	64
2016-03-25 11:11:05.1-04	2016-03-25 11:11:05.1-04	\N	192	2	BACKER	268	\N	805	54
2016-06-09 20:00:00-04	\N	\N	577	4	ADMIN	738	\N	694	\N
2016-09-22 21:07:10.698-04	2016-09-22 21:07:10.698-04	\N	1263	59	BACKER	1568	\N	792	96
2016-01-31 19:00:00-05	\N	\N	73	3	ADMIN	94	\N	725	\N
2017-01-14 12:11:43.287-05	2017-01-14 12:11:43.287-05	\N	2549	270	BACKER	2767	\N	763	\N
2017-02-27 19:25:20.392-05	2017-02-27 19:25:20.392-05	\N	3301	522	BACKER	3424	\N	837	\N
2017-02-10 11:47:34.941-05	2017-02-10 11:47:34.941-05	\N	3053	15	BACKER	3214	\N	838	55
2016-11-28 10:33:15.87-05	2016-11-28 10:33:15.87-05	\N	1890	2	BACKER	2289	\N	810	54
2016-10-06 14:36:39.082-04	2016-10-06 14:36:39.082-04	\N	1438	2	BACKER	1815	\N	713	54
2017-01-03 15:59:38.784-05	2017-01-03 15:59:38.784-05	\N	2416	2	BACKER	2665	\N	709	54
2016-11-30 11:11:42.605-05	2016-11-30 11:11:42.605-05	\N	1957	2	BACKER	2339	\N	710	54
2016-10-07 12:49:20.388-04	2016-10-07 12:49:20.388-04	\N	1446	241	BACKER	1822	\N	712	83
2016-11-29 05:03:23.974-05	2016-11-29 05:03:23.974-05	\N	1908	301	BACKER	2296	\N	707	85
2016-11-17 12:43:31.221-05	2016-11-17 12:43:31.221-05	\N	1808	59	BACKER	2202	\N	708	96
2017-02-01 10:16:22.449-05	2017-02-01 10:16:22.449-05	\N	2898	48	BACKER	3042	\N	801	99
2016-09-29 14:41:11.097-04	2016-09-29 14:41:11.097-04	\N	1374	300	ADMIN	1708	\N	706	\N
2016-09-29 14:32:00.998-04	2016-09-29 14:32:00.998-04	\N	1357	294	ADMIN	1692	\N	714	\N
2016-09-29 14:30:08.992-04	2016-09-29 14:30:08.992-04	\N	1354	292	ADMIN	1689	\N	715	\N
2016-09-29 14:28:08.494-04	2016-09-29 14:28:08.494-04	\N	1352	290	ADMIN	1687	\N	716	\N
2016-09-29 14:28:54.298-04	2016-09-29 14:28:54.298-04	\N	1353	291	ADMIN	1688	\N	719	\N
2016-09-29 14:30:54.26-04	2016-09-29 14:30:54.26-04	\N	1356	293	ADMIN	1691	\N	720	\N
2016-09-29 14:28:08.489-04	2016-09-29 14:28:08.489-04	\N	1351	290	ADMIN	1686	\N	721	\N
2016-09-29 14:26:35.16-04	2016-09-29 14:26:35.16-04	\N	1350	289	ADMIN	1685	\N	722	\N
2016-09-29 14:30:08.999-04	2016-09-29 14:30:08.999-04	\N	1355	292	ADMIN	1690	\N	769	\N
2016-09-29 14:37:07.378-04	2016-09-29 14:37:07.378-04	\N	1367	298	ADMIN	1701	\N	776	\N
2016-09-29 14:43:49.259-04	2016-09-29 14:43:49.259-04	\N	1377	301	ADMIN	1713	\N	782	\N
2016-02-02 18:09:06.035-05	2016-02-02 18:09:06.035-05	\N	2	13	BACKER	109	\N	688	\N
2016-02-02 11:36:39.043-05	2016-02-02 11:36:39.043-05	\N	30	14	BACKER	101	\N	691	\N
2016-02-02 12:04:56.333-05	2016-02-02 12:04:56.333-05	\N	30	13	BACKER	103	\N	691	\N
2016-01-12 19:00:00-05	\N	\N	3	14	HOST	31	\N	51	\N
2016-01-12 19:00:00-05	\N	\N	3	15	HOST	32	\N	51	\N
2016-03-06 19:00:00-05	\N	\N	3	47	HOST	203	\N	51	\N
2016-03-06 19:00:00-05	\N	\N	3	48	HOST	205	\N	51	\N
2015-10-31 20:00:00-04	2015-10-31 20:00:00-04	\N	3	51	HOST	213	\N	51	\N
2016-01-31 19:00:00-05	\N	\N	3	2	HOST	18	\N	51	\N
2016-01-31 19:00:00-05	\N	\N	3	3	HOST	19	\N	51	\N
2016-01-31 19:00:00-05	\N	\N	3	4	HOST	20	\N	51	\N
2016-03-18 20:00:00-04	2016-03-18 20:00:00-04	\N	3	59	HOST	246	\N	51	\N
2016-08-01 20:00:00-04	2016-08-01 20:00:00-04	\N	3	195	HOST	1149	\N	51	\N
2016-09-07 18:13:23.811-04	2016-09-07 18:13:23.811-04	\N	3	241	HOST	1458	\N	51	\N
2016-09-29 14:43:49.259-04	2016-09-29 14:43:49.259-04	\N	3	301	HOST	1715	\N	51	\N
2016-09-29 14:41:11.097-04	2016-09-29 14:41:11.097-04	\N	3	300	HOST	1716	\N	51	\N
2016-09-29 14:38:54.983-04	2016-09-29 14:38:54.983-04	\N	3	299	HOST	1717	\N	51	\N
2016-09-29 14:37:07.378-04	2016-09-29 14:37:07.378-04	\N	3	298	HOST	1718	\N	51	\N
2016-09-29 14:34:59.53-04	2016-09-29 14:34:59.53-04	\N	3	297	HOST	1719	\N	51	\N
2016-09-29 14:33:37.221-04	2016-09-29 14:33:37.221-04	\N	3	295	HOST	1720	\N	51	\N
2016-09-29 14:32:01.003-04	2016-09-29 14:32:01.003-04	\N	3	294	HOST	1721	\N	51	\N
2016-09-29 14:30:54.26-04	2016-09-29 14:30:54.26-04	\N	3	293	HOST	1722	\N	51	\N
2016-09-29 14:30:08.999-04	2016-09-29 14:30:08.999-04	\N	3	292	HOST	1723	\N	51	\N
2016-09-29 14:28:54.298-04	2016-09-29 14:28:54.298-04	\N	3	291	HOST	1724	\N	51	\N
2016-09-29 14:28:08.494-04	2016-09-29 14:28:08.494-04	\N	3	290	HOST	1725	\N	51	\N
2016-09-29 14:26:35.16-04	2016-09-29 14:26:35.16-04	\N	3	289	HOST	1726	\N	51	\N
2016-09-29 14:25:22.012-04	2016-09-29 14:25:22.012-04	\N	3	288	HOST	1727	\N	51	\N
2016-09-29 14:24:17.83-04	2016-09-29 14:24:17.83-04	\N	3	287	HOST	1728	\N	51	\N
2016-09-29 14:19:11.467-04	2016-09-29 14:19:11.467-04	\N	3	286	HOST	1729	\N	51	\N
2016-09-29 14:17:47.337-04	2016-09-29 14:17:47.337-04	\N	3	285	HOST	1730	\N	51	\N
2016-09-29 14:16:52.145-04	2016-09-29 14:16:52.145-04	\N	3	284	HOST	1732	\N	51	\N
2016-09-29 14:16:17.13-04	2016-09-29 14:16:17.13-04	\N	3	283	HOST	1733	\N	51	\N
2016-09-29 14:15:23.948-04	2016-09-29 14:15:23.948-04	\N	3	282	HOST	1734	\N	51	\N
2016-09-29 14:14:46.62-04	2016-09-29 14:14:46.62-04	\N	3	281	HOST	1735	\N	51	\N
2016-09-29 14:13:48.784-04	2016-09-29 14:13:48.784-04	\N	3	280	HOST	1736	\N	51	\N
2016-09-29 14:12:58.888-04	2016-09-29 14:12:58.888-04	\N	3	279	HOST	1737	\N	51	\N
2016-09-29 14:11:53.87-04	2016-09-29 14:11:53.87-04	\N	3	278	HOST	1738	\N	51	\N
2016-09-29 14:10:43.445-04	2016-09-29 14:10:43.445-04	\N	3	277	HOST	1739	\N	51	\N
2016-09-29 14:09:42.812-04	2016-09-29 14:09:42.812-04	\N	3	276	HOST	1740	\N	51	\N
2016-09-29 14:08:19.528-04	2016-09-29 14:08:19.528-04	\N	3	275	HOST	1741	\N	51	\N
2016-09-29 14:06:44.758-04	2016-09-29 14:06:44.758-04	\N	3	274	HOST	1742	\N	51	\N
2016-09-29 14:06:00.979-04	2016-09-29 14:06:00.979-04	\N	3	273	HOST	1743	\N	51	\N
2016-09-29 14:05:19.101-04	2016-09-29 14:05:19.101-04	\N	3	272	HOST	1744	\N	51	\N
2016-09-29 14:03:46.814-04	2016-09-29 14:03:46.814-04	\N	3	271	HOST	1745	\N	51	\N
2016-09-29 14:02:54.581-04	2016-09-29 14:02:54.581-04	\N	3	270	HOST	1746	\N	51	\N
2016-09-29 14:01:49.724-04	2016-09-29 14:01:49.724-04	\N	3	269	HOST	1747	\N	51	\N
2016-09-29 14:01:04.753-04	2016-09-29 14:01:04.753-04	\N	3	268	HOST	1748	\N	51	\N
2016-09-29 14:00:01.891-04	2016-09-29 14:00:01.891-04	\N	3	267	HOST	1749	\N	51	\N
2016-09-29 13:59:15.446-04	2016-09-29 13:59:15.446-04	\N	3	266	HOST	1750	\N	51	\N
2016-09-29 13:58:16.643-04	2016-09-29 13:58:16.643-04	\N	3	265	HOST	1751	\N	51	\N
2016-09-29 13:54:53.501-04	2016-09-29 13:54:53.501-04	\N	3	264	HOST	1752	\N	51	\N
2016-09-29 13:53:00.559-04	2016-09-29 13:53:00.559-04	\N	3	263	HOST	1753	\N	51	\N
2016-09-29 13:51:29.396-04	2016-09-29 13:51:29.396-04	\N	3	262	HOST	1754	\N	51	\N
2016-09-29 13:49:43.088-04	2016-09-29 13:49:43.088-04	\N	3	261	HOST	1755	\N	51	\N
2016-09-29 13:44:40.461-04	2016-09-29 13:44:40.461-04	\N	3	260	HOST	1756	\N	51	\N
2016-09-29 13:43:14.112-04	2016-09-29 13:43:14.112-04	\N	3	259	HOST	1757	\N	51	\N
2017-01-03 19:00:00-05	2017-01-03 19:00:00-05	\N	3	430	HOST	2682	\N	51	\N
2017-02-21 11:25:28.555-05	2017-02-21 11:25:28.555-05	\N	3	510	HOST	3326	\N	51	\N
2017-02-21 11:55:29.765-05	2017-02-21 11:55:29.765-05	\N	3	511	HOST	3328	\N	51	\N
2017-02-21 13:11:30.855-05	2017-02-21 13:11:30.855-05	\N	3	512	HOST	3332	\N	51	\N
2017-02-21 13:35:34.613-05	2017-02-21 13:35:34.613-05	\N	3	513	HOST	3334	\N	51	\N
2017-02-21 13:49:14.435-05	2017-02-21 13:49:14.435-05	\N	3	515	HOST	3338	\N	51	\N
2017-02-21 14:02:21.646-05	2017-02-21 14:02:21.646-05	\N	3	516	HOST	3341	\N	51	\N
2017-02-21 14:07:25.321-05	2017-02-21 14:07:25.321-05	\N	3	517	HOST	3343	\N	51	\N
2017-02-21 14:13:03.538-05	2017-02-21 14:13:03.538-05	\N	3	518	HOST	3345	\N	51	\N
2017-02-21 14:25:28.822-05	2017-02-21 14:25:28.822-05	\N	3	519	HOST	3347	\N	51	\N
2017-02-21 14:34:47.427-05	2017-02-21 14:34:47.427-05	\N	3	520	HOST	3349	\N	51	\N
2017-02-21 14:39:46.29-05	2017-02-21 14:39:46.29-05	\N	3	521	HOST	3351	\N	51	\N
2017-02-21 14:45:19.309-05	2017-02-21 14:45:19.309-05	\N	3	522	HOST	3353	\N	51	\N
2017-02-21 15:04:49.156-05	2017-02-21 15:04:49.156-05	\N	3	523	HOST	3355	\N	51	\N
2017-02-21 15:11:44.893-05	2017-02-21 15:11:44.893-05	\N	3	524	HOST	3357	\N	51	\N
2017-02-21 15:16:59.184-05	2017-02-21 15:16:59.184-05	\N	3	525	HOST	3359	\N	51	\N
2017-04-03 12:22:46.049-04	2017-04-03 12:22:46.049-04	\N	3	584	HOST	3951	\N	51	\N
2015-11-19 05:07:53.479-05	2017-10-26 17:24:03.799-04	\N	3	51	HOST	4719	\N	51	\N
2017-05-10 19:45:46.804-04	2017-05-10 19:45:46.804-04	\N	4749	522	BACKER	4528	\N	747	\N
2017-04-30 21:40:31.703-04	2017-04-30 21:40:31.703-04	\N	3419	516	BACKER	4353	\N	841	\N
2017-02-01 12:30:50.44-05	2017-02-01 12:30:50.44-05	\N	2906	271	BACKER	3045	\N	693	57
2017-04-11 22:05:36.09-04	2017-04-11 22:05:36.09-04	\N	4173	13	BACKER	4093	\N	692	61
2017-05-09 14:14:23.365-04	2017-05-09 14:14:23.365-04	\N	4720	2	BACKER	4500	\N	846	54
2017-04-04 15:51:04.96-04	2017-04-04 15:51:04.96-04	\N	3999	2	BACKER	3972	\N	836	54
2017-01-18 08:54:51.032-05	2017-01-18 08:54:51.032-05	\N	2594	48	BACKER	2794	\N	697	99
2017-05-09 01:59:17.562-04	2017-05-09 01:59:17.562-04	\N	4711	517	BACKER	4493	\N	711	105
2017-05-01 13:13:36.311-04	2017-05-01 13:13:36.311-04	\N	4550	516	BACKER	4371	\N	785	122
2017-05-15 08:07:59.716-04	2017-05-15 08:07:59.716-04	\N	4834	14	BACKER	4597	\N	799	125
2016-09-29 14:08:19.528-04	2016-09-29 14:08:19.528-04	\N	1328	275	ADMIN	1663	\N	686	\N
2016-09-29 14:09:42.806-04	2016-09-29 14:09:42.806-04	\N	1329	276	ADMIN	1664	\N	687	\N
2016-03-01 23:42:00.064-05	2016-03-01 23:42:00.064-05	\N	126	13	BACKER	169	\N	704	\N
2016-09-01 10:41:37.755-04	2016-09-01 10:41:37.755-04	\N	1094	2	BACKER	1388	\N	738	54
2016-12-18 20:41:29.216-05	2016-12-18 20:41:29.216-05	\N	2220	259	BACKER	2545	\N	700	80
2017-03-09 13:29:55.806-05	2017-03-09 13:29:55.806-05	\N	3442	259	BACKER	3521	\N	754	80
2016-09-29 14:10:43.445-04	2016-09-29 14:10:43.445-04	\N	1332	277	ADMIN	1667	\N	831	\N
\N	\N	\N	1094	738	ADMIN	4721	\N	849	\N
\N	\N	\N	224	820	ADMIN	4726	\N	854	\N
2016-05-19 15:24:42.921-04	2016-05-19 15:24:42.921-04	\N	392	2	BACKER	533	\N	718	54
2017-04-10 21:09:50.695-04	2017-04-10 21:09:50.695-04	\N	4153	13	BACKER	4088	\N	842	61
2016-11-22 10:22:40.419-05	2016-11-22 10:22:40.419-05	\N	1846	59	BACKER	2246	\N	701	96
2016-09-29 14:10:43.419-04	2016-09-29 14:10:43.419-04	\N	1331	277	ADMIN	1666	\N	695	\N
2016-09-29 13:44:40.454-04	2016-09-29 13:44:40.454-04	\N	1304	260	ADMIN	1638	\N	705	\N
2016-09-29 14:26:35.151-04	2016-09-29 14:26:35.151-04	\N	1349	289	ADMIN	1684	\N	723	\N
2016-09-29 14:25:22.012-04	2016-09-29 14:25:22.012-04	\N	1348	288	ADMIN	1683	\N	724	\N
2016-09-29 14:24:17.83-04	2016-09-29 14:24:17.83-04	\N	1346	287	ADMIN	1681	\N	726	\N
2016-09-29 14:24:17.825-04	2016-09-29 14:24:17.825-04	\N	1345	287	ADMIN	1680	\N	727	\N
2016-09-29 14:19:11.462-04	2016-09-29 14:19:11.462-04	\N	1343	286	ADMIN	1678	\N	728	\N
2016-09-29 14:16:52.145-04	2016-09-29 14:16:52.145-04	\N	1341	284	ADMIN	1676	\N	729	\N
2016-09-29 14:17:47.337-04	2016-09-29 14:17:47.337-04	\N	1342	285	ADMIN	1677	\N	730	\N
2016-09-29 14:16:17.13-04	2016-09-29 14:16:17.13-04	\N	1340	283	ADMIN	1675	\N	731	\N
2016-09-29 14:14:46.62-04	2016-09-29 14:14:46.62-04	\N	1338	281	ADMIN	1673	\N	732	\N
2016-09-29 14:15:23.948-04	2016-09-29 14:15:23.948-04	\N	1339	282	ADMIN	1674	\N	733	\N
2016-09-29 14:13:48.784-04	2016-09-29 14:13:48.784-04	\N	1337	280	ADMIN	1672	\N	734	\N
2016-09-29 14:12:58.888-04	2016-09-29 14:12:58.888-04	\N	1336	279	ADMIN	1671	\N	735	\N
2016-09-29 14:11:53.87-04	2016-09-29 14:11:53.87-04	\N	1334	278	ADMIN	1669	\N	736	\N
2016-09-07 18:13:23.641-04	2016-09-07 18:13:23.641-04	\N	1145	241	ADMIN	1457	\N	739	\N
2016-09-29 14:09:42.812-04	2016-09-29 14:09:42.812-04	\N	1330	276	ADMIN	1665	\N	740	\N
2016-09-29 14:06:44.758-04	2016-09-29 14:06:44.758-04	\N	1326	274	ADMIN	1661	\N	743	\N
2016-09-29 14:05:19.093-04	2016-09-29 14:05:19.093-04	\N	1323	272	ADMIN	1658	\N	745	\N
2016-09-29 14:05:19.101-04	2016-09-29 14:05:19.101-04	\N	1324	272	ADMIN	1659	\N	744	\N
2016-08-01 20:00:00-04	2016-08-01 20:00:00-04	\N	898	195	ADMIN	1151	\N	746	\N
2016-08-01 20:00:00-04	2016-08-01 20:00:00-04	\N	897	195	ADMIN	1150	\N	748	\N
2016-09-29 14:03:46.814-04	2016-09-29 14:03:46.814-04	\N	1322	271	ADMIN	1657	\N	749	\N
2016-09-29 14:02:54.576-04	2016-09-29 14:02:54.576-04	\N	1320	270	ADMIN	1655	\N	751	\N
2016-09-29 14:02:54.581-04	2016-09-29 14:02:54.581-04	\N	1321	270	ADMIN	1656	\N	752	\N
2016-09-29 14:01:49.724-04	2016-09-29 14:01:49.724-04	\N	1319	269	ADMIN	1654	\N	753	\N
2016-01-31 19:00:00-05	\N	\N	68	15	ADMIN	89	\N	755	\N
2016-09-29 14:25:22-04	2016-09-29 14:25:22-04	\N	1347	288	ADMIN	1682	\N	756	\N
2016-09-29 14:01:04.753-04	2016-09-29 14:01:04.753-04	\N	1318	268	ADMIN	1653	\N	757	\N
2016-09-29 14:01:04.72-04	2016-09-29 14:01:04.72-04	\N	1317	268	ADMIN	1652	\N	758	\N
2016-09-29 13:59:15.446-04	2016-09-29 13:59:15.446-04	\N	1316	266	ADMIN	1650	\N	760	\N
2016-09-29 13:58:16.643-04	2016-09-29 13:58:16.643-04	\N	1315	265	ADMIN	1649	\N	761	\N
2016-01-31 19:00:00-05	\N	\N	70	12	ADMIN	91	\N	762	\N
2016-09-29 13:54:53.501-04	2016-09-29 13:54:53.501-04	\N	1314	264	ADMIN	1648	\N	764	\N
2016-09-29 14:00:01.891-04	2016-09-29 14:00:01.891-04	\N	1314	267	ADMIN	1651	\N	764	\N
2016-09-29 13:54:53.485-04	2016-09-29 13:54:53.485-04	\N	1313	264	ADMIN	1647	\N	765	\N
2016-01-10 19:00:00-05	\N	\N	31	14	ADMIN	13	\N	766	\N
2016-09-29 13:53:00.559-04	2016-09-29 13:53:00.559-04	\N	1312	263	ADMIN	1646	\N	767	\N
2016-09-29 13:51:29.396-04	2016-09-29 13:51:29.396-04	\N	1310	262	ADMIN	1644	\N	770	\N
2016-09-29 13:51:29.377-04	2016-09-29 13:51:29.377-04	\N	1309	262	ADMIN	1643	\N	772	\N
2016-01-31 19:00:00-05	\N	\N	72	3	ADMIN	93	\N	773	\N
2016-01-31 19:00:00-05	\N	\N	77	4	ADMIN	98	\N	774	\N
2016-09-29 13:49:43.088-04	2016-09-29 13:49:43.088-04	\N	1308	261	ADMIN	1642	\N	777	\N
2016-01-31 19:00:00-05	\N	\N	75	4	ADMIN	96	\N	779	\N
2016-01-31 19:00:00-05	\N	\N	78	4	ADMIN	99	\N	778	\N
2016-09-29 13:49:43.081-04	2016-09-29 13:49:43.081-04	\N	1307	261	ADMIN	1641	\N	780	\N
2016-09-29 13:44:40.461-04	2016-09-29 13:44:40.461-04	\N	1305	260	ADMIN	1639	\N	783	\N
2016-01-31 19:00:00-05	\N	\N	76	4	ADMIN	97	\N	784	\N
2016-01-31 19:00:00-05	\N	\N	67	13	ADMIN	88	\N	787	\N
2016-09-29 13:53:00.559-04	2016-09-29 13:53:00.559-04	\N	1311	263	ADMIN	1645	\N	789	\N
2016-09-29 14:12:58.877-04	2016-09-29 14:12:58.877-04	\N	1335	279	ADMIN	1670	\N	790	\N
2016-01-10 19:00:00-05	\N	\N	32	14	ADMIN	14	\N	797	\N
2016-01-10 19:00:00-05	\N	\N	35	12	ADMIN	11	\N	806	\N
2016-03-18 20:00:00-04	2016-03-18 20:00:00-04	\N	170	59	ADMIN	247	\N	809	\N
2016-01-31 19:00:00-05	\N	\N	71	3	ADMIN	92	\N	816	\N
2016-01-10 19:00:00-05	\N	\N	33	13	ADMIN	12	\N	817	\N
2016-01-10 19:00:00-05	\N	\N	7	10	ADMIN	8	\N	821	\N
2016-01-10 19:00:00-05	\N	\N	37	10	ADMIN	10	\N	822	\N
2016-01-10 19:00:00-05	\N	\N	34	15	ADMIN	15	\N	823	\N
2016-01-10 19:00:00-05	\N	\N	36	10	ADMIN	9	\N	826	\N
2016-03-18 20:00:00-04	2016-03-18 20:00:00-04	\N	171	59	ADMIN	248	\N	827	\N
2016-09-29 14:11:53.863-04	2016-09-29 14:11:53.863-04	\N	1333	278	ADMIN	1668	\N	830	\N
2016-01-31 19:00:00-05	\N	\N	69	12	ADMIN	90	\N	834	\N
2016-09-29 14:08:19.514-04	2016-09-29 14:08:19.514-04	\N	1327	275	ADMIN	1662	\N	835	\N
2016-09-29 14:06:00.979-04	2016-09-29 14:06:00.979-04	\N	1325	273	ADMIN	1660	\N	843	\N
2016-03-06 19:00:00-05	\N	\N	141	47	ADMIN	202	\N	844	\N
2016-01-31 19:00:00-05	\N	\N	74	4	ADMIN	95	\N	845	\N
2016-09-29 14:43:49.259-04	2016-09-29 14:43:49.259-04	\N	1376	301	ADMIN	1712	\N	786	\N
2016-09-29 14:41:11.097-04	2016-09-29 14:41:11.097-04	\N	1373	300	ADMIN	1709	\N	791	\N
2016-09-29 14:43:49.259-04	2016-09-29 14:43:49.259-04	\N	1378	301	ADMIN	1714	\N	793	\N
2016-09-29 14:41:11.077-04	2016-09-29 14:41:11.077-04	\N	1371	300	ADMIN	1706	\N	795	\N
2016-09-29 14:41:11.089-04	2016-09-29 14:41:11.089-04	\N	1372	300	ADMIN	1707	\N	796	\N
2016-09-29 14:43:49.258-04	2016-09-29 14:43:49.258-04	\N	1379	301	ADMIN	1711	\N	800	\N
2016-09-29 14:38:54.983-04	2016-09-29 14:38:54.983-04	\N	1369	299	ADMIN	1704	\N	802	\N
2016-09-29 14:38:54.974-04	2016-09-29 14:38:54.974-04	\N	1368	299	ADMIN	1703	\N	804	\N
2016-09-29 14:37:07.378-04	2016-09-29 14:37:07.378-04	\N	1366	298	ADMIN	1702	\N	807	\N
2016-09-29 14:37:07.37-04	2016-09-29 14:37:07.37-04	\N	1365	298	ADMIN	1700	\N	811	\N
2016-09-29 14:34:59.53-04	2016-09-29 14:34:59.53-04	\N	1364	297	ADMIN	1699	\N	812	\N
2016-09-29 14:34:59.522-04	2016-09-29 14:34:59.522-04	\N	1362	297	ADMIN	1697	\N	814	\N
2016-09-29 14:34:59.53-04	2016-09-29 14:34:59.53-04	\N	1363	297	ADMIN	1698	\N	815	\N
2016-09-29 14:33:37.221-04	2016-09-29 14:33:37.221-04	\N	1360	295	ADMIN	1696	\N	818	\N
2016-09-29 14:38:54.983-04	2016-09-29 14:38:54.983-04	\N	1370	299	ADMIN	1705	\N	825	\N
2016-09-29 14:33:37.213-04	2016-09-29 14:33:37.213-04	\N	1359	295	ADMIN	1694	\N	828	\N
2016-09-29 14:43:49.24-04	2016-09-29 14:43:49.24-04	\N	1375	301	ADMIN	1710	\N	829	\N
2016-09-29 14:33:37.221-04	2016-09-29 14:33:37.221-04	\N	1361	295	ADMIN	1695	\N	832	\N
2016-09-29 14:32:01.003-04	2016-09-29 14:32:01.003-04	\N	1358	294	ADMIN	1693	\N	833	\N
2017-04-03 12:22:45.962-04	2017-04-03 12:22:45.962-04	\N	3206	584	ADMIN	3950	\N	690	\N
2017-02-21 11:25:28.457-05	2017-02-21 11:25:28.457-05	\N	3	510	ADMIN	3325	\N	51	\N
2017-02-21 13:11:30.773-05	2017-02-21 13:11:30.773-05	\N	3	512	ADMIN	3331	\N	51	\N
2017-02-21 11:55:29.655-05	2017-02-21 11:55:29.655-05	\N	3	511	ADMIN	3327	\N	51	\N
2017-02-21 13:35:34.524-05	2017-02-21 13:35:34.524-05	\N	3	513	ADMIN	3333	\N	51	\N
2017-02-21 13:49:14.345-05	2017-02-21 13:49:14.345-05	\N	3	515	ADMIN	3337	\N	51	\N
2017-02-21 14:02:21.568-05	2017-02-21 14:02:21.568-05	\N	3	516	ADMIN	3340	\N	51	\N
2017-02-21 14:07:25.188-05	2017-02-21 14:07:25.188-05	\N	3	517	ADMIN	3342	\N	51	\N
2017-02-21 14:13:03.394-05	2017-02-21 14:13:03.394-05	\N	3	518	ADMIN	3344	\N	51	\N
2017-02-21 14:25:28.725-05	2017-02-21 14:25:28.725-05	\N	3	519	ADMIN	3346	\N	51	\N
2017-02-21 14:34:47.02-05	2017-02-21 14:34:47.02-05	\N	3	520	ADMIN	3348	\N	51	\N
2017-02-21 14:39:46.239-05	2017-02-21 14:39:46.239-05	\N	3	521	ADMIN	3350	\N	51	\N
2017-02-21 14:45:19.169-05	2017-02-21 14:45:19.169-05	\N	3	522	ADMIN	3352	\N	51	\N
2017-02-21 15:04:48.979-05	2017-02-21 15:04:48.979-05	\N	3	523	ADMIN	3354	\N	51	\N
2017-02-21 15:11:44.767-05	2017-02-21 15:11:44.767-05	\N	3	524	ADMIN	3356	\N	51	\N
2017-02-21 15:16:59.092-05	2017-02-21 15:16:59.092-05	\N	3	525	ADMIN	3358	\N	51	\N
2016-03-06 19:00:00-05	\N	\N	142	48	ADMIN	204	\N	696	\N
2016-09-29 14:19:11.467-04	2016-09-29 14:19:11.467-04	\N	1344	286	ADMIN	1679	\N	698	\N
\N	\N	\N	884	750	ADMIN	4722	\N	850	\N
\N	\N	\N	283	824	ADMIN	4727	\N	855	\N
2016-09-29 13:43:14.112-04	2016-09-29 13:43:14.112-04	\N	1303	259	ADMIN	1637	\N	702	\N
2017-01-03 19:00:00-05	2017-01-03 19:00:00-05	\N	2431	430	ADMIN	2681	\N	703	\N
\N	\N	\N	129	689	ADMIN	4720	\N	848	\N
\N	\N	\N	303	808	ADMIN	4725	\N	853	\N
2016-05-23 16:27:28.294-04	2016-05-23 16:27:28.294-04	\N	426	2	BACKER	573	\N	741	54
2017-04-20 06:17:23.321-04	2017-04-20 06:17:23.321-04	\N	4348	59	BACKER	4200	\N	840	96
2017-01-16 13:03:56.965-05	2017-01-16 13:03:56.965-05	\N	2561	48	BACKER	2772	\N	699	99
2015-05-02 20:00:00-04	\N	\N	28	2	ADMIN	5	\N	847	\N
\N	\N	\N	308	798	ADMIN	4723	\N	851	\N
\N	\N	\N	192	805	ADMIN	4724	\N	852	\N
\N	\N	\N	883	839	ADMIN	4728	\N	856	\N
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                4017.dat                                                                                            0000600 0004000 0002000 00000162062 13174451173 0014262 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        8141	email	mailinglist.host	t	2017-02-21 15:04:49.157-05	2017-02-21 15:04:49.157-05	3	523	http://****
8147	email	mailinglist.host	t	2017-02-21 15:11:44.894-05	2017-02-21 15:11:44.894-05	3	524	http://****
8153	email	mailinglist.host	t	2017-02-21 15:16:59.184-05	2017-02-21 15:16:59.184-05	3	525	http://****
595	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	286	http://****
596	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	287	http://****
597	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	195	http://****
598	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	288	http://****
599	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	289	http://****
735	email	mailinglist.backers	t	2016-10-10 16:37:16.762-04	2016-10-10 16:37:16.762-04	108	2	http://****
16243	email	mailinglist.backers	t	2017-05-09 14:14:23.366-04	2017-05-09 14:14:23.366-04	4720	2	http://****
1360	email	mailinglist.backers	t	2016-10-10 16:37:16.984-04	2016-10-10 16:37:16.984-04	686	2	http://****
1911	email	mailinglist.backers	t	2016-10-10 16:37:17.146-04	2016-10-10 16:37:17.146-04	1178	2	http://****
2645	email	mailinglist.backers	t	2016-11-22 10:22:40.421-05	2016-11-22 10:22:40.421-05	1846	59	http://****
6351	email	mailinglist.backers	t	2017-01-14 12:11:43.288-05	2017-01-14 12:11:43.288-05	2549	270	http://****
6368	email	mailinglist.backers	t	2017-01-16 13:03:56.966-05	2017-01-16 13:03:56.966-05	2561	48	http://****
6433	email	mailinglist.backers	t	2017-01-18 08:54:51.032-05	2017-01-18 08:54:51.032-05	2594	48	http://****
16640	email	mailinglist.backers	t	2017-05-15 08:07:59.717-04	2017-05-15 08:07:59.717-04	4834	14	http://****
7122	email	mailinglist.backers	t	2017-02-01 12:30:50.441-05	2017-02-01 12:30:50.441-05	2906	271	http://****
7610	email	mailinglist.backers	t	2017-02-10 11:47:34.942-05	2017-02-10 11:47:34.942-05	3053	15	http://****
8040	email	mailinglist.host	t	2017-02-21 11:25:28.556-05	2017-02-21 11:25:28.556-05	3	510	http://****
8048	email	mailinglist.host	t	2017-02-21 11:55:29.765-05	2017-02-21 11:55:29.765-05	3	511	http://****
8064	email	mailinglist.host	t	2017-02-21 13:11:30.856-05	2017-02-21 13:11:30.856-05	3	512	http://****
8074	email	mailinglist.host	t	2017-02-21 13:35:34.614-05	2017-02-21 13:35:34.614-05	3	513	http://****
8140	email	collective.monthlyreport	t	2017-02-21 15:04:48.984-05	2017-02-21 15:04:48.984-05	3	523	http://****
8146	email	collective.monthlyreport	t	2017-02-21 15:11:44.769-05	2017-02-21 15:11:44.769-05	3	524	http://****
8152	email	collective.monthlyreport	t	2017-02-21 15:16:59.094-05	2017-02-21 15:16:59.094-05	3	525	http://****
8039	email	collective.monthlyreport	t	2017-02-21 11:25:28.459-05	2017-02-21 11:25:28.459-05	3	510	http://****
8047	email	collective.monthlyreport	t	2017-02-21 11:55:29.66-05	2017-02-21 11:55:29.66-05	3206	511	http://****
8063	email	collective.monthlyreport	t	2017-02-21 13:11:30.775-05	2017-02-21 13:11:30.775-05	3	512	http://****
8073	email	collective.monthlyreport	t	2017-02-21 13:35:34.526-05	2017-02-21 13:35:34.526-05	3	513	http://****
8142	email	collective.transaction.created	t	2017-02-21 15:04:49.157-05	2017-02-21 15:04:49.157-05	3	523	http://****
8148	email	collective.transaction.created	t	2017-02-21 15:11:44.895-05	2017-02-21 15:11:44.895-05	3	524	http://****
8154	email	collective.transaction.created	t	2017-02-21 15:16:59.185-05	2017-02-21 15:16:59.185-05	3	525	http://****
8041	email	collective.transaction.created	t	2017-02-21 11:25:28.556-05	2017-02-21 11:25:28.556-05	3	510	http://****
8049	email	collective.transaction.created	t	2017-02-21 11:55:29.765-05	2017-02-21 11:55:29.765-05	3	511	http://****
8065	email	collective.transaction.created	t	2017-02-21 13:11:30.856-05	2017-02-21 13:11:30.856-05	3	512	http://****
8145	email	collective.expense.created	t	2017-02-21 15:11:44.769-05	2017-02-21 15:11:44.769-05	3	524	http://****
8151	email	collective.expense.created	t	2017-02-21 15:16:59.094-05	2017-02-21 15:16:59.094-05	3	525	http://****
2919	email	collective.expense.created	t	2016-11-28 17:28:52.444-05	2017-01-10 19:00:00-05	3	295	http://****
2926	email	collective.expense.created	t	2016-11-28 17:28:52.445-05	2017-01-10 19:00:00-05	3	288	http://****
2931	email	collective.expense.created	t	2016-11-28 17:28:52.446-05	2017-01-10 19:00:00-05	3	283	http://****
2936	email	collective.expense.created	t	2016-11-28 17:28:52.447-05	2017-01-10 19:00:00-05	3	278	http://****
5772	email	collective.expense.created	f	2016-12-28 19:13:56.342-05	2017-01-17 19:00:00-05	1339	282	http://****
5558	email	collective.expense.created	f	2016-12-28 19:13:56.268-05	2017-01-17 19:00:00-05	34	15	http://****
5789	email	collective.expense.created	f	2016-12-28 19:13:56.345-05	2017-01-17 19:00:00-05	1371	300	http://****
16437	email	collective.donation.created	f	2017-05-11 12:41:40.872-04	2017-05-11 12:41:40.872-04	171	59	http://****
8088	email	mailinglist.host	t	2017-02-21 13:49:14.435-05	2017-02-21 13:49:14.435-05	3	515	http://****
8095	email	mailinglist.host	t	2017-02-21 14:02:21.647-05	2017-02-21 14:02:21.647-05	3	516	http://****
16332	email	mailinglist.backers	t	2017-05-10 19:45:46.805-04	2017-05-10 19:45:46.805-04	4749	522	http://****
8426	email	mailinglist.backers	f	2017-02-27 19:25:20.393-05	2017-02-27 19:25:20.393-05	3301	522	http://****
12034	email	mailinglist.backers	t	2017-03-09 13:29:55.807-05	2017-03-09 13:29:55.807-05	3442	259	http://****
16214	email	mailinglist.backers	t	2017-05-09 01:59:17.564-04	2017-05-09 01:59:17.564-04	4711	517	http://****
13800	email	mailinglist.host	t	2017-04-03 12:22:46.049-04	2017-04-03 12:22:46.049-04	3	584	http://****
13887	email	mailinglist.backers	t	2017-04-04 15:51:04.96-04	2017-04-04 15:51:04.96-04	3999	2	http://****
14398	email	mailinglist.backers	t	2017-04-10 21:09:50.696-04	2017-04-10 21:09:50.696-04	4153	13	http://****
14447	email	mailinglist.backers	t	2017-04-11 22:05:36.091-04	2017-04-11 22:05:36.091-04	4173	13	http://****
15002	email	mailinglist.backers	t	2017-04-20 06:17:23.322-04	2017-04-20 06:17:23.322-04	4348	59	http://****
15657	email	mailinglist.backers	t	2017-04-30 21:40:31.704-04	2017-04-30 21:40:31.704-04	3419	516	http://****
15717	email	mailinglist.backers	t	2017-05-01 13:13:36.324-04	2017-05-01 13:13:36.324-04	4550	516	http://****
79	slack	all	t	2016-07-18 20:00:00-04	2016-07-18 20:00:00-04	\N	2	http://****
80	slack	all	t	2016-07-18 20:00:00-04	2016-07-18 20:00:00-04	\N	3	http://****
81	slack	all	t	2016-07-18 20:00:00-04	2016-07-18 20:00:00-04	\N	4	http://****
82	slack	all	t	2016-07-18 20:00:00-04	2016-07-18 20:00:00-04	\N	10	http://****
83	slack	all	t	2016-07-18 20:00:00-04	2016-07-18 20:00:00-04	\N	12	http://****
84	slack	all	t	2016-07-18 20:00:00-04	2016-07-18 20:00:00-04	\N	13	http://****
85	slack	all	t	2016-07-18 20:00:00-04	2016-07-18 20:00:00-04	\N	14	http://****
86	slack	all	t	2016-07-18 20:00:00-04	2016-07-18 20:00:00-04	\N	15	http://****
87	slack	all	t	2016-07-18 20:00:00-04	2016-07-18 20:00:00-04	\N	47	http://****
88	slack	all	t	2016-07-18 20:00:00-04	2016-07-18 20:00:00-04	\N	48	http://****
89	slack	all	t	2016-07-18 20:00:00-04	2016-07-18 20:00:00-04	\N	59	http://****
566	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	261	http://****
567	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	10	http://****
568	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	268	http://****
569	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	262	http://****
570	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	269	http://****
8087	email	collective.monthlyreport	t	2017-02-21 13:49:14.347-05	2017-02-21 13:49:14.347-05	3	515	http://****
8094	email	collective.monthlyreport	t	2017-02-21 14:02:21.57-05	2017-02-21 14:02:21.57-05	3	516	http://****
13799	email	collective.monthlyreport	t	2017-04-03 12:22:45.964-04	2017-04-03 12:22:45.964-04	3206	584	http://****
8089	email	collective.transaction.created	t	2017-02-21 13:49:14.436-05	2017-02-21 13:49:14.436-05	3	515	http://****
13801	email	collective.transaction.created	t	2017-04-03 12:22:46.049-04	2017-04-03 12:22:46.049-04	3	584	http://****
70	email	collective.transaction.created	t	2016-07-06 20:00:00-04	2016-07-06 20:00:00-04	577	4	http://****
39	email	collective.transaction.created	t	2016-06-09 20:00:00-04	2016-06-09 20:00:00-04	142	48	http://****
40	email	collective.transaction.created	t	2016-06-09 20:00:00-04	2016-06-09 20:00:00-04	28	2	http://****
41	email	collective.transaction.created	t	2016-06-09 20:00:00-04	2016-06-09 20:00:00-04	33	13	http://****
42	email	collective.transaction.created	t	2016-06-09 20:00:00-04	2016-06-09 20:00:00-04	67	13	http://****
43	email	collective.transaction.created	t	2016-06-09 20:00:00-04	2016-06-09 20:00:00-04	71	3	http://****
44	email	collective.transaction.created	t	2016-06-09 20:00:00-04	2016-06-09 20:00:00-04	72	3	http://****
45	email	collective.transaction.created	t	2016-06-09 20:00:00-04	2016-06-09 20:00:00-04	73	3	http://****
46	email	collective.transaction.created	t	2016-06-09 20:00:00-04	2016-06-09 20:00:00-04	170	59	http://****
47	email	collective.transaction.created	t	2016-06-09 20:00:00-04	2016-06-09 20:00:00-04	171	59	http://****
48	email	collective.transaction.created	t	2016-06-09 20:00:00-04	2016-06-09 20:00:00-04	35	12	http://****
49	email	collective.transaction.created	t	2016-06-09 20:00:00-04	2016-06-09 20:00:00-04	69	12	http://****
50	email	collective.transaction.created	t	2016-06-09 20:00:00-04	2016-06-09 20:00:00-04	70	12	http://****
8093	email	collective.expense.created	t	2017-02-21 14:02:21.57-05	2017-02-21 14:02:21.57-05	3	516	http://****
13798	email	collective.expense.created	t	2017-04-03 12:22:45.964-04	2017-04-03 12:22:45.964-04	3206	584	http://****
13802	email	collective.expense.created	t	2017-04-03 12:22:46.05-04	2017-04-03 12:22:46.05-04	3	584	http://****
571	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	263	http://****
572	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	270	http://****
573	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	264	http://****
574	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	265	http://****
575	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	15	http://****
576	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	259	http://****
577	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	266	http://****
578	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	271	http://****
579	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	260	http://****
580	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	267	http://****
581	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	272	http://****
582	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	273	http://****
583	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	14	http://****
584	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	274	http://****
585	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	275	http://****
586	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	276	http://****
587	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	277	http://****
588	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	279	http://****
589	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	280	http://****
590	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	281	http://****
591	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	282	http://****
592	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	283	http://****
593	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	284	http://****
594	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	285	http://****
600	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	290	http://****
601	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	291	http://****
602	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	292	http://****
603	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	293	http://****
604	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	294	http://****
605	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	295	http://****
606	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	297	http://****
607	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	298	http://****
608	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	299	http://****
609	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	13	http://****
610	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	278	http://****
611	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	59	http://****
612	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	2	http://****
613	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	51	http://****
614	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	241	http://****
615	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	3	http://****
616	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	48	http://****
617	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	47	http://****
618	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	4	http://****
619	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	300	http://****
620	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	301	http://****
621	email	group.transactions.created	t	2016-10-04 16:38:40-04	2016-10-04 16:38:40-04	3	12	http://****
655	email	mailinglist.backers	t	2016-10-10 16:37:16.676-04	2016-10-10 16:37:16.676-04	126	13	http://****
658	email	mailinglist.backers	t	2016-10-10 16:37:16.677-04	2016-10-10 16:37:16.677-04	2	10	http://****
698	email	mailinglist.backers	t	2016-10-10 16:37:16.722-04	2016-10-10 16:37:16.722-04	2	13	http://****
865	email	mailinglist.backers	t	2016-10-10 16:37:16.826-04	2016-10-10 16:37:16.826-04	192	2	http://****
1003	email	mailinglist.backers	t	2016-10-10 16:37:16.887-04	2016-10-10 16:37:16.887-04	308	2	http://****
680	email	mailinglist.backers	t	2016-10-10 16:37:16.704-04	2016-10-10 16:37:16.704-04	30	12	http://****
690	email	mailinglist.backers	t	2016-10-10 16:37:16.719-04	2016-10-10 16:37:16.719-04	30	14	http://****
691	email	mailinglist.backers	t	2016-10-10 16:37:16.72-04	2016-10-10 16:37:16.72-04	80	10	http://****
697	email	mailinglist.backers	t	2016-10-10 16:37:16.722-04	2016-10-10 16:37:16.722-04	8	14	http://****
912	email	mailinglist.backers	t	2016-10-10 16:37:16.84-04	2016-10-10 16:37:16.84-04	224	2	http://****
990	email	mailinglist.backers	t	2016-10-10 16:37:16.883-04	2016-10-10 16:37:16.883-04	303	13	http://****
1089	email	mailinglist.backers	t	2016-10-10 16:37:16.922-04	2016-10-10 16:37:16.922-04	392	2	http://****
692	email	mailinglist.backers	t	2016-10-10 16:37:16.72-04	2016-10-10 16:37:16.72-04	30	13	http://****
799	email	mailinglist.backers	t	2016-10-10 16:37:16.803-04	2016-10-10 16:37:16.803-04	129	2	http://****
987	email	mailinglist.backers	t	2016-10-10 16:37:16.883-04	2016-10-10 16:37:16.883-04	283	13	http://****
1244	email	mailinglist.backers	t	2016-10-10 16:37:16.958-04	2016-10-10 16:37:16.958-04	8	3	http://****
1322	email	mailinglist.backers	t	2016-10-10 16:37:16.976-04	2016-10-10 16:37:16.976-04	642	48	http://****
1232	email	mailinglist.backers	t	2016-10-10 16:37:16.955-04	2016-10-10 16:37:16.955-04	551	2	http://****
1237	email	mailinglist.backers	t	2016-10-10 16:37:16.956-04	2016-10-10 16:37:16.956-04	555	13	http://****
1321	email	mailinglist.backers	t	2016-10-10 16:37:16.975-04	2016-10-10 16:37:16.975-04	642	4	http://****
1128	email	mailinglist.backers	t	2016-10-10 16:37:16.931-04	2016-10-10 16:37:16.931-04	426	2	http://****
1320	email	mailinglist.backers	t	2016-10-10 16:37:16.975-04	2016-10-10 16:37:16.975-04	642	12	http://****
1325	email	mailinglist.backers	t	2016-10-10 16:37:16.976-04	2016-10-10 16:37:16.976-04	646	2	http://****
1595	email	mailinglist.backers	t	2016-10-10 16:37:17.04-04	2016-10-10 16:37:17.04-04	884	2	http://****
1609	email	mailinglist.backers	t	2016-10-10 16:37:17.062-04	2016-10-10 16:37:17.062-04	896	4	http://****
1594	email	mailinglist.backers	t	2016-10-10 16:37:17.04-04	2016-10-10 16:37:17.04-04	883	2	http://****
1805	email	mailinglist.backers	t	2016-10-10 16:37:17.119-04	2016-10-10 16:37:17.119-04	1094	2	http://****
1888	email	mailinglist.backers	t	2016-10-10 16:37:17.141-04	2016-10-10 16:37:17.141-04	1158	241	http://****
1961	email	mailinglist.backers	t	2016-10-10 16:37:17.158-04	2016-10-10 16:37:17.158-04	1244	4	http://****
1985	email	mailinglist.backers	t	2016-10-10 16:37:17.168-04	2016-10-10 16:37:17.168-04	1263	59	http://****
2045	email	mailinglist.backers	t	2016-10-10 16:37:17.194-04	2016-10-10 16:37:17.194-04	1299	2	http://****
2233	email	mailinglist.backers	t	2016-10-10 16:37:17.237-04	2016-10-10 16:37:17.237-04	1446	241	http://****
2226	email	mailinglist.backers	t	2016-10-10 16:37:17.235-04	2016-10-10 16:37:17.235-04	1438	2	http://****
2392	email	collective.monthlyreport	t	2016-11-06 19:37:19.104-05	2016-11-06 19:37:19.104-05	1303	259	http://****
2397	email	collective.monthlyreport	t	2016-11-06 19:37:19.104-05	2016-11-06 19:37:19.104-05	1309	262	http://****
2401	email	collective.monthlyreport	t	2016-11-06 19:37:19.105-05	2016-11-06 19:37:19.105-05	1313	264	http://****
2406	email	collective.monthlyreport	t	2016-11-06 19:37:19.106-05	2016-11-06 19:37:19.106-05	1317	268	http://****
2411	email	collective.monthlyreport	t	2016-11-06 19:37:19.106-05	2016-11-06 19:37:19.106-05	1322	271	http://****
2416	email	collective.monthlyreport	t	2016-11-06 19:37:19.107-05	2016-11-06 19:37:19.107-05	1327	275	http://****
2421	email	collective.monthlyreport	t	2016-11-06 19:37:19.107-05	2016-11-06 19:37:19.107-05	1332	277	http://****
2426	email	collective.monthlyreport	t	2016-11-06 19:37:19.108-05	2016-11-06 19:37:19.108-05	1337	280	http://****
2431	email	collective.monthlyreport	t	2016-11-06 19:37:19.109-05	2016-11-06 19:37:19.109-05	1342	285	http://****
2436	email	collective.monthlyreport	t	2016-11-06 19:37:19.109-05	2016-11-06 19:37:19.109-05	1347	288	http://****
2441	email	collective.monthlyreport	t	2016-11-06 19:37:19.11-05	2016-11-06 19:37:19.11-05	1352	290	http://****
2446	email	collective.monthlyreport	t	2016-11-06 19:37:19.11-05	2016-11-06 19:37:19.11-05	1357	294	http://****
2451	email	collective.monthlyreport	t	2016-11-06 19:37:19.111-05	2016-11-06 19:37:19.111-05	1362	297	http://****
2456	email	collective.monthlyreport	t	2016-11-06 19:37:19.112-05	2016-11-06 19:37:19.112-05	1366	298	http://****
2461	email	collective.monthlyreport	t	2016-11-06 19:37:19.113-05	2016-11-06 19:37:19.113-05	1372	300	http://****
2466	email	collective.monthlyreport	t	2016-11-06 19:37:19.113-05	2016-11-06 19:37:19.113-05	1376	301	http://****
2597	email	mailinglist.backers	t	2016-11-17 12:43:31.222-05	2016-11-17 12:43:31.222-05	1808	59	http://****
2697	email	mailinglist.backers	t	2016-11-28 10:33:15.871-05	2016-11-28 10:33:15.871-05	1890	2	http://****
3000	email	mailinglist.backers	t	2016-11-29 05:03:23.975-05	2016-11-29 05:03:23.975-05	1908	301	http://****
3047	email	mailinglist.backers	t	2016-11-30 11:11:42.607-05	2016-11-30 11:11:42.607-05	1957	2	http://****
3286	email	mailinglist.backers	t	2016-12-18 20:41:29.217-05	2016-12-18 20:41:29.217-05	2220	259	http://****
6045	email	mailinglist.backers	t	2017-01-03 15:59:38.785-05	2017-01-03 15:59:38.785-05	2416	2	http://****
2917	email	collective.expense.created	t	2016-11-28 17:28:52.443-05	2017-01-10 19:00:00-05	3	298	http://****
2922	email	collective.expense.created	t	2016-11-28 17:28:52.445-05	2017-01-10 19:00:00-05	3	292	http://****
2927	email	collective.expense.created	t	2016-11-28 17:28:52.446-05	2017-01-10 19:00:00-05	3	287	http://****
2932	email	collective.expense.created	t	2016-11-28 17:28:52.447-05	2017-01-10 19:00:00-05	3	282	http://****
2937	email	collective.expense.created	t	2016-11-28 17:28:52.448-05	2017-01-10 19:00:00-05	3	277	http://****
2942	email	collective.expense.created	t	2016-11-28 17:28:52.449-05	2017-01-10 19:00:00-05	3	272	http://****
2947	email	collective.expense.created	t	2016-11-28 17:28:52.45-05	2017-01-10 19:00:00-05	3	267	http://****
2953	email	collective.expense.created	t	2016-11-28 17:28:52.451-05	2017-01-10 19:00:00-05	3	261	http://****
2897	email	collective.expense.created	t	2016-11-28 17:28:52.436-05	2017-01-10 19:00:00-05	3	241	http://****
2915	email	collective.expense.created	t	2016-11-28 17:28:52.443-05	2017-01-10 19:00:00-05	3	300	http://****
2920	email	collective.expense.created	t	2016-11-28 17:28:52.444-05	2017-01-10 19:00:00-05	3	294	http://****
2925	email	collective.expense.created	t	2016-11-28 17:28:52.445-05	2017-01-10 19:00:00-05	3	289	http://****
2929	email	collective.expense.created	t	2016-11-28 17:28:52.446-05	2017-01-10 19:00:00-05	3	285	http://****
2935	email	collective.expense.created	t	2016-11-28 17:28:52.447-05	2017-01-10 19:00:00-05	3	279	http://****
2939	email	collective.expense.created	t	2016-11-28 17:28:52.448-05	2017-01-10 19:00:00-05	3	275	http://****
7114	email	mailinglist.backers	t	2017-02-01 10:16:22.45-05	2017-02-01 10:16:22.45-05	2898	48	http://****
8101	email	mailinglist.host	t	2017-02-21 14:07:25.322-05	2017-02-21 14:07:25.322-05	3	517	http://****
8107	email	mailinglist.host	t	2017-02-21 14:13:03.539-05	2017-02-21 14:13:03.539-05	3	518	http://****
8113	email	mailinglist.host	t	2017-02-21 14:25:28.823-05	2017-02-21 14:25:28.823-05	3	519	http://****
8119	email	mailinglist.host	t	2017-02-21 14:34:47.428-05	2017-02-21 14:34:47.428-05	3	520	http://****
8125	email	mailinglist.host	t	2017-02-21 14:39:46.291-05	2017-02-21 14:39:46.291-05	3	521	http://****
8131	email	mailinglist.host	t	2017-02-21 14:45:19.314-05	2017-02-21 14:45:19.314-05	3	522	http://****
8144	email	mailinglist.admins	t	2017-02-21 15:11:44.768-05	2017-02-21 15:11:44.768-05	3	524	http://****
8150	email	mailinglist.admins	t	2017-02-21 15:16:59.093-05	2017-02-21 15:16:59.093-05	3	525	http://****
763	email	mailinglist.admins	t	2016-10-10 16:37:16.793-04	2016-10-10 16:37:16.793-04	70	12	http://****
764	email	mailinglist.admins	t	2016-10-10 16:37:16.793-04	2016-10-10 16:37:16.793-04	71	3	http://****
769	email	mailinglist.admins	t	2016-10-10 16:37:16.795-04	2016-10-10 16:37:16.795-04	76	4	http://****
2052	email	mailinglist.admins	t	2016-10-10 16:37:17.196-04	2016-10-10 16:37:17.196-04	1307	261	http://****
2059	email	mailinglist.admins	t	2016-10-10 16:37:17.197-04	2016-10-10 16:37:17.197-04	1314	264	http://****
2064	email	mailinglist.admins	t	2016-10-10 16:37:17.198-04	2016-10-10 16:37:17.198-04	1318	268	http://****
8099	email	collective.monthlyreport	t	2017-02-21 14:07:25.189-05	2017-02-21 14:07:25.189-05	3	517	http://****
8106	email	collective.monthlyreport	t	2017-02-21 14:13:03.397-05	2017-02-21 14:13:03.397-05	3	518	http://****
8112	email	collective.monthlyreport	t	2017-02-21 14:25:28.726-05	2017-02-21 14:25:28.726-05	3	519	http://****
8118	email	collective.monthlyreport	t	2017-02-21 14:34:47.023-05	2017-02-21 14:34:47.023-05	3	520	http://****
8124	email	collective.monthlyreport	t	2017-02-21 14:39:46.24-05	2017-02-21 14:39:46.24-05	3	521	http://****
8130	email	collective.monthlyreport	t	2017-02-21 14:45:19.171-05	2017-02-21 14:45:19.171-05	3	522	http://****
8075	email	collective.transaction.created	t	2017-02-21 13:35:34.614-05	2017-02-21 13:35:34.614-05	3	513	http://****
8096	email	collective.transaction.created	t	2017-02-21 14:02:21.647-05	2017-02-21 14:02:21.647-05	3	516	http://****
8102	email	collective.transaction.created	t	2017-02-21 14:07:25.322-05	2017-02-21 14:07:25.322-05	3	517	http://****
8108	email	collective.transaction.created	t	2017-02-21 14:13:03.539-05	2017-02-21 14:13:03.539-05	3	518	http://****
8114	email	collective.transaction.created	t	2017-02-21 14:25:28.823-05	2017-02-21 14:25:28.823-05	3	519	http://****
5770	email	collective.expense.created	f	2016-12-28 19:13:56.342-05	2017-01-17 19:00:00-05	1337	280	http://****
5759	email	collective.expense.created	f	2016-12-28 19:13:56.34-05	2017-01-17 19:00:00-05	1317	268	http://****
5760	email	collective.expense.created	f	2016-12-28 19:13:56.34-05	2017-01-17 19:00:00-05	1319	269	http://****
5788	email	collective.expense.created	f	2016-12-28 19:13:56.344-05	2017-01-17 19:00:00-05	1365	298	http://****
5781	email	collective.expense.created	f	2016-12-28 19:13:56.343-05	2017-01-17 19:00:00-05	1353	291	http://****
5765	email	collective.expense.created	f	2016-12-28 19:13:56.341-05	2017-01-17 19:00:00-05	1325	273	http://****
5782	email	collective.expense.created	f	2016-12-28 19:13:56.343-05	2017-01-17 19:00:00-05	1354	292	http://****
5768	email	collective.expense.created	f	2016-12-28 19:13:56.341-05	2017-01-17 19:00:00-05	1331	277	http://****
8037	email	mailinglist.admins	t	2017-02-21 11:25:28.458-05	2017-02-21 11:25:28.458-05	3	510	http://****
8045	email	mailinglist.admins	t	2017-02-21 11:55:29.657-05	2017-02-21 11:55:29.657-05	3206	511	http://****
8061	email	mailinglist.admins	t	2017-02-21 13:11:30.774-05	2017-02-21 13:11:30.774-05	3	512	http://****
8071	email	mailinglist.admins	t	2017-02-21 13:35:34.525-05	2017-02-21 13:35:34.525-05	3	513	http://****
8085	email	mailinglist.admins	t	2017-02-21 13:49:14.347-05	2017-02-21 13:49:14.347-05	3	515	http://****
8092	email	mailinglist.admins	t	2017-02-21 14:02:21.569-05	2017-02-21 14:02:21.569-05	3	516	http://****
13797	email	mailinglist.admins	t	2017-04-03 12:22:45.963-04	2017-04-03 12:22:45.963-04	3206	584	http://****
624	email	mailinglist.admins	t	2016-10-10 16:37:16.649-04	2016-10-10 16:37:16.649-04	7	10	http://****
625	email	mailinglist.admins	t	2016-10-10 16:37:16.65-04	2016-10-10 16:37:16.65-04	36	10	http://****
626	email	mailinglist.admins	t	2016-10-10 16:37:16.65-04	2016-10-10 16:37:16.65-04	37	10	http://****
627	email	mailinglist.admins	t	2016-10-10 16:37:16.651-04	2016-10-10 16:37:16.651-04	35	12	http://****
628	email	mailinglist.admins	t	2016-10-10 16:37:16.652-04	2016-10-10 16:37:16.652-04	33	13	http://****
629	email	mailinglist.admins	t	2016-10-10 16:37:16.652-04	2016-10-10 16:37:16.652-04	31	14	http://****
630	email	mailinglist.admins	t	2016-10-10 16:37:16.654-04	2016-10-10 16:37:16.654-04	32	14	http://****
633	email	mailinglist.admins	t	2016-10-10 16:37:16.654-04	2016-10-10 16:37:16.654-04	34	15	http://****
669	email	mailinglist.admins	t	2016-10-10 16:37:16.688-04	2016-10-10 16:37:16.688-04	141	47	http://****
671	email	mailinglist.admins	t	2016-10-10 16:37:16.69-04	2016-10-10 16:37:16.69-04	142	48	http://****
765	email	mailinglist.admins	t	2016-10-10 16:37:16.794-04	2016-10-10 16:37:16.794-04	72	3	http://****
770	email	mailinglist.admins	t	2016-10-10 16:37:16.795-04	2016-10-10 16:37:16.795-04	77	4	http://****
705	email	mailinglist.admins	t	2016-10-10 16:37:16.725-04	2016-10-10 16:37:16.725-04	28	2	http://****
844	email	mailinglist.admins	t	2016-10-10 16:37:16.819-04	2016-10-10 16:37:16.819-04	170	59	http://****
761	email	mailinglist.admins	t	2016-10-10 16:37:16.792-04	2016-10-10 16:37:16.792-04	68	15	http://****
768	email	mailinglist.admins	t	2016-10-10 16:37:16.795-04	2016-10-10 16:37:16.795-04	75	4	http://****
760	email	mailinglist.admins	t	2016-10-10 16:37:16.792-04	2016-10-10 16:37:16.792-04	67	13	http://****
766	email	mailinglist.admins	t	2016-10-10 16:37:16.794-04	2016-10-10 16:37:16.794-04	73	3	http://****
771	email	mailinglist.admins	t	2016-10-10 16:37:16.796-04	2016-10-10 16:37:16.796-04	78	4	http://****
762	email	mailinglist.admins	t	2016-10-10 16:37:16.793-04	2016-10-10 16:37:16.793-04	69	12	http://****
767	email	mailinglist.admins	t	2016-10-10 16:37:16.794-04	2016-10-10 16:37:16.794-04	74	4	http://****
845	email	mailinglist.admins	t	2016-10-10 16:37:16.819-04	2016-10-10 16:37:16.819-04	171	59	http://****
1261	email	mailinglist.admins	t	2016-10-10 16:37:16.962-04	2016-10-10 16:37:16.962-04	577	4	http://****
1613	email	mailinglist.admins	t	2016-10-10 16:37:17.063-04	2016-10-10 16:37:17.063-04	898	195	http://****
1612	email	mailinglist.admins	t	2016-10-10 16:37:17.063-04	2016-10-10 16:37:17.063-04	897	195	http://****
1873	email	mailinglist.admins	t	2016-10-10 16:37:17.137-04	2016-10-10 16:37:17.137-04	1145	241	http://****
2069	email	mailinglist.admins	t	2016-10-10 16:37:17.199-04	2016-10-10 16:37:17.199-04	1323	272	http://****
2075	email	mailinglist.admins	t	2016-10-10 16:37:17.201-04	2016-10-10 16:37:17.201-04	1329	276	http://****
2080	email	mailinglist.admins	t	2016-10-10 16:37:17.202-04	2016-10-10 16:37:17.202-04	1334	278	http://****
2085	email	mailinglist.admins	t	2016-10-10 16:37:17.203-04	2016-10-10 16:37:17.203-04	1339	282	http://****
2091	email	mailinglist.admins	t	2016-10-10 16:37:17.204-04	2016-10-10 16:37:17.204-04	1345	287	http://****
2096	email	mailinglist.admins	t	2016-10-10 16:37:17.205-04	2016-10-10 16:37:17.205-04	1350	289	http://****
2100	email	mailinglist.admins	t	2016-10-10 16:37:17.206-04	2016-10-10 16:37:17.206-04	1355	292	http://****
2104	email	mailinglist.admins	t	2016-10-10 16:37:17.207-04	2016-10-10 16:37:17.207-04	1358	294	http://****
2109	email	mailinglist.admins	t	2016-10-10 16:37:17.208-04	2016-10-10 16:37:17.208-04	1363	297	http://****
2114	email	mailinglist.admins	t	2016-10-10 16:37:17.209-04	2016-10-10 16:37:17.209-04	1368	299	http://****
2119	email	mailinglist.admins	t	2016-10-10 16:37:17.21-04	2016-10-10 16:37:17.21-04	1374	300	http://****
2124	email	mailinglist.admins	t	2016-10-10 16:37:17.212-04	2016-10-10 16:37:17.212-04	1377	301	http://****
2049	email	mailinglist.admins	t	2016-10-10 16:37:17.195-04	2016-10-10 16:37:17.195-04	1304	260	http://****
2055	email	mailinglist.admins	t	2016-10-10 16:37:17.196-04	2016-10-10 16:37:17.196-04	1310	262	http://****
2060	email	mailinglist.admins	t	2016-10-10 16:37:17.197-04	2016-10-10 16:37:17.197-04	1315	265	http://****
2065	email	mailinglist.admins	t	2016-10-10 16:37:17.198-04	2016-10-10 16:37:17.198-04	1319	269	http://****
2070	email	mailinglist.admins	t	2016-10-10 16:37:17.199-04	2016-10-10 16:37:17.199-04	1324	272	http://****
2076	email	mailinglist.admins	t	2016-10-10 16:37:17.201-04	2016-10-10 16:37:17.201-04	1330	276	http://****
2081	email	mailinglist.admins	t	2016-10-10 16:37:17.202-04	2016-10-10 16:37:17.202-04	1335	279	http://****
2086	email	mailinglist.admins	t	2016-10-10 16:37:17.203-04	2016-10-10 16:37:17.203-04	1340	283	http://****
2090	email	mailinglist.admins	t	2016-10-10 16:37:17.204-04	2016-10-10 16:37:17.204-04	1344	286	http://****
2093	email	mailinglist.admins	t	2016-10-10 16:37:17.204-04	2016-10-10 16:37:17.204-04	1347	288	http://****
2101	email	mailinglist.admins	t	2016-10-10 16:37:17.206-04	2016-10-10 16:37:17.206-04	1354	292	http://****
2107	email	mailinglist.admins	t	2016-10-10 16:37:17.208-04	2016-10-10 16:37:17.208-04	1360	295	http://****
2112	email	mailinglist.admins	t	2016-10-10 16:37:17.209-04	2016-10-10 16:37:17.209-04	1367	298	http://****
2117	email	mailinglist.admins	t	2016-10-10 16:37:17.21-04	2016-10-10 16:37:17.21-04	1371	300	http://****
2122	email	mailinglist.admins	t	2016-10-10 16:37:17.211-04	2016-10-10 16:37:17.211-04	1379	301	http://****
2050	email	mailinglist.admins	t	2016-10-10 16:37:17.195-04	2016-10-10 16:37:17.195-04	1305	260	http://****
2056	email	mailinglist.admins	t	2016-10-10 16:37:17.196-04	2016-10-10 16:37:17.196-04	1311	263	http://****
2061	email	mailinglist.admins	t	2016-10-10 16:37:17.197-04	2016-10-10 16:37:17.197-04	1316	266	http://****
2066	email	mailinglist.admins	t	2016-10-10 16:37:17.199-04	2016-10-10 16:37:17.199-04	1320	270	http://****
2071	email	mailinglist.admins	t	2016-10-10 16:37:17.2-04	2016-10-10 16:37:17.2-04	1325	273	http://****
2072	email	mailinglist.admins	t	2016-10-10 16:37:17.2-04	2016-10-10 16:37:17.2-04	1326	274	http://****
2077	email	mailinglist.admins	t	2016-10-10 16:37:17.201-04	2016-10-10 16:37:17.201-04	1331	277	http://****
2082	email	mailinglist.admins	t	2016-10-10 16:37:17.202-04	2016-10-10 16:37:17.202-04	1336	279	http://****
2087	email	mailinglist.admins	t	2016-10-10 16:37:17.203-04	2016-10-10 16:37:17.203-04	1341	284	http://****
2094	email	mailinglist.admins	t	2016-10-10 16:37:17.205-04	2016-10-10 16:37:17.205-04	1348	288	http://****
2099	email	mailinglist.admins	t	2016-10-10 16:37:17.206-04	2016-10-10 16:37:17.206-04	1353	291	http://****
2106	email	mailinglist.admins	t	2016-10-10 16:37:17.207-04	2016-10-10 16:37:17.207-04	1361	295	http://****
2111	email	mailinglist.admins	t	2016-10-10 16:37:17.208-04	2016-10-10 16:37:17.208-04	1365	298	http://****
2116	email	mailinglist.admins	t	2016-10-10 16:37:17.21-04	2016-10-10 16:37:17.21-04	1370	299	http://****
2121	email	mailinglist.admins	t	2016-10-10 16:37:17.211-04	2016-10-10 16:37:17.211-04	1375	301	http://****
2125	email	mailinglist.admins	t	2016-10-10 16:37:17.212-04	2016-10-10 16:37:17.212-04	1378	301	http://****
2053	email	mailinglist.admins	t	2016-10-10 16:37:17.196-04	2016-10-10 16:37:17.196-04	1308	261	http://****
2057	email	mailinglist.admins	t	2016-10-10 16:37:17.197-04	2016-10-10 16:37:17.197-04	1312	263	http://****
2062	email	mailinglist.admins	t	2016-10-10 16:37:17.198-04	2016-10-10 16:37:17.198-04	1314	267	http://****
2067	email	mailinglist.admins	t	2016-10-10 16:37:17.199-04	2016-10-10 16:37:17.199-04	1321	270	http://****
2074	email	mailinglist.admins	t	2016-10-10 16:37:17.2-04	2016-10-10 16:37:17.2-04	1328	275	http://****
2079	email	mailinglist.admins	t	2016-10-10 16:37:17.201-04	2016-10-10 16:37:17.201-04	1333	278	http://****
2083	email	mailinglist.admins	t	2016-10-10 16:37:17.202-04	2016-10-10 16:37:17.202-04	1337	280	http://****
2088	email	mailinglist.admins	t	2016-10-10 16:37:17.203-04	2016-10-10 16:37:17.203-04	1342	285	http://****
2095	email	mailinglist.admins	t	2016-10-10 16:37:17.205-04	2016-10-10 16:37:17.205-04	1349	289	http://****
2098	email	mailinglist.admins	t	2016-10-10 16:37:17.206-04	2016-10-10 16:37:17.206-04	1352	290	http://****
2105	email	mailinglist.admins	t	2016-10-10 16:37:17.207-04	2016-10-10 16:37:17.207-04	1359	295	http://****
2110	email	mailinglist.admins	t	2016-10-10 16:37:17.208-04	2016-10-10 16:37:17.208-04	1364	297	http://****
2115	email	mailinglist.admins	t	2016-10-10 16:37:17.21-04	2016-10-10 16:37:17.21-04	1369	299	http://****
2120	email	mailinglist.admins	t	2016-10-10 16:37:17.211-04	2016-10-10 16:37:17.211-04	1373	300	http://****
2048	email	mailinglist.admins	t	2016-10-10 16:37:17.195-04	2016-10-10 16:37:17.195-04	1303	259	http://****
2054	email	mailinglist.admins	t	2016-10-10 16:37:17.196-04	2016-10-10 16:37:17.196-04	1309	262	http://****
2058	email	mailinglist.admins	t	2016-10-10 16:37:17.197-04	2016-10-10 16:37:17.197-04	1313	264	http://****
2063	email	mailinglist.admins	t	2016-10-10 16:37:17.198-04	2016-10-10 16:37:17.198-04	1317	268	http://****
2068	email	mailinglist.admins	t	2016-10-10 16:37:17.199-04	2016-10-10 16:37:17.199-04	1322	271	http://****
2073	email	mailinglist.admins	t	2016-10-10 16:37:17.2-04	2016-10-10 16:37:17.2-04	1327	275	http://****
2078	email	mailinglist.admins	t	2016-10-10 16:37:17.201-04	2016-10-10 16:37:17.201-04	1332	277	http://****
2084	email	mailinglist.admins	t	2016-10-10 16:37:17.202-04	2016-10-10 16:37:17.202-04	1338	281	http://****
2089	email	mailinglist.admins	t	2016-10-10 16:37:17.204-04	2016-10-10 16:37:17.204-04	1343	286	http://****
2092	email	mailinglist.admins	t	2016-10-10 16:37:17.204-04	2016-10-10 16:37:17.204-04	1346	287	http://****
2097	email	mailinglist.admins	t	2016-10-10 16:37:17.205-04	2016-10-10 16:37:17.205-04	1351	290	http://****
2102	email	mailinglist.admins	t	2016-10-10 16:37:17.207-04	2016-10-10 16:37:17.207-04	1356	293	http://****
2103	email	mailinglist.admins	t	2016-10-10 16:37:17.207-04	2016-10-10 16:37:17.207-04	1357	294	http://****
2108	email	mailinglist.admins	t	2016-10-10 16:37:17.208-04	2016-10-10 16:37:17.208-04	1362	297	http://****
2113	email	mailinglist.admins	t	2016-10-10 16:37:17.209-04	2016-10-10 16:37:17.209-04	1366	298	http://****
2118	email	mailinglist.admins	t	2016-10-10 16:37:17.21-04	2016-10-10 16:37:17.21-04	1372	300	http://****
2123	email	mailinglist.admins	t	2016-10-10 16:37:17.211-04	2016-10-10 16:37:17.211-04	1376	301	http://****
8098	email	mailinglist.admins	t	2017-02-21 14:07:25.188-05	2017-02-21 14:07:25.188-05	3	517	http://****
8104	email	mailinglist.admins	t	2017-02-21 14:13:03.396-05	2017-02-21 14:13:03.396-05	3	518	http://****
8110	email	mailinglist.admins	t	2017-02-21 14:25:28.726-05	2017-02-21 14:25:28.726-05	3	519	http://****
8116	email	mailinglist.admins	t	2017-02-21 14:34:47.023-05	2017-02-21 14:34:47.023-05	3	520	http://****
8122	email	mailinglist.admins	t	2017-02-21 14:39:46.24-05	2017-02-21 14:39:46.24-05	3	521	http://****
8128	email	mailinglist.admins	t	2017-02-21 14:45:19.17-05	2017-02-21 14:45:19.17-05	3	522	http://****
8138	email	mailinglist.admins	t	2017-02-21 15:04:48.982-05	2017-02-21 15:04:48.982-05	3	523	http://****
99	email	collective.monthlyreport	t	2016-08-10 20:22:42.133-04	2016-08-10 20:22:42.133-04	7	10	http://****
100	email	collective.monthlyreport	t	2016-08-10 20:22:42.133-04	2016-08-10 20:22:42.133-04	36	10	http://****
101	email	collective.monthlyreport	t	2016-08-10 20:22:42.134-04	2016-08-10 20:22:42.134-04	37	10	http://****
102	email	collective.monthlyreport	t	2016-08-10 20:22:42.135-04	2016-08-10 20:22:42.135-04	35	12	http://****
103	email	collective.monthlyreport	t	2016-08-10 20:22:42.136-04	2016-08-10 20:22:42.136-04	33	13	http://****
104	email	collective.monthlyreport	t	2016-08-10 20:22:42.136-04	2016-08-10 20:22:42.136-04	31	14	http://****
105	email	collective.monthlyreport	t	2016-08-10 20:22:42.137-04	2016-08-10 20:22:42.137-04	32	14	http://****
106	email	collective.monthlyreport	t	2016-08-10 20:22:42.139-04	2016-08-10 20:22:42.139-04	34	15	http://****
115	email	collective.monthlyreport	t	2016-08-10 20:22:42.145-04	2016-08-10 20:22:42.145-04	141	47	http://****
116	email	collective.monthlyreport	t	2016-08-10 20:22:42.146-04	2016-08-10 20:22:42.146-04	142	48	http://****
124	email	collective.monthlyreport	t	2016-08-10 20:22:42.149-04	2016-08-10 20:22:42.149-04	28	2	http://****
148	email	collective.monthlyreport	t	2016-08-10 20:22:42.162-04	2016-08-10 20:22:42.162-04	67	13	http://****
149	email	collective.monthlyreport	t	2016-08-10 20:22:42.164-04	2016-08-10 20:22:42.164-04	68	15	http://****
150	email	collective.monthlyreport	t	2016-08-10 20:22:42.164-04	2016-08-10 20:22:42.164-04	69	12	http://****
151	email	collective.monthlyreport	t	2016-08-10 20:22:42.164-04	2016-08-10 20:22:42.164-04	70	12	http://****
152	email	collective.monthlyreport	t	2016-08-10 20:22:42.165-04	2016-08-10 20:22:42.165-04	71	3	http://****
153	email	collective.monthlyreport	t	2016-08-10 20:22:42.165-04	2016-08-10 20:22:42.165-04	72	3	http://****
154	email	collective.monthlyreport	t	2016-08-10 20:22:42.166-04	2016-08-10 20:22:42.166-04	73	3	http://****
155	email	collective.monthlyreport	t	2016-08-10 20:22:42.166-04	2016-08-10 20:22:42.166-04	74	4	http://****
156	email	collective.monthlyreport	t	2016-08-10 20:22:42.166-04	2016-08-10 20:22:42.166-04	75	4	http://****
157	email	collective.monthlyreport	t	2016-08-10 20:22:42.167-04	2016-08-10 20:22:42.167-04	76	4	http://****
158	email	collective.monthlyreport	t	2016-08-10 20:22:42.167-04	2016-08-10 20:22:42.167-04	77	4	http://****
159	email	collective.monthlyreport	t	2016-08-10 20:22:42.168-04	2016-08-10 20:22:42.168-04	78	4	http://****
194	email	collective.monthlyreport	t	2016-08-10 20:22:42.182-04	2016-08-10 20:22:42.182-04	170	59	http://****
335	email	collective.monthlyreport	t	2016-08-10 20:22:42.23-04	2016-08-10 20:22:42.23-04	577	4	http://****
472	email	collective.monthlyreport	t	2016-08-10 20:22:42.274-04	2016-08-10 20:22:42.274-04	898	195	http://****
471	email	collective.monthlyreport	t	2016-08-10 20:22:42.273-04	2016-08-10 20:22:42.273-04	897	195	http://****
195	email	collective.monthlyreport	t	2016-08-10 20:22:42.182-04	2016-08-10 20:22:42.182-04	171	59	http://****
2393	email	collective.monthlyreport	t	2016-11-06 19:37:19.104-05	2016-11-06 19:37:19.104-05	1304	260	http://****
2398	email	collective.monthlyreport	t	2016-11-06 19:37:19.105-05	2016-11-06 19:37:19.105-05	1310	262	http://****
2403	email	collective.monthlyreport	t	2016-11-06 19:37:19.105-05	2016-11-06 19:37:19.105-05	1315	265	http://****
2408	email	collective.monthlyreport	t	2016-11-06 19:37:19.106-05	2016-11-06 19:37:19.106-05	1319	269	http://****
2413	email	collective.monthlyreport	t	2016-11-06 19:37:19.106-05	2016-11-06 19:37:19.106-05	1324	272	http://****
2418	email	collective.monthlyreport	t	2016-11-06 19:37:19.107-05	2016-11-06 19:37:19.107-05	1329	276	http://****
2423	email	collective.monthlyreport	t	2016-11-06 19:37:19.108-05	2016-11-06 19:37:19.108-05	1334	278	http://****
2428	email	collective.monthlyreport	t	2016-11-06 19:37:19.108-05	2016-11-06 19:37:19.108-05	1339	282	http://****
2433	email	collective.monthlyreport	t	2016-11-06 19:37:19.109-05	2016-11-06 19:37:19.109-05	1344	286	http://****
2438	email	collective.monthlyreport	t	2016-11-06 19:37:19.109-05	2016-11-06 19:37:19.109-05	1349	289	http://****
2442	email	collective.monthlyreport	t	2016-11-06 19:37:19.11-05	2016-11-06 19:37:19.11-05	1353	291	http://****
2447	email	collective.monthlyreport	t	2016-11-06 19:37:19.11-05	2016-11-06 19:37:19.11-05	1358	294	http://****
2452	email	collective.monthlyreport	t	2016-11-06 19:37:19.112-05	2016-11-06 19:37:19.112-05	1363	297	http://****
2457	email	collective.monthlyreport	t	2016-11-06 19:37:19.112-05	2016-11-06 19:37:19.112-05	1368	299	http://****
2462	email	collective.monthlyreport	t	2016-11-06 19:37:19.113-05	2016-11-06 19:37:19.113-05	1374	300	http://****
2467	email	collective.monthlyreport	t	2016-11-06 19:37:19.113-05	2016-11-06 19:37:19.113-05	1377	301	http://****
2394	email	collective.monthlyreport	t	2016-11-06 19:37:19.104-05	2016-11-06 19:37:19.104-05	1305	260	http://****
2399	email	collective.monthlyreport	t	2016-11-06 19:37:19.105-05	2016-11-06 19:37:19.105-05	1311	263	http://****
2405	email	collective.monthlyreport	t	2016-11-06 19:37:19.106-05	2016-11-06 19:37:19.106-05	1314	267	http://****
2409	email	collective.monthlyreport	t	2016-11-06 19:37:19.106-05	2016-11-06 19:37:19.106-05	1320	270	http://****
2414	email	collective.monthlyreport	t	2016-11-06 19:37:19.107-05	2016-11-06 19:37:19.107-05	1325	273	http://****
2419	email	collective.monthlyreport	t	2016-11-06 19:37:19.107-05	2016-11-06 19:37:19.107-05	1330	276	http://****
2424	email	collective.monthlyreport	t	2016-11-06 19:37:19.108-05	2016-11-06 19:37:19.108-05	1335	279	http://****
2429	email	collective.monthlyreport	t	2016-11-06 19:37:19.108-05	2016-11-06 19:37:19.108-05	1340	283	http://****
2435	email	collective.monthlyreport	t	2016-11-06 19:37:19.109-05	2016-11-06 19:37:19.109-05	1346	287	http://****
2440	email	collective.monthlyreport	t	2016-11-06 19:37:19.11-05	2016-11-06 19:37:19.11-05	1351	290	http://****
2444	email	collective.monthlyreport	t	2016-11-06 19:37:19.11-05	2016-11-06 19:37:19.11-05	1355	292	http://****
2449	email	collective.monthlyreport	t	2016-11-06 19:37:19.111-05	2016-11-06 19:37:19.111-05	1361	295	http://****
2455	email	collective.monthlyreport	t	2016-11-06 19:37:19.112-05	2016-11-06 19:37:19.112-05	1367	298	http://****
2460	email	collective.monthlyreport	t	2016-11-06 19:37:19.113-05	2016-11-06 19:37:19.113-05	1371	300	http://****
2465	email	collective.monthlyreport	t	2016-11-06 19:37:19.113-05	2016-11-06 19:37:19.113-05	1379	301	http://****
2395	email	collective.monthlyreport	t	2016-11-06 19:37:19.104-05	2016-11-06 19:37:19.104-05	1307	261	http://****
2400	email	collective.monthlyreport	t	2016-11-06 19:37:19.105-05	2016-11-06 19:37:19.105-05	1312	263	http://****
2404	email	collective.monthlyreport	t	2016-11-06 19:37:19.105-05	2016-11-06 19:37:19.105-05	1316	266	http://****
2410	email	collective.monthlyreport	t	2016-11-06 19:37:19.106-05	2016-11-06 19:37:19.106-05	1321	270	http://****
2415	email	collective.monthlyreport	t	2016-11-06 19:37:19.107-05	2016-11-06 19:37:19.107-05	1326	274	http://****
2420	email	collective.monthlyreport	t	2016-11-06 19:37:19.107-05	2016-11-06 19:37:19.107-05	1331	277	http://****
2425	email	collective.monthlyreport	t	2016-11-06 19:37:19.108-05	2016-11-06 19:37:19.108-05	1336	279	http://****
2430	email	collective.monthlyreport	t	2016-11-06 19:37:19.108-05	2016-11-06 19:37:19.108-05	1341	284	http://****
2434	email	collective.monthlyreport	t	2016-11-06 19:37:19.109-05	2016-11-06 19:37:19.109-05	1345	287	http://****
2439	email	collective.monthlyreport	t	2016-11-06 19:37:19.11-05	2016-11-06 19:37:19.11-05	1350	289	http://****
2445	email	collective.monthlyreport	t	2016-11-06 19:37:19.11-05	2016-11-06 19:37:19.11-05	1356	293	http://****
2450	email	collective.monthlyreport	t	2016-11-06 19:37:19.111-05	2016-11-06 19:37:19.111-05	1360	295	http://****
2454	email	collective.monthlyreport	t	2016-11-06 19:37:19.112-05	2016-11-06 19:37:19.112-05	1365	298	http://****
2459	email	collective.monthlyreport	t	2016-11-06 19:37:19.113-05	2016-11-06 19:37:19.113-05	1370	299	http://****
2464	email	collective.monthlyreport	t	2016-11-06 19:37:19.113-05	2016-11-06 19:37:19.113-05	1375	301	http://****
2348	email	collective.monthlyreport	t	2016-11-06 19:37:19.095-05	2016-11-06 19:37:19.095-05	1145	241	http://****
2396	email	collective.monthlyreport	t	2016-11-06 19:37:19.104-05	2016-11-06 19:37:19.104-05	1308	261	http://****
2402	email	collective.monthlyreport	t	2016-11-06 19:37:19.105-05	2016-11-06 19:37:19.105-05	1314	264	http://****
2407	email	collective.monthlyreport	t	2016-11-06 19:37:19.106-05	2016-11-06 19:37:19.106-05	1318	268	http://****
2412	email	collective.monthlyreport	t	2016-11-06 19:37:19.106-05	2016-11-06 19:37:19.106-05	1323	272	http://****
2417	email	collective.monthlyreport	t	2016-11-06 19:37:19.107-05	2016-11-06 19:37:19.107-05	1328	275	http://****
2422	email	collective.monthlyreport	t	2016-11-06 19:37:19.107-05	2016-11-06 19:37:19.107-05	1333	278	http://****
2427	email	collective.monthlyreport	t	2016-11-06 19:37:19.108-05	2016-11-06 19:37:19.108-05	1338	281	http://****
2432	email	collective.monthlyreport	t	2016-11-06 19:37:19.109-05	2016-11-06 19:37:19.109-05	1343	286	http://****
2437	email	collective.monthlyreport	t	2016-11-06 19:37:19.109-05	2016-11-06 19:37:19.109-05	1348	288	http://****
2443	email	collective.monthlyreport	t	2016-11-06 19:37:19.11-05	2016-11-06 19:37:19.11-05	1354	292	http://****
2448	email	collective.monthlyreport	t	2016-11-06 19:37:19.111-05	2016-11-06 19:37:19.111-05	1359	295	http://****
2453	email	collective.monthlyreport	t	2016-11-06 19:37:19.112-05	2016-11-06 19:37:19.112-05	1364	297	http://****
2458	email	collective.monthlyreport	t	2016-11-06 19:37:19.112-05	2016-11-06 19:37:19.112-05	1369	299	http://****
2463	email	collective.monthlyreport	t	2016-11-06 19:37:19.113-05	2016-11-06 19:37:19.113-05	1373	300	http://****
2468	email	collective.monthlyreport	t	2016-11-06 19:37:19.114-05	2016-11-06 19:37:19.114-05	1378	301	http://****
8120	email	collective.transaction.created	t	2017-02-21 14:34:47.428-05	2017-02-21 14:34:47.428-05	3	520	http://****
8127	email	collective.transaction.created	t	2017-02-21 14:39:46.291-05	2017-02-21 14:39:46.291-05	3	521	http://****
8132	email	collective.transaction.created	t	2017-02-21 14:45:19.315-05	2017-02-21 14:45:19.315-05	3	522	http://****
5769	email	collective.expense.created	f	2016-12-28 19:13:56.342-05	2017-01-17 19:00:00-05	1335	279	http://****
5777	email	collective.expense.created	f	2016-12-28 19:13:56.343-05	2017-01-17 19:00:00-05	1345	287	http://****
5556	email	collective.expense.created	f	2016-12-28 19:13:56.266-05	2017-01-17 19:00:00-05	35	12	http://****
5775	email	collective.expense.created	f	2016-12-28 19:13:56.342-05	2017-01-17 19:00:00-05	1342	285	http://****
5596	email	collective.expense.created	f	2016-12-28 19:13:56.284-05	2017-01-17 19:00:00-05	170	59	http://****
5753	email	collective.expense.created	f	2016-12-28 19:13:56.339-05	2017-01-17 19:00:00-05	1307	261	http://****
5570	email	collective.expense.created	f	2016-12-28 19:13:56.274-05	2017-01-17 19:00:00-05	71	3	http://****
5790	email	collective.expense.created	f	2016-12-28 19:13:56.345-05	2017-01-17 19:00:00-05	1375	301	http://****
5571	email	collective.expense.created	f	2016-12-28 19:13:56.275-05	2017-01-17 19:00:00-05	74	4	http://****
5778	email	collective.expense.created	f	2016-12-28 19:13:56.343-05	2017-01-17 19:00:00-05	1347	288	http://****
5773	email	collective.expense.created	f	2016-12-28 19:13:56.342-05	2017-01-17 19:00:00-05	1340	283	http://****
5784	email	collective.expense.created	f	2016-12-28 19:13:56.344-05	2017-01-17 19:00:00-05	1359	295	http://****
5761	email	collective.expense.created	f	2016-12-28 19:13:56.34-05	2017-01-17 19:00:00-05	1320	270	http://****
5752	email	collective.expense.created	f	2016-12-28 19:13:56.339-05	2017-01-17 19:00:00-05	1304	260	http://****
5787	email	collective.expense.created	f	2016-12-28 19:13:56.345-05	2017-01-17 19:00:00-05	1368	299	http://****
8038	email	collective.expense.created	t	2017-02-21 11:25:28.459-05	2017-02-21 11:25:28.459-05	3	510	http://****
8046	email	collective.expense.created	t	2017-02-21 11:55:29.658-05	2017-02-21 11:55:29.658-05	3206	511	http://****
8050	email	collective.expense.created	t	2017-02-21 11:55:29.766-05	2017-02-21 11:55:29.766-05	3	511	http://****
8062	email	collective.expense.created	t	2017-02-21 13:11:30.775-05	2017-02-21 13:11:30.775-05	3	512	http://****
8072	email	collective.expense.created	t	2017-02-21 13:35:34.525-05	2017-02-21 13:35:34.525-05	3	513	http://****
2945	email	collective.expense.created	t	2016-11-28 17:28:52.449-05	2017-01-10 19:00:00-05	3	269	http://****
2950	email	collective.expense.created	t	2016-11-28 17:28:52.45-05	2017-01-10 19:00:00-05	3	264	http://****
2955	email	collective.expense.created	t	2016-11-28 17:28:52.451-05	2017-01-10 19:00:00-05	3	259	http://****
2916	email	collective.expense.created	t	2016-11-28 17:28:52.443-05	2017-01-10 19:00:00-05	3	299	http://****
2921	email	collective.expense.created	t	2016-11-28 17:28:52.445-05	2017-01-10 19:00:00-05	3	293	http://****
2924	email	collective.expense.created	t	2016-11-28 17:28:52.445-05	2017-01-10 19:00:00-05	3	290	http://****
2930	email	collective.expense.created	t	2016-11-28 17:28:52.446-05	2017-01-10 19:00:00-05	3	284	http://****
2934	email	collective.expense.created	t	2016-11-28 17:28:52.447-05	2017-01-10 19:00:00-05	3	280	http://****
2940	email	collective.expense.created	t	2016-11-28 17:28:52.448-05	2017-01-10 19:00:00-05	3	274	http://****
2944	email	collective.expense.created	t	2016-11-28 17:28:52.449-05	2017-01-10 19:00:00-05	3	270	http://****
2949	email	collective.expense.created	t	2016-11-28 17:28:52.45-05	2017-01-10 19:00:00-05	3	265	http://****
2914	email	collective.expense.created	t	2016-11-28 17:28:52.443-05	2017-01-10 19:00:00-05	3	301	http://****
2941	email	collective.expense.created	t	2016-11-28 17:28:52.448-05	2017-01-10 19:00:00-05	3	273	http://****
2946	email	collective.expense.created	t	2016-11-28 17:28:52.449-05	2017-01-10 19:00:00-05	3	268	http://****
2951	email	collective.expense.created	t	2016-11-28 17:28:52.45-05	2017-01-10 19:00:00-05	3	263	http://****
2701	email	collective.expense.created	t	2016-11-28 17:28:52.359-05	2017-01-10 19:00:00-05	3	10	http://****
2703	email	collective.expense.created	t	2016-11-28 17:28:52.36-05	2017-01-10 19:00:00-05	3	12	http://****
2704	email	collective.expense.created	t	2016-11-28 17:28:52.361-05	2017-01-10 19:00:00-05	3	13	http://****
2705	email	collective.expense.created	t	2016-11-28 17:28:52.362-05	2017-01-10 19:00:00-05	3	14	http://****
2706	email	collective.expense.created	t	2016-11-28 17:28:52.362-05	2017-01-10 19:00:00-05	3	15	http://****
2708	email	collective.expense.created	t	2016-11-28 17:28:52.365-05	2017-01-10 19:00:00-05	3	47	http://****
2709	email	collective.expense.created	t	2016-11-28 17:28:52.368-05	2017-01-10 19:00:00-05	3	48	http://****
2712	email	collective.expense.created	t	2016-11-28 17:28:52.373-05	2017-01-10 19:00:00-05	3	51	http://****
2723	email	collective.expense.created	t	2016-11-28 17:28:52.376-05	2017-01-10 19:00:00-05	3	2	http://****
2724	email	collective.expense.created	t	2016-11-28 17:28:52.377-05	2017-01-10 19:00:00-05	3	3	http://****
2725	email	collective.expense.created	t	2016-11-28 17:28:52.377-05	2017-01-10 19:00:00-05	3	4	http://****
2751	email	collective.expense.created	t	2016-11-28 17:28:52.388-05	2017-01-10 19:00:00-05	3	59	http://****
2954	email	collective.expense.created	t	2016-11-28 17:28:52.451-05	2017-01-10 19:00:00-05	3	260	http://****
2851	email	collective.expense.created	t	2016-11-28 17:28:52.427-05	2017-01-10 19:00:00-05	3	195	http://****
2918	email	collective.expense.created	t	2016-11-28 17:28:52.444-05	2017-01-10 19:00:00-05	3	297	http://****
2923	email	collective.expense.created	t	2016-11-28 17:28:52.445-05	2017-01-10 19:00:00-05	3	291	http://****
2928	email	collective.expense.created	t	2016-11-28 17:28:52.446-05	2017-01-10 19:00:00-05	3	286	http://****
2933	email	collective.expense.created	t	2016-11-28 17:28:52.447-05	2017-01-10 19:00:00-05	3	281	http://****
2938	email	collective.expense.created	t	2016-11-28 17:28:52.448-05	2017-01-10 19:00:00-05	3	276	http://****
2943	email	collective.expense.created	t	2016-11-28 17:28:52.449-05	2017-01-10 19:00:00-05	3	271	http://****
2948	email	collective.expense.created	t	2016-11-28 17:28:52.45-05	2017-01-10 19:00:00-05	3	266	http://****
2952	email	collective.expense.created	t	2016-11-28 17:28:52.451-05	2017-01-10 19:00:00-05	3	262	http://****
5766	email	collective.expense.created	f	2016-12-28 19:13:56.341-05	2017-01-17 19:00:00-05	1329	276	http://****
5780	email	collective.expense.created	f	2016-12-28 19:13:56.343-05	2017-01-17 19:00:00-05	1351	290	http://****
5557	email	collective.expense.created	f	2016-12-28 19:13:56.267-05	2017-01-17 19:00:00-05	33	13	http://****
5774	email	collective.expense.created	f	2016-12-28 19:13:56.342-05	2017-01-17 19:00:00-05	1341	284	http://****
5751	email	collective.expense.created	f	2016-12-28 19:13:56.339-05	2017-01-17 19:00:00-05	1303	259	http://****
5589	email	collective.expense.created	f	2016-12-28 19:13:56.281-05	2017-01-17 19:00:00-05	142	48	http://****
5552	email	collective.expense.created	f	2016-12-28 19:13:56.264-05	2017-01-17 19:00:00-05	28	2	http://****
5563	email	collective.expense.created	f	2016-12-28 19:13:56.267-05	2017-01-17 19:00:00-05	31	14	http://****
5767	email	collective.expense.created	f	2016-12-28 19:13:56.341-05	2017-01-17 19:00:00-05	1333	278	http://****
5786	email	collective.expense.created	f	2016-12-28 19:13:56.344-05	2017-01-17 19:00:00-05	1357	294	http://****
5776	email	collective.expense.created	f	2016-12-28 19:13:56.343-05	2017-01-17 19:00:00-05	1343	286	http://****
5771	email	collective.expense.created	f	2016-12-28 19:13:56.342-05	2017-01-17 19:00:00-05	1338	281	http://****
5588	email	collective.expense.created	f	2016-12-28 19:13:56.281-05	2017-01-17 19:00:00-05	141	47	http://****
5555	email	collective.expense.created	f	2016-12-28 19:13:56.265-05	2017-01-17 19:00:00-05	7	10	http://****
5757	email	collective.expense.created	f	2016-12-28 19:13:56.34-05	2017-01-17 19:00:00-05	1316	266	http://****
5763	email	collective.expense.created	f	2016-12-28 19:13:56.341-05	2017-01-17 19:00:00-05	1326	274	http://****
5764	email	collective.expense.created	f	2016-12-28 19:13:56.341-05	2017-01-17 19:00:00-05	1327	275	http://****
5779	email	collective.expense.created	f	2016-12-28 19:13:56.343-05	2017-01-17 19:00:00-05	1349	289	http://****
5758	email	collective.expense.created	f	2016-12-28 19:13:56.34-05	2017-01-17 19:00:00-05	1314	267	http://****
5689	email	collective.expense.created	f	2016-12-28 19:13:56.324-05	2017-01-17 19:00:00-05	897	195	http://****
5733	email	collective.expense.created	f	2016-12-28 19:13:56.333-05	2017-01-17 19:00:00-05	1145	241	http://****
5762	email	collective.expense.created	f	2016-12-28 19:13:56.341-05	2017-01-17 19:00:00-05	1323	272	http://****
5783	email	collective.expense.created	f	2016-12-28 19:13:56.344-05	2017-01-17 19:00:00-05	1356	293	http://****
5785	email	collective.expense.created	f	2016-12-28 19:13:56.344-05	2017-01-17 19:00:00-05	1362	297	http://****
5756	email	collective.expense.created	f	2016-12-28 19:13:56.34-05	2017-01-17 19:00:00-05	1315	265	http://****
5754	email	collective.expense.created	f	2016-12-28 19:13:56.339-05	2017-01-17 19:00:00-05	1309	262	http://****
5755	email	collective.expense.created	f	2016-12-28 19:13:56.339-05	2017-01-17 19:00:00-05	1313	264	http://****
8086	email	collective.expense.created	t	2017-02-21 13:49:14.347-05	2017-02-21 13:49:14.347-05	3	515	http://****
8100	email	collective.expense.created	t	2017-02-21 14:07:25.189-05	2017-02-21 14:07:25.189-05	3	517	http://****
8105	email	collective.expense.created	t	2017-02-21 14:13:03.396-05	2017-02-21 14:13:03.396-05	3	518	http://****
8111	email	collective.expense.created	t	2017-02-21 14:25:28.726-05	2017-02-21 14:25:28.726-05	3	519	http://****
8117	email	collective.expense.created	t	2017-02-21 14:34:47.023-05	2017-02-21 14:34:47.023-05	3	520	http://****
8123	email	collective.expense.created	t	2017-02-21 14:39:46.24-05	2017-02-21 14:39:46.24-05	3	521	http://****
8129	email	collective.expense.created	t	2017-02-21 14:45:19.17-05	2017-02-21 14:45:19.17-05	3	522	http://****
8139	email	collective.expense.created	t	2017-02-21 15:04:48.983-05	2017-02-21 15:04:48.983-05	3	523	http://****
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                              4007.dat                                                                                            0000600 0004000 0002000 00000044614 13174451173 0014263 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        13	30	12	USD	1000	Donation to WWCode Atlanta	\N	2016-04-01 10:32:16.445-04	2017-02-02 10:06:14.763-05	\N	39	\N	\N	\N	691	\N	1
67	30	14	USD	100	Monthly donation to wwcode seattle	6	2016-04-01 10:32:16.552-04	2017-02-02 10:06:15.538-05	\N	41	\N	\N	\N	691	\N	1
102	2	13	USD	100	Recurring subscription	2	2016-04-01 10:32:16.704-04	2016-04-01 10:32:16.704-04	2016-04-07 10:32:16.691-04	\N	\N	\N	\N	688	\N	1
69	30	13	USD	100	Monthly donation to wwcode washington dc	7	2016-04-01 10:32:16.561-04	2017-02-02 10:06:15.552-05	\N	43	\N	\N	\N	691	\N	1
71	8	14	USD	100	Monthly donation to wwcode seattle	8	2016-04-01 10:32:16.574-04	2017-02-02 10:06:15.567-05	\N	45	\N	\N	\N	819	\N	1
2393	3	516	USD	20000	Global Development	\N	2017-04-07 08:25:51.051-04	2017-04-07 08:25:51.101-04	\N	\N	2017-04-07 08:25:51.1-04		\N	51	\N	1
2472	3	517	USD	100000	Director Travel Stipend CONNECT	\N	2017-04-17 16:41:37.54-04	2017-04-17 16:41:37.67-04	\N	\N	2017-04-17 16:41:37.669-04		\N	51	\N	1
2487	3	511	MXN	25000	Leadership Development: Director Travel Stipend to attend CONNECT 2017	\N	2017-04-17 18:34:32.173-04	2017-04-17 18:34:32.292-04	\N	\N	2017-04-17 18:34:32.289-04		\N	51	\N	1
2473	3	517	USD	5000	PayPal Fees	\N	2017-04-17 16:41:53.536-04	2017-04-17 16:41:53.62-04	\N	\N	2017-04-17 16:41:53.619-04		\N	51	\N	1
2488	3	511	MXN	18800	Leadership Development: Director travel stipend to attend CONNECT 2017	\N	2017-04-17 18:35:06.028-04	2017-04-17 18:35:06.109-04	\N	\N	2017-04-17 18:35:06.109-04		\N	51	\N	1
2522	3	59	USD	610	PayPal Fees for Google I/O	\N	2017-04-19 14:35:02.98-04	2017-04-19 14:35:03.062-04	\N	\N	2017-04-19 14:35:03.062-04		\N	51	\N	1
2521	3	3	USD	1190	PayPal Fees for Google I/O	\N	2017-04-19 14:26:58.952-04	2017-04-19 14:26:59.01-04	\N	\N	2017-04-19 14:26:59.009-04		\N	51	\N	1
2636	3419	516	USD	200	Monthly donation to Women Who Code Huntsville	2031	2017-04-30 21:40:26.938-04	2017-04-30 21:40:31.729-04	\N	2749	2017-04-30 21:40:31.727-04	\N	\N	841	\N	1
2519	3	2	USD	1480	PayPal Fee for Google I/O Ticket	\N	2017-04-19 14:18:17.942-04	2017-04-19 14:18:19.333-04	\N	\N	2017-04-19 14:18:19.333-04		\N	51	\N	1
2508	3	14	USD	1480	PayPal fees Google I/O Travel Stipend	\N	2017-04-18 20:39:23.089-04	2017-04-18 20:39:23.171-04	\N	\N	2017-04-18 20:39:23.17-04		\N	51	\N	1
2507	3	195	USD	1400	PayPal Fees for Google I/O	\N	2017-04-18 20:31:31.884-04	2017-04-18 20:31:31.962-04	\N	\N	2017-04-18 20:31:31.961-04		\N	51	\N	1
2506	3	12	USD	1480	PayPal Fees Google I/O Ticket	\N	2017-04-18 20:20:11.451-04	2017-04-18 20:20:11.557-04	\N	\N	2017-04-18 20:20:11.552-04		\N	51	\N	1
2505	3	12	USD	1198	PayPal Fees Google I/O Ticket	\N	2017-04-18 20:19:14.259-04	2017-04-18 20:19:14.339-04	\N	\N	2017-04-18 20:19:14.339-04		\N	51	\N	1
2489	3	511	MXN	2200	PayPal Fees	\N	2017-04-17 18:35:54.945-04	2017-04-17 18:35:55.035-04	\N	\N	2017-04-17 18:35:55.034-04		\N	51	\N	1
2649	3	13	USD	154800	iOS Dev Camp 2016 (Capital One)	\N	2017-05-01 14:02:20.457-04	2017-05-01 14:02:20.53-04	\N	\N	2017-05-01 14:02:20.457-04		61	521	\N	1
2151	3	12	USD	50000	Leadership Development: Google i/o grant for Alicia C.	\N	2017-03-27 13:10:04.532-04	2017-03-27 13:10:04.637-04	\N	\N	2017-03-27 13:10:04.532-04		75	4	\N	1
2477	3	270	USD	100000	Network Development: Attend CapOne WIT 2017 Kickoff to announce partnership for re-launch	\N	2017-04-17 18:09:42.506-04	2017-04-17 18:09:42.582-04	\N	\N	2017-04-17 18:09:42.506-04		73	4	\N	1
2697	3	51	USD	15000	Zapier + WWCode Atlanta	\N	2017-05-03 13:44:48.667-04	2017-05-03 13:44:48.731-04	\N	\N	2017-05-03 13:44:48.667-04		98	292	\N	1
2217	3	291	CAD	50000	Google I/O Travel Grant: Evangelique L.	\N	2017-03-31 19:37:30.782-04	2017-03-31 19:37:30.831-04	\N	\N	2017-03-31 19:37:30.782-04		60	275	\N	1
2490	3	430	USD	100000	Google I/O Travel Grant: Yelyzaveta L.	\N	2017-04-17 18:40:40.287-04	2017-04-17 18:40:40.376-04	\N	\N	2017-04-17 18:40:40.287-04		101	15	\N	1
2204	3	2	USD	50000	Google I/O Travel Grant: Patricia C. 	\N	2017-03-31 13:17:51.642-04	2017-03-31 13:17:51.712-04	\N	\N	2017-03-31 13:17:51.642-04		54	521	\N	1
2520	3	3	USD	40000	Google I/O Travel Expense	\N	2017-04-19 14:26:01.156-04	2017-04-19 14:26:01.247-04	\N	\N	2017-04-19 14:26:01.156-04		69	524	\N	1
2741	3	301	EUR	16563	Regional Leadership Event: Sofia	\N	2017-05-08 11:30:18.503-04	2017-05-08 11:30:18.616-04	\N	\N	2017-05-08 11:30:18.503-04		85	270	\N	1
2154	3	277	USD	100000	Leadership Development: Google I/O Travel Grant: Lydia L.	\N	2017-03-27 13:53:48.436-04	2017-03-27 13:53:48.659-04	\N	\N	2017-03-27 13:53:48.436-04		86	284	\N	1
2470	3	267	GBP	4000	PayPal Fees to transfer Google I/O stipend	\N	2017-04-17 15:31:52.832-04	2017-04-17 15:31:52.941-04	\N	\N	2017-04-17 15:31:52.832-04		77	292	\N	1
2677	3	51	USD	60000	Fullstory + WWCode Atlanta	\N	2017-05-02 14:45:44.196-04	2017-05-02 14:45:44.266-04	\N	\N	2017-05-02 14:45:44.196-04		98	195	\N	1
2152	3	59	USD	20000	Google I/O travel grant: Kezia W. 	\N	2017-03-27 13:45:17.489-04	2017-03-27 13:45:17.596-04	\N	\N	2017-03-27 13:45:17.489-04		96	241	\N	1
2215	3	286	USD	7500	PayPal Fees for Google I/O transfer	\N	2017-03-31 18:52:45.044-04	2017-03-31 18:52:45.089-04	\N	\N	2017-03-31 18:52:45.044-04		126	292	\N	1
2794	3	59	USD	90000	Adroit Resources - Global Development	\N	2017-05-11 12:41:16.673-04	2017-05-11 12:41:16.796-04	\N	\N	2017-05-11 12:41:16.673-04		96	292	\N	1
2503	3	278	GBP	3562	PayPal Fees for Google I/O travel stipend	\N	2017-04-18 15:41:30.217-04	2017-04-18 15:41:30.305-04	\N	\N	2017-04-18 15:41:30.217-04		76	292	\N	1
1129	1846	59	USD	30000	Donation to WWCode Portland	\N	2016-11-22 10:22:36.145-05	2016-11-22 10:22:40.436-05	\N	1211	2016-11-22 10:22:36.145-05	\N	96	701	\N	1
25	129	2	USD	30000	Donation to WWCode Austin	\N	2016-04-01 10:32:16.462-04	2017-02-02 10:06:14.962-05	\N	94	2016-04-01 10:32:16.462-04	\N	54	689	\N	1
246	392	2	USD	50000	Donation to WWCode Austin	\N	2016-05-19 15:24:42.786-04	2017-02-02 10:06:17.118-05	\N	288	2016-05-19 15:24:42.786-04	\N	54	718	\N	1
489	884	2	USD	20000	Donation to WWCode Austin	\N	2016-08-01 11:55:26.677-04	2017-02-02 10:06:19.797-05	\N	562	2016-08-01 11:55:26.677-04	\N	54	750	\N	1
364	646	2	USD	75000	Donation to WWCode Austin	\N	2016-06-22 16:09:45.975-04	2017-02-02 10:06:18.866-05	\N	435	2016-06-22 16:09:45.975-04	\N	54	771	\N	1
312	551	2	USD	150000	Donation to WWCode Austin	\N	2016-06-06 15:04:36.791-04	2017-02-02 10:06:18.114-05	\N	377	2016-06-06 15:04:36.791-04	\N	54	781	\N	1
191	308	2	USD	150000	Donation to WWCode Austin	\N	2016-05-03 09:07:27.747-04	2017-02-02 10:06:16.352-05	\N	230	2016-05-03 09:07:27.747-04	\N	54	798	\N	1
1712	2906	271	USD	2500	Monthly donation to WWCode Dallas	1366	2017-02-01 12:30:44.044-05	2017-02-01 12:30:50.454-05	\N	1804	2017-02-01 12:30:44.044-05	\N	57	693	\N	1
316	555	13	USD	100000	Donation to WWCode Washington DC	\N	2016-06-06 20:53:47.064-04	2017-02-02 10:06:18.126-05	\N	381	2016-06-06 20:53:47.064-04	\N	61	742	\N	1
183	303	13	USD	50000	Donation to WWCode Washington DC	\N	2016-04-29 09:51:18.715-04	2017-02-02 10:06:16.329-05	\N	216	2016-04-29 09:51:18.715-04	\N	61	808	\N	1
181	283	13	USD	50000	Donation to WWCode Washington DC	\N	2016-04-28 11:01:17.431-04	2017-02-02 10:06:16.319-05	\N	213	2016-04-28 11:01:17.431-04	\N	61	824	\N	1
1167	1890	2	USD	4000	Donation to WWCode Austin	\N	2016-11-28 10:33:12.038-05	2016-11-28 10:33:15.883-05	\N	1249	2016-11-28 10:33:12.038-05	\N	54	810	\N	1
808	1438	2	USD	12500	Donation to WWCode Austin	\N	2016-10-06 14:36:35.208-04	2016-10-06 14:36:39.093-04	\N	880	2016-10-06 14:36:35.208-04	\N	54	713	\N	1
1215	1957	2	USD	20000	Donation to WWCode Austin	\N	2016-11-30 11:11:39.696-05	2016-11-30 11:11:42.626-05	\N	1296	2016-11-30 11:11:39.696-05	\N	54	710	\N	1
1466	2416	2	USD	20000	Donation to WWCode Austin	\N	2017-01-03 15:59:34.554-05	2017-01-03 15:59:38.801-05	\N	1553	2017-01-03 15:59:34.554-05	\N	54	709	\N	1
488	883	2	USD	150000	Donation to WWCode Austin	\N	2016-08-01 11:54:13.775-04	2017-02-02 10:06:19.784-05	\N	561	2016-08-01 11:54:13.775-04	\N	54	839	\N	1
153	224	2	USD	20000	Donation to WWCode Austin	\N	2016-04-13 12:46:10.093-04	2017-02-02 10:06:16.24-05	\N	173	2016-04-13 12:46:10.093-04	\N	54	820	\N	1
15	108	2	USD	30000	Donation to WWCode Austin	\N	2016-04-01 10:32:16.447-04	2017-02-02 10:06:14.785-05	\N	71	2016-04-01 10:32:16.447-04	\N	54	813	\N	1
513	192	2	USD	150000	Donation to WWCode Austin	\N	2016-08-05 16:48:07.943-04	2017-02-02 10:06:20.648-05	\N	589	2016-08-05 16:48:07.943-04	\N	54	805	\N	1
64	192	2	USD	30000	Donation to WWCode Austin	\N	2016-04-01 10:32:16.52-04	2017-02-02 10:06:15.499-05	\N	152	2016-04-01 10:32:16.52-04	\N	54	805	\N	1
498	896	4	USD	10000	Monthly donation to wwcode san francisco	378	2016-08-03 13:47:17.188-04	2017-02-02 10:06:20.1-05	\N	571	2016-08-03 13:47:17.188-04	\N	64	759	\N	1
1388	2220	259	USD	2500	Donation to WWCode Birmingham	\N	2016-12-18 20:41:26.702-05	2016-12-18 20:41:29.227-05	\N	1471	2016-12-18 20:41:26.702-05	\N	80	700	\N	1
1389	2220	259	USD	2500	Donation to WWCode Birmingham	\N	2016-12-18 20:41:58.846-05	2016-12-18 20:42:01.434-05	2016-12-27 19:00:00-05	1472	2016-12-18 20:41:58.846-05	\N	80	700	\N	1
2003	3442	259	USD	6000	Donation to WWCode Birmingham	\N	2017-03-09 13:29:52.29-05	2017-03-09 13:29:55.868-05	\N	2104	2017-03-09 13:29:52.29-05	\N	80	754	\N	1
812	1446	241	USD	2500	Donation to WWCode Taipei	\N	2016-10-07 12:49:14.682-04	2016-10-07 12:49:20.396-04	\N	884	2016-10-07 12:49:14.682-04	\N	83	712	\N	1
1175	1908	301	EUR	25000	Donation to WWCode Berlin	\N	2016-11-29 05:03:21.531-05	2016-11-29 05:03:23.984-05	\N	1257	2016-11-29 05:03:21.531-05	\N	85	707	\N	1
700	1263	59	USD	25000	Donation to WWCode Portland	\N	2016-09-22 21:07:06.293-04	2016-09-22 21:07:10.714-04	\N	790	2016-09-22 21:07:06.293-04	\N	96	792	\N	1
1098	1808	59	USD	50000	Donation to WWCode Portland	\N	2016-11-17 12:43:26.405-05	2016-11-17 12:43:31.282-05	\N	1179	2016-11-17 12:43:26.405-05	\N	96	708	\N	1
1953	1263	59	USD	25000	Donation to WWCode Portland	\N	2017-03-01 17:51:17.006-05	2017-03-01 17:51:20.789-05	\N	2048	2017-03-01 17:51:17.006-05	\N	96	792	\N	1
1709	2898	48	USD	22500	Donation to WWCode Twin Cities	\N	2017-02-01 10:16:17.78-05	2017-02-01 10:16:22.469-05	\N	1801	2017-02-01 10:16:17.78-05	\N	99	801	\N	1
1557	2594	48	USD	10000	Donation to WWCode Twin Cities	\N	2017-01-18 08:54:47.782-05	2017-01-18 08:54:51.04-05	\N	1647	2017-01-18 08:54:47.782-05	\N	99	697	\N	1
1537	2561	48	USD	50000	Donation to WWCode Twin Cities	\N	2017-01-16 13:03:53.812-05	2017-01-16 13:03:57.019-05	\N	1622	2017-01-16 13:03:53.812-05	\N	99	699	\N	1
1801	3053	15	USD	84241	Donation to WWCode Boulder/Denver	\N	2017-02-10 11:47:30.962-05	2017-02-10 11:47:34.968-05	\N	1890	2017-02-10 11:47:30.962-05	\N	55	838	\N	1
622	1094	2	USD	200000	Donation to WWCode Austin	\N	2016-09-01 10:41:33.696-04	2016-09-01 10:41:37.79-04	\N	707	2016-09-01 10:41:33.696-04	\N	54	738	\N	1
2713	3	430	USD	1200	Western Union Fees for Google I/O grant	\N	2017-05-04 14:58:24.782-04	2017-05-04 14:58:24.948-04	\N	\N	2017-05-04 14:58:24.947-04		\N	51	\N	1
258	426	2	USD	50000	Donation to WWCode Austin	\N	2016-05-23 16:27:28.19-04	2017-02-02 10:06:17.13-05	\N	306	2016-05-23 16:27:28.19-04	\N	54	741	\N	1
2702	3	259	USD	2175	Catherine L. - fees and Global development	\N	2017-05-03 20:12:19.758-04	2017-05-03 20:12:19.828-04	\N	\N	2017-05-03 20:12:19.827-04		\N	51	\N	1
65	2	10	USD	500	Monthly donation to wwcode mexico city	1	2016-04-01 10:32:16.527-04	2017-02-02 10:06:21.656-05	\N	34	\N	\N	\N	688	\N	1
2783	4749	522	CAD	1000	Donation to Women Who Code Vancouver	\N	2017-05-10 19:45:43.437-04	2017-05-10 19:45:46.821-04	\N	2888	2017-05-10 19:45:46.821-04	\N	\N	747	\N	1
70	30	13	USD	100	Monthly donation to wwcode washington dc	3	2016-04-01 10:32:16.57-04	2017-02-02 10:06:21.68-05	\N	44	\N	\N	\N	691	\N	1
1935	3301	522	CAD	30000	Donation to Women Who Code Vancouver	\N	2017-02-27 19:25:15.618-05	2017-02-27 19:25:20.42-05	\N	2030	2017-02-27 19:25:20.419-05	\N	\N	837	\N	1
1531	2549	270	USD	1000	Monthly donation to WWCode Chicago	1238	2017-01-14 12:11:39.405-05	2017-01-14 12:11:43.298-05	\N	1616	2017-01-14 12:11:43.297-05	\N	\N	763	\N	1
686	1244	4	USD	0	Monthly donation to wwcode san francisco	530	2016-09-20 16:58:49.811-04	2016-10-14 16:08:32.409-04	\N	773	2016-09-20 16:58:51.909-04	\N	\N	717	\N	1
320	8	3	USD	100	Monthly donation to wwcode new york	224	2016-06-09 13:28:13.93-04	2017-02-02 10:06:18.32-05	\N	385	\N	\N	\N	819	\N	1
386	686	2	USD	1000	Monthly donation to wwcode austin	286	2016-07-01 18:31:45.982-04	2017-02-02 10:06:19.11-05	\N	461	\N	\N	\N	803	\N	1
361	642	48	USD	100	Donation to WWCode Twin Cities	\N	2016-06-21 12:06:05.176-04	2017-02-02 10:06:18.855-05	\N	432	\N	\N	\N	775	\N	1
360	642	4	USD	100	Donation to WWCode San Francisco	\N	2016-06-21 12:05:00.946-04	2017-02-02 10:06:18.844-05	\N	431	\N	\N	\N	775	\N	1
359	642	12	USD	100	Donation to WWCode Atlanta	\N	2016-06-21 12:02:55.605-04	2017-02-02 10:06:18.833-05	\N	430	\N	\N	\N	775	\N	1
101	8	14	USD	100	Recurring subscription	8	2016-04-01 10:32:16.701-04	2016-04-01 10:32:16.701-04	2016-04-07 10:32:16.701-04	\N	\N	\N	\N	819	\N	1
87	2	10	USD	500	Recurring subscription	1	2016-04-01 10:32:16.648-04	2016-04-01 10:32:16.648-04	2016-04-07 10:32:16.648-04	\N	\N	\N	\N	688	\N	1
100	30	13	USD	100	Recurring subscription	3	2016-04-01 10:32:16.697-04	2016-04-01 10:32:16.697-04	2016-04-07 10:32:16.691-04	\N	\N	\N	\N	691	\N	1
95	126	13	USD	100	Monthly donation to wwcode washington dc	33	2016-04-01 10:32:16.673-04	2017-02-02 10:06:15.838-05	\N	93	\N	\N	\N	704	\N	1
83	7	10	MXN	100	Monthly donation to wwcode mexico city	16	2016-04-01 10:32:16.636-04	2016-10-14 16:08:31.996-04	\N	\N	\N	\N	\N	821	\N	1
99	30	13	USD	100	Recurring subscription	7	2016-04-01 10:32:16.691-04	2016-04-01 10:32:16.691-04	2016-04-07 10:32:16.691-04	\N	\N	\N	\N	691	\N	1
122	7	10	MXN	100	Recurring subscription	16	2016-04-01 10:32:16.774-04	2016-04-01 10:32:16.774-04	2016-04-01 10:32:16.774-04	\N	\N	\N	\N	821	\N	1
97	30	14	USD	100	Recurring subscription	6	2016-04-01 10:32:16.68-04	2016-04-01 10:32:16.68-04	2016-04-07 10:32:16.68-04	\N	\N	\N	\N	691	\N	1
72	2	13	USD	100	Monthly donation to wwcode washington dc	2	2016-04-01 10:32:16.577-04	2017-02-02 10:06:15.583-05	\N	46	\N	\N	\N	688	\N	1
98	80	10	MXN	500	Recurring subscription	4	2016-04-01 10:32:16.686-04	2016-04-01 10:32:16.686-04	2016-04-07 10:32:16.686-04	\N	\N	\N	\N	768	\N	1
68	80	10	MXN	500	Monthly donation to wwcode mexico city	4	2016-04-01 10:32:16.557-04	2017-02-02 10:06:15.653-05	\N	42	\N	\N	\N	768	\N	1
2694	3	51	USD	30000	User Testing and WWCode ATL	\N	2017-05-03 13:33:13.357-04	2017-05-03 13:33:13.7-04	\N	\N	2017-05-03 13:33:13.357-04		98	292	\N	1
653	1178	2	USD	50000	Donation to WWCode Austin	\N	2016-09-13 00:15:02.18-04	2016-09-13 00:15:05.541-04	\N	737	2016-09-13 00:15:02.18-04	\N	54	788	\N	1
768	1299	2	USD	19000	Donation to WWCode Austin	\N	2016-09-28 17:47:15.105-04	2016-09-28 17:47:19.41-04	\N	842	2016-09-28 17:47:15.105-04	\N	54	794	\N	1
2430	4173	13	USD	2500	Donation to WWCode Washington DC	\N	2017-04-11 22:05:32.82-04	2017-04-11 22:05:36.109-04	\N	2546	2017-04-11 22:05:32.82-04	\N	61	692	\N	1
2421	4153	13	USD	25000	Donation to WWCode Washington DC	\N	2017-04-10 21:09:47.558-04	2017-04-10 21:09:50.716-04	\N	2535	2017-04-10 21:09:47.558-04	\N	61	842	\N	1
2755	4720	2	USD	84000	Donation to WWCode Austin	\N	2017-05-09 14:14:19.702-04	2017-05-09 14:14:23.386-04	\N	2860	2017-05-09 14:14:19.702-04	\N	54	846	\N	1
2332	3999	2	USD	20000	Donation to WWCode Austin	\N	2017-04-04 15:51:02.781-04	2017-04-04 15:51:04.976-04	\N	2438	2017-04-04 15:51:02.781-04	\N	54	836	\N	1
2676	3	12	USD	300000	FullStory - Global Development	\N	2017-05-02 14:43:43.093-04	2017-05-02 14:43:43.175-04	\N	\N	2017-05-02 14:43:43.093-04		75	292	\N	1
2696	3	12	USD	75000	Zapier - Global Development	\N	2017-05-03 13:44:10.796-04	2017-05-03 13:44:10.856-04	\N	\N	2017-05-03 13:44:10.796-04		75	292	\N	1
2471	3	277	USD	9000	PayPal fees to transfer Google I/O stipend	\N	2017-04-17 15:41:07.575-04	2017-04-17 15:41:07.676-04	\N	\N	2017-04-17 15:41:07.575-04		86	292	\N	1
2475	3	278	GBP	4250	PayPal Fees	\N	2017-04-17 17:06:54.729-04	2017-04-17 17:06:54.818-04	\N	\N	2017-04-17 17:06:54.729-04		76	292	\N	1
2208	3	278	GBP	80500	Google I/O travel grant: Kanke I.	\N	2017-03-31 13:54:33.373-04	2017-03-31 13:54:33.566-04	\N	\N	2017-03-31 13:54:33.373-04		76	4	\N	1
2662	3	3	USD	2930	PayPal fees for Google I/O	\N	2017-05-01 20:33:45.604-04	2017-05-01 20:33:45.819-04	\N	\N	2017-05-01 20:33:45.604-04		69	292	\N	1
2644	4550	516	USD	500	Monthly donation to Women Who Code Huntsville	2039	2017-05-01 13:13:32.223-04	2017-05-01 13:13:36.337-04	\N	2757	2017-05-01 13:13:32.223-04	\N	122	785	\N	1
2206	3	267	GBP	79600	Google I/O Travel Grant: Rabeb O. 	\N	2017-03-31 13:20:23.87-04	2017-03-31 13:20:23.928-04	\N	\N	2017-03-31 13:20:23.87-04		77	285	\N	1
2693	3	12	USD	150000	User Testing - Global Development	\N	2017-05-03 13:32:39.617-04	2017-05-03 13:32:39.663-04	\N	\N	2017-05-03 13:32:39.617-04		75	292	\N	1
2474	3	278	GBP	85000	Travel Stipend for CONNECT	\N	2017-04-17 17:05:14.99-04	2017-04-17 17:05:15.087-04	\N	\N	2017-04-17 17:05:14.99-04		76	292	\N	1
2532	4348	59	USD	10000	Donation to WWCode Portland	\N	2017-04-20 06:17:20.169-04	2017-04-20 06:17:23.35-04	\N	2643	2017-04-20 06:17:20.169-04	\N	96	840	\N	1
2486	3	278	GBP	41000	Leadership Development: Director Stipend to attend NY Stock Exchange Bell Ringing	\N	2017-04-17 18:31:52.609-04	2017-04-17 18:31:52.754-04	\N	\N	2017-04-17 18:31:52.609-04		76	292	\N	1
2817	4834	14	USD	20000	Donation to WWCode Seattle	\N	2017-05-15 08:07:56.843-04	2017-05-15 08:07:59.734-04	\N	2922	2017-05-15 08:07:56.843-04	\N	125	799	\N	1
2750	4711	517	USD	1000	Monthly donation to Women Who Code Manila	2103	2017-05-09 01:59:11.956-04	2017-05-09 01:59:17.596-04	\N	2855	2017-05-09 01:59:11.956-04	\N	105	711	\N	1
2153	3	277	USD	100000	Leadership Development: Google I/O travel grant: Chee Yim G.	\N	2017-03-27 13:52:38.07-04	2017-03-27 13:52:38.138-04	\N	\N	2017-03-27 13:52:38.07-04		86	292	\N	1
2209	3	278	GBP	39800	Google I/O travel grant: Anastasia D. 	\N	2017-03-31 14:01:48.379-04	2017-03-31 14:01:48.43-04	\N	\N	2017-03-31 14:01:48.379-04		76	292	\N	1
2214	3	286	USD	20000	Leadership Development: Conference support for Karina M. 	\N	2017-03-31 18:50:23.845-04	2017-03-31 18:50:23.931-04	2017-03-31 20:00:00-04	\N	2017-03-31 18:50:23.845-04		126	292	\N	1
2212	3	286	USD	100000	Leadership Development: Google I/O Travel grant for Karina M.	\N	2017-03-31 18:32:34.085-04	2017-03-31 18:32:34.135-04	\N	\N	2017-03-31 18:32:34.085-04		126	261	\N	1
2710	3	276	USD	2175	In honour of Maya Johnston	\N	2017-05-04 12:21:53.626-04	2017-05-04 12:21:53.703-04	\N	\N	2017-05-04 12:21:53.702-04		\N	51	\N	1
647	1158	241	USD	1000	Monthly donation to wwcode taipei	496	2016-09-09 23:42:49.15-04	2016-10-14 16:08:32.241-04	\N	731	2016-09-09 23:42:51.443-04	\N	\N	737	\N	1
\.


                                                                                                                    4003.dat                                                                                            0000600 0004000 0002000 00000071461 13174451173 0014257 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        884	*****@paypal.com	*****	*****	stripe	\N	2016-10-07 12:49:14.672-04	2016-10-07 12:49:15.283-04	\N	\N	1446	\N	\N	712	2017-10-26 17:24:03.849-04	\N	f	\N
880	*****@paypal.com	*****	*****	stripe	\N	2016-10-06 14:36:35.196-04	2016-10-06 14:36:35.794-04	\N	\N	1438	\N	\N	713	2017-10-26 17:24:03.853-04	\N	f	\N
773	*****@paypal.com	*****	*****	stripe	\N	2016-09-20 16:58:49.788-04	2016-09-20 16:58:50.526-04	\N	\N	1244	\N	\N	717	2017-10-26 17:24:03.874-04	\N	f	\N
731	*****@paypal.com	*****	*****	stripe	\N	2016-09-09 23:42:49.13-04	2016-09-09 23:42:49.63-04	\N	\N	1158	\N	\N	737	2017-10-26 17:24:03.924-04	\N	f	\N
707	*****@paypal.com	*****	*****	stripe	\N	2016-09-01 10:41:33.663-04	2016-09-01 10:41:34.394-04	\N	\N	1094	\N	\N	738	2017-10-26 17:24:03.924-04	\N	f	\N
306	*****@paypal.com	*****	*****	stripe	\N	2016-05-23 16:27:26.16-04	2016-05-23 16:27:26.962-04	\N	\N	426	\N	\N	741	2017-10-26 17:24:03.947-04	\N	f	\N
381	*****@paypal.com	*****	*****	stripe	\N	2016-06-06 20:53:45.068-04	2016-06-06 20:53:45.674-04	\N	\N	555	\N	\N	742	2017-10-26 17:24:03.95-04	\N	f	\N
562	*****@paypal.com	*****	*****	stripe	\N	2016-08-01 11:55:23.426-04	2016-08-01 11:55:24.6-04	\N	\N	884	\N	\N	750	2017-10-26 17:24:03.957-04	\N	f	\N
571	*****@paypal.com	*****	*****	stripe	\N	2016-08-03 13:47:13.706-04	2016-08-03 13:47:14.326-04	\N	\N	896	\N	\N	759	2017-10-26 17:24:03.978-04	\N	f	\N
42	*****@paypal.com	*****	*****	stripe	\N	2016-02-02 11:52:00.333-05	2016-02-02 11:52:00.333-05	\N	\N	80	\N	\N	768	2017-10-26 17:24:04.004-04	\N	f	\N
435	*****@paypal.com	*****	*****	stripe	\N	2016-06-22 16:09:44.066-04	2016-06-22 16:09:44.651-04	\N	\N	646	\N	\N	771	2017-10-26 17:24:04.019-04	\N	f	\N
430	*****@paypal.com	*****	*****	stripe	\N	2016-06-21 12:02:53.255-04	2016-06-21 12:02:53.912-04	\N	\N	642	\N	\N	775	2017-10-26 17:24:04.022-04	\N	f	\N
431	*****@paypal.com	*****	*****	stripe	\N	2016-06-21 12:04:57.958-04	2016-06-21 12:04:59.511-04	\N	\N	642	\N	\N	775	2017-10-26 17:24:04.022-04	\N	f	\N
432	*****@paypal.com	*****	*****	stripe	\N	2016-06-21 12:06:02.746-04	2016-06-21 12:06:03.475-04	\N	\N	642	\N	\N	775	2017-10-26 17:24:04.022-04	\N	f	\N
377	*****@paypal.com	*****	*****	stripe	\N	2016-06-06 15:04:34.62-04	2016-06-06 15:04:35.385-04	\N	\N	551	\N	\N	781	2017-10-26 17:24:04.042-04	\N	f	\N
737	*****@paypal.com	*****	*****	stripe	\N	2016-09-13 00:15:02.169-04	2016-09-13 00:15:02.814-04	\N	\N	1178	\N	\N	788	2017-10-26 17:24:04.05-04	\N	f	\N
790	*****@paypal.com	*****	*****	stripe	\N	2016-09-22 21:07:06.282-04	2016-09-22 21:07:07.667-04	\N	\N	1263	\N	\N	792	2017-10-26 17:24:04.068-04	\N	f	\N
842	*****@paypal.com	*****	*****	stripe	\N	2016-09-28 17:47:15.094-04	2016-09-28 17:47:16.348-04	\N	\N	1299	\N	\N	794	2017-10-26 17:24:04.07-04	\N	f	\N
219	*****@paypal.com	*****	*****	stripe	\N	2016-04-29 14:46:16.188-04	2016-04-29 14:46:16.688-04	\N	\N	308	\N	\N	798	2017-10-26 17:24:04.076-04	\N	f	\N
230	*****@paypal.com	*****	*****	stripe	\N	2016-05-03 09:07:25.728-04	2016-05-03 09:07:26.509-04	\N	\N	308	\N	\N	798	2017-10-26 17:24:04.076-04	\N	f	\N
461	*****@paypal.com	*****	*****	stripe	\N	2016-07-01 18:31:42.782-04	2016-07-01 18:31:43.38-04	\N	\N	686	\N	\N	803	2017-10-26 17:24:04.091-04	\N	f	\N
152	*****@paypal.com	*****	*****	stripe	\N	2016-03-25 11:11:03.086-04	2016-03-25 11:11:03.086-04	\N	\N	192	\N	\N	805	2017-10-26 17:24:04.093-04	\N	f	\N
589	*****@paypal.com	*****	*****	stripe	\N	2016-08-05 16:48:05.525-04	2016-08-05 16:48:06.15-04	\N	\N	192	\N	\N	805	2017-10-26 17:24:04.093-04	\N	f	\N
216	*****@paypal.com	*****	*****	stripe	\N	2016-04-29 09:51:16.73-04	2016-04-29 09:51:17.252-04	\N	\N	303	\N	\N	808	2017-10-26 17:24:04.099-04	\N	f	\N
71	*****@paypal.com	*****	*****	stripe	\N	2016-02-18 14:54:06.513-05	2016-02-18 14:54:06.513-05	\N	\N	108	\N	\N	813	2017-10-26 17:24:04.113-04	\N	f	\N
45	*****@paypal.com	*****	*****	stripe	\N	2016-02-02 16:46:42.678-05	2016-02-02 16:46:42.678-05	\N	\N	8	\N	\N	819	2017-10-26 17:24:04.124-04	\N	f	\N
90	*****@paypal.com	*****	*****	stripe	\N	2016-02-29 20:35:13.096-05	2016-02-29 20:35:13.096-05	\N	\N	8	\N	\N	819	2017-10-26 17:24:04.124-04	\N	f	\N
124	*****@paypal.com	*****	*****	stripe	\N	2016-03-17 11:29:28.675-04	2016-03-17 11:29:28.674-04	\N	\N	8	\N	\N	819	2017-10-26 17:24:04.124-04	\N	f	\N
110	*****@paypal.com	*****	*****	stripe	\N	2016-03-07 22:35:50.332-05	2016-03-07 22:35:50.332-05	\N	\N	8	\N	\N	819	2017-10-26 17:24:04.124-04	\N	f	\N
189	*****@paypal.com	*****	*****	paypal	\N	2016-04-20 10:14:38.754-04	2016-04-20 10:15:18.774-04	2016-04-20 10:15:18.772-04	\N	8	\N	\N	819	2017-10-26 17:24:04.124-04	\N	f	\N
385	*****@paypal.com	*****	*****	stripe	\N	2016-06-09 13:28:10.609-04	2016-06-09 13:28:11.319-04	\N	\N	8	\N	\N	819	2017-10-26 17:24:04.124-04	\N	f	\N
587	*****@paypal.com	*****	*****	stripe	\N	2016-08-04 17:49:06.957-04	2016-08-04 17:49:07.534-04	\N	\N	8	\N	\N	819	2017-10-26 17:24:04.124-04	\N	f	\N
701	*****@paypal.com	*****	*****	stripe	\N	2016-08-31 04:34:48.855-04	2016-08-31 04:34:49.606-04	\N	\N	8	\N	\N	819	2017-10-26 17:24:04.124-04	\N	f	\N
789	*****@paypal.com	*****	*****	stripe	\N	2016-09-22 14:56:45.915-04	2016-09-22 14:56:47.116-04	\N	\N	8	\N	\N	819	2017-10-26 17:24:04.124-04	\N	f	\N
885	*****@paypal.com	*****	*****	stripe	\N	2016-10-07 16:46:31.454-04	2016-10-07 16:46:32.168-04	\N	\N	8	\N	\N	819	2017-10-26 17:24:04.124-04	\N	f	\N
911	*****@paypal.com	*****	*****	stripe	\N	2016-10-15 11:47:38.174-04	2016-10-15 11:47:38.802-04	\N	\N	8	\N	\N	819	2017-10-26 17:24:04.124-04	\N	f	\N
173	*****@paypal.com	*****	*****	stripe	\N	2016-04-13 12:46:07.391-04	2016-04-13 12:46:08.785-04	\N	\N	224	\N	\N	820	2017-10-26 17:24:04.126-04	\N	f	\N
64	*****@paypal.com	*****	*****	stripe	\N	2016-02-15 13:46:04.238-05	2016-02-15 13:46:04.238-05	\N	\N	7	\N	\N	821	2017-10-26 17:24:04.129-04	\N	f	\N
213	*****@paypal.com	*****	*****	stripe	\N	2016-04-28 11:01:14.747-04	2016-04-28 11:01:15.975-04	\N	\N	283	\N	\N	824	2017-10-26 17:24:04.133-04	\N	f	\N
561	*****@paypal.com	*****	*****	stripe	\N	2016-08-01 11:54:11.721-04	2016-08-01 11:54:12.394-04	\N	\N	883	\N	\N	839	2017-10-26 17:24:04.17-04	\N	f	\N
26	*****@paypal.com	*****	*****	paypal	\N	2015-12-18 15:07:43.76-05	2016-05-26 11:38:39.069-04	2015-12-18 16:52:39.247-05	2016-05-26 11:38:39.068-04	3	\N	\N	857	2017-10-26 17:24:03.799-04	\N	f	\N
320	*****@paypal.com	*****	*****	paypal	\N	2016-05-26 11:37:59.825-04	2016-05-26 11:38:38.996-04	2016-05-26 11:38:38.994-04	2016-08-03 17:40:05.198-04	3	\N	\N	857	2017-10-26 17:24:03.799-04	\N	f	\N
2546	*****@paypal.com	*****	*****	stripe	\N	2017-04-11 22:05:32.807-04	2017-04-11 22:05:33.502-04	\N	\N	4173	\N	\N	692	2017-10-26 17:24:03.772-04	\N	f	\N
1804	*****@paypal.com	*****	*****	stripe	\N	2017-02-01 12:30:44.023-05	2017-02-01 12:30:45.232-05	\N	\N	2906	\N	\N	693	2017-10-26 17:24:03.772-04	\N	f	\N
1645	*****@paypal.com	*****	*****	stripe	\N	2017-01-18 08:51:43.462-05	2017-01-18 08:51:44.621-05	\N	\N	2594	\N	\N	697	2017-10-26 17:24:03.811-04	\N	f	\N
1646	*****@paypal.com	*****	*****	stripe	\N	2017-01-18 08:53:28.297-05	2017-01-18 08:53:29.29-05	\N	\N	2594	\N	\N	697	2017-10-26 17:24:03.811-04	\N	f	\N
1647	*****@paypal.com	*****	*****	stripe	\N	2017-01-18 08:54:47.775-05	2017-01-18 08:54:48.732-05	\N	\N	2594	\N	\N	697	2017-10-26 17:24:03.811-04	\N	f	\N
1179	*****@paypal.com	*****	*****	stripe	\N	2016-11-17 12:43:26.371-05	2016-11-17 12:43:27.368-05	\N	\N	1808	\N	\N	708	2017-10-26 17:24:03.845-04	\N	f	\N
1553	*****@paypal.com	*****	*****	stripe	\N	2017-01-03 15:59:34.532-05	2017-01-03 15:59:35.653-05	\N	\N	2416	\N	\N	709	2017-10-26 17:24:03.845-04	\N	f	\N
1257	*****@paypal.com	*****	*****	stripe	\N	2016-11-29 05:03:21.517-05	2016-11-29 05:03:22.16-05	\N	\N	1908	\N	\N	707	2017-10-26 17:24:03.845-04	\N	f	\N
1296	*****@paypal.com	*****	*****	stripe	\N	2016-11-30 11:11:39.675-05	2016-11-30 11:11:40.34-05	\N	\N	1957	\N	\N	710	2017-10-26 17:24:03.848-04	\N	f	\N
288	*****@paypal.com	*****	*****	stripe	\N	2016-05-19 15:24:40.781-04	2016-05-19 15:24:41.33-04	\N	\N	392	\N	\N	718	2017-10-26 17:24:03.874-04	\N	f	\N
2104	*****@paypal.com	*****	*****	stripe	\N	2017-03-09 13:29:52.21-05	2017-03-09 13:29:53.195-05	\N	\N	3442	\N	\N	754	2017-10-26 17:24:03.974-04	\N	f	\N
1616	*****@paypal.com	*****	*****	stripe	\N	2017-01-14 12:11:39.386-05	2017-01-14 12:11:39.965-05	\N	\N	2549	\N	\N	763	2017-10-26 17:24:03.999-04	\N	f	\N
2048	*****@paypal.com	*****	*****	stripe	\N	2017-03-01 17:51:16.983-05	2017-03-01 17:51:18.471-05	\N	\N	1263	\N	\N	792	2017-10-26 17:24:04.068-04	\N	f	\N
1801	*****@paypal.com	*****	*****	stripe	\N	2017-02-01 10:16:17.747-05	2017-02-01 10:16:18.471-05	\N	\N	2898	\N	\N	801	2017-10-26 17:24:04.088-04	\N	f	\N
1249	*****@paypal.com	*****	*****	stripe	\N	2016-11-28 10:33:12.012-05	2016-11-28 10:33:12.766-05	\N	\N	1890	\N	\N	810	2017-10-26 17:24:04.105-04	\N	f	\N
1111	*****@paypal.com	*****	*****	stripe	\N	2016-11-03 11:52:11.942-04	2016-11-03 11:52:12.638-04	\N	\N	8	\N	\N	819	2017-10-26 17:24:04.124-04	\N	f	\N
1348	*****@paypal.com	*****	*****	stripe	\N	2016-12-02 14:17:05.459-05	2016-12-02 14:17:06.168-05	\N	\N	8	\N	\N	819	2017-10-26 17:24:04.124-04	\N	f	\N
1744	*****@paypal.com	*****	*****	stripe	\N	2017-01-28 19:05:21.392-05	2017-01-28 19:05:21.978-05	\N	\N	8	\N	\N	819	2017-10-26 17:24:04.124-04	\N	f	\N
2091	*****@paypal.com	*****	*****	stripe	\N	2017-03-07 16:36:22.758-05	2017-03-07 16:36:23.955-05	\N	\N	8	\N	\N	819	2017-10-26 17:24:04.124-04	\N	f	\N
2438	*****@paypal.com	*****	*****	stripe	\N	2017-04-04 15:51:02.77-04	2017-04-04 15:51:03.349-04	\N	\N	3999	\N	\N	836	2017-10-26 17:24:04.162-04	\N	f	\N
2030	*****@paypal.com	*****	*****	stripe	\N	2017-02-27 19:25:15.595-05	2017-02-27 19:25:16.385-05	\N	\N	3301	\N	\N	837	2017-10-26 17:24:04.166-04	\N	f	\N
1890	*****@paypal.com	*****	*****	stripe	\N	2017-02-10 11:47:30.914-05	2017-02-10 11:47:31.716-05	\N	\N	3053	\N	\N	838	2017-10-26 17:24:04.168-04	\N	f	\N
2642	*****@paypal.com	*****	*****	stripe	\N	2017-04-20 05:34:08.282-04	2017-04-20 05:34:09.518-04	\N	\N	4348	\N	\N	840	2017-10-26 17:24:04.175-04	\N	f	\N
2643	*****@paypal.com	*****	*****	stripe	\N	2017-04-20 06:17:20.159-04	2017-04-20 06:17:21.398-04	\N	\N	4348	\N	\N	840	2017-10-26 17:24:04.175-04	\N	f	\N
2535	*****@paypal.com	*****	*****	stripe	\N	2017-04-10 21:09:47.541-04	2017-04-10 21:09:48.354-04	\N	\N	4153	\N	\N	842	2017-10-26 17:24:04.177-04	\N	f	\N
1793	*****@paypal.com	*****	*****	stripe	\N	2017-01-31 10:51:34.575-05	2017-01-31 10:51:36.336-05	\N	\N	1325	\N	\N	843	2017-10-26 17:24:04.178-04	\N	f	\N
971	*****@paypal.com	*****	*****	paypal	\N	2016-10-22 06:52:05.33-04	2016-10-22 06:52:05.881-04	\N	2016-10-27 17:01:07.137-04	3	\N	\N	857	2017-10-26 17:24:03.799-04	\N	f	\N
573	*****@paypal.com	*****	*****	paypal	\N	2016-08-03 17:38:52.082-04	2016-08-03 17:40:05.094-04	2016-08-03 17:40:05.093-04	2016-10-27 17:02:50.674-04	3	\N	\N	857	2017-10-26 17:24:03.799-04	\N	f	\N
1043	*****@paypal.com	*****	*****	paypal	\N	2016-10-31 17:12:07.923-04	2016-10-31 17:12:53.002-04	2016-10-31 17:12:53.002-04	2016-10-31 17:34:17.33-04	3	\N	\N	857	2017-10-26 17:24:03.799-04	\N	f	\N
1024	*****@paypal.com	*****	*****	paypal	\N	2016-10-27 17:01:07.153-04	2016-10-27 17:02:50.617-04	2016-10-27 17:02:50.616-04	2016-10-31 17:08:26.464-04	3	\N	\N	857	2017-10-26 17:24:03.799-04	\N	f	\N
1042	*****@paypal.com	*****	*****	paypal	\N	2016-10-31 17:04:38.968-04	2016-10-31 17:08:26.416-04	2016-10-31 17:08:26.414-04	2016-10-31 17:12:53.305-04	3	\N	\N	857	2017-10-26 17:24:03.799-04	\N	f	\N
1114	*****@paypal.com	*****	*****	paypal	\N	2016-11-03 15:32:01.482-04	2016-11-03 15:32:02.116-04	\N	2016-11-03 15:33:52.634-04	3	\N	\N	857	2017-10-26 17:24:03.799-04	\N	f	\N
1044	*****@paypal.com	*****	*****	paypal	\N	2016-10-31 17:33:13-04	2016-10-31 17:34:17.306-04	2016-10-31 17:34:17.306-04	2016-11-03 15:34:26.577-04	3	\N	\N	857	2017-10-26 17:24:03.799-04	\N	f	\N
19	*****@paypal.com	*****	*****	paypal	\N	2015-12-16 04:42:57.058-05	2015-12-16 13:22:05.853-05	\N	2015-12-16 13:22:05.842-05	2	\N	\N	688	2017-10-26 17:24:03.765-04	\N	f	\N
18	*****@paypal.com	*****	*****	paypal	\N	2015-12-16 04:42:53.531-05	2015-12-16 04:42:57.019-05	\N	2015-12-16 04:42:57.018-05	2	\N	\N	688	2017-10-26 17:24:03.765-04	\N	f	\N
17	*****@paypal.com	*****	*****	paypal	\N	2015-12-15 22:05:01.805-05	2015-12-16 13:22:39.715-05	2015-12-15 22:05:25.467-05	2015-12-16 13:22:39.714-05	2	\N	\N	688	2017-10-26 17:24:03.765-04	\N	f	\N
24	*****@paypal.com	*****	*****	paypal	\N	2015-12-16 13:28:34.146-05	2015-12-16 13:28:36.228-05	\N	2015-12-16 13:28:36.227-05	2	\N	\N	688	2017-10-26 17:24:03.765-04	\N	f	\N
29	*****@paypal.com	*****	*****	paypal	\N	2016-01-12 12:51:35.761-05	2016-01-12 12:54:45.421-05	2016-01-12 12:52:16.235-05	2016-01-12 12:54:45.421-05	2	\N	\N	688	2017-10-26 17:24:03.765-04	\N	f	\N
27	*****@paypal.com	*****	*****	stripe	\N	2016-01-06 19:55:36.615-05	2016-01-06 19:55:36.615-05	\N	\N	2	\N	\N	688	2017-10-26 17:24:03.765-04	\N	f	\N
25	*****@paypal.com	*****	*****	paypal	\N	2015-12-16 13:28:36.264-05	2016-01-12 12:52:16.325-05	2015-12-16 13:29:24.829-05	2016-01-12 12:52:16.323-05	2	\N	\N	688	2017-10-26 17:24:03.765-04	\N	f	\N
30	*****@paypal.com	*****	*****	paypal	\N	2016-01-12 12:53:19.259-05	2016-01-12 12:53:20.842-05	\N	2016-01-12 12:53:20.841-05	2	\N	\N	688	2017-10-26 17:24:03.765-04	\N	f	\N
31	*****@paypal.com	*****	*****	paypal	\N	2016-01-12 12:53:20.88-05	2016-01-12 12:54:22.364-05	\N	2016-01-12 12:54:22.343-05	2	\N	\N	688	2017-10-26 17:24:03.765-04	\N	f	\N
34	*****@paypal.com	*****	*****	stripe	\N	2016-01-18 18:54:03.69-05	2016-01-18 18:54:03.69-05	\N	\N	2	\N	\N	688	2017-10-26 17:24:03.765-04	\N	f	\N
32	*****@paypal.com	*****	*****	paypal	\N	2016-01-12 12:54:22.442-05	2016-01-22 01:25:25.222-05	2016-01-12 12:54:45.399-05	2016-01-22 01:25:25.222-05	2	\N	\N	688	2017-10-26 17:24:03.765-04	\N	f	\N
36	*****@paypal.com	*****	*****	paypal	\N	2016-01-23 13:23:35.682-05	2016-03-10 11:54:14.551-05	2016-01-23 13:23:58.941-05	2016-03-10 11:54:14.542-05	2	\N	\N	688	2017-10-26 17:24:03.765-04	\N	f	\N
119	*****@paypal.com	*****	*****	paypal	\N	2016-03-11 16:34:11.535-05	2016-03-26 00:12:54.174-04	\N	2016-03-26 00:12:54.171-04	2	\N	\N	688	2017-10-26 17:24:03.765-04	\N	f	\N
46	*****@paypal.com	*****	*****	stripe	\N	2016-02-02 18:09:03.515-05	2016-02-02 18:09:03.515-05	\N	\N	2	\N	\N	688	2017-10-26 17:24:03.765-04	\N	f	\N
68	*****@paypal.com	*****	*****	stripe	\N	2016-02-16 19:12:43.167-05	2016-02-16 19:12:43.165-05	\N	\N	2	\N	\N	688	2017-10-26 17:24:03.765-04	\N	f	\N
105	*****@paypal.com	*****	*****	paypal	\N	2016-03-05 13:48:06.494-05	2016-03-10 11:53:49.77-05	\N	2016-03-10 11:53:49.769-05	2	\N	\N	688	2017-10-26 17:24:03.765-04	\N	f	\N
117	*****@paypal.com	*****	*****	paypal	\N	2016-03-10 11:53:49.777-05	2016-03-10 11:54:14.484-05	2016-03-10 11:54:14.479-05	\N	2	\N	\N	688	2017-10-26 17:24:03.765-04	\N	f	\N
35	*****@paypal.com	*****	*****	paypal	\N	2016-01-22 01:24:39.343-05	2016-01-23 13:23:58.964-05	2016-01-22 01:25:25.199-05	2016-01-23 13:23:58.964-05	2	\N	\N	688	2017-10-26 17:24:03.765-04	\N	f	\N
109	*****@paypal.com	*****	*****	stripe	\N	2016-03-07 21:43:27.661-05	2016-03-07 21:43:27.661-05	\N	\N	2	\N	\N	688	2017-10-26 17:24:03.765-04	\N	f	\N
252	*****@paypal.com	*****	*****	stripe	\N	2016-05-10 13:19:56.78-04	2016-05-10 13:19:58.837-04	\N	\N	2	\N	\N	688	2017-10-26 17:24:03.765-04	\N	f	\N
494	*****@paypal.com	*****	*****	stripe	\N	2016-07-08 12:25:56.621-04	2016-07-08 12:25:58.207-04	\N	\N	2	\N	\N	688	2017-10-26 17:24:03.765-04	\N	f	\N
495	*****@paypal.com	*****	*****	stripe	\N	2016-07-08 13:24:14.577-04	2016-07-08 13:24:15.71-04	\N	\N	2	\N	\N	688	2017-10-26 17:24:03.765-04	\N	f	\N
524	*****@paypal.com	*****	*****	stripe	\N	2016-07-18 17:00:51.641-04	2016-07-18 17:00:52.921-04	\N	\N	2	\N	\N	688	2017-10-26 17:24:03.765-04	\N	f	\N
567	*****@paypal.com	*****	*****	stripe	\N	2016-08-03 00:54:45.226-04	2016-08-03 00:54:46.256-04	\N	\N	2	\N	\N	688	2017-10-26 17:24:03.765-04	\N	f	\N
1040	*****@paypal.com	*****	*****	stripe	\N	2016-10-31 09:27:24.403-04	2016-10-31 09:27:25.268-04	\N	\N	2	\N	\N	688	2017-10-26 17:24:03.765-04	\N	f	\N
1106	*****@paypal.com	*****	*****	stripe	\N	2016-11-02 18:49:22.021-04	2016-11-02 18:49:23.61-04	\N	\N	2	\N	\N	688	2017-10-26 17:24:03.765-04	\N	f	\N
1262	*****@paypal.com	*****	*****	stripe	\N	2016-11-29 13:35:19.012-05	2016-11-29 13:35:20.055-05	\N	\N	2	\N	\N	688	2017-10-26 17:24:03.765-04	\N	f	\N
1701	*****@paypal.com	*****	*****	stripe	\N	2017-01-24 08:28:17.965-05	2017-01-24 08:28:21.097-05	\N	\N	2	\N	\N	688	2017-10-26 17:24:03.765-04	\N	f	\N
1742	*****@paypal.com	*****	*****	stripe	\N	2017-01-28 18:51:03.682-05	2017-01-28 18:51:05.032-05	\N	\N	2	\N	\N	688	2017-10-26 17:24:03.765-04	\N	f	\N
1986	*****@paypal.com	*****	*****	stripe	\N	2017-02-22 13:25:00.347-05	2017-02-22 13:25:00.347-05	\N	\N	2	\N	\N	688	2017-10-26 17:24:03.765-04	\N	f	\N
2071	*****@paypal.com	*****	*****	stripe	\N	2017-03-04 11:55:18.286-05	2017-03-04 11:55:19.53-05	\N	\N	2	\N	\N	688	2017-10-26 17:24:03.765-04	\N	f	\N
2074	*****@paypal.com	*****	*****	stripe	\N	2017-03-05 00:40:45.496-05	2017-03-05 00:40:48.337-05	\N	\N	2	\N	\N	688	2017-10-26 17:24:03.765-04	\N	f	\N
2246	*****@paypal.com	*****	*****	stripe	\N	2017-03-25 10:33:48.263-04	2017-03-25 10:33:51.315-04	\N	\N	2	\N	\N	688	2017-10-26 17:24:03.765-04	\N	f	\N
2208	*****@paypal.com	*****	*****	stripe	\N	2017-03-21 23:28:09.493-04	2017-03-21 23:28:11.234-04	\N	\N	2	\N	\N	688	2017-10-26 17:24:03.765-04	\N	f	\N
2247	*****@paypal.com	*****	*****	stripe	\N	2017-03-25 11:36:50.843-04	2017-03-25 11:36:53.712-04	\N	\N	2	\N	\N	688	2017-10-26 17:24:03.765-04	\N	f	\N
9	*****@paypal.com	*****	*****	paypal	\N	2015-11-23 13:13:00.576-05	2015-12-15 22:05:25.484-05	2015-11-30 12:00:17.828-05	2015-12-15 22:05:25.484-05	2	\N	\N	688	2017-10-26 17:24:03.765-04	\N	f	\N
160	*****@paypal.com	*****	*****	stripe	\N	2016-04-01 11:09:24.215-04	2016-04-01 11:09:25.585-04	\N	\N	2	\N	\N	688	2017-10-26 17:24:03.765-04	\N	f	\N
23	*****@paypal.com	*****	*****	paypal	\N	2015-12-16 13:22:06.064-05	2015-12-16 13:29:24.85-05	2015-12-16 13:22:39.681-05	2015-12-16 13:29:24.848-05	2	\N	\N	688	2017-10-26 17:24:03.765-04	\N	f	\N
153	*****@paypal.com	*****	*****	paypal	\N	2016-03-26 00:12:54.185-04	2016-03-26 00:12:54.98-04	\N	\N	2	\N	\N	688	2017-10-26 17:24:03.765-04	\N	f	\N
94	*****@paypal.com	*****	*****	stripe	\N	2016-03-02 16:31:48.638-05	2016-03-02 16:31:48.638-05	\N	\N	129	\N	\N	689	2017-10-26 17:24:03.767-04	\N	f	\N
43	*****@paypal.com	*****	*****	stripe	\N	2016-02-02 12:04:53.229-05	2016-02-02 12:04:53.229-05	\N	\N	30	\N	\N	691	2017-10-26 17:24:03.772-04	\N	f	\N
41	*****@paypal.com	*****	*****	stripe	\N	2016-02-02 11:36:35.761-05	2016-02-02 11:36:35.761-05	\N	\N	30	\N	\N	691	2017-10-26 17:24:03.772-04	\N	f	\N
44	*****@paypal.com	*****	*****	stripe	\N	2016-02-02 12:09:19.757-05	2016-02-02 12:09:19.757-05	\N	\N	30	\N	\N	691	2017-10-26 17:24:03.772-04	\N	f	\N
39	*****@paypal.com	*****	*****	stripe	\N	2016-01-29 17:23:51.784-05	2016-01-29 17:23:51.784-05	\N	\N	30	\N	\N	691	2017-10-26 17:24:03.772-04	\N	f	\N
51	*****@paypal.com	*****	*****	stripe	\N	2016-02-09 23:12:33.556-05	2016-02-09 23:12:33.556-05	\N	\N	30	\N	\N	691	2017-10-26 17:24:03.772-04	\N	f	\N
80	*****@paypal.com	*****	*****	stripe	\N	2016-02-25 18:45:02.363-05	2016-02-25 18:45:02.363-05	\N	\N	30	\N	\N	691	2017-10-26 17:24:03.772-04	\N	f	\N
2855	*****@paypal.com	*****	*****	stripe	\N	2017-05-09 01:59:11.913-04	2017-05-09 01:59:13.104-04	\N	\N	4711	\N	\N	711	2017-10-26 17:24:03.849-04	\N	f	\N
2888	*****@paypal.com	*****	*****	stripe	\N	2017-05-10 19:45:43.414-04	2017-05-10 19:45:44.785-04	\N	\N	4749	\N	\N	747	2017-10-26 17:24:03.953-04	\N	f	\N
2757	*****@paypal.com	*****	*****	stripe	\N	2017-05-01 13:13:32.205-04	2017-05-01 13:13:32.817-04	\N	\N	4550	\N	\N	785	2017-10-26 17:24:04.048-04	\N	f	\N
2922	*****@paypal.com	*****	*****	stripe	\N	2017-05-15 08:07:56.825-04	2017-05-15 08:07:57.556-04	\N	\N	4834	\N	\N	799	2017-10-26 17:24:04.08-04	\N	f	\N
2659	*****@paypal.com	*****	*****	stripe	\N	2017-04-20 17:31:48-04	2017-04-20 17:31:49.294-04	\N	\N	8	\N	\N	819	2017-10-26 17:24:04.124-04	\N	f	\N
2847	*****@paypal.com	*****	*****	stripe	\N	2017-05-08 16:06:11.209-04	2017-05-08 16:06:11.921-04	\N	\N	8	\N	\N	819	2017-10-26 17:24:04.124-04	\N	f	\N
159	*****@paypal.com	*****	*****	stripe	\N	2016-04-01 10:33:31.759-04	2016-04-01 10:33:32.893-04	\N	\N	8	\N	\N	819	2017-10-26 17:24:04.124-04	\N	f	\N
11	*****@paypal.com	*****	*****	paypal	\N	2015-11-30 13:25:48.501-05	2015-12-03 18:53:17.763-05	\N	2015-12-03 18:53:17.762-05	7	\N	\N	821	2017-10-26 17:24:04.129-04	\N	f	\N
12	*****@paypal.com	*****	*****	paypal	\N	2015-12-03 18:53:17.772-05	2015-12-03 18:54:56.087-05	2015-12-03 18:54:56.084-05	\N	7	\N	\N	821	2017-10-26 17:24:04.129-04	\N	f	\N
2749	*****@paypal.com	*****	*****	stripe	\N	2017-04-30 21:40:26.919-04	2017-04-30 21:40:28.231-04	\N	\N	3419	\N	\N	841	2017-10-26 17:24:04.175-04	\N	f	\N
2860	*****@paypal.com	*****	*****	stripe	\N	2017-05-09 14:14:19.686-04	2017-05-09 14:14:21.05-04	\N	\N	4720	\N	\N	846	2017-10-26 17:24:04.182-04	\N	f	\N
1115	*****@paypal.com	*****	*****	paypal	\N	2016-11-03 15:33:52.773-04	2016-11-03 15:34:26.403-04	2016-11-03 15:34:26.402-04	2016-11-03 15:41:28.484-04	3	\N	\N	857	2017-10-26 17:24:03.799-04	\N	f	\N
1116	*****@paypal.com	*****	*****	paypal	\N	2016-11-03 15:35:14.952-04	2016-11-03 15:35:15.487-04	\N	2016-11-03 15:39:59.781-04	3	\N	\N	857	2017-10-26 17:24:03.799-04	\N	f	\N
1117	*****@paypal.com	*****	*****	paypal	\N	2016-11-03 15:39:59.972-04	2016-11-03 15:41:28.432-04	2016-11-03 15:41:28.432-04	2016-11-18 16:01:23.135-05	3	\N	\N	857	2017-10-26 17:24:03.799-04	\N	f	\N
203	*****@paypal.com	*****	*****	stripe	\N	2016-04-25 10:42:01.738-04	2016-04-25 10:42:02.272-04	\N	\N	30	\N	\N	691	2017-10-26 17:24:03.772-04	\N	f	\N
323	*****@paypal.com	*****	*****	stripe	\N	2016-05-26 20:52:12.759-04	2016-05-26 20:52:14.148-04	\N	\N	30	\N	\N	691	2017-10-26 17:24:03.772-04	\N	f	\N
507	*****@paypal.com	*****	*****	stripe	\N	2016-07-12 17:19:35.579-04	2016-07-12 17:19:36.177-04	\N	\N	30	\N	\N	691	2017-10-26 17:24:03.772-04	\N	f	\N
572	*****@paypal.com	*****	*****	stripe	\N	2016-08-03 15:30:20.399-04	2016-08-03 15:30:20.964-04	\N	\N	30	\N	\N	691	2017-10-26 17:24:03.772-04	\N	f	\N
703	*****@paypal.com	*****	*****	stripe	\N	2016-08-31 14:22:18.085-04	2016-08-31 14:22:28.874-04	\N	\N	30	\N	\N	691	2017-10-26 17:24:03.772-04	\N	f	\N
715	*****@paypal.com	*****	*****	stripe	\N	2016-09-05 12:25:43.529-04	2016-09-05 12:25:44.192-04	\N	\N	30	\N	\N	691	2017-10-26 17:24:03.772-04	\N	f	\N
176	*****@paypal.com	*****	*****	stripe	\N	2016-04-14 14:12:55.955-04	2016-04-14 14:12:56.555-04	\N	\N	30	\N	\N	691	2017-10-26 17:24:03.772-04	\N	f	\N
1811	*****@paypal.com	*****	*****	stripe	\N	2017-02-01 16:53:00.461-05	2017-02-01 16:53:01.901-05	\N	\N	30	\N	\N	691	2017-10-26 17:24:03.772-04	\N	f	\N
1622	*****@paypal.com	*****	*****	stripe	\N	2017-01-16 13:03:53.804-05	2017-01-16 13:03:54.509-05	\N	\N	2561	\N	\N	699	2017-10-26 17:24:03.813-04	\N	f	\N
1471	*****@paypal.com	*****	*****	stripe	\N	2016-12-18 20:41:26.69-05	2016-12-18 20:41:27.187-05	\N	\N	2220	\N	\N	700	2017-10-26 17:24:03.813-04	\N	f	\N
1472	*****@paypal.com	*****	*****	stripe	\N	2016-12-18 20:41:58.818-05	2016-12-18 20:41:59.328-05	\N	\N	2220	\N	\N	700	2017-10-26 17:24:03.813-04	\N	f	\N
1211	*****@paypal.com	*****	*****	stripe	\N	2016-11-22 10:22:36.125-05	2016-11-22 10:22:37.512-05	\N	\N	1846	\N	\N	701	2017-10-26 17:24:03.814-04	\N	f	\N
93	*****@paypal.com	*****	*****	stripe	\N	2016-03-01 23:41:57.377-05	2016-03-01 23:41:57.377-05	\N	\N	126	\N	\N	704	2017-10-26 17:24:03.817-04	\N	f	\N
1189	*****@paypal.com	*****	*****	paypal	\N	2016-11-18 16:00:56.092-05	2016-11-18 16:01:23.091-05	2016-11-18 16:01:23.091-05	2016-11-18 16:02:50.88-05	3	\N	\N	857	2017-10-26 17:24:03.799-04	\N	f	\N
1190	*****@paypal.com	*****	*****	paypal	\N	2016-11-18 16:02:28.687-05	2016-11-18 16:02:50.197-05	2016-11-18 16:02:50.193-05	2016-11-18 16:03:32.325-05	3	\N	\N	857	2017-10-26 17:24:03.799-04	\N	f	\N
1191	*****@paypal.com	*****	*****	paypal	\N	2016-11-18 16:03:06.664-05	2016-11-18 16:03:32.285-05	2016-11-18 16:03:32.285-05	2016-12-20 11:50:13.592-05	3	\N	\N	857	2017-10-26 17:24:03.799-04	\N	f	\N
1476	*****@paypal.com	*****	*****	paypal	\N	2016-12-20 11:45:05.334-05	2016-12-20 13:53:04.678-05	2016-12-20 13:53:04.677-05	2017-01-25 13:43:43.363-05	3	\N	\N	857	2017-10-26 17:24:03.799-04	\N	f	\N
1718	*****@paypal.com	*****	*****	paypal	\N	2017-01-25 13:42:33.289-05	2017-01-25 13:43:43.316-05	2017-01-25 13:43:43.315-05	2017-02-10 15:19:25.564-05	3	\N	\N	857	2017-10-26 17:24:03.799-04	\N	f	\N
1893	*****@paypal.com	*****	*****	paypal	\N	2017-02-10 15:18:58.618-05	2017-03-14 13:47:25.438-04	2017-03-14 13:47:25.433-04	2017-03-14 13:48:00.117-04	3	\N	\N	857	2017-10-26 17:24:03.799-04	\N	f	\N
2149	*****@paypal.com	*****	*****	paypal	\N	2017-03-14 13:47:32.51-04	2017-03-17 11:34:02.314-04	2017-03-17 11:34:02.314-04	2017-03-17 11:34:41.542-04	3	2018-03-14 13:47:32.043-04	\N	857	2017-10-26 17:24:03.799-04	\N	f	\N
2218	*****@paypal.com	*****	*****	paypal	\N	2017-03-22 16:58:36.077-04	2017-03-27 12:00:11.768-04	2017-03-27 12:00:11.767-04	2017-03-27 12:01:06.921-04	3	2018-03-22 16:58:35.533-04	\N	857	2017-10-26 17:24:03.799-04	\N	f	\N
2180	*****@paypal.com	*****	*****	paypal	\N	2017-03-17 11:34:13.62-04	2017-03-22 16:58:30.022-04	2017-03-22 16:58:30.021-04	2017-03-22 16:59:49.26-04	3	2018-03-17 11:34:13.106-04	\N	857	2017-10-26 17:24:03.799-04	\N	f	\N
2264	*****@paypal.com	*****	*****	paypal	\N	2017-03-27 11:58:40.001-04	2017-03-27 11:58:40.001-04	\N	2017-03-27 12:01:06.923-04	3	2018-03-27 11:58:39.313-04	\N	857	2017-10-26 17:24:03.799-04	\N	f	\N
2265	*****@paypal.com	*****	*****	paypal	\N	2017-03-27 12:00:15.115-04	2017-03-27 13:46:18.273-04	2017-03-27 13:46:18.272-04	2017-03-27 13:46:43.247-04	3	2018-03-27 12:00:14.596-04	\N	857	2017-10-26 17:24:03.799-04	\N	f	\N
2266	*****@paypal.com	*****	*****	paypal	\N	2017-03-27 13:46:21.637-04	2017-03-27 13:54:36.2-04	2017-03-27 13:54:36.199-04	2017-03-27 13:55:03.518-04	3	2018-03-27 13:46:21.041-04	\N	857	2017-10-26 17:24:03.799-04	\N	f	\N
2267	*****@paypal.com	*****	*****	paypal	\N	2017-03-27 13:54:38.499-04	2017-03-31 13:54:59.737-04	2017-03-31 13:54:59.736-04	2017-03-31 13:57:17.587-04	3	2018-03-27 13:54:37.975-04	\N	857	2017-10-26 17:24:03.799-04	\N	f	\N
2318	*****@paypal.com	*****	*****	paypal	\N	2017-03-31 13:55:08.767-04	2017-03-31 18:33:10.929-04	2017-03-31 18:33:10.928-04	2017-03-31 18:33:37.928-04	3	2018-03-31 13:55:08.252-04	\N	857	2017-10-26 17:24:03.799-04	\N	f	\N
2601	*****@paypal.com	*****	*****	paypal	\N	2017-04-17 17:15:58.306-04	2017-04-17 17:15:58.306-04	\N	2017-04-17 17:17:31.155-04	3	2018-04-17 17:15:57.816-04	\N	857	2017-10-26 17:24:03.799-04	\N	f	\N
2560	*****@paypal.com	*****	*****	paypal	\N	2017-04-13 16:50:41.094-04	2017-04-13 16:57:22.555-04	2017-04-13 16:57:22.534-04	2017-04-17 15:34:05.25-04	3	2018-04-13 16:50:40.609-04	\N	857	2017-10-26 17:24:03.799-04	\N	f	\N
2561	*****@paypal.com	*****	*****	paypal	\N	2017-04-13 16:52:22.989-04	2017-04-13 16:52:22.989-04	\N	2017-04-13 16:57:22.804-04	3	2018-04-13 16:52:22.424-04	\N	857	2017-10-26 17:24:03.799-04	\N	f	\N
2321	*****@paypal.com	*****	*****	paypal	\N	2017-03-31 18:33:13.922-04	2017-03-31 18:33:37.801-04	2017-03-31 18:33:37.801-04	2017-04-13 16:57:22.795-04	3	2018-03-31 18:33:13.429-04	\N	857	2017-10-26 17:24:03.799-04	\N	f	\N
2589	*****@paypal.com	*****	*****	paypal	\N	2017-04-17 10:29:51.502-04	2017-04-17 10:29:51.502-04	\N	2017-04-17 15:34:05.252-04	3	2018-04-17 10:29:50.969-04	\N	857	2017-10-26 17:24:03.799-04	\N	f	\N
2592	*****@paypal.com	*****	*****	paypal	\N	2017-04-17 15:32:22.818-04	2017-04-17 15:32:22.818-04	\N	2017-04-17 15:34:05.253-04	3	2018-04-17 15:32:22.311-04	\N	857	2017-10-26 17:24:03.799-04	\N	f	\N
2593	*****@paypal.com	*****	*****	paypal	\N	2017-04-17 15:32:25.362-04	2017-04-17 15:32:25.362-04	\N	2017-04-17 15:34:05.254-04	3	2018-04-17 15:32:24.902-04	\N	857	2017-10-26 17:24:03.799-04	\N	f	\N
2595	*****@paypal.com	*****	*****	paypal	\N	2017-04-17 15:33:26.483-04	2017-04-17 15:33:26.483-04	\N	2017-04-17 15:34:05.255-04	3	2018-04-17 15:33:26.015-04	\N	857	2017-10-26 17:24:03.799-04	\N	f	\N
2602	*****@paypal.com	*****	*****	paypal	\N	2017-04-17 17:16:50.566-04	2017-04-17 17:17:30.886-04	2017-04-17 17:17:30.886-04	\N	3	2018-04-17 17:16:49.999-04	\N	857	2017-10-26 17:24:03.799-04	\N	f	\N
2596	*****@paypal.com	*****	*****	paypal	\N	2017-04-17 17:03:48.29-04	2017-04-17 17:03:48.29-04	\N	2017-04-17 17:17:31.145-04	3	2018-04-17 17:03:47.645-04	\N	857	2017-10-26 17:24:03.799-04	\N	f	\N
2597	*****@paypal.com	*****	*****	paypal	\N	2017-04-17 17:08:47.699-04	2017-04-17 17:08:47.699-04	\N	2017-04-17 17:17:31.148-04	3	2018-04-17 17:08:47.299-04	\N	857	2017-10-26 17:24:03.799-04	\N	f	\N
2599	*****@paypal.com	*****	*****	paypal	\N	2017-04-17 17:14:29.551-04	2017-04-17 17:14:29.551-04	\N	2017-04-17 17:17:31.151-04	3	2018-04-17 17:14:29.12-04	\N	857	2017-10-26 17:24:03.799-04	\N	f	\N
2600	*****@paypal.com	*****	*****	paypal	\N	2017-04-17 17:15:56.101-04	2017-04-17 17:15:56.101-04	\N	2017-04-17 17:17:31.153-04	3	2018-04-17 17:15:55.67-04	\N	857	2017-10-26 17:24:03.799-04	\N	f	\N
2594	*****@paypal.com	*****	*****	paypal	\N	2017-04-17 15:33:22.594-04	2017-04-17 17:16:44.162-04	2017-04-17 17:16:44.162-04	2017-04-17 17:17:31.156-04	3	2018-04-17 15:33:22.134-04	\N	857	2017-10-26 17:24:03.799-04	\N	f	\N
2846	*****@paypal.com	*****	*****	paypal	\N	2017-05-08 11:30:40.035-04	2017-05-08 11:30:40.035-04	\N	\N	3	2018-05-08 11:30:39.371-04	\N	857	2017-10-26 17:24:03.799-04	\N	f	\N
\.


                                                                                                                                                                                                               4018.dat                                                                                            0000600 0004000 0002000 00000010527 13174451173 0014261 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        00-stripemanaged-model.js
01-transaction-model.js
02-group-model.js
03-card-model.js
04-application-model.js
05-user-model.js
06-paykey-model.js
07-activity-model.js
08-usergroup-model.js
09-application-group-model.js
10-transaction-model-relations.js
11-activity-model-relation.js
12-card-model-relation.js
20151030150110-addpaypalfield.js
20151208112311-add_group_public_flag.js
20151209114845-add_email_to_stripe_managed_account.js
20151221110406-add_stripesubscriptionid_to_transaction.js
20151230143257-add-longdescription-logo-video-image-expensePolicy-to-Group-migration.js
20151230150937-rename-membership_type-to-membershipType-migration.js
20151230160803-add_group_slug.js
20160105163703-add_transaction_payment_method.js
20160108134935-merge-name-field-and-add-website-and-twitter-handle-migration.js
20160108145839-updating-longDescription-datatype-migration.js
20160109164217-addVAT-migration.js
20160111104412-switch-expensepolicy-to-be-larger-migration.js
20160112093010-reshape_stripe_managed_account.js
20160113172636-add_stripe_accountid_to_user.js
20160113172933-replace-usergroup-role.js
20160115105814-add-website-twitter-to-group.js
20160119121646-add-pending-subscription.js
20160121133658-subscriptions-migration.js
20160128142427-add_reset_token_to_user.js
20160211190935-add-group-tiers.js
20160216121153-add-interval-to-transaction.js
20160218164134-add-new-constraint-to-UserGroups.js
20160219151355-add-usergroup-id.js
201602242300-add-vendor.js
20160225133109-rename-subscriptions-to-notifications.js
20160226153046-subscription-remodel.js
20160226154559-transactions-subscription-reshape.js
20160309143800-notifications-webhook.js
20160311090652-connected-account-migration.js
20160311113816-transaction-paranoid-migration.js
20160321114955-transaction-data.js
20160322231916-rename-card-to-paymentmethod-migration.js
20160323121731-rename-CardId-to-PaymentsMethodId-in-Transactions-migration.js
20160323133617-add-donations-table-migration.js
20160323152724-add-fields-to-transactions-migration.js
20160402120725-add-fee-fields-to-transactions-migration.js
20160405133705-add-burnrate-and-mission-to-group.js
201604150000-add-backgroundImage.js
201604150000-add-referer-to-users.js
20160415194252-add-netAmountInGroupCurrency-to-Transactions-migration.js
20160416141204-add-hostCommissionPercent-migration.js
20160505173300-add-connected-account-group-id.js
20160511222234-group-settings-and-whyjoin.js
20160519162112-make-group.slug-unique-migration.js
20160520153932-remove-user.email-unique-constraint-migration.js
20160602124940-group-data.js
20160608001600-add-expenses-table.js
20160610103923-add-payoutmethod-to-expense-migration.js
20160616161932-group-tags-and-supercollective-field-migration.js
20160610161454-add-users-description-organization.js
20160613174610-temporal-migration.js
20160713221132-user-add-longDescription.js
20160716003148-users-add-mission.js
20160802180635-add-paymentmethod-to-donation.js
20160815115600-add-sessions-table.js
20160822191515-processedAt-in-Donation-migration.js
20160918000000-users-add-firstname.js
20161007172819-lastEditedBy-in-Groups-migration.js
20161007175650-add-grouphistories-migration.js
20161012000000-comments.js
20161117000000-users-add-billingAddress.js
20161204000000-add-index.js
20161205175944-increase-group-mission-length-migration.js
201701040000-group-isActive.js
20170116163901-create-Event-migration.js
20170116170650-create-Tier-migration.js
20170116190354-create-Response-migration.js
20170124210251-New-fields-Event-Tier-Response-migration.js
20170125005855-Add-Lat-Long-in-Event-migration.js
20170127211709-remove-unused-transaction-fields-migration.js
20170127223729-change-amounts-to-ints-migration.js
20170209212119-add-response-to-migration.js
20170220000000-transactions-add-uuid.js
20170228184811-add-fields-to-PaymentMethod-migration.js
201703150000-add-timezone-events.js
20170310165323-add-notes-to-donations-migration.js
201704100000-updateTiers.js
20170525000000-event-addIndex.js
201706030000-add-HostId.js
201706300000-addTransactionDonationIndex.js
201707080000-add-tiers-maxQuantityPerUser.js
201707100000-add-tiers-to-group.js
201707120000-updatePaymentMethod.js
201707140000-GroupToCollective.js
201709020000-AddPaymentMethodData.js
201709110000-DoubleEntry.js
20171007190000-PopulateOrderFromCollectiveId.js
201710090000-TierDescription.js
20171018154610-create-org-members.js
20171024163252-host-cleanup.js
\.


                                                                                                                                                                         4019.dat                                                                                            0000600 0004000 0002000 00000000005 13174451173 0014250 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           4020.dat                                                                                            0000600 0004000 0002000 00000004437 13174451173 0014255 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        6	100	USD	month	f	\N	*****	2016-02-02 11:36:36-05	2016-06-01 20:00:00-04	2016-02-29 20:07:14.394-05	2016-02-29 20:07:14.394-05	\N
7	100	USD	month	f	\N	*****	2016-02-02 12:04:54-05	2016-06-01 20:00:00-04	2016-02-29 20:07:14.807-05	2016-02-29 20:07:14.807-05	\N
3	100	USD	month	f	\N	*****	2016-02-02 12:09:20-05	2016-06-01 20:00:00-04	2016-02-29 20:07:13.303-05	2016-02-29 20:07:13.303-05	\N
8	100	USD	month	f	\N	*****	2016-02-02 16:46:43-05	2016-06-01 20:00:00-04	2016-02-29 20:07:15.151-05	2016-02-29 20:07:15.151-05	\N
2	100	USD	month	f	\N	*****	2016-02-02 18:09:04-05	2016-06-01 20:00:00-04	2016-02-29 20:07:12.938-05	2016-02-29 20:07:12.938-05	\N
16	100	MXN	month	f	\N	*****	2016-02-15 13:46:05-05	\N	2016-02-29 20:07:18.292-05	2016-02-29 20:07:18.292-05	\N
1	500	USD	month	f	\N	*****	\N	\N	2016-02-29 20:07:12.45-05	2016-02-29 20:07:12.45-05	\N
496	1000	USD	month	t	\N	*****	2016-09-09 23:42:55.758-04	\N	2016-09-09 23:42:49.141-04	2016-09-09 23:42:55.759-04	\N
33	100	USD	month	f	\N	*****	2016-03-01 23:42:15.671-05	2016-06-01 20:00:00-04	2016-03-01 23:41:59.934-05	2016-03-01 23:42:15.673-05	\N
4	500	MXN	month	f	\N	*****	2016-02-02 11:52:01-05	\N	2016-02-29 20:07:13.684-05	2016-02-29 20:07:13.684-05	\N
378	10000	USD	month	f	\N	*****	2016-08-03 13:47:24.609-04	2016-08-03 13:48:03.066-04	2016-08-03 13:47:17.197-04	2016-08-03 13:48:03.067-04	\N
2031	200	USD	month	t	\N	*****	2017-04-30 21:40:31.674-04	\N	2017-04-30 21:40:26.929-04	2017-04-30 21:40:31.674-04	\N
224	100	USD	month	t	\N	*****	2016-06-09 13:28:30.06-04	\N	2016-06-09 13:28:13.943-04	2016-06-09 13:28:30.069-04	\N
1366	2500	USD	month	t	\N	*****	2017-02-01 12:30:50.219-05	\N	2017-02-01 12:30:44.034-05	2017-02-01 12:30:50.219-05	\N
2039	500	USD	month	t	\N	*****	2017-05-01 13:13:36.243-04	\N	2017-05-01 13:13:32.216-04	2017-05-01 13:13:36.243-04	\N
286	1000	USD	month	t	\N	*****	2016-07-01 18:38:36.9-04	\N	2016-07-01 18:31:45.99-04	2016-07-01 18:38:36.9-04	\N
530	0	USD	month	f	\N	*****	2016-09-20 16:59:00.661-04	2017-01-16 10:00:35.909-05	2016-09-20 16:58:49.798-04	2017-01-16 10:00:35.909-05	\N
2103	1000	USD	month	t	\N	*****	2017-05-09 01:59:17.481-04	\N	2017-05-09 01:59:11.936-04	2017-05-09 01:59:17.482-04	\N
1238	1000	USD	month	f	\N	*****	2017-01-14 12:12:00.516-05	2017-02-22 18:10:02.422-05	2017-01-14 12:11:39.397-05	2017-02-22 18:10:02.422-05	\N
\.


                                                                                                                                                                                                                                 4023.dat                                                                                            0000600 0004000 0002000 00000033702 13174451173 0014255 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        40	backer	\N	200	EUR	\N	\N	\N	\N	2017-10-26 17:24:04.197-04	\N	\N	backers	\N	\N	TIER	524	month	\N	[200,1000,2500]
42	backer	\N	500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.198-04	\N	\N	backers	\N	\N	TIER	521	month	\N	\N
45	sponsor	\N	10000	USD	\N	\N	\N	\N	2017-10-26 17:24:04.198-04	\N	\N	sponsors	\N	\N	TIER	521	month	\N	\N
46	backer	\N	500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.199-04	\N	\N	backers	\N	\N	TIER	525	month	\N	\N
50	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.199-04	\N	\N	backers	\N	\N	TIER	262	\N	Become a backer	[2500,5000,10000]
51	backer	\N	500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.199-04	\N	\N	backers	\N	\N	TIER	510	month	\N	\N
54	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.236-04	\N	\N	backers	\N	\N	TIER	2	\N	Become a backer	[2500,5000,10000]
55	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.236-04	\N	\N	backers	\N	\N	TIER	15	\N	Become a backer	[2500,5000,10000]
57	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.238-04	\N	\N	backers	\N	\N	TIER	271	\N	Become a backer	[2500,5000,10000]
58	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.238-04	\N	\N	backers	\N	\N	TIER	288	\N	Become a backer	[2500,5000,10000]
62	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.24-04	\N	\N	backers	\N	\N	TIER	289	\N	Become a backer	[2500,5000,10000]
65	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.298-04	\N	\N	backers	\N	\N	TIER	268	\N	Become a backer	[2500,5000,10000]
72	Backers	Support us with a donation and help us continue our activities.	2500	AUD	\N	\N	\N	\N	2017-10-26 17:24:04.33-04	\N	\N	backers	\N	\N	TIER	281	\N	Become a backer	[2500,5000,10000]
76	Backers	Support us with a donation and help us continue our activities.	2500	GBP	\N	\N	\N	\N	2017-10-26 17:24:04.36-04	\N	\N	backers	\N	\N	TIER	278	\N	Become a backer	[2500,5000,10000]
79	Backers	Support us with a donation and help us continue our activities.	2500	AUD	\N	\N	\N	\N	2017-10-26 17:24:04.368-04	\N	\N	backers	\N	\N	TIER	266	\N	Become a backer	[2500,5000,10000]
85	Backers	Support us with a donation and help us continue our activities.	2500	EUR	\N	\N	\N	\N	2017-10-26 17:24:04.465-04	\N	\N	backers	\N	\N	TIER	301	\N	Become a backer	[2500,5000,10000]
89	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.506-04	\N	\N	backers	\N	\N	TIER	263	\N	Become a backer	[2500,5000,10000]
92	Backers	Support us with a donation and help us continue our activities.	2500	CAD	\N	\N	\N	\N	2017-10-26 17:24:04.566-04	\N	\N	backers	\N	\N	TIER	293	\N	Become a backer	[2500,5000,10000]
93	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.592-04	\N	\N	backers	\N	\N	TIER	272	\N	Become a backer	[2500,5000,10000]
94	Backers	Support us with a donation and help us continue our activities.	2500	EUR	\N	\N	\N	\N	2017-10-26 17:24:04.599-04	\N	\N	backers	\N	\N	TIER	298	\N	Become a backer	[2500,5000,10000]
96	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.625-04	\N	\N	backers	\N	\N	TIER	59	\N	Become a backer	[2500,5000,10000]
97	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.647-04	\N	\N	backers	\N	\N	TIER	260	\N	Become a backer	[2500,5000,10000]
102	Backers	Support us with a donation and help us continue our activities.	2500	MXN	\N	\N	\N	\N	2017-10-26 17:24:04.68-04	\N	\N	backers	\N	\N	TIER	299	\N	Become a backer	[2500,5000,10000]
107	backer	\N	500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.771-04	\N	\N	backers	\N	\N	TIER	513	month	\N	\N
110	sponsor	\N	10000	MXN	\N	\N	\N	\N	2017-10-26 17:24:04.783-04	\N	\N	sponsors	\N	\N	TIER	511	month	\N	\N
112	sponsor	\N	10000	USD	\N	\N	\N	\N	2017-10-26 17:24:04.798-04	\N	\N	sponsors	\N	\N	TIER	512	month	\N	\N
114	sponsor	\N	10000	EUR	\N	\N	\N	\N	2017-10-26 17:24:04.799-04	\N	\N	sponsors	\N	\N	TIER	523	month	\N	\N
115	backer	\N	500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.88-04	\N	\N	backers	\N	\N	TIER	520	month	\N	\N
116	sponsor	\N	10000	USD	\N	\N	\N	\N	2017-10-26 17:24:04.88-04	\N	\N	sponsors	\N	\N	TIER	520	month	\N	\N
121	sponsor	\N	10000	USD	\N	\N	\N	\N	2017-10-26 17:24:04.906-04	\N	\N	sponsors	\N	\N	TIER	516	month	\N	\N
125	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.907-04	\N	\N	backers	\N	\N	TIER	14	\N	Become a backer	[2500,5000,10000]
127	Backers	Support us with a donation and help us continue our activities.	2500	EUR	\N	\N	\N	\N	2017-10-26 17:24:04.942-04	\N	\N	backers	\N	\N	TIER	283	\N	Become a backer	[2500,5000,10000]
44	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.198-04	\N	\N	backers	\N	\N	TIER	292	\N	Become a backer	[2500,5000,10000]
47	sponsor	\N	10000	USD	\N	\N	\N	\N	2017-10-26 17:24:04.199-04	\N	\N	sponsors	\N	\N	TIER	525	month	\N	\N
52	sponsor	\N	10000	USD	\N	\N	\N	\N	2017-10-26 17:24:04.199-04	\N	\N	sponsors	\N	\N	TIER	510	month	\N	\N
56	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.236-04	\N	\N	backers	\N	\N	TIER	290	\N	Become a backer	[2500,5000,10000]
61	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.239-04	\N	\N	backers	\N	\N	TIER	13	\N	Become a backer	[2500,5000,10000]
64	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.295-04	\N	\N	backers	\N	\N	TIER	4	\N	Become a backer	[2500,5000,10000]
66	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.307-04	\N	\N	backers	\N	\N	TIER	287	\N	Become a backer	[2500,5000,10000]
71	Backers	Support us with a donation and help us continue our activities.	5000	MXN	\N	\N	\N	\N	2017-10-26 17:24:04.321-04	\N	\N	backers	\N	\N	TIER	10	\N	Become a backer	[5000,10000,25000,50000,100000]
75	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.36-04	\N	\N	backers	\N	\N	TIER	12	\N	Become a backer	[2500,5000,10000]
77	Backers	Support us with a donation and help us continue our activities.	2500	GBP	\N	\N	\N	\N	2017-10-26 17:24:04.363-04	\N	\N	backers	\N	\N	TIER	267	\N	Become a backer	[2500,5000,10000]
81	Backers	Support us with a donation and help us continue our activities.	2500	AUD	\N	\N	\N	\N	2017-10-26 17:24:04.375-04	\N	\N	backers	\N	\N	TIER	297	\N	Become a backer	[2500,5000,10000]
84	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.45-04	\N	\N	backers	\N	\N	TIER	195	\N	Become a backer	[2500,5000,10000]
90	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.536-04	\N	\N	backers	\N	\N	TIER	294	\N	Become a backer	[2500,5000,10000]
91	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.563-04	\N	\N	backers	\N	\N	TIER	273	\N	Become a backer	[2500,5000,10000]
100	Sponsors	Become a Sponsor and help us fulfill our mission to inspire women to excel in tech careers. See the description above for more info.	150000	USD	\N	\N	\N	\N	2017-10-26 17:24:04.665-04	\N	\N	sponsors	\N	\N	TIER	48	\N	Become a Sponsor	[150000,300000,500000]
103	backer	\N	500	GBP	\N	\N	\N	\N	2017-10-26 17:24:04.691-04	\N	\N	backers	\N	\N	TIER	584	month	\N	\N
106	sponsor	\N	10000	USD	\N	\N	\N	\N	2017-10-26 17:24:04.731-04	\N	\N	sponsors	\N	\N	TIER	517	month	\N	\N
118	sponsor	\N	10000	USD	\N	\N	\N	\N	2017-10-26 17:24:04.882-04	\N	\N	sponsors	\N	\N	TIER	519	month	\N	\N
123	backer	\N	500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.907-04	\N	\N	backers	\N	\N	TIER	515	month	\N	\N
126	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.933-04	\N	\N	backers	\N	\N	TIER	286	\N	Become a backer	[2500,5000,10000]
128	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.953-04	\N	\N	backers	\N	\N	TIER	280	\N	Become a backer	[2500,5000,10000]
43	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.198-04	\N	\N	backers	\N	\N	TIER	275	\N	Become a backer	[2500,5000,10000]
49	backer	\N	500	CAD	\N	\N	\N	\N	2017-10-26 17:24:04.199-04	\N	\N	backers	\N	\N	TIER	522	month	\N	\N
60	Backers	Support us with a donation and help us continue our activities.	2500	CAD	\N	\N	\N	\N	2017-10-26 17:24:04.239-04	\N	\N	backers	\N	\N	TIER	291	\N	Become a backer	[2500,5000,10000]
63	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.24-04	\N	\N	backers	\N	\N	TIER	300	\N	Become a backer	[2500,5000,10000]
67	Backers	Support us with a donation and help us continue our activities.	2500	GBP	\N	\N	\N	\N	2017-10-26 17:24:04.309-04	\N	\N	backers	\N	\N	TIER	264	\N	Become a backer	[2500,5000,10000]
73	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.352-04	\N	\N	backers	\N	\N	TIER	270	\N	Become a backer	[2500,5000,10000]
74	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.359-04	\N	\N	backers	\N	\N	TIER	269	\N	Become a backer	[2500,5000,10000]
82	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.424-04	\N	\N	backers	\N	\N	TIER	265	\N	Become a backer	[2500,5000,10000]
98	donor	Become a donor and help us support all the local Women Who Code collectives	\N	USD	\N	\N	\N	\N	2017-10-26 17:24:04.649-04	\N	\N	donors	\N	\N	TIER	51	\N	\N	["other",100000,500000,1000000]
101	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.672-04	\N	\N	backers	\N	\N	TIER	430	\N	Become a backer	[2500,5000,10000]
104	sponsor	\N	10000	GBP	\N	\N	\N	\N	2017-10-26 17:24:04.692-04	\N	\N	sponsors	\N	\N	TIER	584	month	\N	\N
105	backer	\N	500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.731-04	\N	\N	backers	\N	\N	TIER	517	month	\N	\N
108	sponsor	\N	10000	USD	\N	\N	\N	\N	2017-10-26 17:24:04.771-04	\N	\N	sponsors	\N	\N	TIER	513	month	\N	\N
109	backer	\N	500	MXN	\N	\N	\N	\N	2017-10-26 17:24:04.783-04	\N	\N	backers	\N	\N	TIER	511	month	\N	\N
113	backer	\N	500	EUR	\N	\N	\N	\N	2017-10-26 17:24:04.799-04	\N	\N	backers	\N	\N	TIER	523	month	\N	\N
120	sponsor	\N	10000	USD	\N	\N	\N	\N	2017-10-26 17:24:04.893-04	\N	\N	sponsors	\N	\N	TIER	518	month	\N	\N
124	sponsor	\N	10000	USD	\N	\N	\N	\N	2017-10-26 17:24:04.907-04	\N	\N	sponsors	\N	\N	TIER	515	month	\N	\N
41	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.198-04	\N	\N	backers	\N	\N	TIER	47	\N	Become a backer	[2500,5000,10000]
48	sponsor	\N	10000	CAD	\N	\N	\N	\N	2017-10-26 17:24:04.199-04	\N	\N	sponsors	\N	\N	TIER	522	month	\N	\N
53	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.199-04	\N	\N	backers	\N	\N	TIER	295	\N	Become a backer	[2500,5000,10000]
59	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.238-04	\N	\N	backers	\N	\N	TIER	285	\N	Become a backer	[2500,5000,10000]
68	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.31-04	\N	\N	backers	\N	\N	TIER	284	\N	Become a backer	[2500,5000,10000]
69	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.316-04	\N	\N	backers	\N	\N	TIER	3	\N	Become a backer	[2500,5000,10000]
70	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.32-04	\N	\N	backers	\N	\N	TIER	282	\N	Become a backer	[2500,5000,10000]
78	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.366-04	\N	\N	backers	\N	\N	TIER	279	\N	Become a backer	[2500,5000,10000]
80	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.369-04	\N	\N	backers	\N	\N	TIER	259	\N	Become a backer	[2500,5000,10000]
83	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.447-04	\N	\N	backers	\N	\N	TIER	241	\N	Become a backer	[2500,5000,10000]
86	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.466-04	\N	\N	backers	\N	\N	TIER	277	\N	Become a backer	[2500,5000,10000]
87	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.476-04	\N	\N	backers	\N	\N	TIER	276	\N	Become a backer	[2500,5000,10000]
88	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.499-04	\N	\N	backers	\N	\N	TIER	274	\N	Become a backer	[2500,5000,10000]
95	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.608-04	\N	\N	backers	\N	\N	TIER	261	\N	Become a backer	[2500,5000,10000]
99	Backers	Support us with a donation and help us continue our activities.	2500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.664-04	\N	\N	backers	\N	\N	TIER	48	\N	Become a backer	[2500,5000,10000]
111	backer	\N	500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.798-04	\N	\N	backers	\N	\N	TIER	512	month	\N	\N
117	backer	\N	500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.882-04	\N	\N	backers	\N	\N	TIER	519	month	\N	\N
119	backer	\N	500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.893-04	\N	\N	backers	\N	\N	TIER	518	month	\N	\N
122	backer	\N	500	USD	\N	\N	\N	\N	2017-10-26 17:24:04.906-04	\N	\N	backers	\N	\N	TIER	516	month	\N	\N
\.


                                                              4025.dat                                                                                            0000600 0004000 0002000 00001442426 13174451173 0014267 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        3515	DEBIT	Mathews Group 	-60000	USD	2016-11-29 16:45:09.136-05	2016-11-29 16:45:09.136-05	14	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-60000	\N	c5efa3b7-8be0-4c0b-bbf0-d03f78aefba8	51	857	62b63039-d1da-4b28-8644-64019c1528b2
3535	CREDIT	Banner	2000	USD	2016-11-29 18:07:15.153-05	2016-11-29 18:07:15.39-05	289	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2000	\N	3dc39835-0671-450e-bd85-9d5622676954	857	857	1b8b648c-0528-4b6f-a68e-94f822da6e5d
4438	DEBIT	Meetup Fees	-6000	USD	2016-12-28 11:25:48.743-05	2016-12-28 11:25:48.743-05	48	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	664	571bafd6-9a7d-417d-be32-be27d3f4bee4	51	857	4061a6d3-2cf5-4e89-9bc0-c39e5b4c518d
10135	DEBIT	Google I/O Travel Stipend	-100000	USD	2017-05-16 18:00:40.275-04	2017-05-16 18:00:40.275-04	48	142	\N	\N	\N	\N	\N	\N	0	USD	1	-100000	-100000	1088	d1a78d7e-acb9-4d9b-b6fd-2928ebfe9236	696	857	b12ff197-f82a-4b21-93bd-ae73e78c995b
5285	DEBIT	Amazon Echo Dot devices for HackNight and first book for our book club.	-22137	USD	2017-01-25 13:44:31.311-05	2017-01-25 13:44:33.251-05	48	142	1718	\N	\N	\N	\N	\N	\N	\N	\N	\N	-22137	725	37f44afb-0604-4a3b-b8a4-62a32c582d49	696	857	3b0451fd-5b57-48df-9d25-90c838ad7381
5284	DEBIT	Drinks (La Croix water) for Jan HackNight	-2093	USD	2017-01-25 13:41:33.613-05	2017-01-25 13:41:34.163-05	48	142	1476	\N	\N	\N	\N	\N	\N	\N	\N	\N	-2093	724	d365e630-ae76-45cb-b68c-cf1cf918566c	696	857	ecc4a5bc-754c-4f7c-b949-4c478ba6ef31
10132	DEBIT	Snacks and batteries for our robots	-1554	USD	2017-05-16 18:00:04.449-04	2017-05-16 18:00:04.449-04	48	142	\N	\N	\N	\N	\N	\N	0	USD	1	-1554	-1554	1084	51159051-f7cc-4e7d-b285-4d94027c3ab4	696	857	c76a72ad-6125-47f4-889e-328ae399f8aa
10134	DEBIT	Business cards and stickers	-11948	USD	2017-05-16 18:00:30.412-04	2017-05-16 18:00:30.412-04	48	142	\N	\N	\N	\N	\N	\N	0	USD	1	-11948	-11948	1007	3747993e-5291-4be4-be3f-043e95561284	696	857	ef1a471d-df58-45ec-8330-18aecccca84a
10133	DEBIT	Supplies for decorating our robots	-9777	USD	2017-05-16 18:00:15.557-04	2017-05-16 18:00:15.557-04	48	142	\N	\N	\N	\N	\N	\N	0	USD	1	-9777	-9777	1085	00f439f0-30e3-49f5-bc30-40d828f34f7e	696	857	686c11a5-681c-42aa-ac23-d1a878b2ba2b
7684	DEBIT	Travel stipend to attend the Google I/O 2017 Conference.	-100000	USD	2017-03-31 18:33:59.707-04	2017-03-31 18:33:59.731-04	286	1344	2321	\N	\N	\N	\N	\N	7430	USD	1	-100000	-107430	962	a275cb86-6060-4e20-987b-c9d777f576df	698	857	e560cd88-e067-4bca-939f-c3f8828ccfce
2946	DEBIT	Conference Travel	-53720	USD	2016-11-03 17:27:22.46-04	2016-11-03 17:27:22.847-04	48	142	1117	\N	\N	\N	\N	\N	\N	\N	\N	\N	-53720	333	978ddad8-6f16-4c1c-9d03-58133cf4f3f3	696	857	a6db1f7b-0ccf-492c-ac63-5257adb3a0d2
10131	DEBIT	Leadership meeting	-2989	USD	2017-05-16 17:59:48.206-04	2017-05-16 17:59:48.206-04	48	142	\N	\N	\N	\N	\N	\N	0	USD	1	-2989	-2989	1086	f3f420fc-da24-41e2-ac54-8d18166e5162	696	857	49506772-47a7-4bda-ac44-72d9889dc01d
4957	CREDIT	\N	50000	USD	2017-01-16 13:03:56.108-05	2017-01-16 13:03:56.108-05	48	2561	1622	\N	\N	1537	2500	5000	1130	USD	1	50000	41370	\N	b7c440d2-8682-4b57-93b6-3d3dd3cfed88	699	857	cc4aab78-8a98-4bb1-9b5a-3f68221cd3cc
4124	CREDIT	\N	2500	USD	2016-12-18 20:42:01.104-05	2016-12-18 20:42:01.104-05	259	2220	1472	2016-12-27 19:00:00-05	\N	1389	125	250	85	USD	1	2500	2040	\N	3290a890-4996-4581-a0b7-6db14e41f5a8	700	857	649359ac-33cf-459e-8e52-ab809d804d32
4655	CREDIT	\N	20000	USD	2017-01-03 15:59:37.749-05	2017-01-03 15:59:37.749-05	2	2416	1553	\N	\N	1466	1000	2000	470	USD	1	20000	16530	\N	9d9ae433-8160-4ad4-abba-284759515132	709	857	9861bbf1-cf25-4e39-928d-51b8f7e47d34
4123	CREDIT	\N	2500	USD	2016-12-18 20:41:29.006-05	2016-12-18 20:41:29.006-05	259	2220	1471	\N	\N	1388	125	250	85	USD	1	2500	2040	\N	c13eb052-de5b-4e23-b45b-e405f937cfd7	700	857	92278c96-a40f-40ed-b9c0-9ec0ec0de445
3490	CREDIT	\N	25000	EUR	2016-11-29 05:03:23.71-05	2016-11-29 05:03:23.71-05	301	1908	1257	\N	\N	1175	1301	2601	910	USD	0.961057932572175422	26013	20375	\N	49c565db-0a28-4269-8164-4c0ac9a96fe3	707	857	75cf1591-b9bd-4c91-af9a-e279a57a9288
124	CREDIT	Donation to WWCode Washington DC	100	USD	2016-03-01 23:41:59.916-05	2016-04-16 16:40:58.728-04	13	126	93	\N	\N	95	5	10	33	USD	1	100	52	\N	2cd7b544-2cdd-4060-9426-eeb4bed04fb5	704	857	d1f21443-dc0b-414f-81d8-c56a989c878c
3320	CREDIT	\N	30000	USD	2016-11-22 10:22:39.097-05	2016-11-22 10:22:39.097-05	59	1846	1211	\N	\N	1129	1500	3000	1050	USD	1	30000	24450	\N	3413acd7-804a-4bc1-9689-e91da23b2bdc	701	857	16143471-3587-4fa6-9c25-d8764c0aefd5
1423	CREDIT	Recurring subscription	10000	USD	2016-08-03 13:47:25.319-04	2016-08-03 13:47:25.429-04	4	896	571	\N	\N	498	500	1000	250	USD	1	10000	8250	\N	8ce2b0bd-aefa-4369-9ce9-0e1e469b5d64	759	857	2aaeb780-e8ed-41cd-8766-3a919cf47294
9926	CREDIT	\N	1000	CAD	2017-05-10 19:45:46.737-04	2017-05-10 19:45:46.737-04	522	4749	2888	\N	\N	2783	36	71	46	USD	1.39860139860139854	715	786	\N	52d35c0c-9b28-47ca-973a-07470814a70b	747	857	4642def7-c279-4afa-88fc-4ef64d6ca6ad
5852	CREDIT	monthly recurring subscription	1000	USD	2017-02-09 23:43:49.515-05	2017-02-09 23:43:49.515-05	241	1158	731	\N	\N	647	50	100	52	USD	1	1000	798	\N	86ad6819-a20f-4543-a31c-0e1a121bb79f	737	857	06f8ef12-513f-4f37-b48b-3d7c1410cd20
3886	CREDIT	Recurring subscription	1000	USD	2016-12-09 23:43:00.244-05	2016-12-09 23:43:00.244-05	241	1158	731	\N	\N	647	50	100	52	USD	1	1000	798	\N	3a1a2d26-2613-4c61-bb5f-a9fc2f3beffb	737	857	41726545-78af-468d-bd29-50b8e2200e53
3056	CREDIT	Recurring subscription	1000	USD	2016-11-09 23:43:57.271-05	2016-11-09 23:43:57.271-05	241	1158	731	\N	\N	647	50	100	52	USD	1	1000	798	\N	00ceec95-2161-4179-acba-658bcc889e16	737	857	ace3724d-b7c6-40ed-bfed-788bdc8013ae
2370	CREDIT	Recurring subscription	1000	USD	2016-10-10 00:49:33.558-04	2016-10-10 00:49:33.558-04	241	1158	731	\N	\N	647	50	100	52	USD	1	1000	798	\N	270aedde-c9b9-4d4d-b0b2-c79795f17316	737	857	ca0a26b5-292a-4fa9-a365-fdf37d1cce9a
638	DEBIT	May 5 South Hack Night	-5325	USD	2016-05-22 19:46:04.647-04	2016-06-14 14:14:22.083-04	2	28	26	\N	\N	\N	\N	\N	\N	\N	\N	\N	-5325	181	f3cdf43c-6016-4d3f-812c-eedaec5a2fb3	847	857	6aaa2e86-8b6e-4d84-91d6-5c75adb3e739
229	DEBIT	Mar 3 hack night	-4951	USD	2016-03-20 14:06:09.887-04	2016-06-14 14:14:21.784-04	2	28	26	\N	\N	\N	\N	\N	\N	\N	\N	\N	-4951	55	3e4baefa-db35-450e-9660-bc4dca4d53fc	847	857	115cadd6-4947-41c7-9031-56026dbcd930
231	DEBIT	Feb 1, Lightning Talks	-22568	USD	2016-03-20 14:06:09.887-04	2016-06-14 14:14:21.794-04	2	28	26	\N	\N	\N	\N	\N	\N	\N	\N	\N	-22568	56	dd78e12f-6874-43c4-aa5e-5b54aff99c4f	847	857	6e29ba63-ee2b-44c3-ae42-7b6ca4fe0b65
232	DEBIT	Mar 7 Lightning Talks	-15316	USD	2016-03-20 14:06:09.887-04	2016-06-14 14:14:21.794-04	2	28	\N	2016-06-14 14:14:22.455-04	\N	\N	\N	\N	\N	\N	\N	\N	-15316	57	814475bd-7972-4cc2-a22e-fe3da33bf0bf	847	857	012b450f-522e-4860-833a-561a6209db5d
228	DEBIT	Feb 4 hack night	-10284	USD	2016-03-20 14:06:09.887-04	2016-06-14 14:14:21.784-04	2	28	26	\N	\N	\N	\N	\N	\N	\N	\N	\N	-10284	53	2e9e7313-b914-49f1-b17c-14d67569cbf0	847	857	2368dca3-d778-4d59-8fff-71de58432e7b
230	DEBIT	Feb 1, Lightning Talks	-22568	USD	2016-03-20 14:06:09.887-04	2016-03-29 16:37:47.75-04	2	28	\N	2016-03-28 20:00:00-04	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1408a5bd-a893-4d39-8deb-eb1214cee9f5	847	857	c8337f56-3568-4da2-b672-9a86db2c61ec
7071	DEBIT	Mar 7 Lightning Talks	-15316	USD	2017-03-14 13:21:29.296-04	2017-03-14 13:21:29.332-04	2	28	1893	\N	\N	\N	\N	\N	474	USD	1	-15316	-15790	57	f0262195-2244-40eb-b442-02995b885caa	847	857	70e63c77-42ab-4f4c-9fe8-d4878835a0ad
3840	DEBIT	October Hack Night Drinks/Food.	-1100	USD	2016-12-07 00:00:00.86-05	2016-12-07 00:00:00.86-05	273	1325	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1106	485	88d96482-a87c-418a-b53b-a3c895b3d4ae	843	857	b5c6ba70-6ba7-4029-b76e-4f79d7f5b890
4398	DEBIT	Meetup Fees	-5700	EUR	2016-12-27 13:11:51.873-05	2016-12-27 13:11:51.873-05	283	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-5700	652	28af55a2-3111-4783-ba8d-35cf4d105776	51	857	66aaeb74-3900-461d-a06d-af8608e78bff
7520	DEBIT	Google I/O ticket	-37500	USD	2017-03-27 13:12:00.118-04	2017-03-27 13:12:00.138-04	12	69	2265	\N	\N	\N	\N	\N	1118	USD	1	-37500	-38618	949	98f9ec9a-496c-44d1-b27d-35dc1359a639	834	857	08e703f7-02d6-4346-93c6-c7eef0020007
7519	DEBIT	Google I/O	-50000	USD	2017-03-27 13:11:39.25-04	2017-03-27 13:11:39.275-04	12	69	2265	\N	\N	\N	\N	\N	1480	USD	1	-50000	-51480	952	d319eebc-1e7a-4500-a519-705bdc9facf2	834	857	22752b9f-7315-4137-a35c-69b3c0366197
8614	DEBIT	WWCode CONNECT Conference Travel Stipend	-85000	GBP	2017-04-17 17:18:35.523-04	2017-04-17 17:18:35.581-04	278	1333	2602	\N	\N	\N	\N	\N	3760	GBP	1	-85000	-88760	1016	90b0bf3c-bd5e-4224-902c-8989cebcdf81	830	857	93180ed7-bd45-4b39-b3b6-92284608466d
866	CREDIT	Nike Donation	50000	USD	2016-06-10 00:08:56.525-04	2016-06-10 00:08:56.991-04	59	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	50000	\N	6187d107-e599-47d8-8ca5-8ad365ac9df8	857	857	446ac15a-83a5-430d-bc9e-f62541ce6788
612	CREDIT	Women Techmaker WWCode Partnership Grant	120000	USD	2016-05-19 15:10:52.797-04	2016-05-19 15:10:54.053-04	12	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	120000	\N	9615350f-4370-4c3b-bfab-2f2c48fe511c	857	857	b2fc5245-44e4-4bee-9338-1c12e18cb526
10119	DEBIT	Deposit- We Rise Conference Hosting Location	-500000	USD	2017-05-16 17:51:10.574-04	2017-05-16 17:51:10.574-04	12	3206	\N	\N	\N	\N	\N	\N	0	USD	1	-500000	-500000	1123	6f7e4a95-e8f5-408b-b4a6-c32168791436	690	857	9a4858b6-0f6f-48e1-80ea-7ca5e99fd1c1
9042	CREDIT	\N	200	USD	2017-04-30 21:40:30.232-04	2017-04-30 21:40:30.232-04	516	3419	2749	\N	\N	2636	10	20	34	USD	1	200	136	\N	8c5b057c-7596-4791-a13a-fc2a64303098	841	857	4094e5ba-5a47-407a-92a9-50465e91e816
96	CREDIT	Donation to WWCode Mexico City	100	MXN	2016-02-15 13:46:05.92-05	2016-04-01 10:32:17.223-04	10	7	64	2016-04-07 10:32:17.381-04	\N	83	\N	\N	\N	\N	\N	\N	\N	\N	eb1ff5a0-1e75-4d49-8c64-69e64f1b9d6f	821	857	b049f817-1453-42b9-83f3-1bba9c75f74d
202	CREDIT	Recurring subscription	100	MXN	2016-03-15 16:05:22.15-04	2016-04-01 10:32:17.381-04	10	7	64	2016-04-07 10:32:17.381-04	\N	83	5	\N	\N	\N	\N	\N	\N	\N	d1d87139-4731-4474-a1a3-965cce286ed3	821	857	360dd806-a90b-41b9-82f1-5431b04691d0
460	DEBIT	Mile High Agile outreach- supplies	-1115	USD	2016-04-02 20:00:00-04	2016-06-14 14:14:21.989-04	15	68	26	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1115	136	4423d89d-fb84-4db4-acee-0adf95f0492e	755	857	ff85882e-1001-4c43-a4d8-2dfca97e49ec
2941	DEBIT	Order for stickers of our official WWC Boulder/Denver chapter logo	-7800	USD	2016-11-03 15:45:23.582-04	2016-11-03 15:45:24.25-04	15	68	1117	\N	\N	\N	\N	\N	\N	\N	\N	\N	-7800	48	920fcb4b-a53d-48d7-8294-2914e6c5df81	755	857	e30562f8-0666-4a08-9b1e-dfe529a029f8
459	DEBIT	WWC Boulder- April event's food	-14100	USD	2016-04-06 20:00:00-04	2016-06-14 14:14:21.989-04	15	68	320	\N	\N	\N	\N	\N	\N	\N	\N	\N	-14100	137	d79ac9f7-4158-4fea-be4d-6c95b1858509	755	857	8d156329-21c7-420a-9697-8afc8067a7e3
208	DEBIT	Food for March Boulder, CO event	-14000	USD	2016-03-17 14:48:54.413-04	2016-06-14 14:14:21.77-04	15	68	26	\N	\N	\N	\N	\N	\N	\N	\N	\N	-14000	46	614a8194-5d1d-483a-b0ac-231a1f17a036	755	857	02e5484e-8cfe-49bb-a2c0-0c379a99b7ff
211	DEBIT	Order for stickers of our official WWC Boulder/Denver chapter logo	-7800	USD	2016-03-17 23:23:34.628-04	2016-06-14 14:14:21.77-04	15	68	\N	2016-06-14 14:14:22.448-04	\N	\N	\N	\N	\N	\N	\N	\N	-7800	48	33473cbd-5d6e-4231-a8f5-eb5453ae7eb1	755	857	dbbc8496-878d-4f4a-9202-421f001c34fe
461	DEBIT	WWC Stickers	-7000	USD	2016-03-17 20:00:00-04	2016-06-14 14:14:21.998-04	15	68	\N	2016-06-14 14:14:22.481-04	\N	\N	\N	\N	\N	\N	\N	\N	-7000	138	61723292-7257-4ab6-94d3-d267da41382b	755	857	8dd70fa6-0f82-4b82-a5b2-91c169951c9b
4161	DEBIT	Mugs for WWCode-SV	-46419	USD	2016-12-20 13:57:28.399-05	2016-12-20 13:57:28.525-05	300	1374	1476	\N	\N	\N	\N	\N	\N	\N	\N	\N	-46419	605	cecf6f0f-5fc0-40c8-8907-674372e1c419	706	857	f8577610-f98d-4749-bbd1-64ce039f6d95
5838	CREDIT	monthly recurring subscription	100	USD	2017-02-09 13:29:30.017-05	2017-02-09 13:29:30.017-05	3	8	385	\N	\N	320	5	10	32	USD	1	100	53	\N	5c8b0763-ddec-4adc-a069-ad809703c9dd	819	857	ce679571-c4c9-4fb4-973a-7973f025a198
4779	CREDIT	Recurring subscription	100	USD	2017-01-09 13:28:29.701-05	2017-01-09 13:28:29.701-05	3	8	385	\N	\N	320	5	10	32	USD	1	100	53	\N	410d7ba2-bc7c-4acf-9ad8-182b43caacd4	819	857	cfa1aacf-65fc-44fd-9d0a-cef56823901d
3876	CREDIT	Recurring subscription	100	USD	2016-12-09 13:29:17.341-05	2016-12-09 13:29:17.341-05	3	8	385	\N	\N	320	5	10	32	USD	1	100	53	\N	77717eed-fb45-4bf8-a43d-45391bee0f68	819	857	d38234bb-183f-422a-a9f6-eb2dbc0f9f3a
131	CREDIT	Recurring subscription	100	USD	2016-03-02 18:01:26.771-05	2016-04-16 16:40:58.719-04	14	8	45	\N	\N	71	5	10	33	USD	1	100	52	\N	8abd55fb-f09a-4c77-862a-144f73ebdd0d	819	857	83c3328c-5cfd-421b-94a4-d0b3935fbc9d
3047	CREDIT	Recurring subscription	100	USD	2016-11-09 13:29:23.967-05	2016-11-09 13:29:23.967-05	3	8	385	\N	\N	320	5	10	32	USD	1	100	53	\N	c416f18a-645f-4ba1-bc60-7f6ef6291cf5	819	857	3824623c-d8de-438b-a354-a393ae48b1d5
5578	CREDIT	monthly recurring subscription	1000	USD	2017-02-01 18:34:44.326-05	2017-02-01 18:34:44.326-05	2	686	461	\N	\N	386	50	100	52	USD	1	1000	798	\N	5a54016f-f69c-49ef-8d2f-f03740ca539c	803	857	df2fb1b7-2272-433a-9946-4e775983b2d8
3669	CREDIT	Recurring subscription	1000	USD	2016-12-01 18:32:26.764-05	2016-12-01 18:32:26.764-05	2	686	461	\N	\N	386	50	100	52	USD	1	1000	798	\N	d7a57bda-4dda-46e1-badb-2dc573225d85	803	857	bdb1a9c6-4ef4-4332-8310-f8760c0eb07b
1792	CREDIT	Recurring subscription	1000	USD	2016-09-01 19:32:42.475-04	2016-09-01 19:32:42.475-04	2	686	461	\N	\N	386	50	100	52	USD	1	1000	798	\N	f8a6849c-0a33-4c9a-b04f-a5f96d063bfc	803	857	477a43bf-b011-4c6f-94c5-8d7332b4c835
74	CREDIT	Donation to WWCode Washington DC	100	USD	2016-02-02 12:09:22.069-05	2016-04-16 16:40:58.697-04	13	30	44	\N	\N	70	5	10	33	USD	1	100	52	\N	86ca72b0-3163-400d-83e1-e17d7f182d7e	691	857	4221f820-4cf1-4b26-83fd-86c9d965eeab
77	CREDIT	Donation to WWCode Seattle	100	USD	2016-02-02 16:46:44.866-05	2016-04-16 16:40:58.7-04	14	8	45	\N	\N	71	5	10	33	USD	1	100	52	\N	ac7d9c6f-0090-4ff5-bd71-01aaef4f5b99	819	857	e46a37a6-08a7-4b7a-b13c-b608f413ca10
474	CREDIT	Recurring subscription	100	USD	2016-05-02 18:49:03.545-04	2016-05-02 18:49:03.612-04	14	8	45	\N	\N	71	5	10	33	USD	1	100	52	\N	625d1196-61d0-48d5-8a84-0cfd6a50c750	819	857	2fd4c03e-6ff8-4e17-9d2e-d132f29985d1
5021	CREDIT	WWCode t-shirt sales	3563	USD	2017-01-17 22:28:29.874-05	2017-01-17 22:28:30.096-05	290	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3563	\N	2dde7e29-f8fa-4b52-86c1-3cfeb0c374e3	857	857	ca918f65-1ea6-4800-85e6-7c4b89829969
1921	DEBIT	Event food	-3224	USD	2016-09-13 10:57:04.698-04	2016-09-13 10:57:05.111-04	59	171	573	\N	\N	\N	\N	\N	\N	\N	\N	\N	-3224	346	5c624478-95c6-4d37-94e1-3d7ffe3895bd	827	857	cbd4ddcf-92fd-4113-9552-17b258fa91c1
8210	CREDIT	\N	20000	USD	2017-04-04 15:51:04.916-04	2017-04-04 15:51:04.916-04	2	3999	2438	\N	\N	2332	1000	2000	700	USD	1	20000	16300	\N	2d1d8ff1-e35e-417d-b676-75bc6130e73a	836	857	846e1648-6897-4f52-9597-eb9cf3568c4e
4411	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-27 14:54:51.439-05	2016-12-27 14:54:51.679-05	4	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	0c8ffef8-b8d3-43b7-ad21-4d41571029cd	857	857	0cfc2cff-42a6-44d4-9ee9-e59f07fe304c
9879	CREDIT	\N	84000	USD	2017-05-09 14:14:23.283-04	2017-05-09 14:14:23.283-04	2	4720	2860	\N	\N	2755	4200	8400	1878	USD	1	84000	69522	\N	254136b6-233d-4361-9aa2-ceddc7305fe8	846	857	9c56799f-e918-4d1f-9588-7ea87dfe2f3c
6421	CREDIT	\N	30000	CAD	2017-02-27 19:25:20.325-05	2017-02-27 19:25:20.325-05	522	3301	2030	\N	\N	1935	1121	1120	523	USD	1.33832976445396135	22416	26301	\N	e838bae8-af91-48a1-8619-e42c8aab84c7	837	857	36909743-d7f1-4034-b022-385cd5eba285
9357	CREDIT	\N	500	USD	2017-05-01 13:13:34.851-04	2017-05-01 13:13:34.851-04	516	4550	2757	\N	\N	2644	25	50	41	USD	1	500	384	\N	9470e412-b1bd-46f6-a497-907e6d8c9a4d	785	857	02193e7b-d320-4f42-9625-c8b44e09fd56
10051	CREDIT	\N	20000	USD	2017-05-15 08:07:59.63-04	2017-05-15 08:07:59.63-04	14	4834	2922	\N	\N	2817	1000	2000	470	USD	1	20000	16530	\N	2f09aa94-9b15-47bc-8e9c-b8ab6d67d426	799	857	1c8cb7b5-c533-490c-9fd0-1c1d4fa26ce7
1954	DEBIT	Event food	-2911	USD	2016-09-15 20:09:43.149-04	2016-09-15 20:09:43.531-04	59	171	573	\N	\N	\N	\N	\N	\N	\N	\N	\N	-2911	345	86b66e81-a6ce-436d-9ea0-161fa976ce9d	827	857	a3889d78-b131-47f4-a9bf-1ed18083bdbe
2539	DEBIT	Director t-shirt	-3325	USD	2016-10-17 17:01:02.872-04	2016-10-17 17:01:02.925-04	298	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-3325	\N	73b25042-c1cc-45c6-9089-ec29736609fb	51	857	e5d19c1f-a93b-4bd4-9dce-01f0923f2746
8728	CREDIT	\N	10000	USD	2017-04-20 06:17:23.286-04	2017-04-20 06:17:23.286-04	59	4348	2643	\N	\N	2532	500	1000	350	USD	1	10000	8150	\N	04384e27-0f6b-407a-a8d1-e8353f9a4c98	840	857	9baa3883-dabc-4ae9-b35e-fa5609eda117
1391	CREDIT	Donation to WWCode Austin	150000	USD	2016-08-01 11:54:14.382-04	2016-08-01 11:54:14.468-04	2	883	561	\N	\N	488	7500	15000	3330	USD	1	150000	124170	\N	0577aa52-6ea8-4268-9559-de120c9fd743	839	857	3b7c8357-4733-4dbd-9091-2776238c4ee8
337	CREDIT	Donation to WWCode Austin	20000	USD	2016-04-13 12:46:10.463-04	2016-04-16 16:40:58.845-04	2	224	173	\N	\N	153	1000	2000	610	USD	1	20000	16390	\N	07e21011-0879-4523-b624-073fdfd704c3	820	857	c8660193-792a-44e4-a7ff-d074f69bec15
449	CREDIT	Donation to WWCode Washington DC	50000	USD	2016-04-28 11:01:17.801-04	2016-04-28 11:01:17.846-04	13	283	213	\N	\N	181	2500	5000	1480	USD	1	50000	41020	\N	d7208bd6-4f00-4c5d-b85e-3792419450d5	824	857	bcf62fcc-21ca-4088-ad5a-5b2e4db42742
2360	CREDIT	Recurring subscription	100	USD	2016-10-09 14:36:17.958-04	2016-10-09 14:36:17.958-04	3	8	385	\N	\N	320	5	10	32	USD	1	100	53	\N	53835d40-3ec2-48e7-8d85-8f9381ef368c	819	857	96c44820-d784-4c22-ad13-14d109443806
822	DEBIT	3/30/16 Python Gameathon prize - Udemy course	-2400	USD	2016-06-04 17:37:03.991-04	2016-06-14 14:14:22.155-04	2	28	320	\N	\N	\N	\N	\N	\N	\N	\N	\N	-2400	213	0870d634-022a-48de-ac16-c6f668cbea2f	847	857	46f4fff3-ffc1-4223-99e9-18fcb1c74558
641	DEBIT	05-21-16 AI workshop	-30000	USD	2016-05-22 20:26:36.061-04	2016-06-14 14:14:22.092-04	2	28	\N	2016-06-14 14:14:22.535-04	\N	\N	\N	\N	\N	\N	\N	\N	-30000	186	b1caa950-29a7-4b01-b194-5ad97dade460	847	857	aef9f0a0-3c39-44f0-864c-d4d8d24ef655
3837	DEBIT	Food/Drinks for Leadership Team Meeting - Gen, Claire - Oct 2016	-4000	GBP	2016-12-07 00:00:00.86-05	2016-12-07 00:00:00.86-05	278	1333	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-4000	507	57ffa5d8-ca36-46bc-8a78-8bf44617167e	830	857	757edecb-0f6b-4a7c-9324-ba8976d9d67c
6709	CREDIT	monthly recurring subscription	1000	USD	2017-03-01 18:40:00.024-05	2017-03-01 18:40:00.024-05	2	686	461	\N	\N	386	50	100	52	USD	1	1000	798	\N	71e7d3cd-cd4b-465b-a6d1-a0242bb22558	803	857	14d20a9a-9ac1-49e0-bd39-e31b6cb8136d
6700	CREDIT	\N	25000	USD	2017-03-01 17:51:20.759-05	2017-03-01 17:51:20.759-05	59	1263	2048	\N	\N	1953	1250	2500	580	USD	1	25000	20670	\N	bd4cecda-d52c-4c14-9ffa-5831f212eb3f	792	857	4f19c667-0fa8-480d-91eb-97e37d3d18f1
2285	DEBIT	Event Food	-2077	USD	2016-10-05 12:43:28.448-04	2016-10-05 12:43:28.644-04	59	171	573	\N	\N	\N	\N	\N	\N	\N	\N	\N	-2077	374	cdf1fd80-a036-4c27-8a92-17a09ae5c91b	827	857	7d5ee59c-f454-4b9c-a22a-a3692c12ee02
132	CREDIT	Recurring subscription	100	USD	2016-03-02 19:24:57.083-05	2016-04-16 16:40:58.834-04	13	2	46	\N	\N	72	5	10	33	USD	1	100	52	\N	3a77dd06-45f7-43cd-94e3-dffec6785c2b	688	857	aefdbbb2-f34e-4934-9191-3d734375feb2
2824	DEBIT	05-21-16 AI workshop	-30000	USD	2016-10-31 17:16:09.23-04	2016-10-31 17:16:09.38-04	2	28	1043	\N	\N	\N	\N	\N	\N	\N	\N	\N	-30000	186	1bcc20eb-8879-4cb4-834e-a2a7841a6419	847	857	85ee00f1-fabf-417e-a047-24fe5fb400ec
3234	DEBIT	Food (ATXDivHack)	-119954	USD	2016-11-18 16:01:43.887-05	2016-11-18 16:01:44.336-05	2	28	1189	\N	\N	\N	\N	\N	\N	\N	\N	\N	-119954	466	6a6bfacf-cc60-4e92-a2dc-a0d97d985107	847	857	95e7f4e9-68b8-4dc0-8645-98f7eea08edd
3284	DEBIT	Food (ATXDivHack)	-339421	USD	2016-11-21 10:23:08.279-05	2016-11-21 10:23:08.279-05	2	28	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-339421	467	4a086d99-828a-4a85-8a6f-608d3bd7d765	847	857	b0f343fc-25cb-4235-b765-1b7b202a5f29
2820	DEBIT	Painters tape for signs  	-1136	USD	2016-10-31 17:14:51.746-04	2016-10-31 17:14:51.945-04	2	28	1043	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1136	445	e40c1dfc-1af6-4b4d-9f6a-ec62ee2b7f8d	847	857	76e5f3df-5e83-48d2-b4af-7cb58665a29e
2817	DEBIT	Almond milk for coffee (ATXDivHack)	-1192	USD	2016-10-31 17:13:53.591-04	2016-10-31 17:13:53.747-04	2	28	1043	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1192	446	4d9e5244-f21b-43cd-a486-409f2b41487c	847	857	4938fb18-ffaa-4dae-ac3f-1383210dcad6
2939	DEBIT	Event Food	-6471	USD	2016-11-03 15:43:50.827-04	2016-11-03 15:43:51.096-04	59	171	1117	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6471	377	cf42497b-d717-4d8e-99cc-d12ab8b99170	827	857	dbee49c9-c3be-4790-b860-2939c9e48ae4
821	DEBIT	6/2/16 Fireside Chat at Orange Coworking	-20000	USD	2016-06-04 17:37:03.991-04	2016-06-14 14:14:22.145-04	2	28	320	\N	\N	\N	\N	\N	\N	\N	\N	\N	-20000	211	ba544502-40c0-46d0-83d2-419108dfee18	847	857	ecaf6677-a999-4e21-9af0-e3d323b503e5
639	DEBIT	April 4 Lightning Talks	-13315	USD	2016-05-22 19:46:04.647-04	2016-06-14 14:14:22.091-04	2	28	26	\N	\N	\N	\N	\N	\N	\N	\N	\N	-13315	183	8cd8612d-8c56-45a4-af58-054b1251d213	847	857	b1c0a6ec-c31e-4048-87e6-29f63aefb551
640	DEBIT	May 2 Lightning Talks	-8979	USD	2016-05-22 19:46:04.647-04	2016-06-14 14:14:22.092-04	2	28	26	\N	\N	\N	\N	\N	\N	\N	\N	\N	-8979	184	761dc700-eac2-44ef-8aa7-a3dc7268e489	847	857	f974bc7f-1f07-46a6-87f9-78b3d64f12e7
637	DEBIT	April 7 South Hack Night	-5037	USD	2016-05-22 19:46:04.647-04	2016-06-14 14:14:22.083-04	2	28	26	\N	\N	\N	\N	\N	\N	\N	\N	\N	-5037	180	c136a783-1ea9-48e1-aa36-325bc67a6c44	847	857	b1cf353a-7fc6-4330-97be-4917a77e0f21
3517	DEBIT	Lodging and meals for our WWC Seattle 7 team members leadership development retreat. Under approved budget!	-227646	USD	2016-11-29 16:46:42.259-05	2016-11-29 16:46:42.259-05	14	31	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-227646	474	41da1426-3c94-4dfc-9beb-712e3ecf65d5	766	857	85a217ec-4a97-4b78-84a2-cdebf5a4380a
2799	DEBIT	Google DevFest event that WWC sponsored and attended. Two large banners. Table cloth. Plus my luggage since I went directly from airport. 	-1305	USD	2016-10-31 13:52:11.82-04	2016-10-31 13:52:12.734-04	14	31	1024	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1305	427	70dd8d78-1052-4a85-ac86-eeaed28d2c15	766	857	144016ba-1773-45e1-896c-44bbd701aa14
2842	DEBIT	Transportation to get to GeekWire Summit social event 	-729	USD	2016-11-01 12:16:02.625-04	2016-11-01 12:16:02.953-04	14	31	1044	\N	\N	\N	\N	\N	\N	\N	\N	\N	-729	402	f0415f03-23e6-4e11-8083-aac5401f4c17	766	857	cb3c3dc5-d82f-4753-a75a-e4e6daf6783f
2808	DEBIT	Monthly team meeting w core six members. Food/pizza	-3323	USD	2016-10-31 17:02:15.762-04	2016-10-31 17:02:16.402-04	14	31	1024	\N	\N	\N	\N	\N	\N	\N	\N	\N	-3323	400	18e79267-4423-4db3-9fde-a81a0f812e43	766	857	56420ad5-5af6-42ac-b004-d68030a128a0
841	DEBIT	May expense: Travel and expense costs for mentoring at StartUp Weekend, Meeting w Northeeastern University for future WWC events 	-5161	USD	2016-06-06 20:21:31.531-04	2016-06-14 14:14:22.165-04	14	31	320	\N	\N	\N	\N	\N	\N	\N	\N	\N	-5161	218	003cb730-5a3d-4db1-a7b2-32bd980c6452	766	857	f77d510c-4f55-4a55-948f-4982df345f46
250	DEBIT	WwConnect Planning Meeting	-2519	USD	2016-03-10 19:00:00-05	2016-06-14 14:14:21.794-04	14	31	26	\N	\N	\N	\N	\N	\N	\N	\N	\N	-2519	60	007274b9-395d-410d-837a-e4c2863db761	766	857	1af0fd42-ff06-4ab2-855e-fe7b01089add
6271	DEBIT	Lunch w Saranya during leads meeting. I lost the paper copy of the receipt so including the credit card statement 	-5458	USD	2017-02-22 10:27:45.429-05	2017-02-22 10:27:45.466-05	14	31	1893	\N	\N	\N	\N	\N	\N	\N	\N	\N	-5458	775	3cbee278-6d55-4ec8-b437-04378120a652	766	857	3d5b1eb8-9bc2-45b8-b700-15d23ccbc5e5
6270	DEBIT	Travel to attend internal leads meeting to finalize plans for upcoming 2017 events	-6100	USD	2017-02-22 10:27:02.607-05	2017-02-22 10:27:02.62-05	14	31	1893	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6100	774	534ed69b-fc23-4c7d-8acc-b1efd554f7b9	766	857	23746709-2977-44a8-91d1-f296b3da80ef
252	DEBIT	Nike Dinner	-1000	USD	2016-03-17 20:00:00-04	2016-06-14 14:14:21.805-04	14	31	26	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1000	62	6ee48c71-0f0b-4cd8-b3c1-ad7860c9cdf5	766	857	499ddc16-98b2-4714-a19d-b45139375623
571	DEBIT	Connect Conference video footage review	-2948	USD	2016-05-16 20:31:54.682-04	2016-06-14 14:14:22.053-04	14	31	26	\N	\N	\N	\N	\N	\N	\N	\N	\N	-2948	167	79e8eb4f-159b-4d98-8bae-afc1989a3e44	766	857	c1ad4546-9866-4429-9480-bdf3cc03f4d0
249	DEBIT	WwConnect planning meeting	-4656	USD	2016-03-10 19:00:00-05	2016-06-14 14:14:21.794-04	14	31	26	\N	\N	\N	\N	\N	\N	\N	\N	\N	-4656	59	a8e050d7-a0ba-4b7c-8dac-f15e091454e1	766	857	df0326d4-91e9-48e8-b40f-89c0e381afaf
1402	DEBIT	Monthly core team lunch with Sandra Saranya Sara CiCi Tori (5 members) ; on boarding new core member Tori!	-10294	USD	2016-08-02 09:38:05.215-04	2016-08-02 09:38:05.831-04	14	31	320	\N	\N	\N	\N	\N	\N	\N	\N	\N	-10294	255	3a3bfae0-f068-407d-a9ab-031441913c3a	766	857	44111c28-a19e-4f46-a1a6-c8fbebfcd835
69	CREDIT	Donation to WWCode Mexico City	500	MXN	2016-02-02 11:52:02.237-05	2016-04-16 16:40:58.703-04	10	80	42	\N	\N	68	1	2	16	USD	18.5100000000000016	27	148	\N	26a163a5-8959-4ab4-bef5-3d07360183e6	768	857	162eaed6-d5c5-4e6f-b056-45a5e46015df
282	CREDIT	Recurring subscription	500	MXN	2016-04-02 16:10:38.206-04	2016-04-02 16:10:38.242-04	10	80	42	2016-04-07 16:10:38.206-04	\N	68	\N	\N	\N	\N	\N	\N	\N	\N	8cc3139c-729d-497c-9aa9-1c6aba7f53bb	768	857	56e71cc3-2e35-4016-9aea-47125f2692ce
10343	CREDIT	Mathews Group 	60000	USD	2016-11-29 16:45:09.136-05	2016-11-29 16:45:09.136-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	60000	60000	\N	f0762b2f-b60e-4ff6-95db-915b64364dcf	14	857	62b63039-d1da-4b28-8644-64019c1528b2
10344	CREDIT	Meetup Fees	6000	USD	2016-12-28 11:25:48.743-05	2016-12-28 11:25:48.743-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	664	4da13541-489f-45a0-b9ff-c6c2296313fd	48	857	4061a6d3-2cf5-4e89-9bc0-c39e5b4c518d
10345	CREDIT	Google I/O Travel Stipend	100000	USD	2017-05-16 18:00:40.275-04	2017-05-16 18:00:40.275-04	696	142	\N	\N	\N	\N	\N	\N	0	USD	1	100000	100000	1088	145a5415-180c-4282-b969-6be60d80197f	48	857	b12ff197-f82a-4b21-93bd-ae73e78c995b
10346	CREDIT	Drinks (La Croix water) for Jan HackNight	2093	USD	2017-01-25 13:41:33.613-05	2017-01-25 13:41:34.163-05	696	142	1476	\N	\N	\N	\N	\N	\N	\N	1	2093	2093	724	1385bbfd-91eb-4f98-992e-2291bfb07508	48	857	ecc4a5bc-754c-4f7c-b949-4c478ba6ef31
10347	CREDIT	Amazon Echo Dot devices for HackNight and first book for our book club.	22137	USD	2017-01-25 13:44:31.311-05	2017-01-25 13:44:33.251-05	696	142	1718	\N	\N	\N	\N	\N	\N	\N	1	22137	22137	725	72c8772f-dce8-45e3-95c1-306f6b558776	48	857	3b0451fd-5b57-48df-9d25-90c838ad7381
10348	CREDIT	Snacks and batteries for our robots	1554	USD	2017-05-16 18:00:04.449-04	2017-05-16 18:00:04.449-04	696	142	\N	\N	\N	\N	\N	\N	0	USD	1	1554	1554	1084	9c4ccbff-d33d-4301-a8f5-861ed2be6cdc	48	857	c76a72ad-6125-47f4-889e-328ae399f8aa
10349	CREDIT	Business cards and stickers	11948	USD	2017-05-16 18:00:30.412-04	2017-05-16 18:00:30.412-04	696	142	\N	\N	\N	\N	\N	\N	0	USD	1	11948	11948	1007	cc1ac6f4-8721-4d91-aee9-be6632ee7e83	48	857	ef1a471d-df58-45ec-8330-18aecccca84a
10350	CREDIT	Supplies for decorating our robots	9777	USD	2017-05-16 18:00:15.557-04	2017-05-16 18:00:15.557-04	696	142	\N	\N	\N	\N	\N	\N	0	USD	1	9777	9777	1085	190c7a10-a99e-4b1a-aa3e-60cde4d0459f	48	857	686c11a5-681c-42aa-ac23-d1a878b2ba2b
10351	CREDIT	Travel stipend to attend the Google I/O 2017 Conference.	107430	USD	2017-03-31 18:33:59.707-04	2017-03-31 18:33:59.731-04	698	1344	2321	\N	\N	\N	\N	\N	7430	USD	1	107430	100000	962	400b9135-2265-4829-a65a-6bd9832ee852	286	857	e560cd88-e067-4bca-939f-c3f8828ccfce
10353	CREDIT	Food for Anniversary Reception	713	USD	2016-12-07 00:00:00.86-05	2016-12-07 00:00:00.86-05	843	1325	\N	\N	\N	\N	\N	\N	\N	\N	1	713	700	492	ccbfcda4-fdf2-463f-87fc-1c576708bda0	273	857	4e6a3cd2-8570-4a56-b347-cf4177845f69
10342	CREDIT	Banner	2000	USD	2016-11-29 18:07:15.153-05	2016-11-29 18:07:15.39-05	51	3	\N	2017-10-26 17:24:06.373-04	\N	\N	\N	\N	\N	\N	1	\N	2000	\N	accb71c2-2fc4-4aed-a911-c55d3339a635	\N	857	1b8b648c-0528-4b6f-a68e-94f822da6e5d
10352	DEBIT	Banner	-2000	USD	2016-11-29 18:07:15.153-05	2016-11-29 18:07:15.39-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-2000	-2000	\N	014ce5ba-ab0b-4e32-b1a1-f8df048aca77	289	857	1b8b648c-0528-4b6f-a68e-94f822da6e5d
10365	CREDIT	meetup with speaker, Heather VanCura, in conjunction with DevNexus conference	21588	USD	2017-03-14 13:22:10.666-04	2017-03-14 13:22:10.681-04	762	70	1893	\N	\N	\N	\N	\N	638	USD	1	21588	20950	899	01d0ac70-8cb3-456a-8510-719fa5688c27	12	857	9eec12b6-ad3b-43af-9210-3a6e030240ca
10368	CREDIT	April 7 South Hack Night	5037	USD	2016-05-22 19:46:04.647-04	2016-06-14 14:14:22.083-04	847	28	26	\N	\N	\N	\N	\N	\N	\N	1	5037	5037	180	6f19151e-5857-4bf0-8170-af86383cd5f4	2	857	b1cf353a-7fc6-4330-97be-4917a77e0f21
10369	CREDIT	April 4 Lightning Talks	13315	USD	2016-05-22 19:46:04.647-04	2016-06-14 14:14:22.091-04	847	28	26	\N	\N	\N	\N	\N	\N	\N	1	13315	13315	183	d7eb6c67-cb6e-43c0-9c6c-ee08e3d751d5	2	857	b1c0a6ec-c31e-4048-87e6-29f63aefb551
10382	CREDIT	Connect Conference video footage review	2948	USD	2016-05-16 20:31:54.682-04	2016-06-14 14:14:22.053-04	766	31	26	\N	\N	\N	\N	\N	\N	\N	1	2948	2948	167	5a111872-6b34-4a85-998c-9830379782e3	14	857	c1ad4546-9866-4429-9480-bdf3cc03f4d0
10558	DEBIT	\N	-1480	USD	2017-04-18 20:39:23.15-04	2017-04-18 20:39:23.15-04	857	3	\N	\N	\N	2508	0	\N	0	USD	1	-1480	-1480	\N	ca556be1-6a37-4340-8b0a-1e9b19bcdcc2	14	857	6c345928-6909-4573-b954-4dc6d2c97d2f
10562	CREDIT	\N	1480	USD	2017-04-18 20:20:11.527-04	2017-04-18 20:20:11.527-04	51	3	\N	2017-10-26 17:24:06.975-04	\N	2506	\N	\N	\N	USD	1	1480	1480	\N	7154820a-702c-4a3a-82df-9761b0115fb5	\N	857	7f4c5806-3bed-4438-8463-e948e8845912
10595	CREDIT	WOMEN TECHMAKER WWCODE PARTNERSHIP GRANT	34750	USD	2016-05-26 16:50:28.413-04	2016-05-26 16:50:28.721-04	51	3	\N	2017-10-26 17:24:06.722-04	\N	\N	\N	\N	\N	\N	1	\N	34750	\N	ceaf5a2d-b812-4c2a-b210-5fd8727b380c	\N	857	52559260-4928-4453-a298-1b9dfd7cc130
10586	CREDIT	\N	9000	USD	2017-04-17 15:41:07.659-04	2017-04-17 15:41:07.659-04	51	3	\N	2017-10-26 17:24:06.774-04	\N	2471	\N	\N	\N	USD	1	9000	9000	\N	d93977ce-7384-44ab-bb08-55c2a12e5324	\N	857	5f01413a-6b5f-459a-b41a-776a15f63674
10590	CREDIT	International Women's Day Celebrations - Global	51750	USD	2017-03-28 14:27:16.525-04	2017-03-28 14:27:16.748-04	51	3	\N	2017-10-26 17:24:07.206-04	\N	\N	\N	\N	\N	\N	1	\N	51750	\N	1c8fe196-7c93-4170-bfcd-ac5297710dd7	\N	857	b388fa32-3126-4935-91b9-5f99dbb394eb
10598	DEBIT	International Women's Day Celebrations - Global	-51750	USD	2017-03-28 14:27:16.525-04	2017-03-28 14:27:16.748-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-51750	-51750	\N	9551ae0c-11e1-4c09-843f-7296323a3a52	12	857	b388fa32-3126-4935-91b9-5f99dbb394eb
10610	DEBIT	\N	-100000	USD	2017-03-27 13:52:38.123-04	2017-03-27 13:52:38.123-04	857	3	\N	\N	\N	2153	0	\N	0	USD	1	-100000	-100000	\N	61013c86-3c26-4747-b88f-40c84d921fdd	277	857	0082b1d9-f1eb-4a91-b6d5-031794faaf9b
10593	DEBIT	\N	-9000	USD	2017-04-17 15:41:07.659-04	2017-04-17 15:41:07.659-04	857	3	\N	\N	\N	2471	0	\N	0	USD	1	-9000	-9000	\N	fa79c2cb-39a7-4a30-b0ed-af885989282a	277	857	5f01413a-6b5f-459a-b41a-776a15f63674
10597	CREDIT	Women Techmaker WWCode Partnership Grant	70000	USD	2016-05-19 15:17:47.24-04	2016-05-19 15:17:48.401-04	51	3	\N	2017-10-26 17:24:06.607-04	\N	\N	\N	\N	\N	\N	1	\N	70000	\N	c5a5b150-c3ca-4622-a310-b5bd8141e23f	\N	857	3ebbb089-0d33-4b3e-af32-8b2a03b576ad
10603	CREDIT	Quotient Hackathon support	90000	USD	2016-10-07 15:52:59.206-04	2016-10-07 15:52:59.391-04	51	3	\N	2017-10-26 17:24:07.45-04	\N	\N	\N	\N	\N	\N	1	\N	90000	\N	c9d3f390-5910-4d6a-b004-648afa28a218	\N	857	deef5358-a3c6-4bce-8b9b-a3f815f6e8f7
10599	DEBIT	Women Techmaker WWcode Partnership Grant	-100000	USD	2016-05-24 16:23:16.28-04	2016-05-24 16:23:16.552-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-100000	-100000	\N	92fe0705-0dbb-4269-bd13-e42b03532396	3	857	e60fe9c9-3dc1-4342-8c92-af3e180264f5
10618	DEBIT	\N	-90000	USD	2017-05-11 12:41:16.759-04	2017-05-11 12:41:16.759-04	857	3	\N	\N	\N	2794	0	\N	0	USD	1	-90000	-90000	\N	39b2c87d-91a4-48a8-908d-4ec8f1783e33	59	857	19be5c14-eec7-42c1-82d0-8d9429e3df0e
10612	DEBIT	Event sponsorship - transaction fees and global development 	-856500	USD	2017-03-02 01:00:43.46-05	2017-03-02 01:00:44.182-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-856500	-856500	\N	3dbfe704-73ee-4cb7-ae77-9fa8535761fb	12	857	c7af087e-a4d3-4392-83a6-4fb404e8bb2f
10810	DEBIT	Global Development for Meetup Fee	-5700	EUR	2016-12-27 11:34:45.59-05	2016-12-27 11:34:45.771-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-5700	-5700	\N	ae68663c-8031-4e3d-8a02-46b1c404d176	298	857	36493410-978b-4ea4-a1d4-bec57607bfd2
10801	CREDIT	WOMEN TECHMAKER WWCODE PARTNERSHIP GRANT	80000	USD	2016-05-31 14:01:08.532-04	2016-05-31 14:01:07.064-04	51	3	\N	2017-10-26 17:24:06.699-04	\N	\N	\N	\N	\N	\N	1	\N	80000	\N	65416029-7ca4-499f-8a38-34cc4cf63ad3	\N	857	4de2e61e-353d-4d8b-9288-d5b140b24ddc
10806	DEBIT	Donation - fees + global development	-1187	USD	2017-01-05 09:58:39.771-05	2017-01-05 09:58:42.205-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-1187	-1187	\N	fdd7af3c-e464-4898-a7ce-b7eb129a68a4	13	857	bc5b13ae-0c57-43c0-ac61-11325a6ee3eb
10803	DEBIT	donation - fees and global development	-798	USD	2017-01-05 09:48:24.355-05	2017-01-05 09:48:26.734-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-798	-798	\N	4e16823c-5a8a-4f64-be80-8cee5b20c703	241	857	d42220ba-3283-4df9-b63d-912e9d1220a4
10809	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-27 11:53:55.856-05	2016-12-27 11:53:55.969-05	51	3	\N	2017-10-26 17:24:07.464-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	9a10c3b0-d470-4420-835a-88ff95fe15c4	\N	857	e05f5031-9b70-4451-9b02-66209d4114b6
10816	DEBIT	Global Development for Meetup Fee	-6000	USD	2016-12-27 11:53:55.856-05	2016-12-27 11:53:55.969-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	7c283c4b-8603-422d-99ed-2186cc3e2930	275	857	e05f5031-9b70-4451-9b02-66209d4114b6
10814	DEBIT	Women Techmaker WWCode Partnership Grant	-20000	USD	2016-05-25 12:45:53.797-04	2016-05-25 12:45:54.045-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-20000	-20000	\N	4a978565-6e31-4682-9e6f-97da9a04a12a	48	857	4e16210d-0b35-44aa-9b79-6ce838d01d19
10819	DEBIT	Stephen	-450	USD	2016-11-29 17:55:31.534-05	2016-11-29 17:55:31.727-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-450	-450	\N	aa506335-0d57-4cab-bb63-786a00c2a6ad	273	857	a611b04a-de08-4000-bcab-e4207926a18c
10831	DEBIT	Recurring subscription	-52	USD	2016-05-02 18:49:03.545-04	2016-05-02 18:49:03.612-04	819	8	45	\N	\N	71	5	\N	33	USD	1	-52	-100	\N	0cca5f76-d5da-43cd-a25c-f63d53f07798	14	857	2fd4c03e-6ff8-4e17-9d2e-d132f29985d1
10837	DEBIT	Donation to WWCode Austin	-123120	USD	2016-06-06 15:04:37.186-04	2016-06-06 15:04:37.308-04	781	551	377	\N	\N	312	7500	\N	4380	USD	1	-123120	-150000	\N	98776c83-e5f3-4c0d-997b-f34a768ef6af	2	857	41065c49-be6f-424d-aae0-69d53a3a2966
10836	DEBIT	Network budget pre Open Collective	-6264	USD	2016-10-04 18:51:25.324-04	2016-10-04 18:51:26.129-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6264	-6264	\N	c4f1c604-5dec-4f4c-8b26-ca81157d050a	260	857	b3b7cddb-5541-4350-aa77-e409abe2c332
10843	DEBIT	Recurring subscription	-52	USD	2016-04-02 15:27:54.641-04	2016-04-16 16:40:58.809-04	691	30	44	\N	\N	70	5	\N	33	USD	1	-52	-100	\N	0db54b02-b61c-4356-97a8-6d84abc5ac5b	13	857	5b5cbeaf-330a-490c-8de5-2ee11cc01701
10834	DEBIT	Donation from Adane	-450	USD	2016-10-04 18:56:11.881-04	2016-10-04 18:56:13.02-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-450	-450	\N	db085303-da39-4c8e-83b1-e1be6465419c	260	857	ab5f91b2-7715-4e57-9c27-9b2ade14b176
11019	CREDIT	Turner Matching Donation	5000	USD	2016-10-04 11:46:59.013-04	2016-10-04 11:46:59.134-04	51	3	\N	2017-10-26 17:24:07.134-04	\N	\N	\N	\N	\N	\N	1	\N	5000	\N	74c1bd36-2a04-4b76-a40d-c231648fc2e9	\N	857	a3bb1b9b-64ed-4520-bedf-2c0d26e816ae
11041	CREDIT	Mugs for WWCode-SV	46419	USD	2016-12-20 13:57:28.399-05	2016-12-20 13:57:28.525-05	706	1374	1476	\N	\N	\N	\N	\N	\N	\N	1	46419	46419	605	0c2e0a94-4404-4f17-8047-504e1f42d460	300	857	f8577610-f98d-4749-bbd1-64ce039f6d95
11044	DEBIT	Recurring subscription	0	MXN	2016-03-15 16:05:22.15-04	2016-04-01 10:32:17.381-04	821	7	64	2016-04-07 10:32:17.381-04	\N	83	5	\N	\N	\N	1	0	-100	\N	62174fa7-e32f-4fb9-b5ae-227a4315cf29	10	857	360dd806-a90b-41b9-82f1-5431b04691d0
11051	CREDIT	Jasna Rodulfa	1000	USD	2016-04-15 10:17:21.126-04	2016-04-16 16:40:58.829-04	51	3	\N	2017-10-26 17:24:06.989-04	\N	\N	\N	\N	\N	\N	1	\N	1000	\N	1c029006-e1b5-4b36-b43f-57bf82a5903a	\N	857	837bc99b-e49c-44eb-8acf-f4cf9199bfff
11071	DEBIT	Women Who Code Atlanta &amp; DevNexus Soirée global networks support	-1450	USD	2017-03-13 13:06:48.459-04	2017-03-13 13:06:51.099-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-1450	-1450	\N	81c1885d-5dbe-4d9b-b4a9-1c993f0d6fc1	51	857	bd495fef-c3fa-493d-bf0c-0c19d90890f6
11244	CREDIT	Conference Grant	15000	USD	2016-05-24 15:42:50.307-04	2016-06-14 14:14:22.103-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	15000	15000	188	16be9f3f-f9df-4633-9cfb-b1c9016df419	13	857	002f6bbf-1145-4646-82b1-e4754041f1ce
11246	CREDIT	Gift for organizer	3499	USD	2016-10-31 17:14:38.997-04	2016-10-31 17:14:39.22-04	51	3	1043	\N	\N	\N	\N	\N	\N	\N	1	3499	3499	\N	eda39de5-0441-40f8-a613-63d156bebdd0	2	857	99a909aa-1e39-4cf3-ba33-3562e168a8df
11249	CREDIT	Global Developement	150	USD	2016-04-12 14:46:49.263-04	2016-06-14 14:14:21.849-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	150	150	79	a15afd54-bdc4-4770-8847-93260ee49c0f	4	857	efd26028-8d84-45f0-931d-a250e37f61f0
11252	CREDIT	Global Development	150	USD	2016-04-27 12:21:00.228-04	2016-06-14 14:14:21.907-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	150	150	103	af77a499-eb1f-49e4-9f8a-6386d044dd0b	48	857	440c09f2-0c1c-479a-b306-ef0e3bd63713
11262	CREDIT	Meetup Fees	6000	CAD	2016-12-28 11:30:16.279-05	2016-12-28 11:30:16.279-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	666	8924995f-5c3c-4422-9760-c5a0bf5cbb58	293	857	8cd5440a-20c7-409f-b25f-8ce6e35e6e24
11265	CREDIT	Meetup Fees	6000	USD	2016-12-27 12:27:09.602-05	2016-12-27 12:27:09.602-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	644	bf451483-c5cf-410b-90d6-d15c2d9d1874	279	857	638f3084-99dc-4c53-b98d-e8036efe6e6d
11276	CREDIT	Libretas Hackathon	1038000	MXN	2016-02-16 13:56:17.216-05	2016-06-14 14:14:21.738-04	821	7	\N	2016-06-14 14:14:22.435-04	\N	\N	\N	\N	\N	\N	1	1038000	1038000	33	34110d44-bd54-4636-b6b0-b42cefe09a27	10	857	a9a5c0e7-c175-43d4-acc9-e05e7d34fe2b
11278	CREDIT	dinner - downpament	70000	USD	2016-11-03 15:36:06.461-04	2016-11-03 15:36:06.793-04	51	3	1115	\N	\N	\N	\N	\N	\N	\N	1	70000	70000	\N	11fdf4e8-ea7c-4df2-934a-c59b1e6328ab	300	857	a7898ab3-a225-4d98-95c9-2b9efff35095
11281	CREDIT	Banner	2000	USD	2016-11-29 18:07:29.03-05	2016-11-29 18:07:29.148-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	2000	2000	\N	ace77f30-94ef-4ba3-b17b-8218b6517899	289	857	feb8c4c0-4959-4958-838a-e395d9a84f3a
11284	CREDIT	Conference stipend - Gen A.	102409	GBP	2016-10-07 09:10:14.088-04	2016-10-07 09:10:14.841-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	102409	102409	\N	787e3376-9697-4439-921b-d2e07de28d13	278	857	a33b56d4-b70a-48da-8195-4b33c9411c39
11291	CREDIT	Pizza for July monthly event.	12555	USD	2016-08-16 10:52:47.781-04	2016-08-16 10:52:47.799-04	51	3	573	\N	\N	\N	\N	\N	\N	\N	1	12555	12555	\N	3a8bd699-fd23-47e2-a019-8ff6f6d2ff43	15	857	c396dfb2-7468-4b99-b2cf-bad02ac60074
11294	CREDIT	Reimburse Caterina Paun for supplies and mailing expenses	5504	USD	2015-12-14 19:00:00-05	2016-06-14 14:14:22.175-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	5504	5504	225	9a59f85e-789f-4571-8a0e-47c8e1d9c930	59	857	da5ca971-c441-4fb8-921a-2dac66e75731
11297	CREDIT	Stacey Schipper Reimbursement	2322	USD	2016-04-17 18:19:12.094-04	2016-06-14 14:14:21.873-04	51	3	\N	2016-06-14 14:14:22.471-04	\N	\N	\N	\N	\N	\N	1	2322	2322	92	17d481fa-7924-4f6c-b349-773caa2c9096	15	857	f385e73e-5e24-4546-94ff-467f7125439a
11300	CREDIT	Google i/o travel stipend for Yelyzaveta (plus $12 transfer fees)	101200	USD	2017-05-04 15:06:09.002-04	2017-05-04 15:06:09.002-04	51	3	\N	\N	\N	\N	\N	\N	0	USD	1	101200	101200	1099	7391b9f0-6175-4479-8138-1834b3c29e71	430	857	380e1d53-f225-4438-9035-781b0f86487e
11309	CREDIT	90/10 split: Beth Laing	500	USD	2016-10-04 12:06:09.85-04	2016-10-04 12:06:09.85-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	500	500	391	0113df07-7599-4746-b993-ec562b8fcfcf	12	857	48d72bb3-6864-4254-a44a-53b77c9b2e6e
11313	CREDIT	Minimum Fee - May	1000	USD	2016-08-16 10:55:31.274-04	2016-08-16 10:55:31.288-04	51	3	573	\N	\N	\N	\N	\N	\N	\N	1	1000	1000	\N	cd773be9-c6c0-4837-8f0a-9f489df88d55	59	857	fb8f2b21-7b61-4fc3-bcc7-189c4497d466
11323	DEBIT	Recurring subscription	-8250	USD	2016-08-03 13:47:25.319-04	2016-08-03 13:47:25.429-04	759	896	571	\N	\N	498	500	\N	250	USD	1	-8250	-10000	\N	e6b68975-c2cb-40ce-874d-dedcbbc00c7f	4	857	2aaeb780-e8ed-41cd-8766-3a919cf47294
11326	DEBIT	Recurring subscription	-798	USD	2016-12-09 23:43:00.244-05	2016-12-09 23:43:00.244-05	737	1158	731	\N	\N	647	50	\N	52	USD	1	-798	-1000	\N	8db5adc6-96b1-4481-b87a-dd9d070212a4	241	857	41726545-78af-468d-bd29-50b8e2200e53
11328	DEBIT	Recurring subscription	-798	USD	2016-10-10 00:49:33.558-04	2016-10-10 00:49:33.558-04	737	1158	731	\N	\N	647	50	\N	52	USD	1	-798	-1000	\N	3a44ede6-8937-493b-8c1f-77b5044df326	241	857	ca0a26b5-292a-4fa9-a365-fdf37d1cce9a
11337	CREDIT	Stacey Schipper	2322	USD	2016-11-03 15:45:04.691-04	2016-11-03 15:45:04.691-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	2322	2322	\N	4e4ba66c-4ec1-42cd-9963-36f698440525	15	857	25d8ac03-2aff-4d45-999f-a4cee1cb9288
11338	CREDIT	More stickers to give away at events	18800	USD	2016-11-03 15:14:58.094-04	2016-11-03 15:14:58.245-04	51	3	1044	\N	\N	\N	\N	\N	\N	\N	1	18800	18800	\N	e0bce92d-bd9a-49d1-bc1c-eea1db7b6bda	13	857	3c6ad6eb-35a2-4776-a262-a4e6dc6681af
11341	DEBIT	\N	-24450	USD	2016-11-22 10:22:39.097-05	2016-11-22 10:22:39.097-05	701	1846	1211	\N	\N	1129	1500	\N	1050	USD	1	-24450	-30000	\N	082ed931-a71c-4cdb-9011-4764bd141a66	59	857	16143471-3587-4fa6-9c25-d8764c0aefd5
11348	DEBIT	\N	-41370	USD	2016-11-17 12:43:29.797-05	2016-11-17 12:43:29.797-05	708	1808	1179	\N	\N	1098	2500	\N	1130	USD	1	-41370	-50000	\N	f52472b1-efea-41e1-bd48-40089873582a	59	857	009ab8e6-2d5c-4c54-9e5f-8846f5e4a45c
11256	CREDIT	Test	1000	USD	2016-10-11 12:18:39.252-04	2016-10-11 12:18:39.252-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	1000	1000	413	e0842867-7659-40f4-bcc5-4359f1d042a8	195	857	9dfd16f1-5bf5-4ed4-9311-92ad99941f5c
11258	CREDIT	CONNECT 2016	2452	USD	2016-04-25 20:00:00-04	2016-06-14 14:14:21.896-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	2452	2452	99	421a23ec-becc-44e2-b4ec-8dea33ecc5a2	14	857	48f23cab-3d30-45d1-9e49-caa7873663f8
11306	CREDIT	Wine	1647	USD	2016-10-31 17:15:06.269-04	2016-10-31 17:15:06.517-04	51	3	1043	\N	\N	\N	\N	\N	\N	\N	1	1647	1647	\N	f8ec97e1-9cdc-433d-9125-bccbf45dc489	2	857	54094469-384f-4b0f-89f1-7939f95946a5
11293	CREDIT	Food for Denver Meetup	9939	USD	2016-08-16 10:52:04.669-04	2016-08-16 10:52:04.682-04	51	3	573	\N	\N	\N	\N	\N	\N	\N	1	9939	9939	\N	b3bc98f6-6abe-4a29-95a8-62a3e22d4301	15	857	091375f0-9182-4258-99f3-57baf5815d34
11298	CREDIT	Meetup Donation Transaction Fee	163	USD	2016-04-12 14:52:16.188-04	2016-06-14 14:14:21.849-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	163	163	81	2766976e-cf29-45a4-9ba0-58ce42a3deda	4	857	5879dbd1-cd2e-4576-ac1d-2f73354d4e41
11299	CREDIT	Meetup Fee	6000	USD	2016-12-27 11:52:46.242-05	2016-12-27 11:52:46.242-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	640	7008907a-cbe0-4fe4-840e-f31bc4207501	274	857	a2041762-00d6-4e22-b190-144fa23a05ef
11303	CREDIT	Regional Leadership Director Training	631	USD	2016-11-29 17:38:46.551-05	2016-11-29 17:38:46.748-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	631	631	\N	baa6f210-e068-4b44-bd4b-dfef38b3b6e3	47	857	15c315e9-0396-4480-b31b-f1c20773c2b3
11308	CREDIT	Career development event w/ Mike Ross	65000	USD	2016-10-11 20:42:04.584-04	2016-10-11 20:42:04.834-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	65000	65000	\N	19934b04-a77b-42e6-9864-bb16dc4d2bb6	48	857	6609d9cd-0ddf-4b70-aa36-1cd8e7fd8628
11310	CREDIT	90/10 split: Turner matching donation	500	USD	2016-10-04 12:06:02.036-04	2016-10-04 12:06:02.036-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	500	500	393	9a10b230-0db3-4108-8ce5-b0b0dcf5d3d1	12	857	f70ebd42-c070-47f3-9a5d-c756f077e41f
11321	CREDIT	Conference stipend Elizabeth M.	75000	USD	2016-10-11 12:01:27.317-04	2016-10-11 12:01:28.351-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	75000	75000	\N	134587f9-ee40-4c39-a852-786ef5439c7c	195	857	a9a72f45-418d-418e-8680-ff173e59c486
11324	DEBIT	\N	-786	CAD	2017-05-10 19:45:46.737-04	2017-05-10 19:45:46.737-04	747	4749	2888	\N	\N	2783	36	\N	46	USD	1.39860139860140009	-562	-1000	\N	e124030f-6599-40e0-9f3d-a76fade6aedb	522	857	4642def7-c279-4afa-88fc-4ef64d6ca6ad
11331	DEBIT	monthly recurring subscription	-798	USD	2017-03-09 23:43:47.943-05	2017-03-09 23:43:47.943-05	737	1158	731	\N	\N	647	50	\N	52	USD	1	-798	-1000	\N	dc687c3a-c92a-4e48-a394-c68bbf692fff	241	857	c4657e5c-5711-492e-b76e-be7a08b76b18
11335	CREDIT	Meetup Fees	6000	USD	2016-12-27 14:46:50.958-05	2016-12-27 14:46:50.958-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	655	3bb7d44a-90c5-45ca-be22-6f7ac41ee42e	287	857	d336c33f-b9ab-4291-a295-3f4b779aabdf
11345	DEBIT	\N	-2040	USD	2016-12-18 20:42:01.104-05	2016-12-18 20:42:01.104-05	700	2220	1472	2016-12-27 19:00:00-05	\N	1389	125	\N	85	USD	1	-2040	-2500	\N	8add5153-aebc-4e93-8579-7bed801437cf	259	857	649359ac-33cf-459e-8e52-ab809d804d32
11350	DEBIT	Recurring subscription	-52	USD	2016-04-02 11:43:33.706-04	2016-04-16 16:40:58.808-04	704	126	93	\N	\N	95	5	\N	33	USD	1	-52	-100	\N	c199e4a2-1fe4-4dda-af77-47f626b2bde5	13	857	ecc81650-5abb-4ea3-a8a0-671ae192e6ff
11354	CREDIT	Leadership meeting	2989	USD	2017-05-16 17:59:48.206-04	2017-05-16 17:59:48.206-04	696	142	\N	\N	\N	\N	\N	\N	0	USD	1	2989	2989	1086	780fca23-2ffc-42cf-8749-d93b174cf078	48	857	49506772-47a7-4bda-ac44-72d9889dc01d
2238	DEBIT	90/10 split: Turner matching donation	-500	USD	2016-10-04 12:06:02.036-04	2016-10-04 12:06:02.036-04	12	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-500	393	9fcd3132-9867-42dc-85ce-b7435cb35563	51	857	f70ebd42-c070-47f3-9a5d-c756f077e41f
11311	CREDIT	Global Development	250	USD	2016-04-17 18:19:12.094-04	2016-06-14 14:14:21.883-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	250	250	96	bef684fd-5fcf-443a-a384-ba8b0f2db051	48	857	70f6daf9-d2b4-461d-a1f8-bd3f3ee7abd0
11314	CREDIT	Minimum Fee - June	995	USD	2016-08-16 10:55:14.822-04	2016-08-16 10:55:14.844-04	51	3	573	\N	\N	\N	\N	\N	\N	\N	1	995	995	\N	10be9a9e-69ee-49b5-9928-287aa1f56a2d	48	857	37966e83-c6f7-4d12-9e5b-0611869d42a1
11318	CREDIT	Global Development	5000	USD	2016-02-21 19:00:00-05	2016-06-14 14:14:22.186-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	5000	5000	227	e70d86b3-b4a0-4296-a1dd-9ccd8f9d2f42	59	857	5009c152-5893-4b8d-b81f-9faea4d25f2f
11320	CREDIT	FedEx Office	3418	USD	2016-01-24 19:00:00-05	2016-06-14 14:14:22.114-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	3418	3418	195	71d2b3f2-b542-4c18-9950-e9928cdd1443	48	857	77ce5fd6-b1b4-4dc1-b5b3-8ea90a872ffa
11327	DEBIT	Recurring subscription	-798	USD	2016-11-09 23:43:57.271-05	2016-11-09 23:43:57.271-05	737	1158	731	\N	\N	647	50	\N	52	USD	1	-798	-1000	\N	321421be-ecdd-47e1-93cf-7213508c6fb7	241	857	ace3724d-b7c6-40ed-bfed-788bdc8013ae
11329	DEBIT	Recurring subscription	-798	USD	2017-01-09 23:43:19.956-05	2017-01-09 23:43:19.956-05	737	1158	731	\N	\N	647	50	\N	52	USD	1	-798	-1000	\N	e6907921-fbef-4fa4-a5c1-3bc843a8d6b8	241	857	14a63038-480b-425f-b37c-014aab4d0558
11332	DEBIT	Donation to WWCode Austin	-41020	USD	2016-05-19 15:24:43.134-04	2016-05-19 15:24:43.182-04	718	392	288	\N	\N	246	2500	\N	1480	USD	1	-41020	-50000	\N	185e1ad3-fd1f-4bf9-a005-2d67f15cf219	2	857	fbccd6fd-8bb4-4e27-8932-b83552f4bbb7
11336	CREDIT	TShirts	145786	USD	2016-11-21 16:26:37.469-05	2016-11-21 16:26:37.469-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	145786	145786	\N	a7268c43-81aa-40c0-9e2e-482f08bd9a3e	59	857	4e4c6f95-2e2b-442f-b3f6-e0e41acca065
11339	CREDIT	Cash for Prizes/Bartender	50000	USD	2016-11-03 15:12:34.941-04	2016-11-03 15:12:35.306-04	51	3	1044	\N	\N	\N	\N	\N	\N	\N	1	50000	50000	\N	32af4fc3-26af-416e-820b-fda17fb4bce7	2	857	1a8e90e3-9f3f-4ecb-ac3d-4b9cb2664cca
11343	DEBIT	\N	-41370	USD	2017-01-16 13:03:56.108-05	2017-01-16 13:03:56.108-05	699	2561	1622	\N	\N	1537	2500	\N	1130	USD	1	-41370	-50000	\N	b66614ce-6f3c-4d4c-b16b-41bb17c07b7e	48	857	cc4aab78-8a98-4bb1-9b5a-3f68221cd3cc
11346	DEBIT	\N	-2040	USD	2016-12-18 20:41:29.006-05	2016-12-18 20:41:29.006-05	700	2220	1471	\N	\N	1388	125	\N	85	USD	1	-2040	-2500	\N	9ce6bb90-a6ae-4010-9a3b-52ada94ac8ac	259	857	92278c96-a40f-40ed-b9c0-9ec0ec0de445
11353	DEBIT	Recurring subscription	-52	USD	2016-05-02 01:44:10.046-04	2016-05-02 01:44:10.072-04	704	126	93	\N	\N	95	5	\N	33	USD	1	-52	-100	\N	f219141e-4135-48e8-959a-d56607d98f8c	13	857	d5ddd594-035b-4ac0-80da-e0d2e6ebf9c0
376	DEBIT	Global Development	-250	USD	2016-04-17 18:19:12.094-04	2016-06-14 14:14:21.883-04	48	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-250	96	ee258704-7659-4305-bd34-807117acf1d4	51	857	70f6daf9-d2b4-461d-a1f8-bd3f3ee7abd0
5018	CREDIT	WWCode t-shirt sales	1599	USD	2017-01-17 22:21:50.791-05	2017-01-17 22:21:50.964-05	271	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1599	\N	d2873b77-1ea2-48e6-894b-a460b9462b1f	857	857	c8dddb45-6054-43f7-bb24-3657f6a6c099
2338	CREDIT	VMWare Network Support	195000	USD	2016-10-07 15:55:50.273-04	2016-10-07 15:55:50.509-04	300	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	195000	\N	e0aedba4-c471-4406-bc4c-480b6388a75d	857	857	97707c38-f8a1-426a-b667-3ca0b244e275
451	CREDIT	Donation to WWCode Washington DC	50000	USD	2016-04-29 09:51:19.1-04	2016-04-29 09:51:19.15-04	13	303	216	\N	\N	183	2500	5000	1480	USD	1	50000	41020	\N	12d109fa-91c8-4a65-8547-f954d2767714	808	857	4116469f-7fe8-4feb-a26a-689b9129302f
128	CREDIT	Recurring subscription	100	USD	2016-03-02 13:19:33.362-05	2016-04-16 16:40:58.737-04	13	30	43	\N	\N	69	5	10	33	USD	1	100	52	\N	9b592cfc-6e21-487e-9471-b7491af84c89	691	857	ab990239-75f9-4046-8d2e-acda04d6b3a2
985	CREDIT	Donation to WWCode San Francisco	100	USD	2016-06-21 12:05:01.251-04	2016-06-21 12:05:01.296-04	4	642	431	\N	\N	360	5	10	32	USD	1	100	53	\N	2db86e58-3d86-4dc5-80ff-58f5fc7984a7	775	857	53f20902-609c-470d-a9bd-ae1c424341e8
4261	CREDIT	Global Development for Meetup Fee	5700	EUR	2016-12-23 12:13:39.369-05	2016-12-23 12:13:39.507-05	301	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	5700	\N	6f1c4879-9600-446e-b8b1-7c4ca6b64662	857	857	21271fa5-951c-4861-b772-f6e8ce65e9c7
6883	CREDIT	Leadership Development	50616	MXN	2017-03-07 08:01:15.044-05	2017-03-07 08:01:15.192-05	282	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	50616	\N	aaecc386-1923-482a-835a-4662c8858bc3	857	857	2a314ccf-4834-4554-9652-f600bfca92f7
9695	CREDIT	\N	150000	USD	2017-05-03 13:32:39.653-04	2017-05-03 13:32:39.653-04	12	3	\N	\N	\N	2693	0	0	0	USD	1	150000	150000	\N	839c847a-30e8-463a-912f-a6845435eca0	857	857	34557504-56f0-4ef5-9911-16f0a3ef1d1b
3203	CREDIT	$1000 CDK Global event support - transaction and global development	87000	USD	2016-11-17 13:18:40.107-05	2016-11-17 13:18:40.436-05	59	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	87000	\N	cda2e9ae-7568-4ca0-a5a6-b6e8b99fdfb4	857	857	45326c08-71aa-4059-b549-6071ea976a9e
2341	CREDIT	Network Development (100%)	10000	USD	2016-10-07 16:05:13.011-04	2016-10-07 16:05:13.112-04	300	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	10000	\N	65d47c4a-b755-49c7-b2d6-dbddfdfd421e	857	857	4c714c66-eb6d-4a0b-ae54-a487f74d93ec
4365	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-27 11:22:09.234-05	2016-12-27 11:22:09.351-05	13	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	88c4ac88-4f6e-40d9-8cdb-5eee6e9a9dee	857	857	500980b2-a929-40e7-be85-056b560978cb
2532	CREDIT	Director t-shirt	2860	USD	2016-10-17 16:55:47.647-04	2016-10-17 16:55:47.671-04	12	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2860	\N	e973ee0b-ec29-44b5-b658-5e1585b44f89	857	857	648274c2-0e47-41a9-bf23-b6d19f6a1d39
2327	CREDIT	Google I/O conference stipend	102409	GBP	2016-10-07 09:10:42.97-04	2016-10-07 09:10:43.753-04	278	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	102409	\N	7daeaf49-013c-42de-83da-86526afaea32	857	857	79ae0184-77de-4fd8-ac05-150665ff1ad2
2394	CREDIT	Conference stipend Heidi H.	50000	USD	2016-10-11 11:59:30.363-04	2016-10-11 11:59:31.524-04	195	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	50000	\N	0db54f37-f224-4eaa-ae93-e4a02bc97eef	857	857	7fa9091e-4472-4383-84e0-5d75067a1f17
4428	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-28 10:51:42.465-05	2016-12-28 10:51:38.84-05	289	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	6ed65fc3-0248-4071-bdbd-1a43018a5a2e	857	857	8c6ac988-1c07-4c7e-a395-c75367cd11d2
2412	CREDIT	Network development - thanks Atlassian	50000	USD	2016-10-11 15:30:14.934-04	2016-10-11 15:30:15.155-04	297	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	50000	\N	b3fcd677-f2e2-4f24-b35b-b81ab513f215	857	857	912773e6-b3d9-42c3-82a5-d7e45d37b780
9738	CREDIT	\N	2175	USD	2017-05-04 12:21:53.684-04	2017-05-04 12:21:53.684-04	276	3	\N	\N	\N	2710	0	0	0	USD	1	2175	2175	\N	5b429ca7-afd8-4d37-a3ad-51ca7ae6bd82	857	857	93732294-17ee-4a16-ba30-8fe00d9908b3
3598	CREDIT	Network Development	20000	USD	2016-11-30 13:40:15.233-05	2016-11-30 13:40:15.446-05	292	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	20000	\N	1d3a6593-877b-4da0-a966-c2a286127140	857	857	a1510432-66cc-4ab7-b3ea-accc3309f09d
3955	CREDIT	Priyanka - IOT Hackathon donation - fees and global development 	2175	USD	2016-12-13 15:08:29.218-05	2016-12-13 15:08:29.464-05	59	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2175	\N	3b4c5740-bddf-407f-a147-56b43886907c	857	857	b04ef486-66b0-4329-89b8-5476be49777c
2311	CREDIT	Donations via Meetup	3937	USD	2016-10-06 14:41:35.464-04	2016-10-06 14:41:35.487-04	13	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3937	\N	5b67f243-796f-46e5-b77c-c13405674c39	857	857	b57fb235-1376-480e-b3d2-76de4b7aa01e
3956	CREDIT	Donation via Meetup - fees + Global Development	1187	USD	2016-12-13 15:17:57.936-05	2016-12-13 15:17:58.19-05	272	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1187	\N	940cd510-b8a8-460d-b494-d2e4a216ad9e	857	857	bdb877f4-1d78-481d-b97e-c10817db95c0
2230	CREDIT	Conference Grant: Google/IO Alicia Carr	10000	USD	2016-10-04 11:25:59.981-04	2016-10-04 11:26:00.186-04	12	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	10000	\N	382ee140-1ddc-4000-b079-00cd1f595da2	857	857	c650bdd5-10e1-4e35-9bcf-c1d55ef47014
2244	CREDIT	Donation via Meetup	1203	USD	2016-10-04 12:46:07.882-04	2016-10-04 12:46:07.993-04	13	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1203	\N	bbbc1082-58db-4cc2-b14d-7cadc2caabe8	857	857	daca6744-f726-4565-9492-05cf0c18496f
4434	CREDIT	Global Development for Meetup Fee	6000	JPY	2016-12-28 11:00:53.27-05	2016-12-28 11:00:49.939-05	295	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	0dfc10e6-6037-41d3-a5cd-6ba9f5471978	857	857	ddee4eb8-5f86-4d0f-bf07-bc6945a18fc2
858	CREDIT	Dalia donated to WWCode SF	1500	USD	2016-06-09 14:40:21.124-04	2016-06-09 14:40:21.833-04	4	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1500	\N	ebf2964d-38ed-47f4-93dc-59fbb394dc73	857	857	ff085df0-ef20-41f4-867c-cafb8b177680
4379	DEBIT	Meetup Fees	-6000	USD	2016-12-27 11:55:07.385-05	2016-12-27 11:55:07.385-05	275	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	641	ec06bfa7-3251-4878-aa74-24f43641fa64	51	857	e9961387-4ae2-4933-ab1a-182b8e39b529
4793	CREDIT	Recurring subscription	1000	USD	2017-01-09 23:43:19.956-05	2017-01-09 23:43:19.956-05	241	1158	731	\N	\N	647	50	100	52	USD	1	1000	798	\N	2c128b7c-932b-47b7-af1a-311fa87351de	737	857	14a63038-480b-425f-b37c-014aab4d0558
9898	CREDIT	monthly recurring subscription	1000	USD	2017-05-10 00:43:13.462-04	2017-05-10 00:43:13.462-04	241	1158	731	\N	\N	647	50	100	52	USD	1	1000	798	\N	96fff2b3-0c71-4009-8d16-285415e17f66	737	857	eedd6ffb-2a7b-4eb8-87f0-a4a60dc42d39
6944	CREDIT	monthly recurring subscription	1000	USD	2017-03-09 23:43:47.943-05	2017-03-09 23:43:47.943-05	241	1158	731	\N	\N	647	50	100	52	USD	1	1000	798	\N	9b332c05-04c1-4be6-8df7-bd7246af38c4	737	857	c4657e5c-5711-492e-b76e-be7a08b76b18
616	CREDIT	Donation to WWCode Austin	50000	USD	2016-05-19 15:24:43.134-04	2016-05-19 15:24:43.182-04	2	392	288	\N	\N	246	2500	5000	1480	USD	1	50000	41020	\N	4590ecf9-25b0-4935-9570-12af202cc187	718	857	fbccd6fd-8bb4-4e27-8932-b83552f4bbb7
3590	CREDIT	\N	20000	USD	2016-11-30 11:11:42.049-05	2016-11-30 11:11:42.049-05	2	1957	1296	\N	\N	1215	1000	2000	470	USD	1	20000	16530	\N	a7479297-dc89-46e1-bbdb-c34a5e6bd385	710	857	3f99d0a5-a9c3-4865-8baf-f056d1f8531c
4408	DEBIT	Meetup Fees	-6000	USD	2016-12-27 14:50:16.992-05	2016-12-27 14:50:16.992-05	288	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	656	70608aa8-79be-468e-a263-d28237b8531a	51	857	a92116a0-3e95-4a82-9061-70b767a5005f
4406	DEBIT	Meetup Fees	-6000	USD	2016-12-27 14:46:50.958-05	2016-12-27 14:46:50.958-05	287	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	655	b66b4d98-0d80-41e7-8f34-1092f16b136c	51	857	d336c33f-b9ab-4291-a295-3f4b779aabdf
3292	DEBIT	Leadership Development Lodging	-64600	USD	2016-11-21 16:26:46.916-05	2016-11-21 16:26:46.916-05	12	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-64600	\N	96bf91be-3e65-4ccc-932d-61631b570de0	51	857	f0002f35-a096-40f5-b6f7-fa20d73971a7
3291	DEBIT	TShirts	-145786	USD	2016-11-21 16:26:37.469-05	2016-11-21 16:26:37.469-05	59	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-145786	\N	c9204456-a67b-4951-a271-157ab6819d8b	51	857	4e4c6f95-2e2b-442f-b3f6-e0e41acca065
2940	DEBIT	Stacey Schipper	-2322	USD	2016-11-03 15:45:04.691-04	2016-11-03 15:45:04.691-04	15	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-2322	\N	29073502-ed37-49ed-a06e-428e9b043bf8	51	857	25d8ac03-2aff-4d45-999f-a4cee1cb9288
2935	DEBIT	More stickers to give away at events	-18800	USD	2016-11-03 15:14:58.094-04	2016-11-03 15:14:58.245-04	13	3	1044	\N	\N	\N	\N	\N	\N	\N	\N	\N	-18800	\N	31e6e55f-79bc-4a6a-800e-81bc4f5aa825	51	857	3c6ad6eb-35a2-4776-a262-a4e6dc6681af
2934	DEBIT	Cash for Prizes/Bartender	-50000	USD	2016-11-03 15:12:34.941-04	2016-11-03 15:12:35.306-04	2	3	1044	\N	\N	\N	\N	\N	\N	\N	\N	\N	-50000	\N	fb9d785b-41ef-4c26-965c-98709813dd5f	51	857	1a8e90e3-9f3f-4ecb-ac3d-4b9cb2664cca
9408	CREDIT	monthly recurring subscription	2500	USD	2017-05-01 14:32:00.085-04	2017-05-01 14:32:00.085-04	271	2906	1804	\N	\N	1712	125	250	85	USD	1	2500	2040	\N	2fcb187e-35f4-4735-9101-698ea41ab1aa	693	857	e9e87dfa-2c96-45cf-bb92-f7ec19ee5eb7
8427	CREDIT	\N	2500	USD	2017-04-11 22:05:36.032-04	2017-04-11 22:05:36.032-04	13	4173	2546	\N	\N	2430	125	250	85	USD	1	2500	2040	\N	b9bf7bb6-c80e-4b7f-8729-f2e26f39f5e9	692	857	4a5b0659-d7d0-4f52-903a-7aaaf58f2f0f
251	DEBIT	WwConnect Conference Set Up Day 1	-709	USD	2016-03-18 20:00:00-04	2016-06-14 14:14:21.805-04	14	31	26	\N	\N	\N	\N	\N	\N	\N	\N	\N	-709	61	ebea2a47-93be-4832-8bc9-85f559270863	766	857	6903ec10-a78c-49f0-ae08-da1aa59d366d
7527	DEBIT	To redeem travel stipend to Google I/O	-100000	USD	2017-03-27 13:54:16.729-04	2017-03-27 13:54:16.758-04	277	1331	2266	\N	\N	\N	\N	\N	4430	USD	1	-100000	-104430	935	8fcc5228-26e5-41ca-8db6-80fd5ffe1d51	695	857	b15558fe-4be4-4e66-aef3-b9e9df593f88
10354	CREDIT	Food/Drinks for Anniversary Reception with guest WWCode Directors!	4444	USD	2016-12-07 00:00:00.86-05	2016-12-07 00:00:00.86-05	843	1325	\N	\N	\N	\N	\N	\N	\N	\N	1	4444	4400	486	343e9efc-501c-4fd4-8ed0-0b3a6860de74	273	857	1fc3cb43-1cac-4561-af13-847ac86cba04
10355	CREDIT	Goodie Bags	1058	USD	2016-12-07 15:49:55.814-05	2016-12-07 15:49:56.33-05	827	171	1191	\N	\N	\N	\N	\N	\N	\N	1	1058	1058	573	81b7133c-1899-430a-b1c4-f41e01404d9e	59	857	28e2dcc6-d170-4c85-b444-4d51abd3f1d0
10356	CREDIT	T-shirt order - Design Lead	2698	USD	2016-12-06 11:51:54.984-05	2016-12-06 11:51:55.379-05	827	171	1191	\N	\N	\N	\N	\N	\N	\N	1	2698	2698	509	6f63ac4f-c716-4635-b9d9-9824a75f25fd	59	857	acbf0b0e-0996-481f-afb7-dae636b3ea2e
10357	CREDIT	Supplies	3918	USD	2016-12-06 11:51:20.162-05	2016-12-06 11:51:20.661-05	827	171	1191	\N	\N	\N	\N	\N	\N	\N	1	3918	3918	508	f9a29568-5a8a-4895-87d2-91ca5664824e	59	857	34df37d5-950b-4a12-b340-46fa53cbd88e
10358	CREDIT	Marketing for IoT Hackathon	1082	USD	2016-12-06 11:50:56.549-05	2016-12-06 11:50:57.046-05	827	171	1191	\N	\N	\N	\N	\N	\N	\N	1	1082	1082	502	d048ee99-8748-4929-9115-3f48489b53b8	59	857	016d18be-3ca9-4c54-a8cc-b750abe1f219
10359	CREDIT	Thank you bags (16) for hackathon speakers and judges, and for pre-hackathon events volunteers and sponsors.  Each bag contains a WWCode Portland coffee mug, a chocolate bar, ghirardellis squares, and a thank you card.	8181	USD	2016-11-22 16:54:33.366-05	2016-11-22 16:54:33.644-05	827	171	1191	\N	\N	\N	\N	\N	\N	\N	1	8181	8181	499	538a510f-9122-4e17-9537-beb7d861c2eb	59	857	fc84fb74-1df6-4619-95f2-bba7f3be7ec2
10360	CREDIT	Thank you gift to an amazing sponsor!	1700	USD	2016-11-22 07:31:00.49-05	2016-11-22 07:31:00.691-05	827	171	1191	\N	\N	\N	\N	\N	\N	\N	1	1700	1700	501	54bed5cd-25fe-4b67-8698-43a47f16f6ef	59	857	268c3a64-2607-4c10-b71f-ff1262281e29
10361	CREDIT	Domain name for hackathon and study night projects	1798	USD	2017-02-20 15:53:02.864-05	2017-02-20 15:53:02.879-05	827	171	1893	\N	\N	\N	\N	\N	\N	\N	1	1798	1798	497	9c299e49-8995-4a91-9cd8-c125aef7dfc6	59	857	59f36c91-93a4-4be4-b7bb-0aca6550054f
10362	CREDIT	Food for 2017 Planning Meeting w/ leadership team (Jan. 22)	9050	USD	2017-02-07 13:40:49.494-05	2017-02-07 13:40:49.852-05	827	171	1718	\N	\N	\N	\N	\N	\N	\N	1	9050	9050	790	176a1f01-a442-4708-9346-aec601deb73a	59	857	e1301829-9efd-4a95-8d1e-8d3ec6f07ced
10363	DEBIT	Donation to WWCode Austin	-26100	USD	2016-02-18 14:54:08.531-05	2016-04-16 16:40:58.717-04	813	108	71	\N	\N	15	0	\N	900	USD	1	-26100	-30000	\N	c8886edd-a338-41b6-a1c9-f66380a0d825	2	857	c4d0e91b-72f5-4ab8-89bc-d64a63b7bd41
10572	CREDIT	\N	25000	MXN	2017-04-17 18:34:32.259-04	2017-04-17 18:34:32.259-04	51	3	\N	2017-10-26 17:24:07.436-04	\N	2487	\N	\N	\N	MXN	1	25000	25000	\N	ade0e173-cfec-4dbd-be1e-4cfdc4e76767	\N	857	dde1250e-79cd-4912-a2c7-26ff0dedcbf4
10364	DEBIT	monthly recurring subscription	-798	USD	2017-02-14 13:13:04.109-05	2017-02-14 13:13:04.109-05	763	2549	1616	\N	\N	1531	50	\N	52	USD	1	-798	-1000	\N	9baefe25-5fac-480b-a230-931ba878c008	270	857	59871d44-6a6f-459a-ab92-db76a867e2f4
3842	DEBIT	Food for Anniversary Reception	-700	USD	2016-12-07 00:00:00.86-05	2016-12-07 00:00:00.86-05	273	1325	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-713	492	5ea9a1f3-af86-44ce-a16f-5c2b3fd2a5e3	843	857	4e6a3cd2-8570-4a56-b347-cf4177845f69
3841	DEBIT	Food/Drinks for Anniversary Reception with guest WWCode Directors!	-4400	USD	2016-12-07 00:00:00.86-05	2016-12-07 00:00:00.86-05	273	1325	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-4444	486	534b6b59-e66e-4781-9a64-b546b15e08b6	843	857	1fc3cb43-1cac-4561-af13-847ac86cba04
3833	DEBIT	Goodie Bags	-1058	USD	2016-12-07 15:49:55.814-05	2016-12-07 15:49:56.33-05	59	171	1191	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1058	573	6493e4b7-0f63-4534-bf0b-f0ab17750c9e	827	857	28e2dcc6-d170-4c85-b444-4d51abd3f1d0
103	CREDIT	Donation to WWCode Austin	30000	USD	2016-02-18 14:54:08.531-05	2016-04-16 16:40:58.717-04	2	108	71	\N	\N	15	0	3000	900	USD	1	30000	26100	\N	a2af1057-4522-4c6a-b5ec-9f3e41da88e7	813	857	c4d0e91b-72f5-4ab8-89bc-d64a63b7bd41
5969	CREDIT	monthly recurring subscription	1000	USD	2017-02-14 13:13:04.109-05	2017-02-14 13:13:04.109-05	270	2549	1616	\N	\N	1531	50	100	52	USD	1	1000	798	\N	41a806dd-fae3-47ec-8291-293cc822ae9b	763	857	59871d44-6a6f-459a-ab92-db76a867e2f4
9863	CREDIT	\N	1000	USD	2017-05-09 01:59:15.573-04	2017-05-09 01:59:15.573-04	517	4711	2855	\N	\N	2750	50	100	52	USD	1	1000	798	\N	e3494f7e-351e-478a-937b-32ca9c60513f	711	857	51e0973b-d536-4e90-8c64-6a7feee9ad37
3796	DEBIT	T-shirt order - Design Lead	-2698	USD	2016-12-06 11:51:54.984-05	2016-12-06 11:51:55.379-05	59	171	1191	\N	\N	\N	\N	\N	\N	\N	\N	\N	-2698	509	c884d630-10d6-4279-b84b-7383937f1478	827	857	acbf0b0e-0996-481f-afb7-dae636b3ea2e
3794	DEBIT	Marketing for IoT Hackathon	-1082	USD	2016-12-06 11:50:56.549-05	2016-12-06 11:50:57.046-05	59	171	1191	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1082	502	e923e566-7e1f-4e3d-aa4d-3b2926add382	827	857	016d18be-3ca9-4c54-a8cc-b750abe1f219
10370	CREDIT	May 2 Lightning Talks	8979	USD	2016-05-22 19:46:04.647-04	2016-06-14 14:14:22.092-04	847	28	26	\N	\N	\N	\N	\N	\N	\N	1	8979	8979	184	430cb127-57cb-4b7a-a624-1967d8badd1b	2	857	f974bc7f-1f07-46a6-87f9-78b3d64f12e7
10378	CREDIT	May expense: Travel and expense costs for mentoring at StartUp Weekend, Meeting w Northeeastern University for future WWC events 	5161	USD	2016-06-06 20:21:31.531-04	2016-06-14 14:14:22.165-04	766	31	320	\N	\N	\N	\N	\N	\N	\N	1	5161	5161	218	ecaa4928-2bb4-460a-b607-cc83b4ad02b9	14	857	f77d510c-4f55-4a55-948f-4982df345f46
10383	CREDIT	WwConnect Conference Set Up Day 1	709	USD	2016-03-18 20:00:00-04	2016-06-14 14:14:21.805-04	766	31	26	\N	\N	\N	\N	\N	\N	\N	1	709	709	61	c047ae60-2da4-4aaf-9e34-1b84e3ba8766	14	857	6903ec10-a78c-49f0-ae08-da1aa59d366d
10388	DEBIT	\N	-2040	USD	2017-04-11 22:05:36.032-04	2017-04-11 22:05:36.032-04	692	4173	2546	\N	\N	2430	125	\N	85	USD	1	-2040	-2500	\N	0380f80f-6747-4975-b910-ac560e3056cc	13	857	4a5b0659-d7d0-4f52-903a-7aaaf58f2f0f
10394	DEBIT	Recurring subscription	-52	USD	2016-04-02 15:09:44.502-04	2016-04-16 16:40:58.811-04	691	30	41	\N	\N	67	5	\N	33	USD	1	-52	-100	\N	0c9291d3-6f20-43ed-a895-434d1b1cde55	14	857	4febb93e-04fd-4b53-ac12-d97f7f2e622b
10399	DEBIT	Recurring subscription	-380	USD	2016-02-18 20:11:10.784-05	2016-04-16 16:40:58.716-04	688	2	34	\N	\N	65	25	\N	45	USD	1	-380	-500	\N	a3d81378-2958-4996-a512-0f0e69b926ff	10	857	aed703f2-06e4-47b7-958d-7b5bd050736e
10405	CREDIT	Almond milk for coffee (ATXDivHack)	1192	USD	2016-10-31 17:13:53.591-04	2016-10-31 17:13:53.747-04	847	28	1043	\N	\N	\N	\N	\N	\N	\N	1	1192	1192	446	a7eb47e2-ea33-489f-b289-f1879d55e139	2	857	4938fb18-ffaa-4dae-ac3f-1383210dcad6
10409	CREDIT	Drinks for Happy Hour (ATXDivHack)	5518	USD	2016-10-31 17:13:39.794-04	2016-10-31 17:13:40.146-04	847	28	1043	\N	\N	\N	\N	\N	\N	\N	1	5518	5518	447	acba5a34-5bdd-4e9a-b54e-ad16e7a54895	2	857	842645f1-0a3a-485d-8d18-0ada1dedaf58
10415	CREDIT	Event Food	6471	USD	2016-11-03 15:43:50.827-04	2016-11-03 15:43:51.096-04	827	171	1117	\N	\N	\N	\N	\N	\N	\N	1	6471	6471	377	a5e8313b-2378-4daa-8ffe-337e5626cd59	59	857	dbee49c9-c3be-4790-b860-2939c9e48ae4
10419	CREDIT	Event supplies	2715	USD	2016-10-05 12:44:00.394-04	2016-10-05 12:44:00.521-04	827	171	573	\N	\N	\N	\N	\N	\N	\N	1	2715	2715	375	f692ee78-0370-4511-85aa-9b23cf510dc1	59	857	80ce1240-6451-4150-b033-2ef25e07425d
10425	CREDIT	Costco breakfast, lunch, drinks, plates, cups, utensils, snacks, deserts ...	48435	USD	2016-10-31 17:08:49.332-04	2016-10-31 17:08:49.517-04	795	1371	1042	\N	\N	\N	\N	\N	\N	\N	1	48435	48435	417	4a8177b8-2f1d-4eeb-bca4-26260079362b	300	857	dc15cb90-b7be-4bff-a979-08fc9d64894e
10429	CREDIT	Leadership - Planning for 2017 - Evening Coffee	875	USD	2016-12-19 13:43:53.809-05	2016-12-19 13:43:54.334-05	696	142	1191	\N	\N	\N	\N	\N	\N	\N	1	875	875	603	1eeebb73-49dd-4747-8a28-1859671331b8	48	857	8fe5b776-cde9-4083-bc93-3d1f92178045
10431	CREDIT	Robotics: Coding with Your Kids HackNight Supplies	20397	USD	2016-12-19 11:20:39.625-05	2016-12-19 11:20:40.499-05	696	142	1191	\N	\N	\N	\N	\N	\N	\N	1	20397	20397	604	ebf64f32-47b2-4892-9043-12aee7276bfd	48	857	e18c0040-ab6a-4a72-b056-966be4a67e7d
10436	CREDIT	My coworker donated his evening to giving demos of his personal Oculus Rift for our AR/VR event, so I sent him a gift card to thank him for his help with the event.	2500	USD	2016-09-27 15:33:54.08-04	2016-09-27 15:33:54.272-04	696	142	573	\N	\N	\N	\N	\N	\N	\N	1	2500	2500	367	bba00406-b7dd-43f0-a853-b7e95c9cfe6b	48	857	35afd412-dd6d-48e3-9b88-0938d4e4fb40
10439	CREDIT	05-21-16 AI workshop	30000	USD	2016-05-22 20:26:36.061-04	2016-06-14 14:14:22.092-04	847	28	\N	2016-06-14 14:14:22.535-04	\N	\N	\N	\N	\N	\N	1	30000	30000	186	87e3ac1e-ca0a-4c31-9a1a-657ab8345564	2	857	aef9f0a0-3c39-44f0-864c-d4d8d24ef655
10441	CREDIT	Food/Drinks for Leadership Team Meeting - Gen, Claire - Oct 2016	4000	GBP	2016-12-07 00:00:00.86-05	2016-12-07 00:00:00.86-05	830	1333	\N	\N	\N	\N	\N	\N	\N	\N	1	4000	4000	507	70e4eb7a-29aa-4bc7-9551-70c2bb0d587e	278	857	757edecb-0f6b-4a7c-9324-ba8976d9d67c
10446	CREDIT	Transportation for Sandra and Cici to get to meeting location with core team members	749	USD	2016-08-02 09:39:15.789-04	2016-08-02 09:39:15.797-04	766	31	320	\N	\N	\N	\N	\N	\N	\N	1	749	749	256	25523e80-4691-4a05-89d1-85446e3264c3	14	857	dfb13291-16e5-4d17-ad52-e71ff6a97aab
10450	CREDIT	STEM Toys for Coding with Kids Event	10212	USD	2016-08-16 10:58:32.03-04	2016-08-16 10:58:32.041-04	696	142	573	\N	\N	\N	\N	\N	\N	\N	1	10212	10212	293	24368b8f-7511-4477-a2c2-ea997324526b	48	857	543b884f-76a8-4ff2-a38e-25aeae75f561
10452	CREDIT	Leadership Development	50616	MXN	2017-03-14 14:17:51.969-04	2017-03-14 14:17:51.969-04	51	3	\N	\N	\N	\N	\N	\N	0	MXN	1	50616	50616	887	107295af-0634-454a-b869-fe7863f08a8f	282	857	328ad965-0b97-47ce-b92e-72f60a09b0a3
10455	DEBIT	monthly recurring subscription	-2040	USD	2017-03-01 13:37:53.591-05	2017-03-01 13:37:53.591-05	693	2906	1804	\N	\N	1712	125	\N	85	USD	1	-2040	-2500	\N	6d8abd09-c23b-4213-9312-4831130b3ce7	271	857	2f19ba5e-3ff9-49c4-9d43-f7579f024baf
10458	CREDIT	Conference Grant - Sarah Olson	110000	USD	2016-05-10 15:19:21.785-04	2016-06-14 14:14:22.032-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	110000	110000	156	009a0842-296a-4be4-9722-a56c40614e65	48	857	d5cf278b-fb86-4e76-83d2-f96bea636456
10468	CREDIT	Meetup Fees	5700	EUR	2016-12-27 11:36:05.296-05	2016-12-27 11:36:05.296-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	5700	5700	637	61770461-9d98-4748-a457-17370fd20c22	298	857	064218eb-be97-4251-887d-395af6b399db
10471	CREDIT	Meetup Fees	5700	EUR	2016-12-23 12:15:16.054-05	2016-12-23 12:15:16.054-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	5700	5700	620	adc21683-302a-44fd-bc4e-146730760f8a	301	857	8aa5b486-c5c5-4288-9d6c-79ce00dc0f0b
10484	CREDIT	Food at our Sept. monthly event	11478	USD	2016-10-04 18:07:11.046-04	2016-10-04 18:07:11.615-04	51	3	573	\N	\N	\N	\N	\N	\N	\N	1	11478	11478	\N	9d4dbf14-3243-43c6-ad89-46948788948a	15	857	73aa80f4-7a3a-4f3c-9919-f547e7b7dcbe
10502	DEBIT	monthly recurring subscription	-798	USD	2017-05-01 19:34:11.708-04	2017-05-01 19:34:11.708-04	803	686	461	\N	\N	386	50	\N	52	USD	1	-798	-1000	\N	d00725b0-9fb8-43a3-93b6-55686b79b60e	2	857	59e48874-b7a3-4904-a63e-c3d10cb7373a
10505	DEBIT	\N	-20670	USD	2016-09-22 21:07:09.492-04	2016-09-22 21:07:09.492-04	792	1263	790	\N	\N	700	1250	\N	580	USD	1	-20670	-25000	\N	e9397f3b-2891-4f90-b65c-0e854be1a63c	59	857	f19a87fd-002b-4e3d-9ae6-b0d6e9aee57b
10512	DEBIT	Recurring subscription	-798	USD	2016-09-09 23:42:56.392-04	2016-09-09 23:42:56.392-04	737	1158	731	\N	\N	647	50	\N	52	USD	1	-798	-1000	\N	f59cdf74-c858-4b8f-bc92-b124009cb730	241	857	2d0f7f24-2670-4dda-a03d-95ada2a1a0bd
10564	CREDIT	\N	3562	GBP	2017-04-18 15:41:30.286-04	2017-04-18 15:41:30.286-04	51	3	\N	2017-10-26 17:24:06.413-04	\N	2503	\N	\N	\N	GBP	1	3562	3562	\N	97d87167-436b-456e-a3b6-f745d64d9d97	\N	857	2620cd06-d6aa-41ff-a22a-52d8c07e80c1
10567	CREDIT	\N	100000	USD	2017-04-17 18:40:40.357-04	2017-04-17 18:40:40.357-04	51	3	\N	2017-10-26 17:24:06.54-04	\N	2490	\N	\N	\N	USD	1	100000	100000	\N	d643fbbc-190e-4e1a-8c9a-98243be0b575	\N	857	33937e0d-86d5-4b38-9e73-4e25b445e881
10550	CREDIT	\N	1480	USD	2017-04-18 20:39:23.15-04	2017-04-18 20:39:23.15-04	51	3	\N	2017-10-26 17:24:06.889-04	\N	2508	\N	\N	\N	USD	1	1480	1480	\N	37587ead-cdbb-427a-aed0-2771da0552b7	\N	857	6c345928-6909-4573-b954-4dc6d2c97d2f
10546	CREDIT	\N	100000	USD	2017-03-31 18:32:34.123-04	2017-03-31 18:32:34.123-04	51	3	\N	2017-10-26 17:24:06.957-04	\N	2212	\N	\N	\N	USD	1	100000	100000	\N	6290e5dc-9e55-4668-8914-4e50889e7042	\N	857	7b143042-4424-4df1-9a42-42fab8ab48e2
10555	DEBIT	\N	-100000	USD	2017-03-31 18:32:34.123-04	2017-03-31 18:32:34.123-04	857	3	\N	\N	\N	2212	0	\N	0	USD	1	-100000	-100000	\N	de7a1df4-7221-4b46-a41a-2562837dbbdd	286	857	7b143042-4424-4df1-9a42-42fab8ab48e2
10524	CREDIT	\N	2930	USD	2017-05-01 20:33:45.73-04	2017-05-01 20:33:45.73-04	51	3	\N	2017-10-26 17:24:07.003-04	\N	2662	\N	\N	\N	USD	1	2930	2930	\N	3f040095-e415-47a9-b3cc-4594db883fee	\N	857	86c2ce2b-1e91-463a-820b-e068cb5a1fec
10521	CREDIT	AJUG - Global and fees	26250	USD	2017-04-20 17:39:17.741-04	2017-04-20 17:39:18.323-04	51	3	\N	2017-10-26 17:24:07.089-04	\N	\N	\N	\N	\N	\N	1	\N	26250	\N	7e7b1331-c1a9-488b-b2d6-1c928a71fd2d	\N	857	9a7aa0d1-0287-47a9-8666-4502ceafda5d
671	DEBIT	A Small Orange	-12700	USD	2016-02-01 19:00:00-05	2016-06-14 14:14:22.114-04	48	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-12700	194	d40ca73f-6c26-4d43-9c22-6e36ab38f02c	51	857	d516acab-24fb-42d9-bce7-274334af0457
10366	DEBIT	\N	-798	USD	2017-05-09 01:59:15.573-04	2017-05-09 01:59:15.573-04	711	4711	2855	\N	\N	2750	50	\N	52	USD	1	-798	-1000	\N	6cd38281-f4ce-4aeb-bd8c-cec24788ad1d	517	857	51e0973b-d536-4e90-8c64-6a7feee9ad37
10375	CREDIT	Transportation to get to GeekWire Summit social event 	729	USD	2016-11-01 12:16:02.625-04	2016-11-01 12:16:02.953-04	766	31	1044	\N	\N	\N	\N	\N	\N	\N	1	729	729	402	df4bdc2d-94bb-4f85-9729-5128debc2649	14	857	cb3c3dc5-d82f-4753-a75a-e4e6daf6783f
10380	CREDIT	Travel to attend internal leads meeting to finalize plans for upcoming 2017 events	6100	USD	2017-02-22 10:27:02.607-05	2017-02-22 10:27:02.62-05	766	31	1893	\N	\N	\N	\N	\N	\N	\N	1	6100	6100	774	93003fce-e421-4608-8a4b-4ca3939ce3d0	14	857	23746709-2977-44a8-91d1-f296b3da80ef
10389	DEBIT	Recurring subscription	-52	USD	2016-05-02 14:15:35.25-04	2016-05-02 14:15:35.307-04	691	30	44	\N	\N	70	5	\N	33	USD	1	-52	-100	\N	abb83cd6-3adf-4bfb-ac9a-e9594a8245cf	13	857	1b4ae8a6-fd9b-4287-8634-3541c62f4eb7
10395	DEBIT	Donation to WWCode Austin	-26100	USD	2016-03-02 16:31:50.516-05	2016-04-16 16:40:58.67-04	689	129	94	\N	\N	25	0	\N	900	USD	1	-26100	-30000	\N	3b4e36f6-27b0-4132-8fcf-8e7ed993d1bf	2	857	44b82a43-575c-41c3-ab6a-d37e78d7dca8
10400	DEBIT	Donation to WWCode Washington DC	-52	USD	2016-02-02 18:09:05.702-05	2016-04-16 16:40:58.699-04	688	2	46	\N	\N	72	5	\N	33	USD	1	-52	-100	\N	bb647f69-f555-4c7f-a34c-9db93c95df78	13	857	4cbe50e7-903b-4159-990b-615ad236c1c5
10403	CREDIT	Food (ATXDivHack)	339421	USD	2016-11-21 10:23:08.279-05	2016-11-21 10:23:08.279-05	847	28	\N	\N	\N	\N	\N	\N	\N	\N	1	339421	339421	467	a486c39f-2ce2-407b-8168-82b3e5b14ce5	2	857	b0f343fc-25cb-4235-b765-1b7b202a5f29
10407	CREDIT	Drinks and snacks (ATXDivHack)	75932	USD	2016-10-31 17:13:05.943-04	2016-10-31 17:13:06.106-04	847	28	1043	\N	\N	\N	\N	\N	\N	\N	1	75932	75932	449	932eb366-74d3-4880-b0e4-37c1760b0ba6	2	857	a7fbb2b4-b67a-49e2-81ad-6e32c01e5405
10411	CREDIT	September Ruby Tuesday	6497	USD	2016-10-31 17:11:36.488-04	2016-10-31 17:11:36.731-04	847	28	1042	\N	\N	\N	\N	\N	\N	\N	1	6497	6497	450	4743450d-4e92-430e-8f69-d8582fc3aba3	2	857	2a1ddc60-2a7a-415b-ac43-4a93701e415b
10417	CREDIT	Event Food	7167	USD	2016-10-05 12:44:47.862-04	2016-10-05 12:44:48.013-04	827	171	573	\N	\N	\N	\N	\N	\N	\N	1	7167	7167	378	83053b82-598b-4679-8a28-8f83cb96089b	59	857	01d5c213-fa67-4c0d-a4df-c7ff2c72de37
10421	CREDIT	Leadership Event in Sofia	1019	EUR	2016-12-07 16:30:48.339-05	2016-12-07 16:30:48.523-05	800	1379	1191	\N	\N	\N	\N	\N	\N	\N	1	1019	1019	470	2855b6db-ad97-4589-8851-3922ca4aac3f	301	857	c06dc633-ea26-4447-bf1c-64b326b75f7d
10426	CREDIT	Monthly core team meeting. Beverages with dinner for six members 	3080	USD	2016-10-31 13:59:53.602-04	2016-10-31 13:59:53.96-04	766	31	1024	\N	\N	\N	\N	\N	\N	\N	1	3080	3080	401	c6d458a0-b7d2-42ea-90e0-d03e01a75239	14	857	0a05e240-0f6e-4652-98ef-2f1786107966
10430	CREDIT	Leadership - Planning for 2017 - Afternoon Coffee	1175	USD	2016-12-19 13:42:59.021-05	2016-12-19 13:42:59.545-05	696	142	1191	\N	\N	\N	\N	\N	\N	\N	1	1175	1175	601	e44e3e32-5032-40ff-ab05-14b2bf75c5a9	48	857	b3cc48a0-39d1-48ca-a13f-331a2302ffc3
10438	CREDIT	3/30/16 Python Gameathon prize - Udemy course	2400	USD	2016-06-04 17:37:03.991-04	2016-06-14 14:14:22.155-04	847	28	320	\N	\N	\N	\N	\N	\N	\N	1	2400	2400	213	c2917e0b-2d44-440b-ac0d-67faa2a84f8c	2	857	46f4fff3-ffc1-4223-99e9-18fcb1c74558
10445	DEBIT	\N	-20670	USD	2017-03-01 17:51:20.759-05	2017-03-01 17:51:20.759-05	792	1263	2048	\N	\N	1953	1250	\N	580	USD	1	-20670	-25000	\N	0f73da6e-ab65-425c-b997-6bb5e5c5c441	59	857	4f19c667-0fa8-480d-91eb-97e37d3d18f1
10448	CREDIT	Coding books for our study groups (Humble Bundle -- Joy of Coding)	1500	USD	2016-08-19 16:58:54.527-04	2016-08-19 16:58:54.67-04	696	142	573	\N	\N	\N	\N	\N	\N	\N	1	1500	1500	318	ead4a7f5-f67d-400e-87f6-dc7dc64b7563	48	857	74dc7397-13e8-40a6-a0d7-e27f5eb393dd
10453	CREDIT	Wearable Clothing Workshop	34411	USD	2017-03-14 14:00:11.436-04	2017-03-14 14:00:11.448-04	696	142	2149	\N	\N	\N	\N	\N	999	USD	1	34411	33412	815	a7198f1c-593c-48e4-8d37-70655426414c	48	857	90f89aeb-63a4-4c2e-8f44-f7010f3156cc
10456	CREDIT	Meetup Fees	6000	USD	2016-12-23 12:32:55.31-05	2016-12-23 12:32:55.31-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	622	fc4ac2d2-5561-4c4b-98aa-cfc0bb426701	195	857	cad05bc1-4c78-4d6d-9a5c-0265427e6823
10460	CREDIT	Drinks for July monthly event	3316	USD	2016-08-16 10:53:42.013-04	2016-08-16 10:53:42.04-04	51	3	573	\N	\N	\N	\N	\N	\N	\N	1	3316	3316	\N	251c0a97-1c59-4e00-ae07-1c2285650848	15	857	e6d2f447-1af3-49db-b48c-46a0ca7e73c3
10463	CREDIT	Global Development 	150	USD	2016-06-09 14:38:16.857-04	2016-06-14 14:14:22.175-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	150	150	222	91de3a49-524b-45d6-899e-663f49c01e40	4	857	4ce6a9d4-952b-4c77-bfe5-38e32a5f4f0e
10466	CREDIT	Meetup Fees	6000	USD	2017-04-05 10:19:21.293-04	2017-04-05 10:19:21.293-04	51	3	\N	\N	\N	\N	\N	\N	0	USD	1	6000	6000	988	57bcd182-c180-4c09-9c54-80c3cd3bb568	295	857	e2dd278f-032c-43a1-89b2-9ae04d39d763
10469	CREDIT	Meetup Fees	6000	AUD	2016-12-23 12:42:18.688-05	2016-12-23 12:42:18.688-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	623	7b048310-3567-4492-bcfc-c0ce076b0c7b	266	857	e1d8cf75-2f5f-4e99-b0b8-063950419e57
10476	CREDIT	Banner	2000	USD	2016-11-30 16:19:46.014-05	2016-11-30 16:19:46.128-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	2000	2000	\N	e3663cbb-72f8-46d0-8e73-23073f5b691a	269	857	0568e3fa-e5d8-491b-9e77-6c8442a50615
10479	CREDIT	Envelopes for hackathon sponsor prizes	907	USD	2016-11-30 11:12:35.291-05	2016-11-30 11:12:35.54-05	51	3	1191	\N	\N	\N	\N	\N	\N	\N	1	907	907	\N	9f7f838f-9cf0-44dd-8652-d517ad104f58	2	857	1b8c5874-2f34-4c12-b795-7f7be90b9dae
10481	CREDIT	Engineering (Web) - A Small Orange	12700	USD	2016-10-11 20:44:30.933-04	2016-10-11 20:44:31.081-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	12700	12700	\N	87c25d23-5b34-4bbe-aa02-745a0eca4184	48	857	309939b6-315f-46ff-8548-89055e027009
10489	DEBIT	Donation to WWCode Austin	-124170	USD	2016-08-01 11:54:14.382-04	2016-08-01 11:54:14.468-04	839	883	561	\N	\N	488	7500	\N	3330	USD	1	-124170	-150000	\N	82c994dc-03a8-4c84-a7aa-a1f1c6768f80	2	857	3b7c8357-4733-4dbd-9091-2776238c4ee8
10492	DEBIT	Donation to WWCode Austin	-16390	USD	2016-04-13 12:46:10.463-04	2016-04-16 16:40:58.845-04	820	224	173	\N	\N	153	1000	\N	610	USD	1	-16390	-20000	\N	5116650e-2cfa-4d97-8642-a6fb7d570378	2	857	c8660193-792a-44e4-a7ff-d074f69bec15
10496	DEBIT	Recurring subscription	-53	USD	2016-07-09 14:31:14.547-04	2016-07-09 14:31:14.585-04	819	8	385	\N	\N	320	5	\N	32	USD	1	-53	-100	\N	8cf8663d-d8a9-4072-99de-f25851e87d86	3	857	7fd7b99b-f672-4482-9e83-7f8a424fb71e
10498	DEBIT	\N	-3282	USD	2016-11-28 10:33:14.428-05	2016-11-28 10:33:14.428-05	810	1890	1249	\N	\N	1167	200	\N	118	USD	1	-3282	-4000	\N	85401047-4f6b-4a02-bfe9-93548f14ef90	2	857	461a7850-253c-49d9-a971-08eb8745645e
10499	DEBIT	Donation to WWCode Austin	-122250	USD	2016-08-05 16:48:08.414-04	2016-08-05 16:48:08.458-04	805	192	589	\N	\N	513	7500	\N	5250	USD	1	-122250	-150000	\N	eccd1bde-8670-4efa-aef0-f20df7ac2e70	2	857	112aabec-2db7-485c-b867-0f115aab4ca7
10507	DEBIT	Donation to WWCode Twin Cities	-53	USD	2016-06-21 12:06:05.517-04	2016-06-21 12:06:05.626-04	775	642	432	\N	\N	361	5	\N	32	USD	1	-53	-100	\N	aaa84154-d7a3-49cb-aede-483bbe24a3ad	48	857	97d61982-3f01-41b6-9682-644a956bb70b
10582	DEBIT	\N	-100000	USD	2017-04-17 18:09:42.57-04	2017-04-17 18:09:42.57-04	857	3	\N	\N	\N	2477	0	\N	0	USD	1	-100000	-100000	\N	89c61b04-caf6-4632-a0ca-378ea8282805	270	857	0181d00b-2103-42e7-b060-21a5a26bce9b
10515	CREDIT	WWCode t-shirt sales	1229	USD	2017-01-17 22:23:59.112-05	2017-01-17 22:23:59.247-05	51	3	\N	2017-10-26 17:24:06.417-04	\N	\N	\N	\N	\N	\N	1	\N	1229	\N	20e3e9ff-3066-4394-b581-de73d6785af7	\N	857	2659df51-8fa5-40ee-a8ba-0b3691201b92
10523	CREDIT	Network development (stickers)	58590	USD	2016-10-06 12:08:20.916-04	2016-10-06 12:08:21.09-04	51	3	\N	2017-10-26 17:24:06.421-04	\N	\N	\N	\N	\N	\N	1	\N	58590	\N	5ac60589-e61b-403f-bddb-b3bef41a058a	\N	857	2662baec-30e0-4ffe-b56b-7f97352108c8
10530	DEBIT	Network development (stickers)	-58590	USD	2016-10-06 12:08:20.916-04	2016-10-06 12:08:21.09-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-58590	-58590	\N	815571ba-ddb9-4e71-b148-6066eff12cb9	3	857	2662baec-30e0-4ffe-b56b-7f97352108c8
10556	DEBIT	\N	-39800	GBP	2017-03-31 14:01:48.418-04	2017-03-31 14:01:48.418-04	857	3	\N	\N	\N	2209	0	\N	0	GBP	1	-39800	-39800	\N	fbdd200d-ce66-4c4d-b242-726c1d4ba74f	278	857	31745c67-cdeb-485e-ad15-3f61cda10313
10545	DEBIT	\N	-50000	CAD	2017-03-31 19:37:30.819-04	2017-03-31 19:37:30.819-04	857	3	\N	\N	\N	2217	0	\N	0	CAD	1	-50000	-50000	\N	4b817621-2082-46dd-b456-d5daa764ee28	291	857	68a158db-92ef-45db-9056-52bf74b9824b
10519	DEBIT	WWCode t-shirt sales	-982	USD	2017-01-17 22:24:31.362-05	2017-01-17 22:24:31.504-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-982	-982	\N	b9db7962-bcce-4968-b5c3-55f4cce0c8da	13	857	6996f965-9b3d-4af4-a02d-c4883ee7e14f
10533	CREDIT	\N	40000	USD	2017-04-19 14:26:01.228-04	2017-04-19 14:26:01.228-04	51	3	\N	2017-10-26 17:24:07.06-04	\N	2520	\N	\N	\N	USD	1	40000	40000	\N	47834d7c-33b7-4d47-ab35-78555ba67630	\N	857	944cb0fd-553f-4e47-a5e2-785cec9d7c8b
10540	DEBIT	\N	-40000	USD	2017-04-19 14:26:01.228-04	2017-04-19 14:26:01.228-04	857	3	\N	\N	\N	2520	0	\N	0	USD	1	-40000	-40000	\N	b6cc3660-b232-4afb-b22d-0498c86b00b9	3	857	944cb0fd-553f-4e47-a5e2-785cec9d7c8b
10588	DEBIT	\N	-85000	GBP	2017-04-17 17:05:15.067-04	2017-04-17 17:05:15.067-04	857	3	\N	\N	\N	2474	0	\N	0	GBP	1	-85000	-85000	\N	fe434048-8214-4981-9560-f87ab29a1bda	278	857	d7381bbe-8e6b-42cb-9759-ed2f1f81babf
10579	DEBIT	\N	-25000	MXN	2017-04-17 18:34:32.259-04	2017-04-17 18:34:32.259-04	857	3	\N	\N	\N	2487	0	\N	0	MXN	1	-25000	-25000	\N	50090787-8729-47e9-b696-14bd9997b6a9	511	857	dde1250e-79cd-4912-a2c7-26ff0dedcbf4
10552	CREDIT	\N	50000	USD	2017-03-31 13:17:51.695-04	2017-03-31 13:17:51.695-04	51	3	\N	2017-10-26 17:24:07.486-04	\N	2204	\N	\N	\N	USD	1	50000	50000	\N	f5e1127d-fc89-45de-87bb-2aec25334b9a	\N	857	e4a9485f-3f41-4a06-850e-a971234a3ee5
10594	CREDIT	Women Techmaker WWcode Partnership Grant	100000	USD	2016-05-24 16:23:16.28-04	2016-05-24 16:23:16.552-04	51	3	\N	2017-10-26 17:24:07.489-04	\N	\N	\N	\N	\N	\N	1	\N	100000	\N	9a00ec97-2947-4923-9815-1a0311756f37	\N	857	e60fe9c9-3dc1-4342-8c92-af3e180264f5
10367	CREDIT	6/2/16 Fireside Chat at Orange Coworking	20000	USD	2016-06-04 17:37:03.991-04	2016-06-14 14:14:22.145-04	847	28	320	\N	\N	\N	\N	\N	\N	\N	1	20000	20000	211	c3706fc2-d9c2-4bff-b378-4707c527f5e6	2	857	ecaf6677-a999-4e21-9af0-e3d323b503e5
10372	DEBIT	Donation to WWCode Mexico City	-148	MXN	2016-02-02 11:52:02.237-05	2016-04-16 16:40:58.703-04	768	80	42	\N	\N	68	1	\N	16	USD	18.5100000000000016	-8	-500	\N	2eb99f6d-61e5-42bb-8f99-b3a620382cc4	10	857	162eaed6-d5c5-4e6f-b056-45a5e46015df
10377	CREDIT	WwConnect Planning Meeting	2519	USD	2016-03-10 19:00:00-05	2016-06-14 14:14:21.794-04	766	31	26	\N	\N	\N	\N	\N	\N	\N	1	2519	2519	60	7ee11308-87c5-4a58-9b70-fd94cd7c3154	14	857	1af0fd42-ff06-4ab2-855e-fe7b01089add
10381	CREDIT	Nike Dinner	1000	USD	2016-03-17 20:00:00-04	2016-06-14 14:14:21.805-04	766	31	26	\N	\N	\N	\N	\N	\N	\N	1	1000	1000	62	7308b973-d700-4bbd-9c42-f2b1e03b5257	14	857	499ddc16-98b2-4714-a19d-b45139375623
10384	CREDIT	WwConnect planning meeting	4656	USD	2016-03-10 19:00:00-05	2016-06-14 14:14:21.794-04	766	31	26	\N	\N	\N	\N	\N	\N	\N	1	4656	4656	59	b7b871b3-6a2b-4e7c-8dc1-28c4abb50ff9	14	857	df0326d4-91e9-48e8-b40f-89c0e381afaf
10387	DEBIT	monthly recurring subscription	-2040	USD	2017-05-01 14:32:00.085-04	2017-05-01 14:32:00.085-04	693	2906	1804	\N	\N	1712	125	\N	85	USD	1	-2040	-2500	\N	3ed7172e-b79a-4af6-9fa6-d92d41c5e438	271	857	e9e87dfa-2c96-45cf-bb92-f7ec19ee5eb7
10393	DEBIT	Donation to WWCode Washington DC	-52	USD	2016-02-02 12:04:56.247-05	2016-04-16 16:40:58.698-04	691	30	43	\N	\N	69	5	\N	33	USD	1	-52	-100	\N	fda0f9c0-bec1-4bee-9f3d-4e6b7c3058f5	13	857	07aad868-286d-4019-b282-ef6d00b764c2
10397	DEBIT	Donation to WWCode Mexico City	-380	USD	2016-01-18 18:54:06.439-05	2016-04-16 16:40:58.672-04	688	2	34	\N	\N	65	25	\N	45	USD	1	-380	-500	\N	4f5b6cb1-f17d-439e-b169-ed6dcbed7be0	10	857	4ca6c68e-83ca-4a5f-b759-09157c99372f
10401	CREDIT	05-21-16 AI workshop	30000	USD	2016-10-31 17:16:09.23-04	2016-10-31 17:16:09.38-04	847	28	1043	\N	\N	\N	\N	\N	\N	\N	1	30000	30000	186	c8a70339-a076-4534-abaa-a2d0adf8eb34	2	857	85ee00f1-fabf-417e-a047-24fe5fb400ec
10404	CREDIT	Painters tape for signs  	1136	USD	2016-10-31 17:14:51.746-04	2016-10-31 17:14:51.945-04	847	28	1043	\N	\N	\N	\N	\N	\N	\N	1	1136	1136	445	4503af67-f69d-40b3-a254-a6966b01efb6	2	857	76e5f3df-5e83-48d2-b4af-7cb58665a29e
10414	CREDIT	Food for JavaScript Study Night - Oct. 11th	1446	USD	2016-10-31 14:19:11.822-04	2016-10-31 14:19:12.067-04	827	171	1024	\N	\N	\N	\N	\N	\N	\N	1	1446	1446	419	6ea218e7-acc1-4025-ae44-8272db43eabd	59	857	f932e404-8d34-4881-a581-c9545d1f17c1
10420	CREDIT	Leadership Event in Sofia	6444	EUR	2016-12-07 16:38:07.287-05	2016-12-07 16:38:07.429-05	800	1379	1191	\N	\N	\N	\N	\N	\N	\N	1	6444	6444	471	a1ee82b4-0fc5-4d28-af55-6641e68bf750	301	857	75d45d59-c888-4665-8cdd-905067fda701
10427	CREDIT	food/drink for organizers of NODE workshop (had to buy from on-site snack bar)	2838	USD	2016-11-03 17:13:31.956-04	2016-11-03 17:13:32.241-04	762	70	1117	\N	\N	\N	\N	\N	\N	\N	1	2838	2838	409	b40ca2cb-0ee2-40ab-9540-71d208df74e7	12	857	440bc1da-d04f-4303-a1b6-533fb191c758
10435	CREDIT	Dinner for last night's HackNight	13526	USD	2016-08-19 16:58:34.342-04	2016-08-19 16:58:34.554-04	696	142	573	\N	\N	\N	\N	\N	\N	\N	1	13526	13526	319	91cd8101-013d-4d70-9288-06e7edb9757e	48	857	423bdd9d-94bf-4449-89ca-a4b461c22f21
10440	DEBIT	\N	-69722	USD	2017-02-10 11:47:34.349-05	2017-02-10 11:47:34.349-05	838	3053	1890	\N	\N	1801	4212	\N	1883	USD	1	-69722	-84241	\N	191af657-457d-4fb0-9be3-7f089132c854	15	857	0ebac610-ddec-4303-a28e-caf202d4fc69
10442	CREDIT	Event Food	2077	USD	2016-10-05 12:43:28.448-04	2016-10-05 12:43:28.644-04	827	171	573	\N	\N	\N	\N	\N	\N	\N	1	2077	2077	374	ad8c07cf-bda7-47e4-be4e-f769f077e181	59	857	7d5ee59c-f454-4b9c-a22a-a3692c12ee02
10443	CREDIT	Supplies for Agile workshop (2/26)	5996	USD	2017-03-14 14:16:43.183-04	2017-03-14 14:16:43.22-04	827	171	2149	\N	\N	\N	\N	\N	198	USD	1	5996	5798	858	54056277-0a9c-47f0-b10b-cda47b1e2b49	59	857	346be754-0405-4f65-bd49-921f26eedf5f
10449	CREDIT	STEM Toys for Coding with Kids Event	8496	USD	2016-08-16 10:58:01.764-04	2016-08-16 10:58:01.789-04	696	142	573	\N	\N	\N	\N	\N	\N	\N	1	8496	8496	294	9133aa46-675f-45c4-bfcf-1b7076b95a2a	48	857	1d8e7646-c4f5-46f5-bb87-4ce74d5e8323
10451	CREDIT	Leadership Development	14915	MXN	2017-03-14 14:18:46.358-04	2017-03-14 14:18:46.358-04	51	3	\N	\N	\N	\N	\N	\N	0	MXN	1	14915	14915	886	c5ff5fde-93d2-452b-b539-35072531d857	511	857	0f64e397-e397-445c-8a8f-93aa1afb8e33
10459	CREDIT	Event supplies	1797	USD	2016-08-19 13:24:23.638-04	2016-08-19 13:24:24.362-04	51	3	573	\N	\N	\N	\N	\N	\N	\N	1	1797	1797	\N	f91e89df-dfda-43df-b5c3-77dd5d2e3de6	59	857	6c5cbad7-77f0-4c09-a83b-3184ad449659
10462	CREDIT	CONFERENCE GRANT	50000	USD	2016-05-10 20:00:00-04	2016-06-14 14:14:22.114-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	50000	50000	196	2a34dd20-f70a-4650-a2c8-28cf8bc51843	59	857	bae34342-5c90-404a-9d32-e6cac2303909
10465	CREDIT	Conference Expense	8320	USD	2016-05-10 15:19:21.785-04	2016-06-14 14:14:22.042-04	51	3	\N	2016-06-14 14:14:22.515-04	\N	\N	\N	\N	\N	\N	1	8320	8320	158	a7f4069a-37a2-4c3c-911f-d40d7ab101e7	48	857	7e07bf10-a45a-4da7-9706-bbdbd8d4b54d
10472	CREDIT	Meetup Fees	6000	USD	2016-12-23 12:10:34.733-05	2016-12-23 12:10:34.733-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	619	e456455b-d63e-46e7-9798-1f82a28e739c	265	857	0b520997-2aef-4c4a-bb20-a2e50394afd9
10475	CREDIT	Regional Leadership Director Meeting 	7500	USD	2016-11-30 16:20:31.263-05	2016-11-30 16:20:31.464-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	7500	7500	\N	8e09c714-a2a0-452a-97e8-35ff29556156	269	857	f79ccc4e-137c-4c9d-b29b-3915a37333f1
10482	CREDIT	Conference Grant	100000	USD	2016-05-24 15:42:50.307-04	2016-06-14 14:14:22.103-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	100000	100000	189	d5dd5350-2b1e-43ed-8af0-e25cf373bfd6	3	857	d8bc7439-422d-4132-ab45-9346696275fd
10487	CREDIT	90/10 split: Beth Laing	500	USD	2016-10-04 12:06:16.796-04	2016-10-04 12:06:16.796-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	500	500	392	58b8cb8a-af9b-4ceb-8db7-0b67654dfe62	12	857	d966f041-a4b8-4663-ab1e-eda5a1c28a0d
10494	DEBIT	Recurring subscription	-53	USD	2016-09-09 14:29:12.276-04	2016-09-09 14:29:12.276-04	819	8	385	\N	\N	320	5	\N	32	USD	1	-53	-100	\N	94a1fa72-dfc3-490a-8e37-7498a2bbbe53	3	857	85e9e749-016b-4046-ad9a-9d6dfb6d0282
10501	DEBIT	Recurring subscription	-798	USD	2016-07-01 18:38:37.594-04	2016-07-01 18:38:37.617-04	803	686	461	\N	\N	386	50	\N	52	USD	1	-798	-1000	\N	82aebefa-e466-4427-be64-45e6dbbecf36	2	857	b45be811-a169-4b45-9aa8-5a441cdce3fb
10504	DEBIT	\N	-15485	USD	2016-09-28 17:47:18.302-04	2016-09-28 17:47:18.302-04	794	1299	842	\N	\N	768	950	\N	665	USD	1	-15485	-19000	\N	1a7fcc9f-0aa0-49a9-8f0c-7355cd64dba2	2	857	25cb3632-598e-46fe-a673-782dce6656d4
10511	DEBIT	\N	-165570	USD	2016-09-01 10:41:36.24-04	2016-09-01 10:41:36.24-04	738	1094	707	\N	\N	622	10000	\N	4430	USD	1	-165570	-200000	\N	12ce8a71-9d0d-4db5-860c-b7d194784eef	2	857	8c7ac22a-9c25-4041-8872-0424eb1420a0
10537	DEBIT	\N	-18600	USD	2017-02-01 10:16:20.999-05	2017-02-01 10:16:20.999-05	801	2898	1801	\N	\N	1709	1125	\N	525	USD	1	-18600	-22500	\N	2f1f031a-394d-4c7e-9fa2-9ac31936c36e	48	857	dd7863dc-4f43-4a98-8a3a-0bdf38251045
10541	DEBIT	\N	-1480	USD	2017-04-19 14:18:19.043-04	2017-04-19 14:18:19.043-04	857	3	\N	\N	\N	2519	0	\N	0	USD	1	-1480	-1480	\N	ecacab65-82d8-4736-ba9e-14702fec0997	2	857	03af26d7-0f9b-4078-a245-2f51bd327f0f
10525	DEBIT	From Deepa	0	USD	2016-04-12 17:19:00.212-04	2016-04-12 17:19:00.529-04	857	3	\N	2016-04-14 17:19:00.529-04	\N	\N	\N	\N	\N	\N	1	0	-1500	\N	62abf708-8488-4924-a563-e26e1d26616f	4	857	096bc827-7737-4ee6-971e-b26926be0c02
10563	CREDIT	\N	1198	USD	2017-04-18 20:19:14.321-04	2017-04-18 20:19:14.321-04	51	3	\N	2017-10-26 17:24:06.401-04	\N	2505	\N	\N	\N	USD	1	1198	1198	\N	608c1568-ca06-4085-8be7-1db21bc9f1fe	\N	857	2542a4b0-e38e-4160-aa99-3c9554b85490
10571	DEBIT	\N	-3562	GBP	2017-04-18 15:41:30.286-04	2017-04-18 15:41:30.286-04	857	3	\N	\N	\N	2503	0	\N	0	GBP	1	-3562	-3562	\N	6ea4ff1a-d963-4238-9c63-0c05eed47629	278	857	2620cd06-d6aa-41ff-a22a-52d8c07e80c1
10520	DEBIT	WWCode t-shirt sales	-1229	USD	2017-01-17 22:23:59.112-05	2017-01-17 22:23:59.247-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-1229	-1229	\N	2071e877-417d-456f-8234-e67a37585c52	48	857	2659df51-8fa5-40ee-a8ba-0b3691201b92
10575	DEBIT	\N	-100000	USD	2017-04-17 18:40:40.357-04	2017-04-17 18:40:40.357-04	857	3	\N	\N	\N	2490	0	\N	0	USD	1	-100000	-100000	\N	8e364354-8aab-44af-89b1-29e5968fc6bc	430	857	33937e0d-86d5-4b38-9e73-4e25b445e881
10543	CREDIT	\N	7500	USD	2017-03-31 18:52:45.079-04	2017-03-31 18:52:45.079-04	51	3	\N	2017-10-26 17:24:06.737-04	\N	2215	\N	\N	\N	USD	1	7500	7500	\N	29188cff-71a6-449f-9c0e-d34794ff3ce5	\N	857	54aba17d-9c1c-45a0-800a-6058158a1350
10549	DEBIT	\N	-7500	USD	2017-03-31 18:52:45.079-04	2017-03-31 18:52:45.079-04	857	3	\N	\N	\N	2215	0	\N	0	USD	1	-7500	-7500	\N	b16a8aad-651a-4567-a92a-949873ab6c23	286	857	54aba17d-9c1c-45a0-800a-6058158a1350
10514	CREDIT	WWCode t-shirt sales	982	USD	2017-01-17 22:24:31.362-05	2017-01-17 22:24:31.504-05	51	3	\N	2017-10-26 17:24:06.864-04	\N	\N	\N	\N	\N	\N	1	\N	982	\N	7d952ced-a637-4c82-a549-10f6f2dd5a1e	\N	857	6996f965-9b3d-4af4-a02d-c4883ee7e14f
10566	DEBIT	\N	-1480	USD	2017-04-18 20:20:11.527-04	2017-04-18 20:20:11.527-04	857	3	\N	\N	\N	2506	0	\N	0	USD	1	-1480	-1480	\N	99e5b2ef-e63e-486e-82e0-a8e20deee4be	12	857	7f4c5806-3bed-4438-8463-e948e8845912
10531	DEBIT	\N	-2930	USD	2017-05-01 20:33:45.73-04	2017-05-01 20:33:45.73-04	857	3	\N	\N	\N	2662	0	\N	0	USD	1	-2930	-2930	\N	b10035f8-8c7f-4970-a7b2-65b91327ed90	3	857	86c2ce2b-1e91-463a-820b-e068cb5a1fec
10528	DEBIT	AJUG - Global and fees	0	USD	2017-04-20 17:39:17.741-04	2017-04-20 17:39:18.323-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	0	-26250	\N	1fd2dd8b-a64f-4604-8663-65d220a290c8	12	857	9a7aa0d1-0287-47a9-8666-4502ceafda5d
10554	CREDIT	\N	1400	USD	2017-04-18 20:31:31.942-04	2017-04-18 20:31:31.942-04	51	3	\N	2017-10-26 17:24:07.11-04	\N	2507	\N	\N	\N	USD	1	1400	1400	\N	7f6dc434-19ed-4fce-a758-543e30b0dce4	\N	857	9fb9504d-f559-4f59-9239-639f8795ac3c
10583	CREDIT	\N	85000	GBP	2017-04-17 17:05:15.067-04	2017-04-17 17:05:15.067-04	51	3	\N	2017-10-26 17:24:07.411-04	\N	2474	\N	\N	\N	GBP	1	85000	85000	\N	0e6dabaa-5f3e-4b13-adaa-52915687ad80	\N	857	d7381bbe-8e6b-42cb-9759-ed2f1f81babf
10559	DEBIT	\N	-50000	USD	2017-03-31 13:17:51.695-04	2017-03-31 13:17:51.695-04	857	3	\N	\N	\N	2204	0	\N	0	USD	1	-50000	-50000	\N	37a6ac89-c997-4454-a42c-95f0cbf515f0	2	857	e4a9485f-3f41-4a06-850e-a971234a3ee5
2821	DEBIT	Wine	-1647	USD	2016-10-31 17:15:06.269-04	2016-10-31 17:15:06.517-04	2	3	1043	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1647	\N	a1c67931-46a2-4a0a-9012-60f032d6d69e	51	857	54094469-384f-4b0f-89f1-7939f95946a5
10371	DEBIT	Recurring subscription	0	MXN	2016-04-02 16:10:38.206-04	2016-04-02 16:10:38.242-04	768	80	42	2016-04-07 16:10:38.206-04	\N	68	\N	\N	\N	\N	1	0	-500	\N	7df83635-a5d8-4182-9ed5-37e10434d647	10	857	56e71cc3-2e35-4016-9aea-47125f2692ce
10373	CREDIT	Lodging and meals for our WWC Seattle 7 team members leadership development retreat. Under approved budget!	227646	USD	2016-11-29 16:46:42.259-05	2016-11-29 16:46:42.259-05	766	31	\N	\N	\N	\N	\N	\N	\N	\N	1	227646	227646	474	8acdf172-7199-40a1-99c7-a69eb1744c7b	14	857	85a217ec-4a97-4b78-84a2-cdebf5a4380a
10376	CREDIT	Monthly team meeting w core six members. Food/pizza	3323	USD	2016-10-31 17:02:15.762-04	2016-10-31 17:02:16.402-04	766	31	1024	\N	\N	\N	\N	\N	\N	\N	1	3323	3323	400	a95d3249-8dea-4cff-9710-f9525714ea7c	14	857	56420ad5-5af6-42ac-b004-d68030a128a0
10386	CREDIT	To redeem travel stipend to Google I/O	104430	USD	2017-03-27 13:54:16.729-04	2017-03-27 13:54:16.758-04	695	1331	2266	\N	\N	\N	\N	\N	4430	USD	1	104430	100000	935	7b66bd91-ebdf-495c-b73b-09f47f7928c2	277	857	b15558fe-4be4-4e66-aef3-b9e9df593f88
10391	DEBIT	Donation to WWCode Seattle	-52	USD	2016-02-02 11:36:38.327-05	2016-04-16 16:40:58.702-04	691	30	41	\N	\N	67	5	\N	33	USD	1	-52	-100	\N	30c34884-81ca-46b4-9571-b2d382c063e0	14	857	565d4e19-aaaf-4805-aabb-1934289f42f9
10398	DEBIT	Recurring subscription	-52	USD	2016-04-02 21:49:19.352-04	2016-04-16 16:40:58.819-04	688	2	46	\N	\N	72	5	\N	33	USD	1	-52	-100	\N	5fd70777-910c-4b2a-9b9c-52428764415a	13	857	79b02d11-a213-4bf1-870e-0a2aa638c5b8
10402	CREDIT	Food (ATXDivHack)	119954	USD	2016-11-18 16:01:43.887-05	2016-11-18 16:01:44.336-05	847	28	1189	\N	\N	\N	\N	\N	\N	\N	1	119954	119954	466	8432e1a1-6418-42ea-84aa-255c54c6e961	2	857	95e7f4e9-68b8-4dc0-8645-98f7eea08edd
10406	CREDIT	Markers, pens, sticky notes (ATXDivHack)	2108	USD	2016-10-31 17:13:19.592-04	2016-10-31 17:13:19.745-04	847	28	1043	\N	\N	\N	\N	\N	\N	\N	1	2108	2108	448	ee532cce-6b58-4b39-97bc-4a488fa1f2bb	2	857	44a0999f-b2ed-4be0-a3ca-1c4ac3961923
10410	CREDIT	May AI Workshop	26800	USD	2016-10-31 17:10:54.112-04	2016-10-31 17:10:54.327-04	847	28	1042	\N	\N	\N	\N	\N	\N	\N	1	26800	26800	452	cd8043c0-c322-46b3-8788-eb4a782cb1c1	2	857	ddc479b1-0893-4493-8881-f9ad8e42748a
10418	CREDIT	We Code Hackathon 2016	2374	USD	2016-12-06 11:50:34.842-05	2016-12-06 11:50:35.964-05	827	171	1191	\N	\N	\N	\N	\N	\N	\N	1	2374	2374	500	65239a5b-eb54-4710-a104-2577accc00da	59	857	fc486953-6f99-47d7-8862-2bc437d599e6
10424	CREDIT	500 gift cards, 19.62 printed awards	51962	USD	2016-10-31 17:09:11.281-04	2016-10-31 17:09:11.484-04	795	1371	1042	\N	\N	\N	\N	\N	\N	\N	1	51962	51962	416	85a8ed37-0f60-4b8d-9a77-d123e04bd6aa	300	857	006dc738-3846-441d-887c-9a2f0b20dca1
10428	DEBIT	Recurring subscription	-52	USD	2016-03-02 19:24:57.083-05	2016-04-16 16:40:58.834-04	688	2	46	\N	\N	72	5	\N	33	USD	1	-52	-100	\N	304877d9-5647-46bd-bf4a-8016d6c79306	13	857	aefdbbb2-f34e-4934-9191-3d734375feb2
10433	CREDIT	3D Printer & Supplies	30496	USD	2016-12-14 08:03:21.144-05	2016-12-14 08:03:21.949-05	696	142	1191	\N	\N	\N	\N	\N	\N	\N	1	30496	30496	591	478fe425-b3ff-40fd-b7bc-1d230ab14a0e	48	857	7fcc9779-9f25-4a5a-a591-ba20f322ec11
10461	CREDIT	Reimburse Caterina Paun for Program Expenses	9995	USD	2016-02-24 19:00:00-05	2016-06-14 14:14:22.175-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	9995	9995	224	6a9e94a8-623d-4a78-a4d9-ac9bed73215a	59	857	a4f0f2c6-69a5-4c38-8423-81df04996159
10464	CREDIT	WePay fee	125	USD	2016-04-17 18:19:12.094-04	2016-06-14 14:14:21.883-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	125	125	95	226a591f-c615-48a5-bc24-a09ae8a46dc9	13	857	ed8bc2ad-07f3-4d02-b990-415e972b4ecf
10467	CREDIT	Meetup Fees	6000	USD	2016-12-27 11:41:27.235-05	2016-12-27 11:41:27.235-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	638	d88b885c-7f60-4438-824f-5c2f5cfe0417	272	857	0f2fe6d5-6359-4065-87d4-6c3c37627fef
10474	CREDIT	Meetup Fees	6000	USD	2016-12-23 12:00:25.987-05	2016-12-23 12:00:25.987-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	617	84a715c4-b88d-4401-a254-1c4b37c72532	263	857	78d119b6-c841-468f-b1c8-e37c916138e6
10477	CREDIT	Leadership Development - Conference Travel Stipend Google I/O	130000	USD	2016-11-30 16:06:48.939-05	2016-11-30 16:06:49.116-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	130000	130000	\N	14466d14-b1ef-4faf-8f54-c67b86e7707f	241	857	6097c564-e731-4d41-89ed-eeeac61e9ed0
10486	CREDIT	90/10 split: Syema Ailia	250	USD	2016-10-04 12:06:23.454-04	2016-10-04 12:06:23.454-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	250	250	390	40eed1ea-fa3f-437c-9f1c-2912d19d5b0d	12	857	cbe30c5b-cd47-4005-b7f6-a3ad91c7ca62
10488	DEBIT	\N	-8150	USD	2017-04-20 06:17:23.286-04	2017-04-20 06:17:23.286-04	840	4348	2643	\N	\N	2532	500	\N	350	USD	1	-8150	-10000	\N	0edeee16-af82-4167-846c-97f90d37877b	59	857	9baa3883-dabc-4ae9-b35e-fa5609eda117
10490	CREDIT	Event food	2911	USD	2016-09-15 20:09:43.149-04	2016-09-15 20:09:43.531-04	827	171	573	\N	\N	\N	\N	\N	\N	\N	1	2911	2911	345	4c70ad6a-fc58-4b3e-a540-b9397b04355c	59	857	a3889d78-b131-47f4-a9bf-1ed18083bdbe
10493	DEBIT	Recurring subscription	-53	USD	2016-10-09 14:36:17.958-04	2016-10-09 14:36:17.958-04	819	8	385	\N	\N	320	5	\N	32	USD	1	-53	-100	\N	2973ff9c-dd5d-4781-b7da-ec89502dff4f	3	857	96c44820-d784-4c22-ad13-14d109443806
10500	DEBIT	Recurring subscription	-798	USD	2016-08-01 19:35:39.219-04	2016-08-01 19:35:39.244-04	803	686	461	\N	\N	386	50	\N	52	USD	1	-798	-1000	\N	cf87e549-a0e2-49ce-b4e4-32f25f8e0672	2	857	6bd18036-2cfd-40c7-89f5-7bbfdd741fd3
10503	DEBIT	Donation to WWCode Austin	-123120	USD	2016-05-03 09:07:28.39-04	2016-05-03 09:07:28.452-04	798	308	230	\N	\N	191	7500	\N	4380	USD	1	-123120	-150000	\N	ddb2655b-6ae8-4eeb-9a96-3d74b3a8d6a1	2	857	fdceece5-4ce6-4ec8-ae81-2b82052afed3
10509	DEBIT	Donation to WWCode Austin	-16530	USD	2016-08-01 11:55:27.083-04	2016-08-01 11:55:27.184-04	750	884	562	\N	\N	489	1000	\N	470	USD	1	-16530	-20000	\N	1a626101-39ec-4d3d-b6d5-0eecfdadeebf	2	857	2f4bce76-87ad-4757-a57f-676ba927bd4e
10516	DEBIT	\N	-2040	USD	2017-02-01 12:30:48.467-05	2017-02-01 12:30:48.467-05	693	2906	1804	\N	\N	1712	125	\N	85	USD	1	-2040	-2500	\N	8bb5b550-9107-41d1-a20b-ab0028126db7	271	857	d7ac7509-a0e4-4d57-be79-6391b86e6c5a
10522	CREDIT	Director t-shirt	3325	USD	2016-10-17 17:01:02.872-04	2016-10-17 17:01:02.925-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	3325	3325	\N	acf62ec0-5d40-472a-af69-5710c93964ce	298	857	e5d19c1f-a93b-4bd4-9dce-01f0923f2746
10538	DEBIT	\N	-16530	USD	2017-05-15 08:07:59.63-04	2017-05-15 08:07:59.63-04	799	4834	2922	\N	\N	2817	1000	\N	470	USD	1	-16530	-20000	\N	0a179633-4f6a-47ea-9ffa-e0f94c8c3567	14	857	1c8cb7b5-c533-490c-9fd0-1c1d4fa26ce7
10580	DEBIT	\N	-41000	GBP	2017-04-17 18:31:52.729-04	2017-04-17 18:31:52.729-04	857	3	\N	\N	\N	2486	0	\N	0	GBP	1	-41000	-41000	\N	3ecbfa5b-14f4-4d39-8bd4-5de713d7769d	278	857	15fe03d2-b134-41fa-9216-9fed2adbd399
10568	DEBIT	\N	-1198	USD	2017-04-18 20:19:14.321-04	2017-04-18 20:19:14.321-04	857	3	\N	\N	\N	2505	0	\N	0	USD	1	-1198	-1198	\N	36083f22-83b0-4511-b0b0-74e590ba99db	12	857	2542a4b0-e38e-4160-aa99-3c9554b85490
10578	DEBIT	\N	-2200	MXN	2017-04-17 18:35:55.014-04	2017-04-17 18:35:55.014-04	857	3	\N	\N	\N	2489	0	\N	0	MXN	1	-2200	-2200	\N	122d75be-9057-4752-9be1-bfc197ddede9	511	857	2a714010-92a1-46ec-86bb-3c44d3eb9282
10547	CREDIT	\N	39800	GBP	2017-03-31 14:01:48.418-04	2017-03-31 14:01:48.418-04	51	3	\N	2017-10-26 17:24:06.518-04	\N	2209	\N	\N	\N	GBP	1	39800	39800	\N	199d36af-069b-4570-b51c-e0481c074e36	\N	857	31745c67-cdeb-485e-ad15-3f61cda10313
10535	DEBIT	\N	-1190	USD	2017-04-19 14:26:58.997-04	2017-04-19 14:26:58.997-04	857	3	\N	\N	\N	2521	0	\N	0	USD	1	-1190	-1190	\N	179e7d28-12aa-4302-afa4-4aea62614165	3	857	32f9fb80-3dd9-4049-8c37-e3aca02b4aaa
10557	DEBIT	\N	-80500	GBP	2017-03-31 13:54:33.461-04	2017-03-31 13:54:33.461-04	857	3	\N	\N	\N	2208	0	\N	0	GBP	1	-80500	-80500	\N	b8650025-5978-470a-985a-84d113addcab	278	857	57341510-849e-4ffa-bdd0-0cd943049418
10581	CREDIT	\N	4250	GBP	2017-04-17 17:06:54.803-04	2017-04-17 17:06:54.803-04	51	3	\N	2017-10-26 17:24:06.807-04	\N	2475	\N	\N	\N	GBP	1	4250	4250	\N	1c4a61f3-89ea-4500-9f37-205d89b00cfe	\N	857	62eb6e83-1ce1-4f13-a8c3-6ae7b49506f8
10542	CREDIT	\N	50000	CAD	2017-03-31 19:37:30.819-04	2017-03-31 19:37:30.819-04	51	3	\N	2017-10-26 17:24:06.849-04	\N	2217	\N	\N	\N	CAD	1	50000	50000	\N	2ae148db-dfdd-47c1-867a-3a943b33c7ec	\N	857	68a158db-92ef-45db-9056-52bf74b9824b
10518	CREDIT	Intel Donation	100000	USD	2016-04-12 16:32:35.997-04	2016-04-16 16:40:58.826-04	51	3	\N	2017-10-26 17:24:06.952-04	\N	\N	\N	\N	\N	\N	1	\N	100000	\N	d302f68f-0d4d-4784-b22a-50b60e354cf7	\N	857	7a1aa808-0ccb-43fe-a676-08a86d8625c4
10551	CREDIT	\N	79600	GBP	2017-03-31 13:20:23.917-04	2017-03-31 13:20:23.917-04	51	3	\N	2017-10-26 17:24:07.069-04	\N	2206	\N	\N	\N	GBP	1	79600	79600	\N	cd9451f4-d88a-4423-8ac3-8db101c829dd	\N	857	97336c74-2a22-4072-b5de-094e4a31789f
10560	DEBIT	\N	-79600	GBP	2017-03-31 13:20:23.917-04	2017-03-31 13:20:23.917-04	857	3	\N	\N	\N	2206	0	\N	0	GBP	1	-79600	-79600	\N	cc3bc998-93ae-4fec-80c0-adb48fc7e013	267	857	97336c74-2a22-4072-b5de-094e4a31789f
10574	DEBIT	VMWare Network Support	-195000	USD	2016-10-07 15:55:50.273-04	2016-10-07 15:55:50.509-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-195000	-195000	\N	5b8e9b5b-26e2-4790-b79c-292e037706d9	300	857	97707c38-f8a1-426a-b667-3ca0b244e275
10527	CREDIT	\N	610	USD	2017-04-19 14:35:03.04-04	2017-04-19 14:35:03.04-04	51	3	\N	2017-10-26 17:24:07.096-04	\N	2522	\N	\N	\N	USD	1	610	610	\N	d9847150-964f-4ca7-a485-19f9f01fddc2	\N	857	9d897eb6-23a2-43ab-ac2c-43ee4cbe9c6e
10584	CREDIT	\N	5000	USD	2017-04-17 16:41:53.602-04	2017-04-17 16:41:53.602-04	51	3	\N	2017-10-26 17:24:07.1-04	\N	2473	\N	\N	\N	USD	1	5000	5000	\N	76a2a846-2eda-4a07-bda5-a5b3184c8722	\N	857	9e0992b8-9935-4110-a13e-07143f74c4ab
10561	DEBIT	\N	-1400	USD	2017-04-18 20:31:31.942-04	2017-04-18 20:31:31.942-04	857	3	\N	\N	\N	2507	0	\N	0	USD	1	-1400	-1400	\N	41369e71-baec-4b0b-a0ad-b6d1a2474032	195	857	9fb9504d-f559-4f59-9239-639f8795ac3c
10585	CREDIT	\N	100000	USD	2017-04-17 16:41:37.627-04	2017-04-17 16:41:37.627-04	51	3	\N	2017-10-26 17:24:07.217-04	\N	2472	\N	\N	\N	USD	1	100000	100000	\N	b2b1327f-fbf4-437e-943a-91082da07fb5	\N	857	b50454f3-a3f7-4689-83a4-c55b078a35b2
10589	CREDIT	\N	4000	GBP	2017-04-17 15:31:52.919-04	2017-04-17 15:31:52.919-04	51	3	\N	2017-10-26 17:24:07.377-04	\N	2470	\N	\N	\N	GBP	1	4000	4000	\N	198456e2-7b3e-4cf6-af06-274da5f51291	\N	857	d44dae99-dde7-4703-9e3a-4abcb9360ebe
3619	DEBIT	Banner	-2000	USD	2016-11-30 16:19:46.014-05	2016-11-30 16:19:46.128-05	269	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-2000	\N	549a4d38-14e9-451f-af59-00b70014bc58	51	857	0568e3fa-e5d8-491b-9e77-6c8442a50615
10374	CREDIT	Google DevFest event that WWC sponsored and attended. Two large banners. Table cloth. Plus my luggage since I went directly from airport. 	1305	USD	2016-10-31 13:52:11.82-04	2016-10-31 13:52:12.734-04	766	31	1024	\N	\N	\N	\N	\N	\N	\N	1	1305	1305	427	cef16fc4-e358-4107-afe3-64fc57f0b64a	14	857	144016ba-1773-45e1-896c-44bbd701aa14
10379	CREDIT	Lunch w Saranya during leads meeting. I lost the paper copy of the receipt so including the credit card statement 	5458	USD	2017-02-22 10:27:45.429-05	2017-02-22 10:27:45.466-05	766	31	1893	\N	\N	\N	\N	\N	\N	\N	1	5458	5458	775	80c59c3d-fb55-4e90-8200-5447558ae49c	14	857	3d5b1eb8-9bc2-45b8-b700-15d23ccbc5e5
10385	CREDIT	Monthly core team lunch with Sandra Saranya Sara CiCi Tori (5 members) ; on boarding new core member Tori!	10294	USD	2016-08-02 09:38:05.215-04	2016-08-02 09:38:05.831-04	766	31	320	\N	\N	\N	\N	\N	\N	\N	1	10294	10294	255	c58be1df-7706-47ae-9e4e-3599221ed561	14	857	44111c28-a19e-4f46-a1a6-c8fbebfcd835
10390	DEBIT	Recurring subscription	-52	USD	2016-05-02 14:10:42.774-04	2016-05-02 14:10:42.847-04	691	30	43	\N	\N	69	5	\N	33	USD	1	-52	-100	\N	eddad9dd-dd28-4968-a3e2-a7029f8b3a85	13	857	2e05f979-40cc-4b6c-820e-0a3d58863049
10392	DEBIT	Recurring subscription	-52	USD	2016-03-02 12:53:54.346-05	2016-04-16 16:40:58.736-04	691	30	41	\N	\N	67	5	\N	33	USD	1	-52	-100	\N	f8275f19-1ae2-4d3a-95da-b03c268e1d63	14	857	58b59a09-5be7-4b53-96d0-4e1599668e0f
10396	DEBIT	Recurring subscription	-52	USD	2016-05-02 20:15:49.65-04	2016-05-02 20:15:49.711-04	688	2	46	\N	\N	72	5	\N	33	USD	1	-52	-100	\N	f30b2c2c-40aa-4add-80ef-2b61d0d25dfc	13	857	575052a3-9e1c-4fa2-8ab2-b6d3ec794e1b
10408	CREDIT	June South Hack Night	20568	USD	2016-10-31 17:11:20.573-04	2016-10-31 17:11:20.753-04	847	28	1042	\N	\N	\N	\N	\N	\N	\N	1	20568	20568	451	1a4790e3-8a9a-4dcf-8817-9561f8a40f14	2	857	8b640bae-f50c-4f7a-9ac2-fd8eb0604f94
10412	CREDIT	DJ (ATXDivHack)	35000	USD	2016-10-27 17:08:48.506-04	2016-10-27 17:08:48.71-04	847	28	1024	\N	\N	\N	\N	\N	\N	\N	1	35000	35000	453	710126aa-8369-4c48-a4d2-cb924ae1102a	2	857	ef5e10c6-a5eb-4754-8611-d3e59c8d659e
10413	CREDIT	Thank you cards, Christmas cards, stamps (for hackathon and all 2016 sponsors)	4874	USD	2016-11-22 16:55:10.575-05	2016-11-22 16:55:10.713-05	827	171	1191	\N	\N	\N	\N	\N	\N	\N	1	4874	4874	498	72f8d47a-d800-4068-8a48-9bfadef6381c	59	857	1931df99-c5d5-42af-aae3-ffc3038eb6a0
10416	CREDIT	Marketing Materials	2475	USD	2016-10-05 12:45:14.357-04	2016-10-05 12:45:14.485-04	827	171	573	\N	\N	\N	\N	\N	\N	\N	1	2475	2475	376	c933d96d-b58e-4c8e-871c-625119083ddc	59	857	5d6ec404-9928-4fcd-ac2e-15dc65071fe2
10422	CREDIT	WWCode Seattle planning lunch with Sara	2700	USD	2016-10-31 13:52:44.962-04	2016-10-31 13:52:45.274-04	797	32	1024	\N	\N	\N	\N	\N	\N	\N	1	2700	2700	420	7ea695be-a0cd-4b83-9d65-6d6b3b8db6e1	14	857	b2df7d58-e036-4806-ae38-c80cf969e5a9
10423	CREDIT	lunch ordered at Costco	64978	USD	2016-10-28 17:30:59.537-04	2016-10-28 17:30:59.772-04	795	1371	1024	\N	\N	\N	\N	\N	\N	\N	1	64978	64978	418	a83370a1-edb3-43fd-af8b-6779d03e514f	300	857	e07a423d-3ffd-4f9e-8151-3bdc13b4c2df
10432	CREDIT	Leadership - Planning for 2017 - Dinner	9240	USD	2016-12-19 13:45:09.113-05	2016-12-19 13:45:09.64-05	696	142	1191	\N	\N	\N	\N	\N	\N	\N	1	9240	9240	602	14649652-aaf4-43fe-92a9-98bbded7f715	48	857	0b88f790-7ef8-4c0d-bffe-09be53b838a8
10434	CREDIT	Website - Domain Name	2200	USD	2016-12-22 17:19:51.088-05	2016-12-22 17:19:52.143-05	696	142	1476	\N	\N	\N	\N	\N	\N	\N	1	2200	2200	372	f429e1f1-6783-4f16-891f-7d0ab70b9d34	48	857	e11bc7ca-5cee-4121-87c2-77aca0b7bc00
10437	CREDIT	Two VR headsets for our AR/VR event at Best Buy.	4898	USD	2016-09-27 15:31:43.164-04	2016-09-27 15:31:43.42-04	696	142	573	\N	\N	\N	\N	\N	\N	\N	1	4898	4898	366	fdca81cf-7318-440b-abf5-38bbb45f28d5	48	857	dee30261-9267-4820-97f8-ea7b59fc6215
10444	DEBIT	monthly recurring subscription	-798	USD	2017-03-01 18:40:00.024-05	2017-03-01 18:40:00.024-05	803	686	461	\N	\N	386	50	\N	52	USD	1	-798	-1000	\N	1f6fabc7-b4c6-4adb-b12b-9087646b1b97	2	857	14d20a9a-9ac1-49e0-bd39-e31b6cb8136d
10447	CREDIT	WwConnect2016	1025	USD	2016-03-19 20:00:00-04	2016-06-14 14:14:21.806-04	766	31	26	\N	\N	\N	\N	\N	\N	\N	1	1025	1025	64	a0a655e4-f6e1-4af9-bba0-2d5095256dfd	14	857	67b94b33-115e-4d61-afca-f71bd79b4328
10454	CREDIT	Movie screening for "She Started It"	26475	USD	2017-03-14 13:59:53.142-04	2017-03-14 13:59:53.153-04	696	142	2149	\N	\N	\N	\N	\N	775	USD	1	26475	25700	814	ee1fa75a-63c5-43f0-bcb2-3d1e9f278c82	48	857	3357306e-955f-4b74-b4ad-ad2f0f1f84fb
10457	CREDIT	Post-hackathon shipping supplies + supplies for Women + Tech Holiday Party	3776	USD	2016-12-13 13:41:20.962-05	2016-12-13 13:41:21.652-05	51	3	1191	\N	\N	\N	\N	\N	\N	\N	1	3776	3776	\N	64cd4461-47d8-4f2b-b3ef-605b394a1813	59	857	ad0da767-c1f5-4225-aed3-87879a26e119
10470	CREDIT	Meetup Fees	6000	USD	2016-12-23 12:21:53.018-05	2016-12-23 12:21:53.018-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	621	180716a0-87ee-47b3-8384-ab68574917e8	259	857	56d9fbe4-73d8-4547-ade3-e6577e190e65
10473	CREDIT	Meetup Fees	4900	GBP	2016-12-23 12:05:41.927-05	2016-12-23 12:05:41.927-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	4900	4900	618	bab61661-b72c-4e2c-b847-bc8cb2f0ff81	264	857	fef8070e-9c22-4edb-b65d-63d1181e7962
10478	CREDIT	Banner	2000	USD	2016-11-30 13:40:24.258-05	2016-11-30 13:40:24.443-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	2000	2000	\N	2bcc3915-ccc3-4128-a390-330239018d9a	292	857	3fe0cd40-23e1-4791-b0bf-4b808bbeec1e
10480	CREDIT	Photos for sponsor gifts	2104	USD	2016-11-30 11:11:36.238-05	2016-11-30 11:11:36.377-05	51	3	1191	\N	\N	\N	\N	\N	\N	\N	1	2104	2104	\N	f354cbc7-50b0-4d3f-84cf-003dc57cae81	2	857	30c4f29c-3f4f-4da6-900c-c064b137eeb1
10483	CREDIT	A Small Orange	12700	USD	2016-02-01 19:00:00-05	2016-06-14 14:14:22.114-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	12700	12700	194	cd9ede6d-4077-4287-9409-cb5f8dffbf1c	48	857	d516acab-24fb-42d9-bce7-274334af0457
10485	CREDIT	Network Stickers	58590	USD	2016-10-06 12:08:07.615-04	2016-10-06 12:08:07.66-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	58590	58590	\N	d4477335-a08a-4d3f-af52-171f061a7957	3	857	f0af53e4-c393-4b2b-9ee5-97189f281ec3
10491	DEBIT	Donation to WWCode Washington DC	-41020	USD	2016-04-28 11:01:17.801-04	2016-04-28 11:01:17.846-04	824	283	213	\N	\N	181	2500	\N	1480	USD	1	-41020	-50000	\N	a77c8175-77c3-45ee-9cb8-27158d6b495a	13	857	bcf62fcc-21ca-4088-ad5a-5b2e4db42742
10495	DEBIT	Recurring subscription	-53	USD	2016-08-09 14:30:50.866-04	2016-08-09 14:30:50.915-04	819	8	385	\N	\N	320	5	\N	32	USD	1	-53	-100	\N	84247101-f4be-4420-8b14-97e25b5fc04e	3	857	ade1e70e-c0e3-40c7-83f4-57497a017f5a
10497	DEBIT	Recurring subscription	-52	USD	2016-04-02 22:02:46.616-04	2016-04-16 16:40:58.82-04	819	8	45	\N	\N	71	5	\N	33	USD	1	-52	-100	\N	d2263b61-c84d-4ff0-a7c4-7ae8f33081b6	14	857	ed79af13-e4da-4803-be3a-b46bea674f81
10506	DEBIT	Donation to WWCode Atlanta	-53	USD	2016-06-21 12:02:56.072-04	2016-06-21 12:02:56.13-04	775	642	430	\N	\N	359	5	\N	32	USD	1	-53	-100	\N	37739cdc-d90f-49b5-a37d-334a0930b3d3	12	857	1cb2467d-069e-4a93-868b-dae1605e8f4f
10508	DEBIT	Recurring subscription	-798	USD	2017-01-14 12:12:01.244-05	2017-01-14 12:12:01.244-05	763	2549	1616	\N	\N	1531	50	\N	52	USD	1	-798	-1000	\N	af6a9f2a-96ad-4c10-823b-889fa6239006	270	857	d07c3b37-d6b0-431a-8590-6ed01a245180
10510	DEBIT	Donation to WWCode Austin	-41020	USD	2016-05-23 16:27:28.524-04	2016-05-23 16:27:28.599-04	741	426	306	\N	\N	258	2500	\N	1480	USD	1	-41020	-50000	\N	90c408ec-9ba9-4251-81a8-497b05da011e	2	857	b3ab8e62-2bba-465d-b59a-7c3b382f42e9
10513	DEBIT	\N	-8250	USD	2017-01-18 08:54:50.597-05	2017-01-18 08:54:50.597-05	697	2594	1647	\N	\N	1557	500	\N	250	USD	1	-8250	-10000	\N	275ad4b2-e6e7-4c08-870b-ef6418bd9e33	48	857	cdca0239-f450-405c-8dcc-6c7e3a818b76
10536	DEBIT	\N	-26301	CAD	2017-02-27 19:25:20.325-05	2017-02-27 19:25:20.325-05	837	3301	2030	\N	\N	1935	1121	\N	523	USD	1.33832976445396001	-19652	-30000	\N	5f702c03-a15a-4104-8b46-1ba080c76f1a	522	857	36909743-d7f1-4034-b022-385cd5eba285
10539	DEBIT	\N	-384	USD	2017-05-01 13:13:34.851-04	2017-05-01 13:13:34.851-04	785	4550	2757	\N	\N	2644	25	\N	41	USD	1	-384	-500	\N	8eb3997b-24ac-48e7-b74a-ddf4bcabbcb8	516	857	02193e7b-d320-4f42-9625-c8b44e09fd56
10607	CREDIT	\N	50000	USD	2017-03-27 13:10:04.622-04	2017-03-27 13:10:04.622-04	51	3	\N	2017-10-26 17:24:06.741-04	\N	2151	\N	\N	\N	USD	1	50000	50000	\N	f2df4b9c-f715-4812-8130-aa52ad74b4fe	\N	857	559fef52-c712-4037-b931-794b5fd83777
10548	CREDIT	\N	80500	GBP	2017-03-31 13:54:33.461-04	2017-03-31 13:54:33.461-04	51	3	\N	2017-10-26 17:24:06.752-04	\N	2208	\N	\N	\N	GBP	1	80500	80500	\N	d03356c8-6676-4f5a-9337-9fb7b7479c72	\N	857	57341510-849e-4ffa-bdd0-0cd943049418
10526	DEBIT	Intel Donation	-100000	USD	2016-04-12 16:32:35.997-04	2016-04-16 16:40:58.826-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-100000	-100000	\N	e18809b3-0f9b-494e-a680-f858f9c790c0	59	857	7a1aa808-0ccb-43fe-a676-08a86d8625c4
10565	CREDIT	VMWare Network Support	195000	USD	2016-10-07 15:55:50.273-04	2016-10-07 15:55:50.509-04	51	3	\N	2017-10-26 17:24:07.073-04	\N	\N	\N	\N	\N	\N	1	\N	195000	\N	dcd5b7de-24d3-46e7-b3aa-5172d7cd4ce5	\N	857	97707c38-f8a1-426a-b667-3ca0b244e275
10532	DEBIT	\N	-610	USD	2017-04-19 14:35:03.04-04	2017-04-19 14:35:03.04-04	857	3	\N	\N	\N	2522	0	\N	0	USD	1	-610	-610	\N	595f2558-3f68-453b-8531-6a420cd10b0f	59	857	9d897eb6-23a2-43ab-ac2c-43ee4cbe9c6e
10592	DEBIT	\N	-100000	USD	2017-04-17 16:41:37.627-04	2017-04-17 16:41:37.627-04	857	3	\N	\N	\N	2472	0	\N	0	USD	1	-100000	-100000	\N	c0b3b45e-a0c6-42a5-91ec-ffae5c7b77d3	517	857	b50454f3-a3f7-4689-83a4-c55b078a35b2
10544	CREDIT	\N	20000	USD	2017-03-31 18:50:23.915-04	2017-03-31 18:50:23.915-04	51	3	\N	2017-10-26 17:24:07.57-04	\N	2214	\N	\N	\N	USD	1	20000	20000	\N	0e62d293-5c9f-4083-ac27-2771c2d1c474	\N	857	fb8d08c5-1993-4c53-aaa1-516e6089ea27
10553	DEBIT	\N	-20000	USD	2017-03-31 18:50:23.915-04	2017-03-31 18:50:23.915-04	857	3	\N	\N	\N	2214	0	\N	0	USD	1	-20000	-20000	\N	8c2a3542-6787-48cd-8aea-4cdfedc60d2d	286	857	fb8d08c5-1993-4c53-aaa1-516e6089ea27
10639	DEBIT	Recurring subscription	-52	USD	2016-06-09 13:28:30.802-04	2016-06-09 13:28:30.841-04	819	8	385	\N	\N	320	5	\N	33	USD	1	-52	-100	\N	b9510610-0bf8-4db2-8bf8-9244c14e5bf8	3	857	7bfcd82b-3824-4271-a190-c735e93cce4a
10640	DEBIT	Recurring subscription	-798	USD	2017-01-01 18:32:21.416-05	2017-01-01 18:32:21.416-05	803	686	461	\N	\N	386	50	\N	52	USD	1	-798	-1000	\N	c1cfbb92-13b4-4dab-ac0f-cfd8a8cc5fcc	2	857	f931abed-f721-4561-8287-6c8e4f1c700c
10704	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-23 14:48:39.526-05	2016-12-23 14:48:39.685-05	51	3	\N	2017-10-26 17:24:06.26-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	a7e6e164-0408-425a-943a-c8729a7e943a	\N	857	021ea432-c8b9-47b1-a087-d11a98cdae64
10696	DEBIT	Global Development for Meetup Fee	-6000	USD	2016-12-27 11:14:47.836-05	2016-12-27 11:14:47.951-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	2c5b8b31-0507-4944-b902-0fdb957414ea	271	857	0b4d9711-eb14-40a5-aad5-e93397374037
10611	CREDIT	\N	90000	USD	2017-05-11 12:41:16.759-04	2017-05-11 12:41:16.759-04	51	3	\N	2017-10-26 17:24:06.364-04	\N	2794	\N	\N	\N	USD	1	90000	90000	\N	bb618b85-6a86-4e87-a0af-a51b5d0d3952	\N	857	19be5c14-eec7-42c1-82d0-8d9429e3df0e
10790	CREDIT	$1000 Mozilla hackathon support - Global Development	90000	USD	2016-11-17 13:21:06.154-05	2016-11-17 13:21:07.268-05	51	3	\N	2017-10-26 17:24:06.435-04	\N	\N	\N	\N	\N	\N	1	\N	90000	\N	7f7c2c36-0491-4a2a-bbe4-66b04d75dbda	\N	857	27e84d4a-5125-460d-a160-640f89ef7980
10796	DEBIT	$1000 Mozilla hackathon support - Global Development	-90000	USD	2016-11-17 13:21:06.154-05	2016-11-17 13:21:07.268-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-90000	-90000	\N	65b137ce-6927-4fef-9a00-e2f8562afb72	59	857	27e84d4a-5125-460d-a160-640f89ef7980
10677	CREDIT	Global Development for Meetup Fee	6000	MXN	2016-12-27 12:59:52.939-05	2016-12-27 12:59:53.047-05	51	3	\N	2017-10-26 17:24:06.44-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	38b7d680-cff9-4e9c-aee7-33b938f3db9d	\N	857	27fe73bb-fd67-4a9c-a21d-47233c8c41e5
10569	CREDIT	\N	2200	MXN	2017-04-17 18:35:55.014-04	2017-04-17 18:35:55.014-04	51	3	\N	2017-10-26 17:24:06.466-04	\N	2489	\N	\N	\N	MXN	1	2200	2200	\N	1baeed81-03b2-427f-b389-f1a0b4b9b796	\N	857	2a714010-92a1-46ec-86bb-3c44d3eb9282
10729	DEBIT	VMWare foundation Donation - global development (Ramya V., Swathi U. and Anonymous) 	0	USD	2017-04-07 12:43:42.261-04	2017-04-07 12:43:42.673-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	0	-24750	\N	0402cc5c-a652-44c2-b9e9-edc573a78e36	262	857	2c703f5f-0ba5-4961-9cd1-1d82e9347ad4
10701	DEBIT	Global Development for Meetup Fee	-6000	USD	2016-12-28 11:27:36.9-05	2016-12-28 11:27:33.309-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	a3921592-c9f9-48c2-978a-9ddad302a36c	292	857	2fe08efc-1f65-4e3c-82eb-70cc4b462a78
10769	DEBIT	Banner	-2000	USD	2016-11-29 17:34:22.96-05	2016-11-29 17:34:23.085-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-2000	-2000	\N	db05479f-2622-44c6-b2cd-6d65a38e8def	47	857	316c2403-9435-4fd6-b50e-875509e5b0e1
10600	DEBIT	WOMEN TECHMAKER WWCODE PARTNERSHIP GRANT	-34750	USD	2016-05-26 16:50:28.413-04	2016-05-26 16:50:28.721-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-34750	-34750	\N	da03d011-fe9b-42dc-a957-82227f949586	59	857	52559260-4928-4453-a298-1b9dfd7cc130
10781	CREDIT	Global Development	20000	USD	2016-11-29 16:56:45.442-05	2016-11-29 16:56:45.713-05	51	3	\N	2017-10-26 17:24:06.727-04	\N	\N	\N	\N	\N	\N	1	\N	20000	\N	fcc477ff-55d4-475a-9d05-04b77db2792d	\N	857	53ad6d74-130a-40d7-94c2-b57853a3b87b
10786	DEBIT	Global Development	-20000	USD	2016-11-29 16:56:45.442-05	2016-11-29 16:56:45.713-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-20000	-20000	\N	06c7ee68-5309-478f-aec7-183b8809864f	290	857	53ad6d74-130a-40d7-94c2-b57853a3b87b
10614	CREDIT	Leadership Development: Google I/O travel grant for Gen A. 	85000	USD	2017-03-27 09:25:14.008-04	2017-03-27 09:25:14.169-04	51	3	\N	2017-10-26 17:24:06.732-04	\N	\N	\N	\N	\N	\N	1	\N	85000	\N	add0b732-a33b-4c32-8d09-0098d4a06b5e	\N	857	53b0b458-283d-4f3d-b93c-e48c07be82db
10619	DEBIT	Leadership Development: Google I/O travel grant for Gen A. 	-85000	USD	2017-03-27 09:25:14.008-04	2017-03-27 09:25:14.169-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-85000	-85000	\N	297f9eb3-f31c-492e-8e32-dce42baf21ec	278	857	53b0b458-283d-4f3d-b93c-e48c07be82db
10615	DEBIT	\N	-50000	USD	2017-03-27 13:10:04.622-04	2017-03-27 13:10:04.622-04	857	3	\N	\N	\N	2151	0	\N	0	USD	1	-50000	-50000	\N	603fad75-fa14-4a74-9e2c-c290f18242ec	12	857	559fef52-c712-4037-b931-794b5fd83777
10684	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-27 11:30:02.12-05	2016-12-27 11:30:02.272-05	51	3	\N	2017-10-26 17:24:06.769-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	13db702a-3609-4aae-8951-4eb881992b6a	\N	857	5ea33403-2a6e-4edb-a01c-15e81630b4a1
10692	DEBIT	Global Development for Meetup Fee	-6000	USD	2016-12-27 11:30:02.12-05	2016-12-27 11:30:02.272-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	31dc9daa-dfd5-412a-a990-501bd263bb56	15	857	5ea33403-2a6e-4edb-a01c-15e81630b4a1
10652	DEBIT	WWCode t-shirt sales	-2371	USD	2017-01-17 22:33:30.061-05	2017-01-17 22:33:30.587-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-2371	-2371	\N	8c8baf25-c410-4176-a847-7c65964ddfb3	271	857	61262692-fde2-4eb7-a4d7-a23139a3777f
10623	CREDIT	Donations via meetup - fees/global development	2000	USD	2017-02-06 17:56:24.306-05	2017-02-06 17:56:24.52-05	51	3	\N	2017-10-26 17:24:06.814-04	\N	\N	\N	\N	\N	\N	1	\N	2000	\N	59820076-570a-4400-a2af-e560bc94b7e2	\N	857	638165e0-f340-4e3f-8a80-44f4c89a627f
10629	DEBIT	Donations via meetup - fees/global development	-20	USD	2017-02-06 17:56:24.306-05	2017-02-06 17:56:24.52-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-20	-2000	\N	7b32acd4-c69d-4f87-b136-886358c4550d	272	857	638165e0-f340-4e3f-8a80-44f4c89a627f
10742	DEBIT	Global Development for Meetup Fee	-6000	USD	2016-12-27 14:44:22.123-05	2016-12-27 14:44:22.207-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	dc12e07c-b221-4ebd-a41f-24a6237d3f11	287	857	6abcfc7b-a15c-4276-8266-75157b82acec
10577	DEBIT	\N	-18800	MXN	2017-04-17 18:35:06.093-04	2017-04-17 18:35:06.093-04	857	3	\N	\N	\N	2488	0	\N	0	MXN	1	-18800	-18800	\N	3719bce5-1fa6-4796-bbf2-3619d46abe61	511	857	702f7f1e-3e93-4453-8775-1c1da30be9cb
10657	CREDIT	Leadership Development: Google I/O grant for Luisa M.	100000	USD	2017-03-22 13:56:10.528-04	2017-03-22 13:56:10.804-04	51	3	\N	2017-10-26 17:24:06.998-04	\N	\N	\N	\N	\N	USD	1	\N	100000	\N	a22df62b-1e64-4d5f-879b-4c4d5e67cd44	\N	857	86a60d8f-36a3-48ca-8ce0-3f89fab2730b
10662	DEBIT	Leadership Development: Google I/O grant for Luisa M.	-100000	USD	2017-03-22 13:56:10.528-04	2017-03-22 13:56:10.804-04	857	3	\N	\N	\N	\N	\N	\N	\N	USD	1	-100000	-100000	\N	3bfa2f4c-25a2-4425-9a5a-66f3b532ec77	3	857	86a60d8f-36a3-48ca-8ce0-3f89fab2730b
10665	CREDIT	Global Development for Meetup Fee	6000	AUD	2016-12-28 10:55:25.022-05	2016-12-28 10:55:21.475-05	51	3	\N	2017-10-26 17:24:07.013-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	6dd15e1d-f25a-4ae3-ac6a-48e3ee75287d	\N	857	8a50dec8-e8ca-4a58-a350-d6d40e08679d
10673	DEBIT	Global Development for Meetup Fee	-6000	AUD	2016-12-28 10:55:25.022-05	2016-12-28 10:55:21.475-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	d64cd8d6-4713-4898-9021-ecc9daf7343c	297	857	8a50dec8-e8ca-4a58-a350-d6d40e08679d
10605	CREDIT	\N	20000	USD	2017-03-27 13:45:17.58-04	2017-03-27 13:45:17.58-04	51	3	\N	2017-10-26 17:24:07.064-04	\N	2152	\N	\N	\N	USD	1	20000	20000	\N	aaa913a9-c544-41bb-bd68-35bae3f80b42	\N	857	955581ef-affc-4ff3-80a6-ccb62a88553d
10591	DEBIT	\N	-5000	USD	2017-04-17 16:41:53.602-04	2017-04-17 16:41:53.602-04	857	3	\N	\N	\N	2473	0	\N	0	USD	1	-5000	-5000	\N	d9f77921-5d8b-4171-b4fb-d2ac3422a760	517	857	9e0992b8-9935-4110-a13e-07143f74c4ab
10718	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-23 11:32:00.456-05	2016-12-23 11:32:00.622-05	51	3	\N	2017-10-26 17:24:07.242-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	e78ae31b-de95-4cca-9b00-1450ea143129	\N	857	bb988f08-f90e-4c44-9752-5ee09cb61b46
10776	CREDIT	Global Development	15600	USD	2016-11-29 17:08:18.065-05	2016-11-29 17:08:18.213-05	51	3	\N	2017-10-26 17:24:07.261-04	\N	\N	\N	\N	\N	\N	1	\N	15600	\N	3ec68d73-039a-43f8-b07b-816d20a57d94	\N	857	be29d23b-9b29-4c81-8416-3ebde1421789
10784	DEBIT	Global Development	-15600	USD	2016-11-29 17:08:18.065-05	2016-11-29 17:08:18.213-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-15600	-15600	\N	0ffcc978-a2fb-4e20-9afb-095916f77daf	241	857	be29d23b-9b29-4c81-8416-3ebde1421789
10706	DEBIT	Global Development for Meetup Fee	-6000	CAD	2016-12-28 11:21:14.024-05	2016-12-28 11:21:10.449-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	5134fbb7-ff19-4c60-a3bf-83d6684a0878	291	857	c33180c2-c01a-4d7f-b9cb-179396b93072
10745	CREDIT	Global Development - Thanks VMWare	50000	USD	2016-11-30 16:34:00.324-05	2016-11-30 16:34:01.658-05	51	3	\N	2017-10-26 17:24:07.295-04	\N	\N	\N	\N	\N	\N	1	\N	50000	\N	1d5269cd-536a-4474-9fa0-2617549a15df	\N	857	c6fd0248-2ece-4617-8ae8-2b156a417ca9
10753	DEBIT	Global Development - Thanks VMWare	-50000	USD	2016-11-30 16:34:00.324-05	2016-11-30 16:34:01.658-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-50000	-50000	\N	d1972c0e-b33a-4443-825a-357292a8cebe	263	857	c6fd0248-2ece-4617-8ae8-2b156a417ca9
10602	CREDIT	\N	100000	USD	2017-03-27 13:53:48.539-04	2017-03-27 13:53:48.539-04	51	3	\N	2017-10-26 17:24:07.319-04	\N	2154	\N	\N	\N	USD	1	100000	100000	\N	0f9df282-b797-4fac-bc6a-7078affd4d42	\N	857	ca03e9c0-a1ed-4c24-ac05-14b3146ea528
10596	DEBIT	\N	-4000	GBP	2017-04-17 15:31:52.919-04	2017-04-17 15:31:52.919-04	857	3	\N	\N	\N	2470	0	\N	0	GBP	1	-4000	-4000	\N	0863cb54-6334-45e7-9676-35e571cf9940	267	857	d44dae99-dde7-4703-9e3a-4abcb9360ebe
10755	DEBIT	Banner	-2000	USD	2016-11-30 16:33:30.25-05	2016-11-30 16:33:30.386-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-2000	-2000	\N	5fe5247f-7146-4d75-b3e7-700414fd260b	263	857	da7ad689-969d-4d74-8792-8236c6bb6d88
10721	CREDIT	Travel Stipend for Google I/O	100000	USD	2017-03-20 11:17:43.622-04	2017-03-20 11:17:42.994-04	51	3	\N	2017-10-26 17:24:07.431-04	\N	\N	\N	\N	\N	\N	1	\N	100000	\N	f759014c-ec7d-4160-9244-3b884754156b	\N	857	db531c4e-3d6c-4a42-9b40-e3bafdbf0643
10725	DEBIT	Travel Stipend for Google I/O	-100000	USD	2017-03-20 11:17:43.622-04	2017-03-20 11:17:42.994-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-100000	-100000	\N	bca5dbec-d9c7-46e9-a6ea-0bc072534ef1	277	857	db531c4e-3d6c-4a42-9b40-e3bafdbf0643
10609	DEBIT	Quotient Hackathon support	-90000	USD	2016-10-07 15:52:59.206-04	2016-10-07 15:52:59.391-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-90000	-90000	\N	4f7b6d47-9a65-4c31-ab8d-eb1dacd83656	300	857	deef5358-a3c6-4bce-8b9b-a3f815f6e8f7
10647	CREDIT	WWCode t-shirt sales	2778	USD	2017-01-17 22:30:54.132-05	2017-01-17 22:30:54.465-05	51	3	\N	2017-10-26 17:24:07.475-04	\N	\N	\N	\N	\N	\N	1	\N	2778	\N	36f34378-571e-42ef-aa77-d9eee343b66f	\N	857	e18b08fe-c669-4bbd-af27-8e4dc1043b8f
10772	CREDIT	Erica S. donation - fees	450	USD	2016-11-29 17:12:36.336-05	2016-11-29 17:12:36.503-05	51	3	\N	2017-10-26 17:24:07.538-04	\N	\N	\N	\N	\N	\N	1	\N	450	\N	1c7672d4-962a-44f4-9ad8-1a989c8948fb	\N	857	f1fa1b76-776f-4ad8-b56c-bf348e04f9d3
10634	DEBIT	\N	-69522	USD	2017-05-09 14:14:23.283-04	2017-05-09 14:14:23.283-04	846	4720	2860	\N	\N	2755	4200	\N	1878	USD	1	-69522	-84000	\N	2696cf15-6f50-4ecf-809e-03ff7f322909	2	857	9c56799f-e918-4d1f-9588-7ea87dfe2f3c
10641	DEBIT	monthly recurring subscription	-798	USD	2017-04-10 00:43:06.965-04	2017-04-10 00:43:06.965-04	737	1158	731	\N	\N	647	50	\N	52	USD	1	-798	-1000	\N	b5d41b35-d09e-4032-a02a-fedc64ab7bfb	241	857	da55f5ff-aa9c-425a-b558-0fb257ef541c
10738	DEBIT	monthly recurring subscription	-2040	USD	2017-04-01 14:31:19.231-04	2017-04-01 14:31:19.231-04	693	2906	1804	\N	\N	1712	125	\N	85	USD	1	-2040	-2500	\N	d55e17e8-7bea-438a-86a9-1077fbe980f9	271	857	911b118a-dcd0-4fd3-a1cd-5e6112953765
10636	DEBIT	monthly recurring subscription	-53	USD	2017-04-09 14:28:49.104-04	2017-04-09 14:28:49.104-04	819	8	385	\N	\N	320	5	\N	32	USD	1	-53	-100	\N	726f60ca-acf7-4581-9bb9-913b790c70f2	3	857	4658e3a5-68e2-4298-8fd9-476f719cf93a
10689	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-27 11:14:47.836-05	2016-12-27 11:14:47.951-05	51	3	\N	2017-10-26 17:24:06.309-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	3ff55177-1a42-4a57-85ea-b4347dd6e691	\N	857	0b4d9711-eb14-40a5-aad5-e93397374037
10785	DEBIT	Network Development - 10k member bonus	-100000	USD	2016-11-29 16:58:23.625-05	2016-11-29 16:58:23.799-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-100000	-100000	\N	8f2bfb65-e6c9-44f4-921a-bdf2235dca95	4	857	0dd3db16-97eb-4b65-8cb9-c91554d5d325
10646	CREDIT	WWCode t-shirt sales	4742	USD	2017-01-17 22:31:50.631-05	2017-01-17 22:31:50.774-05	51	3	\N	2017-10-26 17:24:06.368-04	\N	\N	\N	\N	\N	\N	1	\N	4742	\N	ca764479-2ed5-4e49-981d-42e816521f0f	\N	857	1a2a9657-2411-47ba-97d6-7859927031ac
10654	DEBIT	WWCode t-shirt sales	-4742	USD	2017-01-17 22:31:50.631-05	2017-01-17 22:31:50.774-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-4742	-4742	\N	e235086b-c93b-4adb-8b74-48d9e107eac3	2	857	1a2a9657-2411-47ba-97d6-7859927031ac
10714	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-23 11:45:15.022-05	2016-12-23 11:45:15.147-05	51	3	\N	2017-10-26 17:24:06.425-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	45cc328a-8e31-4932-ba15-07e31fa928ac	\N	857	26d0a91a-685b-4369-a20b-f44fefdf9da8
10763	CREDIT	Banner	2000	USD	2016-11-29 17:34:22.96-05	2016-11-29 17:34:23.085-05	51	3	\N	2017-10-26 17:24:06.513-04	\N	\N	\N	\N	\N	\N	1	\N	2000	\N	419aa5ca-920b-4c58-866a-0a1b8e8334c6	\N	857	316c2403-9435-4fd6-b50e-875509e5b0e1
10698	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-28 11:24:49.292-05	2016-12-28 11:24:45.838-05	51	3	\N	2017-10-26 17:24:06.527-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	cacd6421-ea0f-486d-bd49-8956e85cf4cc	\N	857	320ad09e-b535-4551-be83-ae6e1bceef36
10702	DEBIT	Global Development for Meetup Fee	-6000	USD	2016-12-28 11:24:49.292-05	2016-12-28 11:24:45.838-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	a23de4dc-6bcb-4e82-a01c-d5919eb9730b	48	857	320ad09e-b535-4551-be83-ae6e1bceef36
10733	DEBIT	\N	-20000	USD	2017-04-07 08:25:51.09-04	2017-04-07 08:25:51.09-04	857	3	\N	\N	\N	2393	0	\N	0	USD	1	-20000	-20000	\N	2b62d0f2-4d1c-4c55-b8fa-364ce564a2a3	516	857	369700f8-926d-40c9-bafb-80d852f5a6cb
10770	CREDIT	Network Budget Balance Pre Open Collective	17475	USD	2016-11-29 17:28:03.065-05	2016-11-29 17:28:03.231-05	51	3	\N	2017-10-26 17:24:06.577-04	\N	\N	\N	\N	\N	\N	1	\N	17475	\N	60804577-a81f-4641-aa43-1b19ab0d8bad	\N	857	37dca71f-17eb-4664-9ebe-41b327bd6519
10775	DEBIT	Network Budget Balance Pre Open Collective	-17475	USD	2016-11-29 17:28:03.065-05	2016-11-29 17:28:03.231-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-17475	-17475	\N	0b1c0df1-75b2-480b-a089-b8b22093b754	282	857	37dca71f-17eb-4664-9ebe-41b327bd6519
10632	CREDIT	Donations - Fees 	17328	USD	2017-02-06 15:06:15.502-05	2017-02-06 15:06:15.622-05	51	3	\N	2017-10-26 17:24:06.59-04	\N	\N	\N	\N	\N	\N	1	\N	17328	\N	18124d78-1f0a-4a66-b5c0-a9880a0cf1d0	\N	857	38b3e113-4a51-4a0e-802f-44a612d2039c
10601	DEBIT	Women Techmaker WWCode Partnership Grant	-70000	USD	2016-05-19 15:17:47.24-04	2016-05-19 15:17:48.401-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-70000	-70000	\N	df1be9b7-dfdb-46d0-99f5-21ab70f7f6e5	3	857	3ebbb089-0d33-4b3e-af32-8b2a03b576ad
10798	DEBIT	$1000 CDK Global event support - transaction and global development	-87000	USD	2016-11-17 13:18:40.107-05	2016-11-17 13:18:40.436-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-87000	-87000	\N	fd1845c9-b7c8-4ca9-bad6-e61ec2adea14	59	857	45326c08-71aa-4059-b549-6071ea976a9e
10794	DEBIT	$5000 Intel Hackathon support - global development	-450000	USD	2016-11-17 13:23:08.268-05	2016-11-17 13:23:08.461-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-450000	-450000	\N	45fc4162-9e12-451b-945e-982859d4c174	59	857	460d718f-5941-4c48-b4f5-e06dff1b49f1
10719	DEBIT	Global Development for Meetup Fees	-6000	USD	2016-12-23 11:50:35.869-05	2016-12-23 11:50:36.131-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	c75eaa0f-9b2d-4066-b346-322074240364	12	857	4f2e681e-55c9-4c67-9eaa-2e9d5e0f6422
10661	CREDIT	\N	16563	EUR	2017-05-08 11:30:18.585-04	2017-05-08 11:30:18.585-04	51	3	\N	2017-10-26 17:24:06.713-04	\N	2741	\N	\N	\N	EUR	1	16563	16563	\N	f0539070-43d0-4d67-abe5-de0046195160	\N	857	4f473854-3613-4a98-bb6c-cd915cbadf73
10644	CREDIT	WWCode t-shirt sales	2371	USD	2017-01-17 22:33:30.061-05	2017-01-17 22:33:30.587-05	51	3	\N	2017-10-26 17:24:06.798-04	\N	\N	\N	\N	\N	\N	1	\N	2371	\N	2ffa9b9b-6e4f-487b-a6de-b878ce1dbe4e	\N	857	61262692-fde2-4eb7-a4d7-a23139a3777f
10735	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-27 14:44:22.123-05	2016-12-27 14:44:22.207-05	51	3	\N	2017-10-26 17:24:06.869-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	7d3431dc-18da-4ab4-ac8b-75dffe01d8cb	\N	857	6abcfc7b-a15c-4276-8266-75157b82acec
10743	CREDIT	Network Development	15755	GBP	2016-10-07 10:03:54.031-04	2016-10-07 10:03:54.119-04	51	3	\N	2017-10-26 17:24:06.941-04	\N	\N	\N	\N	\N	\N	1	\N	15755	\N	15ae98ec-4bc2-4518-857e-9707059a3b7f	\N	857	78a0e602-07cd-4cea-923e-2921af8ba115
10748	DEBIT	Network Development	-15755	GBP	2016-10-07 10:03:54.031-04	2016-10-07 10:03:54.119-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-15755	-15755	\N	cb59f3f7-08cc-460f-bb4d-579dfc992227	278	857	78a0e602-07cd-4cea-923e-2921af8ba115
10651	DEBIT	WWCode t-shirt sales	-1389	USD	2017-01-17 22:32:30.654-05	2017-01-17 22:32:30.825-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-1389	-1389	\N	e60534c4-eb40-4554-bbe8-69187e2a96fa	15	857	7ba01fe1-dcf5-41bf-b093-70098b25cac7
10759	CREDIT	Donation from Margaret - fees	2012	USD	2016-11-29 18:37:14.82-05	2016-11-29 18:37:15.082-05	51	3	\N	2017-10-26 17:24:06.97-04	\N	\N	\N	\N	\N	\N	1	\N	2012	\N	d29b3b80-1c3a-45ea-a485-0c47e2888588	\N	857	7d0406cd-6904-4037-879b-6e0594da132d
10765	DEBIT	Donation from Margaret - fees	-2012	USD	2016-11-29 18:37:14.82-05	2016-11-29 18:37:15.082-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-2012	-2012	\N	40f22498-1046-4bff-a609-64a0a88f62fa	272	857	7d0406cd-6904-4037-879b-6e0594da132d
10675	DEBIT	Global Development for Meetup Fee	-6000	USD	2016-12-28 10:51:42.465-05	2016-12-28 10:51:38.84-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	68458cbf-fe99-4761-bb65-412c15d52945	289	857	8c6ac988-1c07-4c7e-a395-c75367cd11d2
10649	CREDIT	WWCode t-shirt sales	982	USD	2017-01-17 22:30:10.748-05	2017-01-17 22:30:10.906-05	51	3	\N	2017-10-26 17:24:07.115-04	\N	\N	\N	\N	\N	\N	1	\N	982	\N	b2c7d488-002e-432b-987f-b5575b67201a	\N	857	a0138364-7fbc-47c2-87cd-3c0649e781ee
10658	DEBIT	WWCode t-shirt sales	-982	USD	2017-01-17 22:30:10.748-05	2017-01-17 22:30:10.906-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-982	-982	\N	1498d060-33e9-4b49-8f91-18f5137da835	259	857	a0138364-7fbc-47c2-87cd-3c0649e781ee
10642	CREDIT	Donation via meetup	775	USD	2017-01-17 22:48:10.558-05	2017-01-17 22:48:10.699-05	51	3	\N	2017-10-26 17:24:07.161-04	\N	\N	\N	\N	\N	\N	1	\N	775	\N	259d8b12-9bd0-4334-996a-dfce9845f63d	\N	857	a7d25bad-a0d5-4a9e-98a0-c53a0e969b43
10752	CREDIT	Network Development	20000	USD	2016-11-29 19:23:24.87-05	2016-11-29 19:23:24.511-05	51	3	\N	2017-10-26 17:24:07.17-04	\N	\N	\N	\N	\N	\N	1	\N	20000	\N	eaf251a5-d04a-40b9-ba56-1c3e885ede3d	\N	857	a9e92dc9-25d5-446c-8440-10a922e510a3
10773	CREDIT	Erica S. donation - fees	450	USD	2016-11-29 17:11:37.922-05	2016-11-29 17:11:38.131-05	51	3	\N	2017-10-26 17:24:07.18-04	\N	\N	\N	\N	\N	\N	1	\N	450	\N	bbe30cda-5fc6-4283-8932-aa5694b64e71	\N	857	ac8d8f79-58d4-47bc-bed3-e4b14d0266d4
10620	DEBIT	\N	-154800	USD	2017-05-01 14:02:20.511-04	2017-05-01 14:02:20.511-04	857	3	\N	\N	\N	2649	0	\N	0	USD	1	-154800	-154800	\N	70046d5a-cd4b-448b-8717-5caac9c868c5	13	857	b23a2d3f-57d7-42a9-91f2-9126672ba4d0
10606	CREDIT	Event sponsorship - transaction fees and global development 	856500	USD	2017-03-02 01:00:43.46-05	2017-03-02 01:00:44.182-05	51	3	\N	2017-10-26 17:24:07.3-04	\N	\N	\N	\N	\N	\N	1	\N	856500	\N	f9f18680-3d83-4eb1-bdba-dbe4f2e975a7	\N	857	c7af087e-a4d3-4392-83a6-4fb404e8bb2f
10624	CREDIT	Gitlab - transaction and global development	41400	USD	2017-02-06 17:12:42.534-05	2017-02-06 17:12:42.684-05	51	3	\N	2017-10-26 17:24:07.368-04	\N	\N	\N	\N	\N	\N	1	\N	41400	\N	bf829f3c-06f6-474f-bcf7-6fb39d698e66	\N	857	d41cec13-4cb9-4c3c-b4ed-9af124850221
10630	DEBIT	Donation - fees	-8	USD	2017-02-06 17:10:44.604-05	2017-02-06 17:10:44.763-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-8	-800	\N	b5271978-761c-47b2-8ea5-ec38cac3a8fc	270	857	d510d8c0-b4d4-4df5-bdca-b93b113c141e
10667	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-28 10:46:26.348-05	2016-12-28 10:46:22.824-05	51	3	\N	2017-10-26 17:24:07.4-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	e5411bf3-59c1-43ab-8883-35d84bb47003	\N	857	d6baf0e0-d5f9-49eb-acab-a88e90ee258b
10655	DEBIT	WWCode t-shirt sales	-2778	USD	2017-01-17 22:30:54.132-05	2017-01-17 22:30:54.465-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-2778	-2778	\N	da12a0bc-d9f2-47b7-a39d-17401b1e56b7	3	857	e18b08fe-c669-4bbd-af27-8e4dc1043b8f
10627	DEBIT	Donations via meetup - fees	-12	USD	2017-02-06 17:58:38.922-05	2017-02-06 17:58:39.29-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-12	-1200	\N	e4fe4b27-7798-428d-b07d-4480b07614cd	13	857	ea3c57e1-dc22-4f6a-979c-36998e2583b1
10669	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-27 13:37:31.611-05	2016-12-27 13:37:31.721-05	51	3	\N	2017-10-26 17:24:07.529-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	d70cee27-2c86-4a28-adaf-258c147b9253	\N	857	ed5e7690-1ee2-46d8-aa49-f0a9ad782e97
10679	DEBIT	Global Development for Meetup Fee	-6000	USD	2016-12-27 13:37:31.611-05	2016-12-27 13:37:31.721-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	5556dde7-bc13-4028-bb4f-f61118ed5938	59	857	ed5e7690-1ee2-46d8-aa49-f0a9ad782e97
10686	CREDIT	Global Development for Meetup Fee	6000	INR	2016-12-27 11:24:37.915-05	2016-12-27 11:24:38.038-05	51	3	\N	2017-10-26 17:24:07.58-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	209a8777-809e-4976-8705-c730606fcde0	\N	857	fe379c2f-8392-4c24-944d-f1c178c7d69b
10694	DEBIT	Global Development for Meetup Fee	-6000	INR	2016-12-27 11:24:37.915-05	2016-12-27 11:24:38.038-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	d1717cfb-ce9e-44a7-b290-a9b9f0ffba5e	47	857	fe379c2f-8392-4c24-944d-f1c178c7d69b
10664	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-28 10:57:55.359-05	2016-12-28 10:57:51.831-05	51	3	\N	2017-10-26 17:24:07.588-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	e1a92b3a-8d43-4b69-a9fb-998db2d0e521	\N	857	feb1b7fc-846f-4469-ac17-88bbf538c9a3
10635	DEBIT	\N	-20670	USD	2017-04-10 21:09:50.621-04	2017-04-10 21:09:50.621-04	842	4153	2535	\N	\N	2421	1250	\N	580	USD	1	-20670	-25000	\N	1285c065-1c62-4285-8cee-9465cecc2c98	13	857	6775310c-b72b-4847-b08e-9805014974b4
10720	DEBIT	Global Development for Meetup Fee	-6000	USD	2016-12-23 11:45:15.022-05	2016-12-23 11:45:15.147-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	abd5ad39-ffba-4d64-9d02-cea5469fad6e	261	857	26d0a91a-685b-4369-a20b-f44fefdf9da8
10681	DEBIT	Global Development for Meetup Fee	-6000	MXN	2016-12-27 12:59:52.939-05	2016-12-27 12:59:53.047-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	c4043b1f-4579-47eb-b744-3a72ba7484e5	10	857	27fe73bb-fd67-4a9c-a21d-47233c8c41e5
10697	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-28 11:27:36.9-05	2016-12-28 11:27:33.309-05	51	3	\N	2017-10-26 17:24:06.499-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	249561dd-2501-475b-a488-77e3b472d017	\N	857	2fe08efc-1f65-4e3c-82eb-70cc4b462a78
10726	CREDIT	\N	20000	USD	2017-04-07 08:25:51.09-04	2017-04-07 08:25:51.09-04	51	3	\N	2017-10-26 17:24:06.564-04	\N	2393	\N	\N	\N	USD	1	20000	20000	\N	ae31cc5e-1c5a-4254-ac54-00c382991664	\N	857	369700f8-926d-40c9-bafb-80d852f5a6cb
10709	CREDIT	Global Development for Meetup Fees	6000	USD	2016-12-23 11:54:04.928-05	2016-12-23 11:54:05.055-05	51	3	\N	2017-10-26 17:24:06.568-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	08e1f8da-41ce-41ad-9be3-80145ec0f48d	\N	857	36fd9da6-3b12-45cc-ab3a-1dcf02722a34
10717	DEBIT	Global Development for Meetup Fees	-6000	USD	2016-12-23 11:54:04.928-05	2016-12-23 11:54:05.055-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	29cc30ff-ce6c-4815-ab73-ad6cbd7f43ef	262	857	36fd9da6-3b12-45cc-ab3a-1dcf02722a34
10680	CREDIT	Global Development for Meetup Fee	6000	MXN	2016-12-27 12:56:03.911-05	2016-12-27 12:56:03.985-05	51	3	\N	2017-10-26 17:24:06.581-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	801751cb-0946-4cce-8bb1-e1a8dd55465a	\N	857	3816d92b-0193-4261-a649-54ca1df0cdd8
10787	DEBIT	International Women's Day Atlanta	0	USD	2017-03-28 14:28:28.77-04	2017-03-28 14:28:28.938-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	0	-10350	\N	89ec6da8-ed94-4553-99cd-b061a7f5393a	51	857	38380fb3-3c7d-4ed0-97c6-bb771dc5c9fb
10638	DEBIT	Donations - Fees 	-173	USD	2017-02-06 15:06:15.502-05	2017-02-06 15:06:15.622-05	857	3	\N	2017-02-05 19:00:00-05	\N	\N	\N	\N	\N	\N	1	-173	-17328	\N	ca31a911-746f-454c-8735-03fcea343841	2	857	38b3e113-4a51-4a0e-802f-44a612d2039c
10756	CREDIT	Donation via Meetup	775	USD	2016-11-29 18:39:08.069-05	2016-11-29 18:39:08.263-05	51	3	\N	2017-10-26 17:24:06.598-04	\N	\N	\N	\N	\N	\N	1	\N	775	\N	8572646b-3139-4c45-8e04-7e179646a2fa	\N	857	3978bda7-5e72-4742-b813-a0a5dd960310
10764	DEBIT	Donation via Meetup	-775	USD	2016-11-29 18:39:08.069-05	2016-11-29 18:39:08.263-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-775	-775	\N	f964fd7e-a1b1-425f-b67b-20e8266da3f2	300	857	3978bda7-5e72-4742-b813-a0a5dd960310
10685	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-27 12:48:49.207-05	2016-12-27 12:48:49.297-05	51	3	\N	2017-10-26 17:24:06.618-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	f48b4ec5-4299-4871-9eb8-60ec33587ba4	\N	857	41b75642-0d55-4ce9-b0a5-bb3d45ca52d5
10693	DEBIT	Global Development for Meetup Fee	-6000	USD	2016-12-27 12:48:49.207-05	2016-12-27 12:48:49.297-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	6b04dc39-5105-4880-b2b3-bc59dea690de	280	857	41b75642-0d55-4ce9-b0a5-bb3d45ca52d5
10739	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-27 11:52:05.93-05	2016-12-27 11:52:06.061-05	51	3	\N	2017-10-26 17:24:06.622-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	b677c50a-2211-467e-95d0-fe2bc7d7c0fb	\N	857	42e9b44f-80b6-491c-83a3-3aa4ba32695e
10746	DEBIT	Global Development for Meetup Fee	-6000	USD	2016-12-27 11:52:05.93-05	2016-12-27 11:52:06.061-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	9bbe8ba6-dbef-4f9b-86c1-248e99769c79	274	857	42e9b44f-80b6-491c-83a3-3aa4ba32695e
10792	CREDIT	$1000 CDK Global event support - transaction and global development	87000	USD	2016-11-17 13:18:40.107-05	2016-11-17 13:18:40.436-05	51	3	\N	2017-10-26 17:24:06.639-04	\N	\N	\N	\N	\N	\N	1	\N	87000	\N	d0c543b2-2229-419c-92bc-1e062caaac18	\N	857	45326c08-71aa-4059-b549-6071ea976a9e
10653	CREDIT	WWCode t-shirt sales	1964	USD	2017-01-17 22:29:40.155-05	2017-01-17 22:29:40.284-05	51	3	\N	2017-10-26 17:24:06.694-04	\N	\N	\N	\N	\N	\N	1	\N	1964	\N	37d6186c-9dd0-4ba5-9b5f-958e01c76ac1	\N	857	4d60d400-61c9-4ef6-b9ab-a41a5c9b912d
10805	DEBIT	WOMEN TECHMAKER WWCODE PARTNERSHIP GRANT	-80000	USD	2016-05-31 14:01:08.532-04	2016-05-31 14:01:07.064-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-80000	-80000	\N	5361651a-bca0-4233-bd92-dabbba87cddc	13	857	4de2e61e-353d-4d8b-9288-d5b140b24ddc
10713	CREDIT	Global Development for Meetup Fees	6000	USD	2016-12-23 11:50:35.869-05	2016-12-23 11:50:36.131-05	51	3	\N	2017-10-26 17:24:06.709-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	29ad7cd9-2cad-45ad-9909-a6c03e4a74fd	\N	857	4f2e681e-55c9-4c67-9eaa-2e9d5e0f6422
10668	DEBIT	\N	-16563	EUR	2017-05-08 11:30:18.585-04	2017-05-08 11:30:18.585-04	857	3	\N	\N	\N	2741	0	\N	0	EUR	1	-16563	-16563	\N	54c997f2-df66-4e4b-b69a-994c6d003634	301	857	4f473854-3613-4a98-bb6c-cd915cbadf73
10688	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-27 11:22:09.234-05	2016-12-27 11:22:09.351-05	51	3	\N	2017-10-26 17:24:06.718-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	51e77533-807a-4153-891d-237ac5ee8760	\N	857	500980b2-a929-40e7-be85-056b560978cb
10671	DEBIT	WOMEN TECHMAKER WWCODE PARTNERSHIP GRANT	-50000	USD	2016-05-26 16:48:43.015-04	2016-05-26 16:48:43.336-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-50000	-50000	\N	a1ddb641-ad18-424c-af89-65818b737165	59	857	5c17f156-0581-44a0-a2ae-8cbc3078f2a7
10766	CREDIT	Network Development	2500	USD	2016-11-29 17:29:22.958-05	2016-11-29 17:29:23.167-05	51	3	\N	2017-10-26 17:24:06.819-04	\N	\N	\N	\N	\N	\N	1	\N	2500	\N	30173b1a-f837-44ca-8f07-5b4830038d28	\N	857	63bd820d-e310-4d69-98ab-aa1f756ff13a
10774	DEBIT	Network Development	-2500	USD	2016-11-29 17:29:22.958-05	2016-11-29 17:29:23.167-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-2500	-2500	\N	f34c804a-29d1-4cc6-a7fa-647eb2906cf5	282	857	63bd820d-e310-4d69-98ab-aa1f756ff13a
10645	CREDIT	WWCode t-shirt sales	1389	USD	2017-01-17 22:32:30.654-05	2017-01-17 22:32:30.825-05	51	3	\N	2017-10-26 17:24:06.966-04	\N	\N	\N	\N	\N	\N	1	\N	1389	\N	bdab0147-4f4c-4ad4-9a71-35fedb973ed8	\N	857	7ba01fe1-dcf5-41bf-b093-70098b25cac7
10754	CREDIT	Donation via meetup	775	USD	2016-11-29 18:39:42.382-05	2016-11-29 18:39:42.512-05	51	3	\N	2017-10-26 17:24:07.037-04	\N	\N	\N	\N	\N	\N	1	\N	775	\N	94342999-6782-4488-b2c2-9a5ed899f61f	\N	857	8f54652f-54d9-4edf-a1cc-503303e05e68
10760	DEBIT	Donation via meetup	-775	USD	2016-11-29 18:39:42.382-05	2016-11-29 18:39:42.512-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-775	-775	\N	70b3a512-8da0-4c2c-8913-1ce5ba508c0c	13	857	8f54652f-54d9-4edf-a1cc-503303e05e68
10613	DEBIT	\N	-20000	USD	2017-03-27 13:45:17.58-04	2017-03-27 13:45:17.58-04	857	3	\N	\N	\N	2152	0	\N	0	USD	1	-20000	-20000	\N	66e4e636-4141-430b-9791-ab74e7ee42dd	59	857	955581ef-affc-4ff3-80a6-ccb62a88553d
10621	DEBIT	Macy's donation - fees and global development	-435000	USD	2017-02-13 19:21:10.361-05	2017-02-13 19:21:10.558-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-435000	-435000	\N	9537f019-3aa6-4241-82ae-333c4c1ead32	12	857	98506445-e9b9-4c48-abb2-54cd8063ee3c
10705	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-23 14:40:51.309-05	2016-12-23 14:40:51.479-05	51	3	\N	2017-10-26 17:24:07.085-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	c94d0740-6d3c-4fa7-a5f5-ccedfe4a47ff	\N	857	99070318-d9ac-4319-82ab-c496080a510c
10812	CREDIT	Stephen	450	USD	2016-11-29 17:55:31.534-05	2016-11-29 17:55:31.727-05	51	3	\N	2017-10-26 17:24:07.144-04	\N	\N	\N	\N	\N	\N	1	\N	450	\N	77e75a04-3fee-48a0-9a37-cd906979db36	\N	857	a611b04a-de08-4000-bcab-e4207926a18c
10648	DEBIT	Donation via meetup	-775	USD	2017-01-17 22:48:10.558-05	2017-01-17 22:48:10.699-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-775	-775	\N	709a5690-6175-452e-bdc0-aec3893c0d1a	272	857	a7d25bad-a0d5-4a9e-98a0-c53a0e969b43
10616	CREDIT	\N	154800	USD	2017-05-01 14:02:20.511-04	2017-05-01 14:02:20.511-04	51	3	\N	2017-10-26 17:24:07.193-04	\N	2649	\N	\N	\N	USD	1	154800	154800	\N	e758894c-2ba7-44bc-a772-4b7b14418eea	\N	857	b23a2d3f-57d7-42a9-91f2-9126672ba4d0
10734	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-27 14:48:41.246-05	2016-12-27 14:48:41.318-05	51	3	\N	2017-10-26 17:24:07.238-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	d2d223b9-5f72-4343-aadc-8527dc235894	\N	857	b958e108-3e79-4d0a-b1c9-2d66d2fc6158
10723	DEBIT	Global Development for Meetup Fee	-6000	USD	2016-12-23 11:32:00.456-05	2016-12-23 11:32:00.622-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	2a2bcf40-3b1d-4976-a2b8-9229110d804c	260	857	bb988f08-f90e-4c44-9752-5ee09cb61b46
10800	CREDIT	Donation - fees + global development	1187	USD	2017-01-05 09:58:39.771-05	2017-01-05 09:58:42.205-05	51	3	\N	2017-10-26 17:24:07.247-04	\N	\N	\N	\N	\N	\N	1	\N	1187	\N	7e7835d6-a4d3-4d12-baa0-532062778cbd	\N	857	bc5b13ae-0c57-43c0-ac61-11325a6ee3eb
10608	DEBIT	\N	-100000	USD	2017-03-27 13:53:48.539-04	2017-03-27 13:53:48.539-04	857	3	\N	\N	\N	2154	0	\N	0	USD	1	-100000	-100000	\N	6cbd12dc-5ef9-4b78-a449-10e4aebec19c	277	857	ca03e9c0-a1ed-4c24-ac05-14b3146ea528
10676	CREDIT	Global Development for Meetup Fee	5700	EUR	2016-12-27 13:10:14.864-05	2016-12-27 13:10:14.928-05	51	3	\N	2017-10-26 17:24:07.364-04	\N	\N	\N	\N	\N	\N	1	\N	5700	\N	b7d4255a-55f9-4f4e-b309-40a934ece5ba	\N	857	d2058375-56ce-4a59-8c9c-92cf66c2e6e3
10631	DEBIT	Gitlab - transaction and global development	-414	USD	2017-02-06 17:12:42.534-05	2017-02-06 17:12:42.684-05	857	3	\N	2017-02-05 19:00:00-05	\N	\N	\N	\N	\N	\N	1	-414	-41400	\N	1c816f1d-deef-4935-a896-f0131e661947	48	857	d41cec13-4cb9-4c3c-b4ed-9af124850221
10625	CREDIT	Donation - fees	800	USD	2017-02-06 17:10:44.604-05	2017-02-06 17:10:44.763-05	51	3	\N	2017-10-26 17:24:07.382-04	\N	\N	\N	\N	\N	\N	1	\N	800	\N	37303269-7d0e-41b9-b190-1104471bdc16	\N	857	d510d8c0-b4d4-4df5-bdca-b93b113c141e
10749	CREDIT	Banner	2000	USD	2016-11-30 16:33:30.25-05	2016-11-30 16:33:30.386-05	51	3	\N	2017-10-26 17:24:07.422-04	\N	\N	\N	\N	\N	\N	1	\N	2000	\N	4214457a-2b52-47b5-8bef-1e867ec156a6	\N	857	da7ad689-969d-4d74-8792-8236c6bb6d88
10660	DEBIT	WWCode t-shirt sales	-1106	USD	2017-01-17 22:29:09.407-05	2017-01-17 22:29:09.561-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-1106	-1106	\N	d824a0c1-2bb6-4b83-82c1-b29321c5bfa8	14	857	e7c07836-6353-4130-ad45-cf80d7cce80b
10691	DEBIT	Global Development for Meetup Fee	-6000	AUD	2016-12-27 12:52:16.09-05	2016-12-27 12:52:16.167-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	3a8db49a-73f9-411a-8859-351588c13aa9	281	857	f06c085e-9131-40e1-a69b-49f43a043568
10777	DEBIT	Erica S. donation - fees	-450	USD	2016-11-29 17:12:36.336-05	2016-11-29 17:12:36.503-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-450	-450	\N	c63808de-9da9-4a49-8a17-c24de569d9da	287	857	f1fa1b76-776f-4ad8-b56c-bf348e04f9d3
10672	DEBIT	Global Development for Meetup Fee	-6000	USD	2016-12-28 10:57:55.359-05	2016-12-28 10:57:51.831-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	34bb576f-7827-4ee1-b792-6a9c8cabc095	241	857	feb1b7fc-846f-4469-ac17-88bbf538c9a3
10728	CREDIT	Event food	3224	USD	2016-09-13 10:57:04.698-04	2016-09-13 10:57:05.111-04	827	171	573	\N	\N	\N	\N	\N	\N	\N	1	3224	3224	346	9bb84086-d81e-47cf-bcb2-0bd809784fdc	59	857	cbd4ddcf-92fd-4113-9552-17b258fa91c1
10727	DEBIT	\N	-16300	USD	2017-04-04 15:51:04.916-04	2017-04-04 15:51:04.916-04	836	3999	2438	\N	\N	2332	1000	\N	700	USD	1	-16300	-20000	\N	56306e3c-a81e-4bf2-ba9c-4ab1e3e10e3a	2	857	846e1648-6897-4f52-9597-eb9cf3568c4e
10757	DEBIT	Conference Travel Stipend - Google I/O Elese	-75000	USD	2016-11-30 16:25:31.161-05	2016-11-30 16:25:41.165-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-75000	-75000	\N	17c2c18f-2312-44f9-a634-a0d93793ff8a	276	857	00da65f6-8655-4ede-baf0-d292f707473f
10736	DEBIT	Global Development for Meetup Fee	-6000	USD	2016-12-27 14:54:51.439-05	2016-12-27 14:54:51.679-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	fbb34467-fc1b-4aaf-9438-37c35952389e	4	857	0cfc2cff-42a6-44d4-9ee9-e59f07fe304c
10815	CREDIT	Network Development	18200	USD	2016-10-11 13:02:51.621-04	2016-10-11 13:02:51.839-04	51	3	\N	2017-10-26 17:24:06.339-04	\N	\N	\N	\N	\N	\N	1	\N	18200	\N	a2d250e3-1e6e-4a1b-95fa-d75c292ac3b0	\N	857	106c8237-a0f0-454b-bf56-c77f5443b40d
10813	CREDIT	Director t-shirt	2898	USD	2016-10-17 16:57:08.514-04	2016-10-17 16:57:08.533-04	51	3	\N	2017-10-26 17:24:06.494-04	\N	\N	\N	\N	\N	\N	1	\N	2898	\N	bfafac69-be58-4a2e-959c-8b0a9706cb11	\N	857	2f7c6e12-f05c-473e-823f-a257d721bd91
10818	DEBIT	Director t-shirt	-2898	USD	2016-10-17 16:57:08.514-04	2016-10-17 16:57:08.533-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-2898	-2898	\N	eaf088c0-de5e-4a62-98e9-ae2789fe1ed7	3	857	2f7c6e12-f05c-473e-823f-a257d721bd91
10690	CREDIT	Global Development for Meetup Fees	6000	USD	2016-12-27 13:40:49.86-05	2016-12-27 13:40:49.921-05	51	3	\N	2017-10-26 17:24:06.551-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	523e71c8-d48f-4372-ba99-570aade2fbcb	\N	857	34cd07ce-7b79-4226-9d08-fbf7aaf6bab2
10699	DEBIT	Global Development for Meetup Fees	-6000	USD	2016-12-27 13:40:49.86-05	2016-12-27 13:40:49.921-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	7a913d04-1a85-4bf8-a756-cd72ef9b2d12	286	857	34cd07ce-7b79-4226-9d08-fbf7aaf6bab2
10643	CREDIT	WWCode t-shirt sales	7570	USD	2017-01-17 22:34:31.424-05	2017-01-17 22:34:31.75-05	51	3	\N	2017-10-26 17:24:06.678-04	\N	\N	\N	\N	\N	\N	1	\N	7570	\N	af5a0cdf-0ad1-4f6d-992b-90ff88b59d48	\N	857	4c136ddc-c105-4a3e-b47f-9d448f0bada0
10650	DEBIT	WWCode t-shirt sales	-7570	USD	2017-01-17 22:34:31.424-05	2017-01-17 22:34:31.75-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-7570	-7570	\N	b0e3c047-b781-43b6-99b9-fd85eb5abfb3	300	857	4c136ddc-c105-4a3e-b47f-9d448f0bada0
10659	DEBIT	WWCode t-shirt sales	-1964	USD	2017-01-17 22:29:40.155-05	2017-01-17 22:29:40.284-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-1964	-1964	\N	3c04bcd9-377e-4ad3-b6be-5275065f737e	273	857	4d60d400-61c9-4ef6-b9ab-a41a5c9b912d
10808	CREDIT	Women Techmaker WWCode Partnership Grant	20000	USD	2016-05-25 12:45:53.797-04	2016-05-25 12:45:54.045-04	51	3	\N	2017-10-26 17:24:06.704-04	\N	\N	\N	\N	\N	\N	1	\N	20000	\N	0663f693-15ea-4bf0-b764-c5162ede09f0	\N	857	4e16210d-0b35-44aa-9b79-6ce838d01d19
10695	DEBIT	Global Development for Meetup Fee	-6000	USD	2016-12-27 11:22:09.234-05	2016-12-27 11:22:09.351-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	f24386dd-c289-4a7d-b3af-44460be0627f	13	857	500980b2-a929-40e7-be85-056b560978cb
10761	CREDIT	Global Development	20000	USD	2016-11-29 18:34:32.59-05	2016-11-29 18:34:32.817-05	51	3	\N	2017-10-26 17:24:06.747-04	\N	\N	\N	\N	\N	\N	1	\N	20000	\N	9e118d54-7b4d-4734-ad39-bd841d24d832	\N	857	56bf4c0b-6f72-4445-b133-62ca54171c27
10768	DEBIT	Global Development	-20000	USD	2016-11-29 18:34:32.59-05	2016-11-29 18:34:32.817-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-20000	-20000	\N	09784b7a-bdb1-40cc-819e-a47d9a88dc05	259	857	56bf4c0b-6f72-4445-b133-62ca54171c27
10827	DEBIT	Network Development (100%)	-10000	USD	2016-10-06 14:42:47.682-04	2016-10-06 14:42:47.71-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-10000	-10000	\N	7963a9b8-03a8-45fb-b5ce-f0f974982f78	13	857	60055c4f-14d4-4947-abda-ef9217563ceb
10707	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-23 14:37:32.49-05	2016-12-23 14:37:32.668-05	51	3	\N	2017-10-26 17:24:06.854-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	470e022d-ef3c-4a02-bd3c-777a67cfe405	\N	857	68e5fc60-1003-4b42-9815-2d37a08961fe
10716	DEBIT	Global Development for Meetup Fee	-6000	USD	2016-12-23 14:37:32.49-05	2016-12-23 14:37:32.668-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	6f54e573-7215-4a22-92d4-618e14a94891	268	857	68e5fc60-1003-4b42-9815-2d37a08961fe
10791	CREDIT	T-shirt payout	1092	USD	2016-11-17 13:03:13.726-05	2016-11-17 13:03:13.862-05	51	3	\N	2017-10-26 17:24:06.901-04	\N	\N	\N	\N	\N	\N	1	\N	1092	\N	1ea7da4f-4277-49f2-afa1-fa046f9f4f7a	\N	857	6df829d3-8072-46a5-a86a-4f4547a64b26
10799	DEBIT	T-shirt payout	-1092	USD	2016-11-17 13:03:13.726-05	2016-11-17 13:03:13.862-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-1092	-1092	\N	1761b704-d881-4c4c-ac14-6dd37e6eb787	59	857	6df829d3-8072-46a5-a86a-4f4547a64b26
10741	CREDIT	Global Development	80000	GBP	2016-11-29 16:14:00.118-05	2016-11-29 16:14:01.107-05	51	3	\N	2017-10-26 17:24:06.906-04	\N	\N	\N	\N	\N	\N	1	\N	80000	\N	cf573eab-8ee7-4ad6-a7aa-7b66ebd6af70	\N	857	6e23be83-aeae-4513-bd40-3dafda0f0fb5
10747	DEBIT	Global Development	-80000	GBP	2016-11-29 16:14:00.118-05	2016-11-29 16:14:01.107-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-80000	-80000	\N	9d19f872-bd93-402c-b5cd-7fb0f3f91299	278	857	6e23be83-aeae-4513-bd40-3dafda0f0fb5
10783	CREDIT	$3500 Course Hero Hackathon support - transaction & global development	304500	USD	2016-11-17 13:27:12.528-05	2016-11-17 13:27:12.742-05	51	3	\N	2017-10-26 17:24:06.915-04	\N	\N	\N	\N	\N	\N	1	\N	304500	\N	ffd3189a-985a-4c07-8e50-010f4993bfc6	\N	857	73e8270e-fe8d-4fef-9c9f-a0b3ed87e722
10788	DEBIT	$3500 Course Hero Hackathon support - transaction & global development	-304500	USD	2016-11-17 13:27:12.528-05	2016-11-17 13:27:12.742-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-304500	-304500	\N	9da1060b-4f2c-47e5-a46a-e02ac7fa9958	59	857	73e8270e-fe8d-4fef-9c9f-a0b3ed87e722
10626	CREDIT	Global Network Development	500000	USD	2017-01-25 13:27:46.907-05	2017-01-25 13:27:47.421-05	51	3	\N	2017-10-26 17:24:06.936-04	\N	\N	\N	\N	\N	\N	1	\N	500000	\N	f2f149a1-6ce0-4340-984f-895b31e279e0	\N	857	786d39f7-4e5e-4c7e-ac40-0b8dfdb25e14
10633	DEBIT	Global Network Development	-500000	USD	2017-01-25 13:27:46.907-05	2017-01-25 13:27:47.421-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-500000	-500000	\N	d7281245-a703-442c-956f-9e36af7bf7e3	51	857	786d39f7-4e5e-4c7e-ac40-0b8dfdb25e14
10708	CREDIT	Paypal Fees for Travel Stipend	3000	USD	2017-03-20 11:38:54.453-04	2017-03-20 11:38:53.749-04	51	3	\N	2017-10-26 17:24:07.007-04	\N	\N	\N	\N	\N	\N	1	\N	3000	\N	9b6bb267-8a94-4916-8c5e-c1260510c045	\N	857	8858e320-c2cd-47c7-bf09-fbdfae714763
10715	DEBIT	Paypal Fees for Travel Stipend	-3000	USD	2017-03-20 11:38:54.453-04	2017-03-20 11:38:53.749-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-3000	-3000	\N	529ddf2e-6313-4dc8-b352-d025a9a72260	277	857	8858e320-c2cd-47c7-bf09-fbdfae714763
10666	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-28 10:51:42.465-05	2016-12-28 10:51:38.84-05	51	3	\N	2017-10-26 17:24:07.028-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	8617deac-d7ae-4217-8a5a-52f9be028624	\N	857	8c6ac988-1c07-4c7e-a395-c75367cd11d2
10637	DEBIT	Taipei Donation - fees and global development	-8	USD	2017-02-06 15:11:26.406-05	2017-02-06 15:11:26.522-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-8	-800	\N	4765b2ff-16cf-4e6b-ae0e-b5eacc4050ac	241	857	90aecccb-f9cf-44a8-80b8-d14ac68b2d19
10712	DEBIT	Global Development for Meetup Fee	-6000	USD	2016-12-23 14:40:51.309-05	2016-12-23 14:40:51.479-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	7ba840a4-3084-4a7e-8491-feab70030f34	269	857	99070318-d9ac-4319-82ab-c496080a510c
10779	DEBIT	Erica S. donation - fees	-450	USD	2016-11-29 17:11:37.922-05	2016-11-29 17:11:38.131-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-450	-450	\N	fe50005b-dd15-49a1-a1a8-0cf2f41a00b9	287	857	ac8d8f79-58d4-47bc-bed3-e4b14d0266d4
10700	CREDIT	Global Development for Meetup Fee	6000	CAD	2016-12-28 11:21:14.024-05	2016-12-28 11:21:10.449-05	51	3	\N	2017-10-26 17:24:07.272-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	237c1e2b-0c55-469e-84ac-e74dd7d49db9	\N	857	c33180c2-c01a-4d7f-b9cb-179396b93072
10795	CREDIT	donation - fees and global development	798	USD	2017-01-05 09:48:24.355-05	2017-01-05 09:48:26.734-05	51	3	\N	2017-10-26 17:24:07.373-04	\N	\N	\N	\N	\N	\N	1	\N	798	\N	9f9fb203-5df5-4035-948c-913b039261e9	\N	857	d42220ba-3283-4df9-b63d-912e9d1220a4
10674	DEBIT	Global Development for Meetup Fee	-6000	USD	2016-12-28 10:46:26.348-05	2016-12-28 10:46:22.824-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	1d93b8d1-05de-4b6f-ba2e-12052166535c	300	857	d6baf0e0-d5f9-49eb-acab-a88e90ee258b
10703	CREDIT	Global Development for Meetup Fee	6000	JPY	2016-12-28 11:00:53.27-05	2016-12-28 11:00:49.939-05	51	3	\N	2017-10-26 17:24:07.441-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	69984e02-5690-488e-85ef-1236824cd268	\N	857	ddee4eb8-5f86-4d0f-bf07-bc6945a18fc2
10711	DEBIT	Global Development for Meetup Fee	-6000	JPY	2016-12-28 11:00:53.27-05	2016-12-28 11:00:49.939-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	f3bf3066-6389-4722-bb5e-09fbd7bc7986	295	857	ddee4eb8-5f86-4d0f-bf07-bc6945a18fc2
10732	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-27 14:51:47.92-05	2016-12-27 14:51:48.117-05	51	3	\N	2017-10-26 17:24:07.471-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	1ed89e08-a387-40ac-a113-679f864207c9	\N	857	e0afd47a-10b7-4734-8c3e-ce96d563fc8a
10737	DEBIT	Global Development for Meetup Fee	-6000	USD	2016-12-27 14:51:47.92-05	2016-12-27 14:51:48.117-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	238409b7-a843-4239-9547-ab882f35c24b	14	857	e0afd47a-10b7-4734-8c3e-ce96d563fc8a
10656	CREDIT	WWCode t-shirt sales	1106	USD	2017-01-17 22:29:09.407-05	2017-01-17 22:29:09.561-05	51	3	\N	2017-10-26 17:24:07.502-04	\N	\N	\N	\N	\N	\N	1	\N	1106	\N	94c54f2c-00a1-473a-9627-331b39968d1c	\N	857	e7c07836-6353-4130-ad45-cf80d7cce80b
10622	CREDIT	Donations via meetup - fees	1200	USD	2017-02-06 17:58:38.922-05	2017-02-06 17:58:39.29-05	51	3	\N	2017-10-26 17:24:07.511-04	\N	\N	\N	\N	\N	\N	1	\N	1200	\N	de2b66b2-bd27-489f-93ce-c41d171d6369	\N	857	ea3c57e1-dc22-4f6a-979c-36998e2583b1
10670	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-27 13:33:56.275-05	2016-12-27 13:33:56.372-05	51	3	\N	2017-10-26 17:24:07.549-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	465a3de8-2649-4f2b-9845-11a57c900faa	\N	857	f68b42ed-1f9c-44a2-9c06-f91a98368e56
10678	DEBIT	Global Development for Meetup Fee	-6000	USD	2016-12-27 13:33:56.275-05	2016-12-27 13:33:56.372-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	afb67c48-f029-4c72-ab7f-82eefdd858d5	284	857	f68b42ed-1f9c-44a2-9c06-f91a98368e56
10724	CREDIT	Global Development for Meetup fee	6000	USD	2016-12-21 13:49:53.054-05	2016-12-21 13:49:53.302-05	51	3	\N	2017-10-26 17:24:07.584-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	8ae6c4d9-11a4-4dae-a5da-ef08651d3223	\N	857	fea752e0-e8b0-447d-8755-7e688698f395
10731	DEBIT	Global Development for Meetup fee	-6000	USD	2016-12-21 13:49:53.054-05	2016-12-21 13:49:53.302-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	b585d5d1-90af-4cc9-82de-17cc3694db14	3	857	fea752e0-e8b0-447d-8755-7e688698f395
10832	DEBIT	Donation to WWCode Washington DC	-41020	USD	2016-04-29 09:51:19.1-04	2016-04-29 09:51:19.15-04	808	303	216	\N	\N	183	2500	\N	1480	USD	1	-41020	-50000	\N	611d6fb5-1c9f-4bf4-be7d-2d400bd94db0	13	857	4116469f-7fe8-4feb-a26a-689b9129302f
10835	DEBIT	Recurring subscription	-798	USD	2016-10-01 19:35:17.911-04	2016-10-01 19:35:17.911-04	803	686	461	\N	\N	386	50	\N	52	USD	1	-798	-1000	\N	219c6bac-8ed2-47b4-9821-d584ba9e4b15	2	857	1ad88c22-7d6b-4245-9adf-0b6873a7d75f
10838	DEBIT	Recurring subscription	-125	MXN	2016-03-02 13:06:23.743-05	2016-04-16 16:40:58.731-04	768	80	42	\N	\N	68	2	\N	16	USD	17.8570999999999991	-7	-500	\N	701b320f-c35b-4e46-b237-cdb8fd321375	10	857	25744c7d-32de-4fbb-b11a-76ba05036347
10842	DEBIT	Recurring subscription	-52	USD	2016-04-02 14:13:51.122-04	2016-04-16 16:40:58.81-04	691	30	43	\N	\N	69	5	\N	33	USD	1	-52	-100	\N	f14b8b52-3f4a-41e5-8db5-15c06179b01d	13	857	25db8f90-bb76-4224-8cf4-16bb3962e3e0
10921	DEBIT	Donation to WWCode Seattle	-52	USD	2016-02-02 16:46:44.866-05	2016-04-16 16:40:58.7-04	819	8	45	\N	\N	71	5	\N	33	USD	1	-52	-100	\N	68cfd266-37e1-4513-9119-543f1fed9fdb	14	857	e46a37a6-08a7-4b7a-b13c-b608f413ca10
10778	DEBIT	Global Development	-19100	USD	2016-11-29 17:17:18.389-05	2016-11-29 17:17:18.558-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-19100	-19100	\N	e7b32d9a-e79f-4890-b8ce-1dc3acc4d32a	287	857	02e2e8cb-75b1-435c-8848-a15099d69a24
10878	DEBIT	Generous donation from Target to support WWCode Twin Cities	-500000	USD	2016-05-26 14:37:24.922-04	2016-05-26 14:37:23.286-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-500000	-500000	\N	a06eb341-64a2-4bc2-b9cc-4aed882161cc	48	857	0871a018-40ba-4634-9bde-65a47b006184
10823	DEBIT	Network Development	-18200	USD	2016-10-11 13:02:51.621-04	2016-10-11 13:02:51.839-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-18200	-18200	\N	ffe2e38e-a7a8-4b98-b65a-bbc8362ebaa2	291	857	106c8237-a0f0-454b-bf56-c77f5443b40d
10824	CREDIT	Network Development	13286	USD	2016-10-04 18:57:17.136-04	2016-10-04 18:57:17.293-04	51	3	\N	2017-10-26 17:24:06.345-04	\N	\N	\N	\N	\N	\N	1	\N	13286	\N	3f5fb647-e188-44ac-9b04-9d877f7f623b	\N	857	121aa478-d522-4261-9d96-b8dc531d7d8e
10950	CREDIT	Global Development for Meetup Fee	6000	AUD	2016-12-23 12:41:14.029-05	2016-12-23 12:41:14.193-05	51	3	\N	2017-10-26 17:24:06.383-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	e70ca809-e20e-4a76-94e2-719818a697dd	\N	857	1d39b3be-07e6-4975-9946-9ee20bd781ee
10782	CREDIT	International Women's Day Atlanta	10350	USD	2017-03-28 14:28:28.77-04	2017-03-28 14:28:28.938-04	51	3	\N	2017-10-26 17:24:06.586-04	\N	\N	\N	\N	\N	\N	1	\N	10350	\N	43c7675f-21cb-4993-bf5c-8fc13174b09d	\N	857	38380fb3-3c7d-4ed0-97c6-bb771dc5c9fb
10937	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-27 12:02:32.71-05	2016-12-27 12:02:32.843-05	51	3	\N	2017-10-26 17:24:06.613-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	f79958e7-0afe-45bc-b6b8-5265ad859891	\N	857	41a8399c-ff4f-4b26-95c7-5b78dcc8199e
10944	DEBIT	Global Development for Meetup Fee	-6000	USD	2016-12-27 12:02:32.71-05	2016-12-27 12:02:32.843-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	2b1be471-3e4c-4196-b95e-8eeefa237e48	277	857	41a8399c-ff4f-4b26-95c7-5b78dcc8199e
10744	CREDIT	WTM Google I/O Travel Stipend	50000	USD	2017-03-17 10:09:18.868-04	2017-03-17 10:09:18.344-04	51	3	\N	2017-10-26 17:24:06.627-04	\N	\N	\N	\N	\N	\N	1	\N	50000	\N	a9cd3b8a-78f9-4f10-b188-b98dc8f406d9	\N	857	434723e4-391d-4399-ad89-e630eee22f7a
10750	DEBIT	WTM Google I/O Travel Stipend	-50000	USD	2017-03-17 10:09:18.868-04	2017-03-17 10:09:18.344-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-50000	-50000	\N	3e40304f-c80f-4ade-a9a6-48cb059bc54f	195	857	434723e4-391d-4399-ad89-e630eee22f7a
10789	CREDIT	$5000 Intel Hackathon support - global development	450000	USD	2016-11-17 13:23:08.268-05	2016-11-17 13:23:08.461-05	51	3	\N	2017-10-26 17:24:06.648-04	\N	\N	\N	\N	\N	\N	1	\N	450000	\N	c1983207-6876-4628-9dd8-a74d52bd26af	\N	857	460d718f-5941-4c48-b4f5-e06dff1b49f1
10762	CREDIT	Regional Leadership Director Training 	13031	USD	2016-11-29 17:35:05.252-05	2016-11-29 17:35:05.379-05	51	3	\N	2017-10-26 17:24:06.652-04	\N	\N	\N	\N	\N	\N	1	\N	13031	\N	44108c91-5b44-499e-879d-68fbc3239301	\N	857	467bbcf0-7f8c-4c29-bd37-3d960f697660
10767	DEBIT	Regional Leadership Director Training 	-13031	USD	2016-11-29 17:35:05.252-05	2016-11-29 17:35:05.379-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-13031	-13031	\N	1906a04a-e6f1-4d4a-a8cb-17fa314aec17	47	857	467bbcf0-7f8c-4c29-bd37-3d960f697660
10850	CREDIT	Network Development	20000	USD	2016-10-11 12:02:18.108-04	2016-10-11 12:02:19.138-04	51	3	\N	2017-10-26 17:24:06.673-04	\N	\N	\N	\N	\N	\N	1	\N	20000	\N	4d0d91bb-7860-4faf-936a-1f6a16d6fb8d	\N	857	4886c6df-feb3-4c47-83cd-233a256d15b6
10917	CREDIT	WWCode t-shirt sales	4397	USD	2017-01-17 22:20:52.226-05	2017-01-17 22:20:52.436-05	51	3	\N	2017-10-26 17:24:06.689-04	\N	\N	\N	\N	\N	\N	1	\N	4397	\N	57579833-124a-4f68-8aa9-924a55697f40	\N	857	4c75e063-bba0-49c9-8872-9663868a41bb
10822	CREDIT	Network Development (100%)	10000	USD	2016-10-06 14:42:47.682-04	2016-10-06 14:42:47.71-04	51	3	\N	2017-10-26 17:24:06.784-04	\N	\N	\N	\N	\N	\N	1	\N	10000	\N	4e09a42d-d21c-4196-b939-cfb090bba849	\N	857	60055c4f-14d4-4947-abda-ef9217563ceb
10820	CREDIT	Donation Scott Z. in honor of his sister	1800	USD	2016-10-11 13:01:23.313-04	2016-10-11 13:01:23.731-04	51	3	\N	2017-10-26 17:24:06.793-04	\N	\N	\N	\N	\N	\N	1	\N	1800	\N	4f3740d9-8995-4d2e-9c06-0f657e239433	\N	857	6125d794-44d0-46d2-8449-eeeabc4025d8
10892	CREDIT	Network Development	17500	USD	2016-10-11 15:35:59.115-04	2016-10-11 15:35:59.305-04	51	3	\N	2017-10-26 17:24:06.822-04	\N	\N	\N	\N	\N	\N	1	\N	17500	\N	cabc7257-0353-4c60-8c15-766505d58a68	\N	857	6421d404-4859-4b01-b484-6c613ab3f67a
10897	DEBIT	Network Development	-17500	USD	2016-10-11 15:35:59.115-04	2016-10-11 15:35:59.305-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-17500	-17500	\N	47e4fa94-b846-49b2-a6fa-7761d72fa1a0	301	857	6421d404-4859-4b01-b484-6c613ab3f67a
10802	CREDIT	Women Techmaker WWCode Partnership Grant	15000	USD	2016-05-24 16:12:34.913-04	2016-05-24 16:12:35.226-04	51	3	\N	2017-10-26 17:24:06.836-04	\N	\N	\N	\N	\N	\N	1	\N	15000	\N	2f6fed65-89e4-410d-bb04-12129c795175	\N	857	65f4c461-0378-46bf-9145-acba2d84008e
10807	DEBIT	Women Techmaker WWCode Partnership Grant	-15000	USD	2016-05-24 16:12:34.913-04	2016-05-24 16:12:35.226-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-15000	-15000	\N	2492f5f4-df58-4063-9758-70abf67cf4f7	13	857	65f4c461-0378-46bf-9145-acba2d84008e
10811	CREDIT	Portland t-shirt proceeds	6915	USD	2016-11-17 13:01:32.1-05	2016-11-17 13:01:32.49-05	51	3	\N	2017-10-26 17:24:06.841-04	\N	\N	\N	\N	\N	\N	1	\N	6915	\N	f9521ab4-a52a-4da9-a1dd-6526d59ca452	\N	857	6654dcaf-6b14-4da8-9b23-414c9d74ccff
10817	DEBIT	Portland t-shirt proceeds	-6915	USD	2016-11-17 13:01:32.1-05	2016-11-17 13:01:32.49-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6915	-6915	\N	be5178b9-efa4-4314-bb0b-7670a16d6d81	59	857	6654dcaf-6b14-4da8-9b23-414c9d74ccff
10926	DEBIT	WWCode Boston t-shirt sales	-1964	USD	2017-01-17 22:19:47.816-05	2017-01-17 22:19:48.024-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-1964	-1964	\N	abd002b0-689e-4312-92f5-4f996f5dc5e0	195	857	681a14e4-aa04-4302-b7df-9efc4f702ac2
10846	CREDIT	Leadership Development 	14915	MXN	2017-03-07 07:55:53.128-05	2017-03-07 07:55:53.3-05	51	3	\N	2017-10-26 17:24:06.892-04	\N	\N	\N	\N	\N	\N	1	\N	14915	\N	852bae92-0a47-46d6-aaf6-65d3e0664dea	\N	857	6c6bdffc-1758-424d-b3ba-acbf53c59209
10902	CREDIT	From Deepa	1500	USD	2016-04-12 17:18:56.547-04	2016-04-16 16:40:58.847-04	51	3	\N	2017-10-26 17:24:07.023-04	\N	\N	\N	\N	\N	\N	1	\N	1500	\N	7b957f70-8f23-4566-8daa-370d327d53cb	\N	857	8b2d652b-5216-455e-a2f7-10647c5beaf0
10758	DEBIT	Network Development	-20000	USD	2016-11-29 19:23:24.87-05	2016-11-29 19:23:24.511-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-20000	-20000	\N	4b1f3ebe-f707-4a84-8488-e075c15480b4	285	857	a9e92dc9-25d5-446c-8440-10a922e510a3
10828	CREDIT	Donation from Adane	450	USD	2016-10-04 18:56:11.881-04	2016-10-04 18:56:13.02-04	51	3	\N	2017-10-26 17:24:07.175-04	\N	\N	\N	\N	\N	\N	1	\N	450	\N	22825f1c-06cf-4b3e-a137-287839b227b9	\N	857	ab5f91b2-7715-4e57-9c27-9b2ade14b176
10933	CREDIT	Priyanka - IOT Hackathon donation - fees and global development 	2175	USD	2016-12-13 15:08:29.218-05	2016-12-13 15:08:29.464-05	51	3	\N	2017-10-26 17:24:07.184-04	\N	\N	\N	\N	\N	\N	1	\N	2175	\N	07aa9806-bb7a-40cb-92f4-ba240e480a23	\N	857	b04ef486-66b0-4329-89b8-5476be49777c
10875	CREDIT	Donation Elizabeth B.	9000	USD	2016-10-11 20:22:08.455-04	2016-10-11 20:22:08.557-04	51	3	\N	2017-10-26 17:24:07.189-04	\N	\N	\N	\N	\N	\N	1	\N	9000	\N	bb2911ba-359e-44af-80b7-bf52d7f35bac	\N	857	b1fd7136-57da-40fc-8018-441b941ba197
10740	DEBIT	Global Development for Meetup Fee	-6000	USD	2016-12-27 14:48:41.246-05	2016-12-27 14:48:41.318-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	9658f44d-028f-408b-ad79-abf161349606	288	857	b958e108-3e79-4d0a-b1c9-2d66d2fc6158
10941	DEBIT	Donation via Meetup - fees + Global Development	-1187	USD	2016-12-13 15:17:57.936-05	2016-12-13 15:17:58.19-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-1187	-1187	\N	3ec811ca-3a96-45c3-9829-1bccf632fda5	272	857	bdb877f4-1d78-481d-b97e-c10817db95c0
10863	DEBIT	Donations made via Meetup as of Jan 2016, less transaction fees	-9212	USD	2016-10-04 11:46:17.845-04	2016-10-04 11:46:18.02-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-9212	-9212	\N	655ddc2c-9cb7-4fe0-95e9-3057fad99ac8	12	857	c1e06911-ef28-4ba5-ab16-f5f228e181a2
10882	CREDIT	Network support - Regional Leadership (thanks VMWare)	370000	USD	2016-10-11 15:51:45.723-04	2016-10-11 15:51:45.897-04	51	3	\N	2017-10-26 17:24:07.284-04	\N	\N	\N	\N	\N	\N	1	\N	370000	\N	1b38ff66-5dc7-44b9-a867-ed10a70c29dd	\N	857	c537c49b-cae3-4697-8bc7-4ebec29b7159
10955	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-23 11:59:24.039-05	2016-12-23 11:59:24.291-05	51	3	\N	2017-10-26 17:24:07.46-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	8cb1abbb-49f0-40ea-8499-90fa510531b5	\N	857	dff25d55-9326-4760-b107-43f83dd0f53f
10793	CREDIT	Donation from Cameron - fees and global development	4350	USD	2017-01-04 15:33:36.359-05	2017-01-04 15:33:37.475-05	51	3	\N	2017-10-26 17:24:07.507-04	\N	\N	\N	\N	\N	\N	1	\N	4350	\N	6cc1a52c-801a-4aa6-8f06-b1d152adf985	\N	857	ea262323-607a-4660-9337-30a6ab0ad6d0
10797	DEBIT	Donation from Cameron - fees and global development	-4350	USD	2017-01-04 15:33:36.359-05	2017-01-04 15:33:37.475-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-4350	-4350	\N	434665d9-2309-4ca0-9d6a-a4ce2720b154	259	857	ea262323-607a-4660-9337-30a6ab0ad6d0
10888	DEBIT	Network Development	-15400	USD	2016-10-04 18:39:26.796-04	2016-10-04 18:39:26.9-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-15400	-15400	\N	f9fa71ac-c9ce-4b5d-8fe1-35ad5e9192f1	273	857	f89d9896-22af-4257-bd3d-f546c22c96ed
10859	CREDIT	Donation: Syema Ailia	2500	USD	2016-10-04 11:47:46.468-04	2016-10-04 11:47:46.624-04	51	3	\N	2017-10-26 17:24:07.565-04	\N	\N	\N	\N	\N	\N	1	\N	2500	\N	8893d363-2398-4bbc-bacb-23b201ef96ce	\N	857	fb6c3a02-639c-48ec-9062-74fb13dbd874
10909	DEBIT	Dalia donated to WWCode SF	-1500	USD	2016-06-09 14:40:21.124-04	2016-06-09 14:40:21.833-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-1500	-1500	\N	3fa7945a-f7fc-45e4-9d87-14105ddd3e92	4	857	ff085df0-ef20-41f4-867c-cafb8b177680
11014	DEBIT	Recurring subscription	-52	USD	2016-03-02 13:26:05.731-05	2016-04-16 16:40:58.833-04	691	30	44	\N	\N	70	5	\N	33	USD	1	-52	-100	\N	19432863-15c2-4950-bde1-3880f1bfd738	13	857	55a55d62-9a76-444e-a4e5-bef99a864c96
10833	DEBIT	Donation to WWCode Austin	-26100	USD	2016-03-25 11:11:04.684-04	2016-04-16 16:40:58.812-04	805	192	152	\N	\N	64	0	\N	900	USD	1	-26100	-30000	\N	0007f367-0bc2-4ca5-b243-e3681d94eb65	2	857	637b47cd-d1e1-48ff-9145-0da9b8cc477f
10922	DEBIT	Donation to WWCode Washington DC	-52	USD	2016-02-02 12:09:22.069-05	2016-04-16 16:40:58.697-04	691	30	44	\N	\N	70	5	\N	33	USD	1	-52	-100	\N	bdfc8687-fadc-40c5-86cb-a2bba98eb827	13	857	4221f820-4cf1-4b26-83fd-86c9d965eeab
10927	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-28 11:31:33.43-05	2016-12-28 11:31:29.837-05	51	3	\N	2017-10-26 17:24:06.333-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	82bcd5db-9873-4d9e-9705-30518b17dd13	\N	857	0ff77414-2198-4f2e-9ec1-6b7333a5db40
10932	DEBIT	Global Development for Meetup Fee	-6000	USD	2016-12-28 11:31:33.43-05	2016-12-28 11:31:29.837-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	e483df8d-cf90-466d-97d4-8fa28bd6c658	294	857	0ff77414-2198-4f2e-9ec1-6b7333a5db40
10830	DEBIT	Network Development	-13286	USD	2016-10-04 18:57:17.136-04	2016-10-04 18:57:17.293-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-13286	-13286	\N	8e8ecfa2-a47f-4399-8214-b0a26d29cea3	260	857	121aa478-d522-4261-9d96-b8dc531d7d8e
10887	CREDIT	Donation Hannah B.	9000	USD	2016-10-04 18:35:46.967-04	2016-10-04 18:35:47.153-04	51	3	\N	2017-10-26 17:24:06.487-04	\N	\N	\N	\N	\N	\N	1	\N	9000	\N	a9ff0fa7-3e47-44a2-87f7-d26426b2d76a	\N	857	2dce4e7d-3bfa-4f2e-9f4f-4557c16a6f34
10893	DEBIT	Donation Hannah B.	-9000	USD	2016-10-04 18:35:46.967-04	2016-10-04 18:35:47.153-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-9000	-9000	\N	9d93ad0f-c8e1-4291-9929-34eb5e7c5340	273	857	2dce4e7d-3bfa-4f2e-9f4f-4557c16a6f34
10973	CREDIT	Banner	2000	USD	2016-11-30 13:40:32.021-05	2016-11-30 13:40:32.139-05	51	3	\N	2017-10-26 17:24:06.504-04	\N	\N	\N	\N	\N	\N	1	\N	2000	\N	3a8e0e69-56d5-4e27-a1c0-d16c96a190b5	\N	857	313fa8d0-9222-47a3-8ed5-dc427c1e61ca
10840	CREDIT	\N	150000	USD	2017-05-03 13:32:39.653-04	2017-05-03 13:32:39.653-04	51	3	\N	2017-10-26 17:24:06.546-04	\N	2693	\N	\N	\N	USD	1	150000	150000	\N	ebc017b5-ca1e-49fd-97dc-22b718c529b4	\N	857	34557504-56f0-4ef5-9911-16f0a3ef1d1b
10849	DEBIT	\N	-150000	USD	2017-05-03 13:32:39.653-04	2017-05-03 13:32:39.653-04	857	3	\N	\N	\N	2693	0	\N	0	USD	1	-150000	-150000	\N	1541797c-0fec-4eeb-baa8-1a5bc72470b1	12	857	34557504-56f0-4ef5-9911-16f0a3ef1d1b
10954	CREDIT	Global Development for Meetup Fee	4900	GBP	2016-12-23 12:02:53.836-05	2016-12-23 12:02:53.991-05	51	3	\N	2017-10-26 17:24:06.555-04	\N	\N	\N	\N	\N	\N	1	\N	4900	\N	0b5ae925-a950-4d6b-aca7-e80e069cf295	\N	857	363a2993-8344-47a0-9875-32dac6958139
10966	DEBIT	Global Development for Meetup Fee	-4900	GBP	2016-12-23 12:02:53.836-05	2016-12-23 12:02:53.991-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-4900	-4900	\N	7acf3212-7491-4f6d-a443-f08b6503cfef	264	857	363a2993-8344-47a0-9875-32dac6958139
10938	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-27 11:58:32.613-05	2016-12-27 11:58:32.719-05	51	3	\N	2017-10-26 17:24:06.643-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	e70297e3-d679-4b8d-9dde-103875fe990c	\N	857	45a38c13-cb16-4808-a151-a908e67ff283
10946	DEBIT	Global Development for Meetup Fee	-6000	USD	2016-12-27 11:58:32.613-05	2016-12-27 11:58:32.719-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	1d13b5a1-eab0-4dc3-bfea-6fdf13abf25f	276	857	45a38c13-cb16-4808-a151-a908e67ff283
10854	CREDIT	Donations via Meetup	2823	USD	2016-10-06 11:53:38.156-04	2016-10-06 11:53:38.231-04	51	3	\N	2017-10-26 17:24:06.657-04	\N	\N	\N	\N	\N	\N	1	\N	2823	\N	02eac6d2-a48b-42ca-8d9a-2b2bc4ed556d	\N	857	4710a845-6d8b-4bb8-b000-298a301c8ee7
10870	CREDIT	Proceeds from teespring	10022	USD	2016-05-26 14:38:50.077-04	2016-05-26 14:38:48.41-04	51	3	\N	2017-10-26 17:24:06.662-04	\N	\N	\N	\N	\N	\N	1	\N	10022	\N	e22ae08f-8485-4e72-b38f-a44c51a24d4b	\N	857	47257e5b-aead-4b84-ae31-51f50919848b
10876	DEBIT	Proceeds from teespring	-10022	USD	2016-05-26 14:38:50.077-04	2016-05-26 14:38:48.41-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-10022	-10022	\N	6f5b5a7d-7ec5-4afc-9359-3a15670d398f	48	857	47257e5b-aead-4b84-ae31-51f50919848b
10925	DEBIT	WWCode t-shirt sales	-4397	USD	2017-01-17 22:20:52.226-05	2017-01-17 22:20:52.436-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-4397	-4397	\N	625320a1-fb0e-42b3-bb04-cba32ae5caa7	273	857	4c75e063-bba0-49c9-8872-9663868a41bb
10978	CREDIT	Global Development - thanks VMWare	50000	USD	2016-11-29 18:07:50.964-05	2016-11-29 18:07:51.154-05	51	3	\N	2017-10-26 17:24:06.764-04	\N	\N	\N	\N	\N	\N	1	\N	50000	\N	5e9b371c-b042-4669-9a1f-eaa2c9e9a591	\N	857	5de80078-7915-4bff-89f1-6ef4da815073
10992	CREDIT	Donation from Shugo	450	USD	2016-10-12 00:30:15.825-04	2016-10-12 00:30:15.896-04	51	3	\N	2017-10-26 17:24:06.803-04	\N	\N	\N	\N	\N	\N	1	\N	450	\N	b5d1fc46-3b08-46ac-a6bf-5ab08eef7ece	\N	857	6250e732-2412-457b-a30b-5790938b9dac
11001	DEBIT	Donation from Shugo	-450	USD	2016-10-12 00:30:15.825-04	2016-10-12 00:30:15.896-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-450	-450	\N	9f0aaba8-d8e5-4e49-8e24-46e7a91fd41c	295	857	6250e732-2412-457b-a30b-5790938b9dac
10821	CREDIT	Conference stipend Heidi H.	50000	USD	2016-10-11 11:59:30.363-04	2016-10-11 11:59:31.524-04	51	3	\N	2017-10-26 17:24:06.98-04	\N	\N	\N	\N	\N	\N	1	\N	50000	\N	c33c8418-7e7e-41ac-9d20-b607e513eef0	\N	857	7fa9091e-4472-4383-84e0-5d75067a1f17
10826	DEBIT	Conference stipend Heidi H.	-50000	USD	2016-10-11 11:59:30.363-04	2016-10-11 11:59:31.524-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-50000	-50000	\N	f4118e1e-8432-40a7-984a-0bbabd6a34d4	195	857	7fa9091e-4472-4383-84e0-5d75067a1f17
10851	CREDIT	Network development	6000	USD	2016-10-06 12:01:48.321-04	2016-10-06 12:01:48.667-04	51	3	\N	2017-10-26 17:24:06.993-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	e8650e12-c6e2-4d33-a9ea-6ae48f150744	\N	857	85a6dbac-4f2e-40be-b685-47ba82531933
10858	DEBIT	Network development	-6000	USD	2016-10-06 12:01:48.321-04	2016-10-06 12:01:48.667-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	cc37a3b6-67b5-40dc-a4b4-25598fd330a7	4	857	85a6dbac-4f2e-40be-b685-47ba82531933
10908	DEBIT	From Deepa	-1500	USD	2016-04-12 17:18:56.547-04	2016-04-16 16:40:58.847-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-1500	-1500	\N	a594498c-f745-465b-bd02-afd235a4e7cd	4	857	8b2d652b-5216-455e-a2f7-10647c5beaf0
10952	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-23 12:31:16.26-05	2016-12-23 12:31:16.392-05	51	3	\N	2017-10-26 17:24:07.032-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	bde429ba-ae5a-464a-a471-0abae8fb58d5	\N	857	8d928bbe-5b2e-4324-9219-3fd51d8c562e
10911	CREDIT	From:\tThao Le	1500	USD	2016-04-12 14:49:06.645-04	2016-04-16 16:40:58.815-04	51	3	\N	2017-10-26 17:24:07.12-04	\N	\N	\N	\N	\N	\N	1	\N	1500	\N	72d26248-1df5-4ea2-bfc0-7cf1b73e8c4b	\N	857	a14b43da-2557-403e-aaa1-8bad61c68c59
10916	DEBIT	From:\tThao Le	-1500	USD	2016-04-12 14:49:06.645-04	2016-04-16 16:40:58.815-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-1500	-1500	\N	c67d9645-33df-4851-9973-73e12ffae66e	4	857	a14b43da-2557-403e-aaa1-8bad61c68c59
10974	CREDIT	Network Development	20000	USD	2016-11-30 13:40:15.233-05	2016-11-30 13:40:15.446-05	51	3	\N	2017-10-26 17:24:07.125-04	\N	\N	\N	\N	\N	\N	1	\N	20000	\N	1213d747-074e-4533-87e3-6a10867e603d	\N	857	a1510432-66cc-4ab7-b3ea-accc3309f09d
10983	DEBIT	Network Development	-20000	USD	2016-11-30 13:40:15.233-05	2016-11-30 13:40:15.446-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-20000	-20000	\N	2f59b3f0-be18-41b8-bff0-583ab61deba0	292	857	a1510432-66cc-4ab7-b3ea-accc3309f09d
10874	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-21 13:49:47.667-05	2016-12-21 13:49:47.892-05	51	3	\N	2017-10-26 17:24:07.139-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	3de36aeb-39ea-4eb9-ae8e-8d2e202b387d	\N	857	a467cb2b-868f-47d5-aaed-ced232702d6e
10881	DEBIT	Global Development for Meetup Fee	-6000	USD	2016-12-21 13:49:47.667-05	2016-12-21 13:49:47.892-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	82cc08c0-397b-4907-bf2a-d8bb375de06e	2	857	a467cb2b-868f-47d5-aaed-ced232702d6e
10981	DEBIT	Network Development	-20000	USD	2016-11-30 15:59:29.087-05	2016-11-30 15:59:29.921-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-20000	-20000	\N	f681473e-759d-4564-86e1-4cc5fb0a603b	280	857	a81f1687-1851-4337-8a08-ed10811d3c4d
10845	DEBIT	WWCode t-shirt sales	-3563	USD	2017-01-17 22:28:29.874-05	2017-01-17 22:28:30.096-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-3563	-3563	\N	ebc92e8d-0c49-4679-b548-c5e53c71d0dc	290	857	ca918f65-1ea6-4800-85e6-7c4b89829969
10997	CREDIT	Network Development	19100	USD	2016-10-11 20:28:02.718-04	2016-10-11 20:28:03.121-04	51	3	\N	2017-10-26 17:24:07.333-04	\N	\N	\N	\N	\N	\N	1	\N	19100	\N	51b5e39c-7273-4bf0-b4c0-96da19135e02	\N	857	cc3cc99f-569a-4615-9a68-f26b3975edde
10988	CREDIT	Regional Leadership Director Training	631	USD	2016-11-29 17:38:57.006-05	2016-11-29 17:38:57.13-05	51	3	\N	2017-10-26 17:24:07.354-04	\N	\N	\N	\N	\N	\N	1	\N	631	\N	0c33da68-b711-4528-bc3e-993e18913ab3	\N	857	cfd23047-8a77-4cec-8d2c-192ce4c222d1
10896	DEBIT	Donation Ailia S.	-9000	USD	2016-10-11 15:44:42.807-04	2016-10-11 15:44:43.161-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-9000	-9000	\N	2d66f7d8-c3c9-46a0-bc54-c21f1530ac05	270	857	d1c7a4d4-915c-4061-af4d-34df0dde8688
10862	CREDIT	Donation from MondoRobot & Avery Brewing Company: Hackathon Proceeds	320247	USD	2016-06-29 14:42:31.848-04	2016-06-29 14:42:32.517-04	51	3	\N	2017-10-26 17:24:07.391-04	\N	\N	\N	\N	\N	\N	1	\N	320247	\N	904a943b-5284-4492-91f5-22c52a6cccbe	\N	857	d680641c-abc8-45bc-bca4-73e113c57ed0
11006	DEBIT	Hackathon Support Open Gov	-45000	USD	2016-10-07 10:41:08.315-04	2016-10-07 10:41:08.391-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-45000	-45000	\N	2a24f27e-117a-4854-a957-2ecb2dc9962e	300	857	d9caf112-a17a-4b8c-8451-9d136d5485ea
10969	CREDIT	Global Development	20000	USD	2016-11-30 16:11:00.067-05	2016-11-30 16:11:00.307-05	51	3	\N	2017-10-26 17:24:07.446-04	\N	\N	\N	\N	\N	\N	1	\N	20000	\N	896d518e-8dcf-4474-a93c-1b138afb1cf6	\N	857	de30b118-7091-4703-8e89-17efcb94c86d
10979	DEBIT	Global Development	-20000	USD	2016-11-30 16:11:00.067-05	2016-11-30 16:11:00.307-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-20000	-20000	\N	7dc982aa-fa1c-4e47-852e-533c84604e33	294	857	de30b118-7091-4703-8e89-17efcb94c86d
10963	DEBIT	Global Development for Meetup Fee	-6000	USD	2016-12-23 11:59:24.039-05	2016-12-23 11:59:24.291-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	38a55c97-8941-41e3-9ec8-deeb2821dc26	263	857	dff25d55-9326-4760-b107-43f83dd0f53f
10959	DEBIT	Google I/O stipend	-39585	GBP	2016-10-07 09:35:45.945-04	2016-10-07 09:35:46.151-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-39585	-39585	\N	4c1ac0fd-6ce1-416c-8102-efc1f6258afb	278	857	e6926362-00f2-4db7-bc14-c7419ee5b750
10867	DEBIT	Donation: Syema Ailia	-2500	USD	2016-10-04 11:47:46.468-04	2016-10-04 11:47:46.624-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-2500	-2500	\N	eed7cfe5-de1b-4fc6-bd61-a6acddc8f423	12	857	fb6c3a02-639c-48ec-9062-74fb13dbd874
11020	DEBIT	monthly recurring subscription	-53	USD	2017-02-09 13:29:30.017-05	2017-02-09 13:29:30.017-05	819	8	385	\N	\N	320	5	\N	32	USD	1	-53	-100	\N	61b958a6-7dd8-4cef-b0ab-08ed8c5a95f2	3	857	ce679571-c4c9-4fb4-973a-7973f025a198
11035	CREDIT	WWC Boulder- April event's food	14100	USD	2016-04-06 20:00:00-04	2016-06-14 14:14:21.989-04	755	68	320	\N	\N	\N	\N	\N	\N	\N	1	14100	14100	137	fc39347c-d56a-4bac-951b-3d63337456d4	15	857	8d156329-21c7-420a-9697-8afc8067a7e3
11043	DEBIT	Donation to WWCode Mexico City	0	MXN	2016-02-15 13:46:05.92-05	2016-04-01 10:32:17.223-04	821	7	64	2016-04-07 10:32:17.381-04	\N	83	\N	\N	\N	\N	1	0	-100	\N	e8bc84c9-0af7-4aaf-a211-1f63904f5790	10	857	b049f817-1453-42b9-83f3-1bba9c75f74d
10844	DEBIT	Recurring subscription	-52	USD	2016-03-02 13:19:33.362-05	2016-04-16 16:40:58.737-04	691	30	43	\N	\N	69	5	\N	33	USD	1	-52	-100	\N	877c735f-413c-47e0-9a29-d0533458d5aa	13	857	ab990239-75f9-4046-8d2e-acda04d6b3a2
10919	DEBIT	Donation to WWCode Atlanta	-891	USD	2016-01-29 17:23:53.315-05	2016-04-16 16:40:58.701-04	691	30	39	\N	\N	13	0	\N	59	USD	1	-891	-1000	\N	68d73037-1973-4629-9d1c-cb38618ac48f	12	857	8d08295a-233f-48bc-8893-5ea2e7f74f99
11025	DEBIT	Recurring subscription	-53	USD	2017-01-09 13:28:29.701-05	2017-01-09 13:28:29.701-05	819	8	385	\N	\N	320	5	\N	32	USD	1	-53	-100	\N	3d2dfd2b-da14-4c9a-ab08-0c7f68c2d796	3	857	cfa1aacf-65fc-44fd-9d0a-cef56823901d
10871	DEBIT	Global Development for Meetup Fee	-6000	MXN	2016-12-27 11:10:30.416-05	2016-12-27 11:10:30.529-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	b2dedbc8-ea8d-40ba-915f-31c9230cced4	299	857	058d345c-2203-452f-bb56-903f4fb5255d
10961	DEBIT	Global Development for Meetup Fee	-6000	AUD	2016-12-23 12:41:14.029-05	2016-12-23 12:41:14.193-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	88f0365b-1b34-4d66-b4ab-e1df30a2a6a0	266	857	1d39b3be-07e6-4975-9946-9ee20bd781ee
11007	CREDIT	Course Hero Hackathon Support	315000	USD	2016-10-07 10:39:15.069-04	2016-10-07 10:39:15.23-04	51	3	\N	2017-10-26 17:24:06.392-04	\N	\N	\N	\N	\N	\N	1	\N	315000	\N	4a293423-e2c4-4ec6-9719-4354f6d8b617	\N	857	1efd0e3f-33f3-4cac-8b09-7294c195bfad
11011	DEBIT	Course Hero Hackathon Support	-315000	USD	2016-10-07 10:39:15.069-04	2016-10-07 10:39:15.23-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-315000	-315000	\N	f8c75edd-d9bd-4069-9db6-fc6be676265e	300	857	1efd0e3f-33f3-4cac-8b09-7294c195bfad
10958	CREDIT	Global Development for Meetup Fee	5700	EUR	2016-12-23 12:13:39.369-05	2016-12-23 12:13:39.507-05	51	3	\N	2017-10-26 17:24:06.396-04	\N	\N	\N	\N	\N	\N	1	\N	5700	\N	da8008ab-3459-4e19-b3ed-47202a430a86	\N	857	21271fa5-951c-4861-b772-f6e8ce65e9c7
10965	DEBIT	Global Development for Meetup Fee	-5700	EUR	2016-12-23 12:13:39.369-05	2016-12-23 12:13:39.507-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-5700	-5700	\N	a5290a57-76b0-4ff1-9306-3eba0514134a	301	857	21271fa5-951c-4861-b772-f6e8ce65e9c7
10894	CREDIT	Andrea S	1500	USD	2016-04-27 16:05:44.711-04	2016-04-27 16:05:44.974-04	51	3	\N	2017-10-26 17:24:06.447-04	\N	\N	\N	\N	\N	\N	1	\N	1500	\N	185b703f-b7ff-413a-b3d6-9564ee1cbd8a	\N	857	2860c49f-3df0-47fd-bb21-6582507854fa
10903	DEBIT	Andrea S	-1500	USD	2016-04-27 16:05:44.711-04	2016-04-27 16:05:44.974-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-1500	-1500	\N	08c03998-f6e0-471b-9770-4efc139c075b	48	857	2860c49f-3df0-47fd-bb21-6582507854fa
10899	CREDIT	Network Development	17750	USD	2016-10-11 15:17:21.991-04	2016-10-11 15:17:22.199-04	51	3	\N	2017-10-26 17:24:06.451-04	\N	\N	\N	\N	\N	\N	1	\N	17750	\N	78a23c13-4e53-44b5-8444-f282408d09ad	\N	857	2893bac3-fee8-45d7-8184-c6d149cd5a45
10906	DEBIT	Network Development	-17750	USD	2016-10-11 15:17:21.991-04	2016-10-11 15:17:22.199-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-17750	-17750	\N	8cfa61db-661b-4de5-81d2-5fb6c5a48039	279	857	2893bac3-fee8-45d7-8184-c6d149cd5a45
10841	CREDIT	Leadership Development	50616	MXN	2017-03-07 08:01:15.044-05	2017-03-07 08:01:15.192-05	51	3	\N	2017-10-26 17:24:06.461-04	\N	\N	\N	\N	\N	\N	1	\N	50616	\N	bccc122e-57c8-40fa-a92a-476215d68364	\N	857	2a314ccf-4834-4554-9652-f600bfca92f7
10848	DEBIT	Leadership Development	-50616	MXN	2017-03-07 08:01:15.044-05	2017-03-07 08:01:15.192-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-50616	-50616	\N	ded2b541-0e12-4536-982e-1d8bc19713bb	282	857	2a314ccf-4834-4554-9652-f600bfca92f7
11015	CREDIT	Sponsorship: AT&T Hackathon Prize	1000000	USD	2016-10-04 11:40:37.72-04	2016-10-04 11:40:37.853-04	51	3	\N	2017-10-26 17:24:06.476-04	\N	\N	\N	\N	\N	\N	1	\N	1000000	\N	105cfa99-1cc4-4bf7-8d6d-c00bc0e088a5	\N	857	2cd57cf6-e3fc-4bff-93c7-29d05bcece28
11023	DEBIT	Sponsorship: AT&T Hackathon Prize	-1000000	USD	2016-10-04 11:40:37.72-04	2016-10-04 11:40:37.853-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-1000000	-1000000	\N	30bdf775-b160-425c-84dc-522d68dfa41c	12	857	2cd57cf6-e3fc-4bff-93c7-29d05bcece28
10993	CREDIT	Hackbright support for hackathon	45000	USD	2016-10-07 16:04:15.299-04	2016-10-07 16:04:15.435-04	51	3	\N	2017-10-26 17:24:06.509-04	\N	\N	\N	\N	\N	\N	1	\N	45000	\N	92c6d47f-d58b-4f1a-8a33-c6551931a97a	\N	857	3144942f-b642-492b-885e-e46f83feb1f8
11003	DEBIT	Hackbright support for hackathon	-45000	USD	2016-10-07 16:04:15.299-04	2016-10-07 16:04:15.435-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-45000	-45000	\N	90a47c1c-426c-46ef-af8e-3e7a58b10ed1	300	857	3144942f-b642-492b-885e-e46f83feb1f8
11008	CREDIT	Donation from Marie W.	900	USD	2016-10-11 20:26:47.2-04	2016-10-11 20:26:47.59-04	51	3	\N	2017-10-26 17:24:06.522-04	\N	\N	\N	\N	\N	\N	1	\N	900	\N	7fb16d33-9ebc-4e78-a879-cea7a436e0e7	\N	857	3198426e-213d-4b72-8f27-f8f20e640e95
11016	DEBIT	Donation from Marie W.	-900	USD	2016-10-11 20:26:47.2-04	2016-10-11 20:26:47.59-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-900	-900	\N	3cf5c90a-03b4-4584-a2e5-6ec18248b8cf	284	857	3198426e-213d-4b72-8f27-f8f20e640e95
10987	CREDIT	Network Development	20000	USD	2016-11-29 17:43:53.719-05	2016-11-29 17:43:53.971-05	51	3	\N	2017-10-26 17:24:06.573-04	\N	\N	\N	\N	\N	\N	1	\N	20000	\N	f48f2ef3-2333-446b-a7af-52bd352e3941	\N	857	3771b950-122d-47e5-a2c6-a13811970366
10999	DEBIT	Network Development (Thanks Atlassian) 	-20000	USD	2016-10-12 01:06:05.058-04	2016-10-12 01:06:05.202-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-20000	-20000	\N	016e957b-bc02-4566-b04c-0d3d9dcebaef	266	857	3c7f99a7-a1a0-426f-9f02-00903bbd5471
10857	DEBIT	Network Development	-20000	USD	2016-10-11 12:02:18.108-04	2016-10-11 12:02:19.138-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-20000	-20000	\N	fdf666bc-3f81-414b-8e41-633f2f46c632	195	857	4886c6df-feb3-4c47-83cd-233a256d15b6
10825	DEBIT	Donation Scott Z. in honor of his sister	-1800	USD	2016-10-11 13:01:23.313-04	2016-10-11 13:01:23.731-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-1800	-1800	\N	e0b7f793-3df7-4ac3-8c57-ffa235d839ba	291	857	6125d794-44d0-46d2-8449-eeeabc4025d8
10934	CREDIT	Global Development for Meetup Fee	4900	GBP	2016-12-27 12:32:02.798-05	2016-12-27 12:32:02.918-05	51	3	\N	2017-10-26 17:24:06.919-04	\N	\N	\N	\N	\N	\N	1	\N	4900	\N	c7f46401-303c-4f1b-b68d-df11a225f2d8	\N	857	74e1c338-3687-4609-83cb-ef1a27c9223f
10943	DEBIT	Global Development for Meetup Fee	-4900	GBP	2016-12-27 12:32:02.798-05	2016-12-27 12:32:02.918-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-4900	-4900	\N	285504fd-cc42-416c-9b9e-c201380001fc	278	857	74e1c338-3687-4609-83cb-ef1a27c9223f
10971	CREDIT	Leadership development - conference stipend Google I/O	130000	USD	2016-11-30 16:07:12.142-05	2016-11-30 16:07:12.419-05	51	3	\N	2017-10-26 17:24:06.932-04	\N	\N	\N	\N	\N	\N	1	\N	130000	\N	c8ceca1a-b4c3-412e-bc1e-fbc0e772a809	\N	857	7773592c-36cc-44a6-8756-edae871029b6
10980	DEBIT	Leadership development - conference stipend Google I/O	-130000	USD	2016-11-30 16:07:12.142-05	2016-11-30 16:07:12.419-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-130000	-130000	\N	afb821d7-248f-403b-b0a6-99f47615cf2b	241	857	7773592c-36cc-44a6-8756-edae871029b6
10853	DEBIT	Google I/O scholarship	-75000	USD	2016-10-06 13:21:27.384-04	2016-10-06 13:21:27.396-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-75000	-75000	\N	716b7433-7134-4d21-b3eb-95f6ee531e99	13	857	906ff318-b3e2-4444-9ca2-7348fdca5c36
10914	CREDIT	Women Techmaker/WWCode partnership grant	50000	USD	2016-05-04 17:17:27.653-04	2016-05-04 17:17:27.886-04	51	3	\N	2017-10-26 17:24:07.092-04	\N	\N	\N	\N	\N	\N	1	\N	50000	\N	5d88661d-2804-4fcb-8e58-103ce9087a38	\N	857	9c4cc495-5200-4f25-8855-78f2e734f469
10923	DEBIT	Women Techmaker/WWCode partnership grant	-50000	USD	2016-05-04 17:17:27.653-04	2016-05-04 17:17:27.886-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-50000	-50000	\N	673a8587-d2db-4049-9189-ec46f2a13280	13	857	9c4cc495-5200-4f25-8855-78f2e734f469
10975	CREDIT	Donation from PB - fees 	1187	USD	2016-11-29 18:33:50.04-05	2016-11-29 18:33:50.206-05	51	3	\N	2017-10-26 17:24:07.129-04	\N	\N	\N	\N	\N	\N	1	\N	1187	\N	482b8633-8ad3-4e75-b594-368412214020	\N	857	a3115ee7-1f41-49fc-8093-f052686cde28
10984	DEBIT	Donation from PB - fees 	-1187	USD	2016-11-29 18:33:50.04-05	2016-11-29 18:33:50.206-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-1187	-1187	\N	f94c734d-58a4-487a-8243-4359c9c4eb84	4	857	a3115ee7-1f41-49fc-8093-f052686cde28
10880	DEBIT	Donation Elizabeth B.	-9000	USD	2016-10-11 20:22:08.455-04	2016-10-11 20:22:08.557-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-9000	-9000	\N	19437a58-082b-4e75-9f07-f14acd73a4d6	288	857	b1fd7136-57da-40fc-8018-441b941ba197
10829	CREDIT	Network budget pre Open Collective	6264	USD	2016-10-04 18:51:25.324-04	2016-10-04 18:51:26.129-04	51	3	\N	2017-10-26 17:24:07.212-04	\N	\N	\N	\N	\N	\N	1	\N	6264	\N	c36f6b46-c428-4f9e-8c14-20215ea9fe5c	\N	857	b3b7cddb-5541-4350-aa77-e409abe2c332
10929	CREDIT	Global Development for Meetup Fee	4900	GBP	2016-12-23 12:55:42.091-05	2016-12-23 12:55:42.249-05	51	3	\N	2017-10-26 17:24:07.233-04	\N	\N	\N	\N	\N	\N	1	\N	4900	\N	0b5cc8ae-6b11-499b-8f70-947e399f5999	\N	857	b7f96a61-bf42-4480-b2d2-4a822c71dc33
10939	DEBIT	Global Development for Meetup Fee	-4900	GBP	2016-12-23 12:55:42.091-05	2016-12-23 12:55:42.249-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-4900	-4900	\N	9dd04b2e-2a1b-444d-86fa-76ad04d7f9f0	267	857	b7f96a61-bf42-4480-b2d2-4a822c71dc33
10839	CREDIT	WWCode t-shirt sales	3563	USD	2017-01-17 22:28:29.874-05	2017-01-17 22:28:30.096-05	51	3	\N	2017-10-26 17:24:07.327-04	\N	\N	\N	\N	\N	\N	1	\N	3563	\N	5f878d37-f65f-46e7-ac96-815e5ed7c8b8	\N	857	ca918f65-1ea6-4800-85e6-7c4b89829969
10996	DEBIT	Regional Leadership Director Training	-631	USD	2016-11-29 17:38:57.006-05	2016-11-29 17:38:57.13-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-631	-631	\N	62c8dca8-740a-4250-bafa-d8210c819cc2	47	857	cfd23047-8a77-4cec-8d2c-192ce4c222d1
10891	CREDIT	Donation Ailia S.	9000	USD	2016-10-11 15:44:42.807-04	2016-10-11 15:44:43.161-04	51	3	\N	2017-10-26 17:24:07.359-04	\N	\N	\N	\N	\N	\N	1	\N	9000	\N	9f2f08d8-8828-4917-ae58-a59808de9b0a	\N	857	d1c7a4d4-915c-4061-af4d-34df0dde8688
10949	CREDIT	Google I/O stipend	39585	GBP	2016-10-07 09:35:45.945-04	2016-10-07 09:35:46.151-04	51	3	\N	2017-10-26 17:24:07.493-04	\N	\N	\N	\N	\N	\N	1	\N	39585	\N	dc638ce1-241f-4bb1-8e60-c26063409337	\N	857	e6926362-00f2-4db7-bc14-c7419ee5b750
11027	DEBIT	Recurring subscription	-52	USD	2016-03-02 18:01:26.771-05	2016-04-16 16:40:58.719-04	819	8	45	\N	\N	71	5	\N	33	USD	1	-52	-100	\N	2742786c-3af1-486c-9ee7-cfbd847cf3f4	14	857	83c3328c-5cfd-421b-94a4-d0b3935fbc9d
11030	DEBIT	Recurring subscription	-798	USD	2016-12-01 18:32:26.764-05	2016-12-01 18:32:26.764-05	803	686	461	\N	\N	386	50	\N	52	USD	1	-798	-1000	\N	eb54a813-f3ea-4fcd-8a98-898170dccf41	2	857	bdb1a9c6-4ef4-4332-8310-f8760c0eb07b
11033	CREDIT	Order for stickers of our official WWC Boulder/Denver chapter logo	7800	USD	2016-11-03 15:45:23.582-04	2016-11-03 15:45:24.25-04	755	68	1117	\N	\N	\N	\N	\N	\N	\N	1	7800	7800	48	9bb551b9-1906-4b38-89f3-58963b23bfd5	15	857	e30562f8-0666-4a08-9b1e-dfe529a029f8
11028	DEBIT	Recurring subscription	-53	USD	2016-11-09 13:29:23.967-05	2016-11-09 13:29:23.967-05	819	8	385	\N	\N	320	5	\N	32	USD	1	-53	-100	\N	1af23a85-1a9b-4dcd-b0b7-cb5b8bcd793c	3	857	3824623c-d8de-438b-a354-a393ae48b1d5
11032	DEBIT	Recurring subscription	-798	USD	2016-09-01 19:32:42.475-04	2016-09-01 19:32:42.475-04	803	686	461	\N	\N	386	50	\N	52	USD	1	-798	-1000	\N	011e9591-22df-4526-9959-278d589ee723	2	857	477a43bf-b011-4c6f-94c5-8d7332b4c835
11034	CREDIT	Mile High Agile outreach- supplies	1115	USD	2016-04-02 20:00:00-04	2016-06-14 14:14:21.989-04	755	68	26	\N	\N	\N	\N	\N	\N	\N	1	1115	1115	136	0e29e319-50fc-4f12-9272-96fe524fc6e6	15	857	ff85882e-1001-4c43-a4d8-2dfca97e49ec
11038	CREDIT	WWC Stickers	7000	USD	2016-03-17 20:00:00-04	2016-06-14 14:14:21.998-04	755	68	\N	2016-06-14 14:14:22.481-04	\N	\N	\N	\N	\N	\N	1	7000	7000	138	ed069abe-91f7-494b-b34f-e0432b69e22f	15	857	8dd70fa6-0f82-4b82-a5b2-91c169951c9b
11042	DEBIT	\N	-136	USD	2017-04-30 21:40:30.232-04	2017-04-30 21:40:30.232-04	841	3419	2749	\N	\N	2636	10	\N	34	USD	1	-136	-200	\N	ab16d1b5-f36a-4b9f-bca9-892ace76bb34	516	857	4094e5ba-5a47-407a-92a9-50465e91e816
11046	DEBIT	monthly recurring subscription	-798	USD	2017-04-01 19:32:24.254-04	2017-04-01 19:32:24.254-04	803	686	461	\N	\N	386	50	\N	52	USD	1	-798	-1000	\N	8f3df44c-66c0-4324-9e44-6dba17731134	2	857	56c60d18-f92d-4de7-9782-65ae6c85bdb0
11049	DEBIT	Donation to WWCode Austin	-61125	USD	2016-06-22 16:09:46.403-04	2016-06-22 16:09:46.432-04	771	646	435	\N	\N	364	3750	\N	2625	USD	1	-61125	-75000	\N	ef64b75b-9704-40f3-9492-01e8fee88e9c	2	857	1e98e19a-4737-4c9c-a871-7b2893909921
10953	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-23 12:20:13.429-05	2016-12-23 12:20:13.545-05	51	3	\N	2017-10-26 17:24:06.323-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	3d36d7da-159d-4d4f-aa90-9bf7bc41ddcb	\N	857	0d9e6906-e705-4919-aa9c-057ed092fc23
10964	DEBIT	Regional Leadership Director Meeting 	-7500	USD	2016-11-30 16:20:12.669-05	2016-11-30 16:20:16.148-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-7500	-7500	\N	9a484496-4609-4255-a232-5e2c2a5bd6c8	269	857	141d1111-2b08-4877-a0b8-1936b3723742
11017	DEBIT	Diana A. Scholarship Google I/O	-25000	USD	2016-10-04 18:19:06.989-04	2016-10-04 18:19:07.108-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-25000	-25000	\N	fccd518b-bd69-46a8-ac1b-5aa6a429df91	272	857	1c5a4959-9738-465d-b5db-6e190149d67e
10936	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-27 12:24:55.371-05	2016-12-27 12:24:55.632-05	51	3	\N	2017-10-26 17:24:06.431-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	43b2333c-39d3-4f5e-9a33-5f0fcd4e23d8	\N	857	273c383e-9e83-49e3-a75c-dc68dbbf058f
10945	DEBIT	Global Development for Meetup Fee	-6000	USD	2016-12-27 12:24:55.371-05	2016-12-27 12:24:55.632-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	fcd22ee6-a2e2-4373-8af0-45d1a8528ae8	279	857	273c383e-9e83-49e3-a75c-dc68dbbf058f
10860	DEBIT	Donations via Meetup	-2823	USD	2016-10-06 11:53:38.156-04	2016-10-06 11:53:38.231-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-2823	-2823	\N	be93e5ce-0584-4e52-a14d-722f6c937ea8	4	857	4710a845-6d8b-4bb8-b000-298a301c8ee7
10910	CREDIT	Leslie Mollner: Thank you very much for all the help I've received from WWCode -TC so far. -Leslie	2250	USD	2016-04-06 14:17:07.204-04	2016-04-16 16:40:58.818-04	51	3	\N	2017-10-26 17:24:06.667-04	\N	\N	\N	\N	\N	\N	1	\N	2250	\N	21490a98-2d94-4137-b8e6-923ef140a90b	\N	857	47c77ff3-fdbc-4006-b3a3-426b2a8320b5
10852	DEBIT	Leadership Development 	-14915	MXN	2017-03-07 07:55:53.128-05	2017-03-07 07:55:53.3-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-14915	-14915	\N	dce816c4-a611-482f-8895-f122ac1a1cc4	511	857	6c6bdffc-1758-424d-b3ba-acbf53c59209
10856	CREDIT	Reverse duplicate transaction	500	USD	2016-10-04 12:12:26.671-04	2016-10-04 12:12:26.903-04	51	3	\N	2017-10-26 17:24:06.896-04	\N	\N	\N	\N	\N	\N	1	\N	500	\N	7b6bdb16-aa44-4667-adb7-a25a6dc4b13d	\N	857	6da26700-e573-4cd3-825d-8540d9e4a5a9
10865	CREDIT	\N	60000	USD	2017-05-02 14:45:44.253-04	2017-05-02 14:45:44.253-04	51	3	\N	2017-10-26 17:24:06.923-04	\N	2677	\N	\N	\N	USD	1	60000	60000	\N	58b0b911-637d-4505-8b21-67ef2df16bea	\N	857	76a6b34c-950c-4160-9f3a-d58653783379
10873	DEBIT	\N	-60000	USD	2017-05-02 14:45:44.253-04	2017-05-02 14:45:44.253-04	857	3	\N	\N	\N	2677	0	\N	0	USD	1	-60000	-60000	\N	a22fb5b4-365e-447a-99d8-270065e918ed	51	857	76a6b34c-950c-4160-9f3a-d58653783379
11012	CREDIT	Network Development	17375	USD	2016-10-04 18:15:45.133-04	2016-10-04 18:15:45.269-04	51	3	\N	2017-10-26 17:24:06.927-04	\N	\N	\N	\N	\N	\N	1	\N	17375	\N	6f2e9ffc-6055-4370-9f81-3eb1e6d453b2	\N	857	77559847-67a8-4a40-9a25-36d3b435edf8
11021	DEBIT	Network Development	-17375	USD	2016-10-04 18:15:45.133-04	2016-10-04 18:15:45.269-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-17375	-17375	\N	d557b0b1-6962-4182-a6c4-45df40a4e8d5	272	857	77559847-67a8-4a40-9a25-36d3b435edf8
10995	CREDIT	Google I/O conference stipend	102409	GBP	2016-10-07 09:10:42.97-04	2016-10-07 09:10:43.753-04	51	3	\N	2017-10-26 17:24:06.947-04	\N	\N	\N	\N	\N	\N	1	\N	102409	\N	1ef59112-8cc4-4550-b4d2-680f8bc1a043	\N	857	79ae0184-77de-4fd8-ac05-150665ff1ad2
11004	DEBIT	Google I/O conference stipend	-102409	GBP	2016-10-07 09:10:42.97-04	2016-10-07 09:10:43.753-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-102409	-102409	\N	081ddcd6-10dc-43c6-b4f5-ea22a5714607	278	857	79ae0184-77de-4fd8-ac05-150665ff1ad2
10847	CREDIT	Google I/O scholarship	75000	USD	2016-10-06 13:21:27.384-04	2016-10-06 13:21:27.396-04	51	3	\N	2017-10-26 17:24:07.042-04	\N	\N	\N	\N	\N	\N	1	\N	75000	\N	60c3e4ff-b30c-4155-9ff3-d8c6164b187e	\N	857	906ff318-b3e2-4444-9ca2-7348fdca5c36
10942	DEBIT	Priyanka - IOT Hackathon donation - fees and global development 	-2175	USD	2016-12-13 15:08:29.218-05	2016-12-13 15:08:29.464-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-2175	-2175	\N	3d78b015-5f87-413d-840d-65e62763bc6c	59	857	b04ef486-66b0-4329-89b8-5476be49777c
10931	CREDIT	Donation via Meetup - fees + Global Development	1187	USD	2016-12-13 15:17:57.936-05	2016-12-13 15:17:58.19-05	51	3	\N	2017-10-26 17:24:07.256-04	\N	\N	\N	\N	\N	\N	1	\N	1187	\N	ce39665a-154d-462b-a520-7372b5eb3862	\N	857	bdb877f4-1d78-481d-b97e-c10817db95c0
10855	CREDIT	Donations made via Meetup as of Jan 2016, less transaction fees	9212	USD	2016-10-04 11:46:17.845-04	2016-10-04 11:46:18.02-04	51	3	\N	2017-10-26 17:24:07.267-04	\N	\N	\N	\N	\N	\N	1	\N	9212	\N	098c4a65-b438-4d1f-af81-9feb7aa5c74a	\N	857	c1e06911-ef28-4ba5-ab16-f5f228e181a2
10976	CREDIT	CONNECT 2016	4536939	USD	2016-11-29 16:44:20.041-05	2016-11-29 16:44:20.185-05	51	3	\N	2017-10-26 17:24:07.291-04	\N	\N	\N	\N	\N	\N	1	\N	4536939	\N	bd44c606-376e-4b25-ac51-74303fda2ff2	\N	857	c6fca1c0-10b6-47bc-b9f0-0edb17153a34
10985	DEBIT	CONNECT 2016	-4536939	USD	2016-11-29 16:44:20.041-05	2016-11-29 16:44:20.185-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-4536939	-4536939	\N	3d211d45-f657-4522-869e-dea64e60cc71	14	857	c6fca1c0-10b6-47bc-b9f0-0edb17153a34
10915	CREDIT	WWCode t-shirt sales	1599	USD	2017-01-17 22:21:50.791-05	2017-01-17 22:21:50.964-05	51	3	\N	2017-10-26 17:24:07.309-04	\N	\N	\N	\N	\N	\N	1	\N	1599	\N	bd488458-93db-4f68-9e52-1fe76e7174e2	\N	857	c8dddb45-6054-43f7-bb24-3657f6a6c099
10924	DEBIT	WWCode t-shirt sales	-1599	USD	2017-01-17 22:21:50.791-05	2017-01-17 22:21:50.964-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-1599	-1599	\N	d5e3c3c8-5da1-414f-8c71-9d656aac88f2	271	857	c8dddb45-6054-43f7-bb24-3657f6a6c099
10948	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-27 11:38:50.944-05	2016-12-27 11:38:51.039-05	51	3	\N	2017-10-26 17:24:07.323-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	1b596348-b73c-40f8-a9e6-96a071d2a610	\N	857	ca079eaf-5d35-435c-a521-2339f7dda6e3
10956	DEBIT	Global Development for Meetup Fee	-6000	USD	2016-12-27 11:38:50.944-05	2016-12-27 11:38:51.039-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	1cf3fce0-8ecd-4a29-b0ff-226412ee6bf0	272	857	ca079eaf-5d35-435c-a521-2339f7dda6e3
10884	CREDIT	Network support - thanks VMWare	200000	USD	2016-10-11 15:50:00.045-04	2016-10-11 15:50:00.312-04	51	3	\N	2017-10-26 17:24:07.338-04	\N	\N	\N	\N	\N	\N	1	\N	200000	\N	fe9acd21-99a7-46e4-8e37-3ff107b9fef8	\N	857	cc8854fb-fa73-401a-9b97-038c67be7fdf
10890	DEBIT	Network support - thanks VMWare	-200000	USD	2016-10-11 15:50:00.045-04	2016-10-11 15:50:00.312-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-200000	-200000	\N	58278ae6-7814-4871-8719-ce504e284649	262	857	cc8854fb-fa73-401a-9b97-038c67be7fdf
10869	DEBIT	Donation from MondoRobot & Avery Brewing Company: Hackathon Proceeds	-320247	USD	2016-06-29 14:42:31.848-04	2016-06-29 14:42:32.517-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-320247	-320247	\N	e9246a45-21e4-413e-9fb2-48adbd2d8524	15	857	d680641c-abc8-45bc-bca4-73e113c57ed0
10947	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-27 11:48:52.922-05	2016-12-27 11:48:53-05	51	3	\N	2017-10-26 17:24:07.405-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	55037370-a2e2-46b3-9d23-d4c52912c3a6	\N	857	d6d4c77d-814e-4327-92de-cf110f5eef7f
10967	CREDIT	Regional Leadership Director Meeting 	7500	USD	2016-11-30 16:20:06.733-05	2016-11-30 16:20:15.577-05	51	3	\N	2017-10-26 17:24:07.455-04	\N	\N	\N	\N	\N	\N	1	\N	7500	\N	80bb6da5-69d5-4d38-be17-063e3f9eb7ac	\N	857	dfd71279-d6e2-4f4f-bcc2-5da322661fb1
10970	DEBIT	Regional Leadership Director Meeting 	-7500	USD	2016-11-30 16:20:06.733-05	2016-11-30 16:20:15.577-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-7500	-7500	\N	f994f617-fc85-43f8-9cfe-4ec86550cf79	269	857	dfd71279-d6e2-4f4f-bcc2-5da322661fb1
10886	DEBIT	Network Development	-20000	USD	2016-10-11 16:03:19.884-04	2016-10-11 16:03:20.084-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-20000	-20000	\N	43783b8f-ed96-4913-a7b5-92738a1836c6	271	857	ecd8394f-1881-4928-bd39-87d67b2ec31b
10990	CREDIT	Network Development	19550	USD	2016-10-12 00:30:34.678-04	2016-10-12 00:30:34.772-04	51	3	\N	2017-10-26 17:24:07.525-04	\N	\N	\N	\N	\N	\N	1	\N	19550	\N	914e9150-2229-4200-8e8d-07da2e48f1c8	\N	857	ed046c5d-614b-433e-a6af-c7f05210589d
11000	DEBIT	Network Development	-19550	USD	2016-10-12 00:30:34.678-04	2016-10-12 00:30:34.772-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-19550	-19550	\N	412a6cfa-7598-4da8-8927-d1c29a3ef6af	295	857	ed046c5d-614b-433e-a6af-c7f05210589d
10901	CREDIT	Dalia donated to WWCode SF	1500	USD	2016-06-09 14:40:21.124-04	2016-06-09 14:40:21.833-04	51	3	\N	2017-10-26 17:24:07.593-04	\N	\N	\N	\N	\N	\N	1	\N	1500	\N	ec291e03-b267-4267-bf9b-7bbeafd6e03e	\N	857	ff085df0-ef20-41f4-867c-cafb8b177680
11026	DEBIT	Recurring subscription	-53	USD	2016-12-09 13:29:17.341-05	2016-12-09 13:29:17.341-05	819	8	385	\N	\N	320	5	\N	32	USD	1	-53	-100	\N	d4d30a54-9a50-4fd8-a308-70665fe41cbf	3	857	d38234bb-183f-422a-a9f6-eb2dbc0f9f3a
11029	DEBIT	monthly recurring subscription	-798	USD	2017-02-01 18:34:44.326-05	2017-02-01 18:34:44.326-05	803	686	461	\N	\N	386	50	\N	52	USD	1	-798	-1000	\N	a3a44772-a4c7-4b9d-a0e9-a49f7fcb9771	2	857	df2fb1b7-2272-433a-9946-4e775983b2d8
11036	CREDIT	Food for March Boulder, CO event	14000	USD	2016-03-17 14:48:54.413-04	2016-06-14 14:14:21.77-04	755	68	26	\N	\N	\N	\N	\N	\N	\N	1	14000	14000	46	32f7b85d-556a-4a98-9677-0ad27bf5b508	15	857	02e5484e-8cfe-49bb-a2c0-0c379a99b7ff
11039	DEBIT	Donation to WWCode Washington DC	-82070	USD	2016-06-06 20:53:47.603-04	2016-06-06 20:53:47.649-04	742	555	381	\N	\N	316	5000	\N	2930	USD	1	-82070	-100000	\N	c9220a30-4136-4226-9ddc-0a730f0b2118	13	857	ccafa374-636a-4d89-947c-80d3aa144d8b
11047	DEBIT	\N	-41370	USD	2016-09-13 00:15:04.709-04	2016-09-13 00:15:04.709-04	788	1178	737	\N	\N	653	2500	\N	1130	USD	1	-41370	-50000	\N	f2a26a3f-2d49-4275-a62e-047997dadf40	2	857	14520f65-7d04-4c5b-9871-a80d926a084f
11050	DEBIT	\N	-4938	USD	2017-03-09 13:29:55.496-05	2017-03-09 13:29:55.496-05	754	3442	2104	\N	\N	2003	300	\N	162	USD	1	-4938	-6000	\N	428ccdf9-8f72-47ce-b181-a65aff9ba11c	259	857	370ac97d-52ac-447b-93a0-02fafe0dc7e0
11031	DEBIT	Recurring subscription	-798	USD	2016-11-01 19:32:30.439-04	2016-11-01 19:32:30.439-04	803	686	461	\N	\N	386	50	\N	52	USD	1	-798	-1000	\N	dde95b7f-9b41-4107-ae5c-ecab0c92e423	2	857	aa18b42d-50dd-40ba-b141-18c55703a7b6
11037	CREDIT	Order for stickers of our official WWC Boulder/Denver chapter logo	7800	USD	2016-03-17 23:23:34.628-04	2016-06-14 14:14:21.77-04	755	68	\N	2016-06-14 14:14:22.448-04	\N	\N	\N	\N	\N	\N	1	7800	7800	48	57a394f9-5962-40b5-8d8e-6dd64758de58	15	857	dbbc8496-878d-4f4a-9202-421f001c34fe
11040	DEBIT	\N	-10320	USD	2016-10-06 14:36:38.382-04	2016-10-06 14:36:38.382-04	713	1438	880	\N	\N	808	625	\N	305	USD	1	-10320	-12500	\N	1dd2a93e-d2e3-43c2-aea0-91c1c0595f44	2	857	984e9bf9-7abf-4e2a-9f2a-31c0719a7e10
11045	DEBIT	monthly recurring subscription	-53	USD	2017-03-09 13:29:18.778-05	2017-03-09 13:29:18.778-05	819	8	385	\N	\N	320	5	\N	32	USD	1	-53	-100	\N	5af1cc4f-e037-46f0-ae1e-f345da97ce03	3	857	754cb919-f95b-4b2f-911a-eeebfc8f4f8c
11048	DEBIT	Donation to WWCode San Francisco	-53	USD	2016-06-21 12:05:01.251-04	2016-06-21 12:05:01.296-04	775	642	431	\N	\N	360	5	\N	32	USD	1	-53	-100	\N	d60283ea-2de4-4d8b-b3c7-6dd5382077a6	4	857	53f20902-609c-470d-a9bd-ae1c424341e8
10940	DEBIT	Donation via meetup - fees and global development	-775	USD	2016-12-13 15:20:15.375-05	2016-12-13 15:20:15.714-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-775	-775	\N	1e59e6bb-440c-4df6-97d4-f04a8404b34d	13	857	0514135f-eb0f-4337-8233-21f5435796e9
10957	CREDIT	Regional Leadership Director Meeting 	7500	USD	2016-11-30 16:20:12.669-05	2016-11-30 16:20:16.148-05	51	3	\N	2017-10-26 17:24:06.35-04	\N	\N	\N	\N	\N	\N	1	\N	7500	\N	8596f8cb-2af3-4687-8df4-206362ba31af	\N	857	141d1111-2b08-4877-a0b8-1936b3723742
11009	CREDIT	Diana A. Scholarship Google I/O	25000	USD	2016-10-04 18:19:06.989-04	2016-10-04 18:19:07.108-04	51	3	\N	2017-10-26 17:24:06.378-04	\N	\N	\N	\N	\N	\N	1	\N	25000	\N	152d0e68-b83a-487c-9d36-fd43f3001ae6	\N	857	1c5a4959-9738-465d-b5db-6e190149d67e
10861	CREDIT	Donation: Beth Laing	5000	USD	2016-10-04 11:47:24.058-04	2016-10-04 11:47:24.175-04	51	3	\N	2017-10-26 17:24:06.406-04	\N	\N	\N	\N	\N	\N	1	\N	5000	\N	d05954fc-1459-4ebe-8a46-dcee5fe94a97	\N	857	257a68f1-29cf-4bf3-83fa-472534c45b8b
10982	DEBIT	Banner	-2000	USD	2016-11-30 13:40:32.021-05	2016-11-30 13:40:32.139-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-2000	-2000	\N	4710edbe-9842-43f5-b9de-4dd415af6cb6	292	857	313fa8d0-9222-47a3-8ed5-dc427c1e61ca
10989	CREDIT	Network Development (Thanks Atlassian) 	20000	USD	2016-10-12 01:06:05.058-04	2016-10-12 01:06:05.202-04	51	3	\N	2017-10-26 17:24:06.603-04	\N	\N	\N	\N	\N	\N	1	\N	20000	\N	49501619-3769-4d2a-b05b-ed5fcdd9b8f3	\N	857	3c7f99a7-a1a0-426f-9f02-00903bbd5471
10913	DEBIT	Leslie Mollner: Thank you very much for all the help I've received from WWCode -TC so far. -Leslie	-2250	USD	2016-04-06 14:17:07.204-04	2016-04-16 16:40:58.818-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-2250	-2250	\N	f9d9c4c5-24e6-4f53-a84d-54fc5be9a2dd	48	857	47c77ff3-fdbc-4006-b3a3-426b2a8320b5
10994	CREDIT	Network Development (100%)	10000	USD	2016-10-07 16:05:13.011-04	2016-10-07 16:05:13.112-04	51	3	\N	2017-10-26 17:24:06.685-04	\N	\N	\N	\N	\N	\N	1	\N	10000	\N	1e83e25e-8b16-431d-9bcf-f96f86f34c5f	\N	857	4c714c66-eb6d-4a0b-ae54-a487f74d93ec
11002	DEBIT	Network Development (100%)	-10000	USD	2016-10-07 16:05:13.011-04	2016-10-07 16:05:13.112-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-10000	-10000	\N	6b057b69-bfd3-492a-af91-a31865c96f72	300	857	4c714c66-eb6d-4a0b-ae54-a487f74d93ec
10928	CREDIT	Global Development for Meetup Fee	6000	CAD	2016-12-28 11:29:31.983-05	2016-12-28 11:29:28.409-05	51	3	\N	2017-10-26 17:24:06.756-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	79b8df75-9a82-4a8e-948d-cf62344da7dc	\N	857	57ffa29b-490a-41c0-b85e-4e7f6b63e31e
10935	DEBIT	Global Development for Meetup Fee	-6000	CAD	2016-12-28 11:29:31.983-05	2016-12-28 11:29:28.409-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	0ea4516f-0576-4c42-8433-b093ca6c1b67	293	857	57ffa29b-490a-41c0-b85e-4e7f6b63e31e
10918	CREDIT	WWCode Boston t-shirt sales	1964	USD	2017-01-17 22:19:47.816-05	2017-01-17 22:19:48.024-05	51	3	\N	2017-10-26 17:24:06.845-04	\N	\N	\N	\N	\N	\N	1	\N	1964	\N	f56ea17d-7761-4576-b24e-f1c47037b4c7	\N	857	681a14e4-aa04-4302-b7df-9efc4f702ac2
10895	CREDIT	Donation from Biotti	403	USD	2016-10-11 15:32:58.956-04	2016-10-11 15:32:59.265-04	51	3	\N	2017-10-26 17:24:06.859-04	\N	\N	\N	\N	\N	\N	1	\N	403	\N	a70a7b6d-a068-48e1-aef2-5f8c2efecde7	\N	857	6983ddef-3936-41f4-b56f-116dc4f41165
10904	DEBIT	Donation from Biotti	-403	USD	2016-10-11 15:32:58.956-04	2016-10-11 15:32:59.265-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-403	-403	\N	36e3e507-0c22-4c40-acc1-79cb1521045d	301	857	6983ddef-3936-41f4-b56f-116dc4f41165
10900	CREDIT	From Lucas in honor of Rachel M. She learned Python and HTML/CSS	2250	USD	2016-10-11 15:13:57.013-04	2016-10-11 15:13:57.265-04	51	3	\N	2017-10-26 17:24:06.885-04	\N	\N	\N	\N	\N	\N	1	\N	2250	\N	89c12a2b-0f69-4b2c-9133-90af9d1ffd5e	\N	857	6bb0b7ea-1a01-409a-8639-d3cd00c0a49b
10907	DEBIT	From Lucas in honor of Rachel M. She learned Python and HTML/CSS	-2250	USD	2016-10-11 15:13:57.013-04	2016-10-11 15:13:57.265-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-2250	-2250	\N	6aae9a8e-9e5f-4b1f-a435-569784588fa7	279	857	6bb0b7ea-1a01-409a-8639-d3cd00c0a49b
10864	DEBIT	Reverse duplicate transaction	-500	USD	2016-10-04 12:12:26.671-04	2016-10-04 12:12:26.903-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-500	-500	\N	70688111-0542-4083-bf83-5a56f52460a2	12	857	6da26700-e573-4cd3-825d-8540d9e4a5a9
10960	DEBIT	Global Development for Meetup Fee	-6000	USD	2016-12-23 12:31:16.26-05	2016-12-23 12:31:16.392-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	9278e815-1e95-4222-a828-461204fd71ed	195	857	8d928bbe-5b2e-4324-9219-3fd51d8c562e
11024	DEBIT	Turner Matching Donation	-5000	USD	2016-10-04 11:46:59.013-04	2016-10-04 11:46:59.134-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-5000	-5000	\N	162fecc2-48b0-4b08-a800-e8bb117f829a	12	857	a3bb1b9b-64ed-4520-bedf-2c0d26e816ae
11061	DEBIT	Network Development	-10000	USD	2016-10-04 17:44:54.4-04	2016-10-04 17:44:54.58-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-10000	-10000	\N	196be242-41ae-4521-84ba-d0e8a77db380	2	857	a6e1d16a-6c88-4ffe-9d4c-bf6333af7c87
11013	CREDIT	Donation via meetup	2363	USD	2016-10-04 18:14:59.695-04	2016-10-04 18:14:59.884-04	51	3	\N	2017-10-26 17:24:07.155-04	\N	\N	\N	\N	\N	\N	1	\N	2363	\N	e590d3c4-b9ec-48fd-8849-657b6b32c9f9	\N	857	a712ec2d-d9ac-444f-9b13-146350772d87
11022	DEBIT	Donation via meetup	-2363	USD	2016-10-04 18:14:59.695-04	2016-10-04 18:14:59.884-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-2363	-2363	\N	369c12c3-21cb-4151-8857-f12912e5eeb3	272	857	a712ec2d-d9ac-444f-9b13-146350772d87
10972	CREDIT	Network Development	20000	USD	2016-11-30 15:59:29.087-05	2016-11-30 15:59:29.921-05	51	3	\N	2017-10-26 17:24:07.166-04	\N	\N	\N	\N	\N	\N	1	\N	20000	\N	9c79bc92-818a-434a-aa81-2c74f5977e0b	\N	857	a81f1687-1851-4337-8a08-ed10811d3c4d
11018	DEBIT	I am an active member and WWC has taken my career in tech to the next level. All the support and lessons from the WWC DC chapter are instrumental in me remaining in this field.	-2250	USD	2016-10-06 13:23:39.409-04	2016-10-06 13:23:39.459-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-2250	-2250	\N	fd49f50d-99e2-4c34-a779-4e896364e426	13	857	c3c539d8-b0c5-4511-a89b-0529f94161ac
10889	DEBIT	Network support - Regional Leadership (thanks VMWare)	-370000	USD	2016-10-11 15:51:45.723-04	2016-10-11 15:51:45.897-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-370000	-370000	\N	590fcecf-fee2-4f28-9af7-f8472e1dafca	262	857	c537c49b-cae3-4697-8bc7-4ebec29b7159
11005	DEBIT	Network Development	-19100	USD	2016-10-11 20:28:02.718-04	2016-10-11 20:28:03.121-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-19100	-19100	\N	641a8005-b3ae-4738-87a7-d9b97c3a4421	284	857	cc3cc99f-569a-4615-9a68-f26b3975edde
10968	CREDIT	Banner	2000	USD	2016-11-30 16:19:37.017-05	2016-11-30 16:19:37.251-05	51	3	\N	2017-10-26 17:24:07.349-04	\N	\N	\N	\N	\N	\N	1	\N	2000	\N	65b7bc43-246f-4095-9e42-d32fb57f192a	\N	857	cf0b9a0f-a4d7-40b9-b2bc-2fcf2d45ede6
10977	DEBIT	Banner	-2000	USD	2016-11-30 16:19:37.017-05	2016-11-30 16:19:37.251-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-2000	-2000	\N	df805148-2720-46ac-9d7a-681bb84796d6	269	857	cf0b9a0f-a4d7-40b9-b2bc-2fcf2d45ede6
10951	DEBIT	Global Development for Meetup Fee	-6000	USD	2016-12-27 11:48:52.922-05	2016-12-27 11:48:53-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	14e7e3a1-5aec-44d6-a4ad-9a56ea51256b	273	857	d6d4c77d-814e-4327-92de-cf110f5eef7f
10998	CREDIT	Hackathon Support Open Gov	45000	USD	2016-10-07 10:41:08.315-04	2016-10-07 10:41:08.391-04	51	3	\N	2017-10-26 17:24:07.417-04	\N	\N	\N	\N	\N	\N	1	\N	45000	\N	5a4e7ae2-a5c3-458e-a11e-2daf2306d2f1	\N	857	d9caf112-a17a-4b8c-8451-9d136d5485ea
10885	DEBIT	Network Development (Thanks Zendesk)	-16129	USD	2016-10-11 16:26:22.964-04	2016-10-11 16:26:23.172-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-16129	-16129	\N	82084626-191b-4f4b-aebc-93b215718b9d	298	857	e39807df-d9f3-4367-8c7e-54dd91d52764
10879	CREDIT	Network Development	20000	USD	2016-10-11 16:03:19.884-04	2016-10-11 16:03:20.084-04	51	3	\N	2017-10-26 17:24:07.52-04	\N	\N	\N	\N	\N	\N	1	\N	20000	\N	6f37914a-9e68-4dfa-ae48-87e35aa190fa	\N	857	ecd8394f-1881-4928-bd39-87d67b2ec31b
10883	CREDIT	Network Development	15400	USD	2016-10-04 18:39:26.796-04	2016-10-04 18:39:26.9-04	51	3	\N	2017-10-26 17:24:07.557-04	\N	\N	\N	\N	\N	\N	1	\N	15400	\N	d549ad10-706b-4e72-9518-b6c643e56592	\N	857	f89d9896-22af-4257-bd3d-f546c22c96ed
11133	CREDIT	WWCode CONNECT Conference Travel Stipend	88760	GBP	2017-04-17 17:18:35.523-04	2017-04-17 17:18:35.581-04	830	1333	2602	\N	\N	\N	\N	\N	3760	GBP	1	88760	85000	1016	329f3215-6be8-4af7-a0e4-8475f2bcc298	278	857	93180ed7-bd45-4b39-b3b6-92284608466d
11135	CREDIT	Printing WWCODE pamphlets for Camas STEM Fair for middle-school girls (organized by OHSU).	4431	USD	2017-02-07 13:40:27.475-05	2017-02-07 13:40:27.96-05	827	171	1718	\N	\N	\N	\N	\N	\N	\N	1	4431	4431	736	9e15ba8d-e29e-4328-a718-9c6ea8604c4a	59	857	755f24ee-a9c8-47a0-b760-731fd98e5de6
11152	CREDIT	Monthly Minimum Fee - May	1000	USD	2016-08-16 10:51:38.913-04	2016-08-16 10:51:38.924-04	51	3	573	\N	\N	\N	\N	\N	\N	\N	1	1000	1000	\N	9d54bb68-cf25-4c1b-8e26-7fbf3c7fd290	12	857	9ae47817-4af0-4bff-81bf-f63352e4d3ad
11158	CREDIT	CONFERENCE GRANT	34750	USD	2016-05-26 15:05:53.771-04	2016-06-14 14:14:22.123-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	34750	34750	197	6e585015-1324-48f2-a3eb-acdfd12dfad3	59	857	2a288453-95f3-4348-9861-137f4573e26d
11162	CREDIT	Meetup Fees	6000	AUD	2016-12-28 10:56:28.934-05	2016-12-28 10:56:28.934-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	661	8de0c33d-a910-4c53-9f57-4c240b33dc9e	297	857	0f747c75-347c-400b-bcaf-55ae7cd03533
11168	CREDIT	Meetup Fees	6000	MXN	2016-12-27 13:01:07.417-05	2016-12-27 13:01:07.417-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	651	2352a090-ace2-4815-baf7-b67d1be00989	10	857	9e015a93-b01d-4472-bd71-440de9af554d
11173	CREDIT	Meetup Fees	6000	USD	2016-12-27 11:23:35.936-05	2016-12-27 11:23:35.936-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	634	6873aa92-9a78-4972-8bdc-55935a9e59f3	13	857	3d8fa24d-a09f-46fb-aa93-9e3628fdcdb1
11174	CREDIT	Meetup Fees	6000	USD	2016-12-27 11:16:27.082-05	2016-12-27 11:16:27.082-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	633	89fbf3f6-e236-49f9-80d9-60fa4b04fdc7	271	857	3b983cb7-31dc-4ae9-8dd3-740f17c024a5
11181	CREDIT	To redeem travel stipend to Google I/O	104430	USD	2017-03-20 11:39:23.328-04	2017-03-20 11:39:23.364-04	831	1332	2180	\N	\N	\N	\N	\N	4430	USD	1	104430	100000	924	9a131244-042d-4948-88a9-4579ac718337	277	857	56f672dc-9159-46bc-9876-bb43beaf966d
11183	CREDIT	IWD event -- wine for event	10044	USD	2017-03-14 13:22:31.446-04	2017-03-14 13:22:31.46-04	762	70	1893	\N	\N	\N	\N	\N	312	USD	1	10044	9732	900	fcdcb761-b66c-41d0-a361-72b94ce689be	12	857	1d123935-e4b4-4795-a005-15e934a0025e
11191	CREDIT	Meetup Fees	6000	USD	2016-12-23 11:52:20.827-05	2016-12-23 11:52:20.827-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	615	15427a43-3c99-4946-b62f-d008d0f24b03	12	857	856deecb-926c-47d7-a62a-ac006a8d52e5
11200	CREDIT	WWC T-shirt	2798	USD	2016-12-06 11:59:36.33-05	2016-12-06 11:59:36.741-05	51	3	1191	\N	\N	\N	\N	\N	\N	\N	1	2798	2798	\N	4c84017c-36c9-4157-8fc9-4fac1398a7af	59	857	e964ad85-4eca-47b2-963f-e5dd07fc4040
11209	CREDIT	Conference Grant	50000	USD	2016-05-04 17:14:39.136-04	2016-06-14 14:14:22.01-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	50000	50000	145	4f7241e1-dcac-4929-ae1f-7b53afbc42f0	13	857	05b61729-878a-4189-982b-90f9fc2e5870
11217	CREDIT	Network budget pre Open Collective	230712	USD	2016-10-07 16:01:03.429-04	2016-10-07 16:01:03.535-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	230712	230712	\N	6a906d3e-f96b-4654-8dda-31b918d5fb74	300	857	d41925c9-e76f-40ca-97f6-2bd571ca387a
11221	CREDIT	Director t-shirt	2860	USD	2016-10-17 16:56:00.744-04	2016-10-17 16:56:00.777-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	2860	2860	\N	e6e33708-c9b6-4afd-bbbd-340011be173d	12	857	2e753a9a-c31d-4289-8f72-fd9e80f29c6a
11227	CREDIT	Mar 7 Lightning Talks	15316	USD	2016-03-20 14:06:09.887-04	2016-06-14 14:14:21.794-04	847	28	\N	2016-06-14 14:14:22.455-04	\N	\N	\N	\N	\N	\N	1	15316	15316	57	e787e3b7-d0c1-4d89-bed5-120eda720082	2	857	012b450f-522e-4860-833a-561a6209db5d
11237	CREDIT	travel to NY for bell ringing at NYSE	30000	USD	2017-01-25 13:20:51.642-05	2017-01-25 13:20:54.592-05	762	70	1476	\N	\N	\N	\N	\N	\N	\N	1	30000	30000	743	8ff400c8-6f0e-4054-a5cf-743df262cd88	12	857	545bf85d-8ef2-4c2b-b655-190eb0b68656
11240	CREDIT	90/10 split: Hackathon donation	32000	USD	2016-10-04 18:05:22.85-04	2016-10-04 18:05:22.85-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	32000	32000	395	43405410-ba72-4bcb-9fdf-c86fa35db780	15	857	a3f4123c-85e4-4819-8c70-38b371d9d4a6
3952	DEBIT	Speaker and sponsor meetings (11/18 + 11/28) and event logistics (12/2)	-2870	USD	2016-12-13 13:44:23.973-05	2016-12-13 13:44:24.945-05	59	3	1191	\N	\N	\N	\N	\N	\N	\N	\N	\N	-2870	\N	2a19b928-ba82-4a49-a329-5c79e51b48e3	51	857	ed14302e-7d93-41df-85f9-8877fe8bb183
11083	DEBIT	$500 OpenGov hackathon support - transaction and global development	-43500	USD	2016-11-17 13:36:48.896-05	2016-11-17 13:36:49.046-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-43500	-43500	\N	8182739d-90e0-45cb-b8fc-9eee7fb58558	59	857	037e8a19-cadd-4281-9061-a544689d4c51
11075	DEBIT	Women Who Code Atlanta &amp; DevNexus Soirée - fees + global	-10875	USD	2017-03-13 13:05:28.744-04	2017-03-13 13:05:31.582-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-10875	-10875	\N	e2a01da3-5f58-4d6b-9b25-d35c8304cb85	12	857	171271be-3b4f-40b2-be9b-6184c8e4bacc
11121	CREDIT	Donation Pamela V.	4500	USD	2016-10-06 14:09:54.319-04	2016-10-06 14:09:54.357-04	51	3	\N	2017-10-26 17:24:06.456-04	\N	\N	\N	\N	\N	\N	1	\N	4500	\N	275a87ec-9d06-45b2-b787-ac4f3b29aad3	\N	857	2929d44f-d745-4707-8d7b-18fe80e8102b
11128	DEBIT	Donation Pamela V.	-4500	USD	2016-10-06 14:09:54.319-04	2016-10-06 14:09:54.357-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-4500	-4500	\N	520e83b7-3452-4296-b515-5da56c4c8d10	13	857	2929d44f-d745-4707-8d7b-18fe80e8102b
11052	CREDIT	Mary Griffus	1000	USD	2016-04-27 00:41:38.126-04	2016-04-27 00:41:38.474-04	51	3	\N	2017-10-26 17:24:06.483-04	\N	\N	\N	\N	\N	\N	1	\N	1000	\N	8c650a45-efa3-4df4-bcdf-763a1226b17e	\N	857	2d5543ba-ae0a-4112-ad41-f78ccb400118
11057	DEBIT	Mary Griffus	-1000	USD	2016-04-27 00:41:38.126-04	2016-04-27 00:41:38.474-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-1000	-1000	\N	12c12597-0465-4ab7-b24f-61cfa0b1dfbe	13	857	2d5543ba-ae0a-4112-ad41-f78ccb400118
11081	CREDIT	Director t-shirt	2860	USD	2016-10-17 16:55:47.647-04	2016-10-17 16:55:47.671-04	51	3	\N	2017-10-26 17:24:06.826-04	\N	\N	\N	\N	\N	\N	1	\N	2860	\N	70acdc55-4c1d-47a3-aba4-6d27409c74a4	\N	857	648274c2-0e47-41a9-bf23-b6d19f6a1d39
11088	DEBIT	Director t-shirt	-2860	USD	2016-10-17 16:55:47.647-04	2016-10-17 16:55:47.671-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-2860	-2860	\N	f611de48-0736-4c79-a88d-409dd3049a3a	12	857	648274c2-0e47-41a9-bf23-b6d19f6a1d39
11105	CREDIT	Network Development: Three Year Bonus:)	50000	USD	2016-10-04 17:52:32.839-04	2016-10-04 17:52:32.962-04	51	3	\N	2017-10-26 17:24:06.831-04	\N	\N	\N	\N	\N	\N	1	\N	50000	\N	7f129b67-f40c-46eb-b49f-0719075cc42f	\N	857	65120030-5816-46e4-8b20-40523e7abd4b
11093	CREDIT	\N	2175	USD	2017-05-03 20:12:19.814-04	2017-05-03 20:12:19.814-04	51	3	\N	2017-10-26 17:24:06.961-04	\N	2702	\N	\N	\N	USD	1	2175	2175	\N	012e6a62-95ee-4a3b-8b1c-9200b3723db2	\N	857	7b35bce9-7183-4ae9-8caf-7f4f76add0a6
11062	DEBIT	Women Techmaker/WWCode Partnership Grant	-50000	USD	2016-05-16 16:01:14.238-04	2016-05-16 16:01:14.49-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-50000	-50000	\N	e7d178c2-403d-4e27-8ac4-cceb2610e525	10	857	8a82c2a5-02f0-42dd-96cd-ad71dddc6206
11143	CREDIT	Women Techmaker WWCode Partnership Grant	120000	USD	2016-05-19 15:10:52.797-04	2016-05-19 15:10:54.053-04	51	3	\N	2017-10-26 17:24:07.198-04	\N	\N	\N	\N	\N	\N	1	\N	120000	\N	e1c6404e-9fa2-4d59-8882-2efb2389ac5e	\N	857	b2fc5245-44e4-4bee-9338-1c12e18cb526
11147	DEBIT	Women Techmaker WWCode Partnership Grant	-120000	USD	2016-05-19 15:10:52.797-04	2016-05-19 15:10:54.053-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-120000	-120000	\N	846da0cd-b128-47a9-8871-ed10627335e8	12	857	b2fc5245-44e4-4bee-9338-1c12e18cb526
11100	DEBIT	Donations via Meetup	-3937	USD	2016-10-06 14:41:35.464-04	2016-10-06 14:41:35.487-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-3937	-3937	\N	e208750d-450d-4212-9724-1ada0ba61c87	13	857	b57fb235-1376-480e-b3d2-76de4b7aa01e
11067	DEBIT	Travel Stipend for CONNECT	0	USD	2017-04-03 16:24:58.616-04	2017-04-03 16:24:58.879-04	857	3	\N	2017-04-02 20:00:00-04	\N	\N	\N	\N	\N	\N	1	0	-50000	\N	9c7d40f1-fa86-4b42-b612-f020f1a31a6c	511	857	b5a5562c-e980-4f58-a2aa-4a9edaec0d91
11112	CREDIT	Blurb donation	54000	USD	2016-10-06 12:06:35.799-04	2016-10-06 12:06:36.235-04	51	3	\N	2017-10-26 17:24:07.229-04	\N	\N	\N	\N	\N	\N	1	\N	54000	\N	b80913b1-11ab-4aa7-8c4a-06988840be1f	\N	857	b77a784c-4cdd-4fe6-a8d0-1ca760a759e5
11117	DEBIT	Blurb donation	-54000	USD	2016-10-06 12:06:35.799-04	2016-10-06 12:06:36.235-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-54000	-54000	\N	376b1093-1cd6-4847-8d3f-8ebecb67e9b0	3	857	b77a784c-4cdd-4fe6-a8d0-1ca760a759e5
11097	DEBIT	Network Development +	-50000	USD	2016-10-07 16:24:13.595-04	2016-10-07 16:24:13.706-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-50000	-50000	\N	42b8858f-fb57-43eb-b843-cc659a1091dd	300	857	c7be7e35-692f-4f6d-9650-36e89035e8db
11079	CREDIT	Director t-shirt	3186	USD	2016-10-17 16:58:21.952-04	2016-10-17 16:58:22.083-04	51	3	\N	2017-10-26 17:24:07.314-04	\N	\N	\N	\N	\N	\N	1	\N	3186	\N	3e93bd72-74e2-40f6-9f1e-1830e93fb3e9	\N	857	c9bc4c3a-762e-49b3-8326-97cdd2fe8488
11087	DEBIT	Director t-shirt	-3186	USD	2016-10-17 16:58:21.952-04	2016-10-17 16:58:22.083-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-3186	-3186	\N	3c6583d8-0c04-4c69-8522-f0401b94c7d2	271	857	c9bc4c3a-762e-49b3-8326-97cdd2fe8488
11073	CREDIT	from Code2040	90000	USD	2016-10-17 11:43:12.71-04	2016-10-17 11:43:13.113-04	51	3	\N	2017-10-26 17:24:07.386-04	\N	\N	\N	\N	\N	\N	1	\N	90000	\N	5a67347d-5b8d-458a-b5b8-038bb9bea048	\N	857	d5659c85-3aab-4882-b441-83b1501a0684
11064	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-23 12:08:24.515-05	2016-12-23 12:08:24.709-05	51	3	\N	2017-10-26 17:24:07.396-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	ff198661-39bd-4474-9ef4-a98b8aa46613	\N	857	d686bddc-81cb-49d3-aa28-3c7e9e506008
11070	DEBIT	Global Development for Meetup Fee	-6000	USD	2016-12-23 12:08:24.515-05	2016-12-23 12:08:24.709-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	1a7fa68c-0c00-4eb0-ac7a-6dc8afe83113	265	857	d686bddc-81cb-49d3-aa28-3c7e9e506008
11063	DEBIT	WOMEN TECHMAKER/WWCODE PARTNERSHIP GRANT	-110000	USD	2016-05-10 17:15:06.327-04	2016-05-10 17:15:06.677-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-110000	-110000	\N	0e4bde21-aa36-4f78-80d1-f500d1174886	48	857	ecc6e049-64c8-4956-bc89-a16bc562d9a7
11084	CREDIT	WWCode Director t-shirt	3649	USD	2016-10-17 16:50:42.245-04	2016-10-17 16:50:42.273-04	51	3	\N	2017-10-26 17:24:07.542-04	\N	\N	\N	\N	\N	\N	1	\N	3649	\N	0cba0aff-6fa9-4501-9c21-f67656182e01	\N	857	f46aee3c-d1ec-4f2b-845b-e3dab0a809da
11090	DEBIT	WWCode Director t-shirt	-3649	USD	2016-10-17 16:50:42.245-04	2016-10-17 16:50:42.273-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-3649	-3649	\N	444b499d-1c4e-4ed3-9ba3-875d1b3bef44	47	857	f46aee3c-d1ec-4f2b-845b-e3dab0a809da
11107	DEBIT	\N	-15000	USD	2017-05-03 13:44:48.715-04	2017-05-03 13:44:48.715-04	857	3	\N	\N	\N	2697	0	\N	0	USD	1	-15000	-15000	\N	c659d061-b042-40c1-92e5-138ba12c7277	51	857	f84648db-6077-401e-8a71-5f57b1c44914
11138	CREDIT	Event supplies	1601	USD	2017-04-11 15:13:28.544-04	2017-04-11 15:13:28.599-04	827	171	2321	\N	\N	\N	\N	\N	74	USD	1	1601	1527	1002	d774fadd-c840-4ef8-bd97-9dc22ce2de33	59	857	7a87706f-dd13-4adc-81c4-9a9cf4706904
11145	CREDIT	Reimburse Caterina for travel expenses to CONNECT 2016	6500	USD	2016-04-05 15:44:01.338-04	2016-06-14 14:14:21.839-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6500	6500	75	b8e1b153-63a7-46c7-a3dd-7d2b5d5205a7	59	857	cf9e0de6-f616-4092-be87-a15946f63158
11149	CREDIT	Conference Grant	120000	USD	2016-05-19 15:07:13.723-04	2016-06-14 14:14:22.074-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	120000	120000	175	8e630837-9e34-46f3-8bdf-8f64962f957e	12	857	449279b8-4af1-43d5-bebf-692a8212d2c9
11155	CREDIT	Network Development: Attend CapOne WIT 2017 Kickoff to announce partnership for re-launch	100000	USD	2017-04-17 18:12:22.995-04	2017-04-17 18:12:22.995-04	51	3	\N	\N	\N	\N	\N	\N	0	USD	1	100000	100000	1027	c95c4751-73be-4eff-9633-17fc3989261e	270	857	1671e106-4c66-43f9-ac71-3d7eaa57594a
11160	CREDIT	Reimbursement to Kamila for coffee purchased for volunteers at CONNECT 2016	11815	USD	2016-04-05 15:44:01.338-04	2016-06-14 14:14:21.839-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	11815	11815	74	f1abead1-bd15-4fae-aa66-59cadfea389c	14	857	f1687580-7a4c-46de-b692-6aebb636eb45
11165	CREDIT	Meetup Fees	6000	USD	2016-12-28 10:44:44.222-05	2016-12-28 10:44:44.222-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	658	ff5f6edd-d50d-49d3-a06d-b1e2b493d8d8	4	857	8ab5f270-de91-4e44-88c1-b4672d5b2995
11169	CREDIT	Meetup Fees	6000	MXN	2016-12-27 12:57:54.314-05	2016-12-27 12:57:54.314-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	650	6c08389e-eaa4-41f2-9637-9dec33239e84	282	857	28ad78a3-733b-4961-9fb6-b78c083a5344
11176	CREDIT	Mar 7 Lightning Talks	15790	USD	2017-03-14 13:21:29.296-04	2017-03-14 13:21:29.332-04	847	28	1893	\N	\N	\N	\N	\N	474	USD	1	15790	15316	57	53230c8f-09dc-4ab1-bee5-4fef6a37fec7	2	857	70e63c77-42ab-4f4c-9fe8-d4878835a0ad
11180	CREDIT	Stickers	15084	USD	2017-04-07 08:58:45.517-04	2017-04-07 08:58:45.531-04	841	3419	2321	\N	\N	\N	\N	\N	454	USD	1	15084	14630	889	f9d39846-0406-42a2-a541-bbaf9d356ff3	516	857	f8a8570a-a5d0-4d6d-80f9-b2617940d49b
11186	CREDIT	Meetup Fees	6000	USD	2016-12-28 10:58:50.078-05	2016-12-28 10:58:50.078-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	662	87f281d9-ee7d-4d32-9f11-7ac1798565b5	241	857	cea24456-b845-4642-8a82-5a0c65e368a9
11190	CREDIT	Meetup Fees	6000	USD	2016-12-23 11:56:04.579-05	2016-12-23 11:56:04.579-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	616	61eb8199-fbb4-408c-97e2-2a89472a680c	262	857	53c94a51-7764-4de5-9f32-56b2c038fcc9
11193	CREDIT	Meetup Fees	6000	USD	2016-12-23 11:49:17.444-05	2016-12-23 11:49:17.444-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	614	9a332e58-08fd-4790-a421-d501fea7f59e	261	857	a70ea427-51e3-4663-87b1-90bb208a3aab
11194	CREDIT	Meetup Fees	6000	USD	2016-12-21 13:54:30.839-05	2016-12-21 13:54:30.839-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	608	b716f3a4-3e32-4ad9-8329-71989a317eaf	3	857	72853007-a44c-4b65-b218-2596d3fd5637
11202	CREDIT	WWCode Seattle network retreat	6207	USD	2016-12-06 11:57:26.568-05	2016-12-06 11:57:26.935-05	51	3	1191	\N	\N	\N	\N	\N	\N	\N	1	6207	6207	\N	040a2aa0-f46b-4bd2-b8e3-73af62ca65e0	14	857	0f06a244-54e0-49a9-946e-557f0451fb9d
11204	CREDIT	Network Budget pre Open Collective	77659	GBP	2016-10-07 10:03:00.623-04	2016-10-07 10:03:00.89-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	77659	77659	\N	473a60c7-8eda-4f46-a95e-2f48a0f5ecac	278	857	f2429458-8329-48a0-b0ea-62d32622d6ef
11207	CREDIT	Network budget pre open collective	55923	USD	2016-11-29 19:18:08.154-05	2016-11-29 19:18:07.832-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	55923	55923	\N	2a57444f-5cc9-4c54-9e1c-8c66705d7bc9	285	857	eb0a8e60-7807-4ed4-896a-c1a583c59e80
11216	CREDIT	Supplies / Gift Bags	4147	USD	2016-12-07 11:50:40.889-05	2016-12-07 11:50:41.383-05	51	3	1191	\N	\N	\N	\N	\N	\N	\N	1	4147	4147	\N	8ea19632-0608-4b2a-a06a-ee99e78339ee	59	857	408000b0-a3d3-4c78-942c-eeaccb4c34f1
11218	CREDIT	WWCode Director shirt	3649	USD	2016-10-17 16:49:16.114-04	2016-10-17 16:49:16.113-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	3649	3649	\N	d822cd38-694c-4090-9493-9702fd9055c0	282	857	65f85f90-06f6-46b7-97ab-fc93249f3f86
11225	CREDIT	Conference stipend Udisha S.	75000	USD	2016-10-06 13:21:09.865-04	2016-10-06 13:21:09.933-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	75000	75000	\N	a889c5ee-d7b7-44a4-bf21-9cd2f7699817	13	857	ce6dc00d-9809-44a9-a9b4-afeb8d420bb1
11228	CREDIT	Feb 4 hack night	10284	USD	2016-03-20 14:06:09.887-04	2016-06-14 14:14:21.784-04	847	28	26	\N	\N	\N	\N	\N	\N	\N	1	10284	10284	53	d722217c-c58c-4b6b-8e66-43f1fb783ecc	2	857	2368dca3-d778-4d59-8fff-71de58432e7b
11231	CREDIT	IVA Libretas Hackathon	166080	MXN	2016-02-16 13:58:04.663-05	2016-06-14 14:14:21.738-04	821	7	\N	2016-06-14 14:14:22.436-04	\N	\N	\N	\N	\N	\N	1	166080	166080	34	ac7ca381-9bd1-44cd-88c8-c33bff4c0d73	10	857	a4c0fd19-7f38-4c49-9b68-93148be040c7
11238	CREDIT	Meetup Fees	6000	USD	2016-12-28 11:28:15.901-05	2016-12-28 11:28:15.901-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	665	b73cac46-a837-4afa-bb63-f264db4faf53	292	857	a2625aa0-84c7-428c-913d-95534f9d12f1
11242	CREDIT	Photographer: Mike Ross	65000	USD	2016-01-05 19:00:00-05	2016-06-14 14:14:22.114-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	65000	65000	193	80034924-5df7-43b3-882e-5270425e4dbb	48	857	93ea00e2-ea18-4545-bc2d-1599058547db
11245	CREDIT	Minimum Fee - May	1000	MXN	2016-08-15 15:22:45.367-04	2016-08-15 15:22:45.38-04	51	3	573	\N	\N	\N	\N	\N	\N	\N	1	1000	1000	\N	c7bae75d-0c5e-40c9-a047-9430e5183888	10	857	cc9ebd38-5528-4419-851c-66af52975484
11255	CREDIT	Global Development	100	USD	2016-04-26 23:56:08.086-04	2016-06-14 14:14:21.897-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	100	100	101	2054f3e7-bec2-498b-b27d-b9ac725cd92e	13	857	17e064f0-1897-48dd-926a-12d01e321c63
11257	CREDIT	test 	0	USD	2016-04-06 13:39:39.954-04	2016-04-06 13:46:25.532-04	51	3	\N	2016-04-06 13:46:25.531-04	\N	\N	\N	\N	\N	\N	1	0	100	\N	cf724218-a3b8-44ed-8f39-89b5f4836109	14	857	446e928b-8ce4-4ad2-a21c-165c53540447
11260	CREDIT	Global Developement	100	USD	2016-04-17 18:19:12.094-04	2016-06-14 14:14:21.883-04	51	3	\N	2016-06-14 14:14:22.48-04	\N	\N	\N	\N	\N	\N	1	100	100	97	ca1a9535-9ef7-4af4-8ddc-6335a77efc11	13	857	9467bc07-5cbe-43fb-88e8-246ed23f6ad1
2529	DEBIT	WWCode Director shirt	-3649	USD	2016-10-17 16:49:16.114-04	2016-10-17 16:49:16.113-04	282	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-3649	\N	cf15a5bb-2cb3-41bd-8ece-7dbf2dbdda36	51	857	65f85f90-06f6-46b7-97ab-fc93249f3f86
11069	CREDIT	Women Who Code Atlanta &amp; DevNexus Soirée - fees + global	10875	USD	2017-03-13 13:05:28.744-04	2017-03-13 13:05:31.582-04	51	3	\N	2017-10-26 17:24:06.358-04	\N	\N	\N	\N	\N	\N	1	\N	10875	\N	528572db-a2d3-4bd2-aaaa-cf540e9e0d1b	\N	857	171271be-3b4f-40b2-be9b-6184c8e4bacc
11096	CREDIT	Network budget pre Open Collective 	406519	USD	2016-10-06 14:36:30.275-04	2016-10-06 14:36:30.298-04	51	3	\N	2017-10-26 17:24:06.49-04	\N	\N	\N	\N	\N	\N	1	\N	406519	\N	eb2dcff2-8707-446b-81e8-ccb97306971f	\N	857	2e9a5b2e-5e8f-4260-9974-b19c1fe06722
11103	DEBIT	Network budget pre Open Collective 	-406519	USD	2016-10-06 14:36:30.275-04	2016-10-06 14:36:30.298-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-406519	-406519	\N	05f2ae9c-2a5a-48c4-ada3-bfe726825aee	13	857	2e9a5b2e-5e8f-4260-9974-b19c1fe06722
11078	CREDIT	Director t-shirt	3325	USD	2016-10-17 17:00:51.295-04	2016-10-17 17:00:51.425-04	51	3	\N	2017-10-26 17:24:06.779-04	\N	\N	\N	\N	\N	\N	1	\N	3325	\N	c4f2bf96-4b39-4d4e-a776-0becebea7590	\N	857	5f40e924-07fc-4ce9-beac-6c3b10002037
11086	DEBIT	Director t-shirt	-3325	USD	2016-10-17 17:00:51.295-04	2016-10-17 17:00:51.425-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-3325	-3325	\N	eebfdb8b-363b-4dab-bbdc-11748cd07f48	298	857	5f40e924-07fc-4ce9-beac-6c3b10002037
11114	CREDIT	Donation received via Meetup, less fees	788	USD	2016-10-04 12:46:13.302-04	2016-10-04 12:46:13.487-04	51	3	\N	2017-10-26 17:24:06.788-04	\N	\N	\N	\N	\N	\N	1	\N	788	\N	c577fd91-d192-4df5-9af4-f72e27a74466	\N	857	6075a9a1-dc87-43de-82bb-b35074a76241
11101	DEBIT	\N	-2175	USD	2017-05-03 20:12:19.814-04	2017-05-03 20:12:19.814-04	857	3	\N	\N	\N	2702	0	\N	0	USD	1	-2175	-2175	\N	cd6340b3-f70d-46d5-8833-8ea3dc2aba94	259	857	7b35bce9-7183-4ae9-8caf-7f4f76add0a6
11104	CREDIT	\N	30000	USD	2017-05-03 13:33:13.688-04	2017-05-03 13:33:13.688-04	51	3	\N	2017-10-26 17:24:06.984-04	\N	2694	\N	\N	\N	USD	1	30000	30000	\N	426f0da5-89e2-47f3-9577-ace17c5690e8	\N	857	805ba995-a678-4a5e-872a-315caeb020ed
11110	DEBIT	\N	-30000	USD	2017-05-03 13:33:13.688-04	2017-05-03 13:33:13.688-04	857	3	\N	\N	\N	2694	0	\N	0	USD	1	-30000	-30000	\N	6848b281-c3f8-4c16-8e75-8575cbb6bc66	51	857	805ba995-a678-4a5e-872a-315caeb020ed
11059	CREDIT	\N	2175	USD	2017-05-04 12:21:53.684-04	2017-05-04 12:21:53.684-04	51	3	\N	2017-10-26 17:24:07.055-04	\N	2710	\N	\N	\N	USD	1	2175	2175	\N	d184294d-3e1f-49fb-b2a4-d4cc2d2f0a6e	\N	857	93732294-17ee-4a16-ba30-8fe00d9908b3
11066	DEBIT	\N	-2175	USD	2017-05-04 12:21:53.684-04	2017-05-04 12:21:53.684-04	857	3	\N	\N	\N	2710	0	\N	0	USD	1	-2175	-2175	\N	50625254-6e05-4188-bce9-3ddc568fb9ba	276	857	93732294-17ee-4a16-ba30-8fe00d9908b3
11053	CREDIT	Network Development	10000	USD	2016-10-04 17:44:54.4-04	2016-10-04 17:44:54.58-04	51	3	\N	2017-10-26 17:24:07.15-04	\N	\N	\N	\N	\N	\N	1	\N	10000	\N	ff34b8b1-b4d1-4956-91ae-f5a3fb449492	\N	857	a6e1d16a-6c88-4ffe-9d4c-bf6333af7c87
11113	CREDIT	Network budget balance pre Open Collective	34240	USD	2016-10-04 17:49:31.268-04	2016-10-04 17:49:31.543-04	51	3	\N	2017-10-26 17:24:07.202-04	\N	\N	\N	\N	\N	\N	1	\N	34240	\N	1a300f39-5e1b-4cf5-a7fd-4d14de938d2c	\N	857	b34aff4d-b3dc-4bf7-80e6-d25d077917d5
11094	CREDIT	Donations via Meetup	3937	USD	2016-10-06 14:41:35.464-04	2016-10-06 14:41:35.487-04	51	3	\N	2017-10-26 17:24:07.221-04	\N	\N	\N	\N	\N	\N	1	\N	3937	\N	b1ab8c08-2267-4e05-9a35-e5abb802a4d1	\N	857	b57fb235-1376-480e-b3d2-76de4b7aa01e
11129	DEBIT	Conference Grant: Google/IO Alicia Carr	-10000	USD	2016-10-04 11:25:59.981-04	2016-10-04 11:26:00.186-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-10000	-10000	\N	1ccea5cc-c080-4420-8b69-f29d5f712236	12	857	c650bdd5-10e1-4e35-9bcf-c1d55ef47014
11116	CREDIT	Donation via Meetup	1203	USD	2016-10-04 12:46:07.882-04	2016-10-04 12:46:07.993-04	51	3	\N	2017-10-26 17:24:07.426-04	\N	\N	\N	\N	\N	\N	1	\N	1203	\N	b88d4ddc-c3ab-493f-bd98-66568260bfa1	\N	857	daca6744-f726-4565-9492-05cf0c18496f
11056	CREDIT	WOMEN TECHMAKER/WWCODE PARTNERSHIP GRANT	110000	USD	2016-05-10 17:15:06.327-04	2016-05-10 17:15:06.677-04	51	3	\N	2017-10-26 17:24:07.516-04	\N	\N	\N	\N	\N	\N	1	\N	110000	\N	bcc40015-dacd-4c00-81fb-5d6aca753316	\N	857	ecc6e049-64c8-4956-bc89-a16bc562d9a7
11123	CREDIT	\N	300000	USD	2017-05-02 14:43:43.157-04	2017-05-02 14:43:43.157-04	51	3	\N	2017-10-26 17:24:07.561-04	\N	2676	\N	\N	\N	USD	1	300000	300000	\N	71bffdc3-20a1-4415-83b2-ae8aa2a9293d	\N	857	f968da78-b8d9-4f5b-8a5e-fdc74da7fe52
11127	DEBIT	Recurring subscription	-52	USD	2016-05-02 13:46:41.832-04	2016-05-02 13:46:41.894-04	691	30	41	\N	\N	67	5	\N	33	USD	1	-52	-100	\N	b7a466f3-cebb-455c-b5cc-0f5dc1f0bc5b	14	857	b1a9f8da-51aa-4bb1-a8bd-43ffe4f78bdb
11131	CREDIT	Google I/O ticket	38618	USD	2017-03-27 13:12:00.118-04	2017-03-27 13:12:00.138-04	834	69	2265	\N	\N	\N	\N	\N	1118	USD	1	38618	37500	949	9d7cf5ca-9a5b-4649-a991-a528aba48e9f	12	857	08e703f7-02d6-4346-93c6-c7eef0020007
11136	CREDIT	Event supplies for Leads	2439	USD	2017-02-07 13:38:14.3-05	2017-02-07 13:38:15.58-05	827	171	1718	\N	\N	\N	\N	\N	\N	\N	1	2439	2439	737	40ab9c0d-2ef6-4817-832c-ea1615938002	59	857	22f6a569-f9ca-4ee6-b79b-779dd78d6ccd
11140	CREDIT	Last minute (less than 7 day advance purchase) airline price purchase from SFO to JFK. Emailed Joey to alert of higher fare. 	59040	USD	2017-02-07 13:32:48.784-05	2017-02-07 13:32:49.072-05	766	31	1718	\N	\N	\N	\N	\N	\N	\N	1	59040	59040	776	bb523931-d02c-404f-be02-05ad7dded6a0	14	857	dccfdddf-67a7-44e9-beb4-89959e6f6431
11144	CREDIT	Meetup Transaction Fee	163	USD	2016-04-12 14:52:16.188-04	2016-06-14 14:14:21.849-04	51	3	\N	2016-06-14 14:14:22.458-04	\N	\N	\N	\N	\N	\N	1	163	163	82	9b214bf3-ca24-468d-b489-d4efafb7f5c7	4	857	cd3e327f-5768-4c1c-a2c1-eae51a8e516b
11148	CREDIT	Minimum Fee - May	1000	USD	2016-08-16 10:54:57.595-04	2016-08-16 10:54:57.609-04	51	3	573	\N	\N	\N	\N	\N	\N	\N	1	1000	1000	\N	2c75c958-af2d-414f-9805-c9337f08bfa8	48	857	b1304f1f-0bcb-4e06-a8bb-709b5ee1c33d
11153	CREDIT	Minimum fee - May	1000	USD	2016-08-16 10:54:12.931-04	2016-08-16 10:54:12.95-04	51	3	573	\N	\N	\N	\N	\N	\N	\N	1	1000	1000	\N	8ad0f8d7-15ca-4f1a-93e0-f0b9a586893c	15	857	1059d11e-b3d0-48db-ad58-6cb4592df70e
11154	CREDIT	Travel Scholarship for WWCode Director	40970	GBP	2017-04-17 18:32:02.724-04	2017-04-17 18:32:02.724-04	51	3	\N	\N	\N	\N	\N	\N	0	GBP	1	40970	40970	768	03685c71-2ce8-4bda-a6da-7622fcc74c1e	278	857	3cc2ca61-003c-4d59-88f8-58ab5b0776ae
11163	CREDIT	Meetup Fees	6000	USD	2016-12-28 10:53:05.613-05	2016-12-28 10:53:05.613-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	660	7d08b187-6739-4b09-8ece-bbe65d1a1566	289	857	b075ab85-a13a-4d9d-9911-3c08b1c7b593
11164	CREDIT	Meetup Fees	6000	USD	2016-12-28 10:49:16.255-05	2016-12-28 10:49:16.255-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	659	3a58784d-a1c9-45b9-b904-187e84b144f5	300	857	15e6915f-7b39-479a-9293-be7114a8c55e
11172	CREDIT	Meetup Fees	4900	GBP	2016-12-27 12:34:46.469-05	2016-12-27 12:34:46.469-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	4900	4900	647	e67bac30-10c8-42b1-95aa-aeb698fbb63b	278	857	00693c59-9b95-4e66-bdc9-899041e763a7
11177	CREDIT	October Hack Night Drinks/Food.	1106	USD	2016-12-07 00:00:00.86-05	2016-12-07 00:00:00.86-05	843	1325	\N	\N	\N	\N	\N	\N	\N	\N	1	1106	1100	485	53c5e151-1b92-496a-94e0-148518d15c87	273	857	b5c6ba70-6ba7-4029-b76e-4f79d7f5b890
11182	CREDIT	Farewell lunch for Clarissa + Welcome lunch for Pranoti 	11500	USD	2017-05-16 17:55:26.725-04	2017-05-16 17:55:26.725-04	797	32	\N	\N	\N	\N	\N	\N	0	USD	1	11500	11500	1119	2c426822-715b-4c97-a716-0f1386df4c7b	14	857	300b704d-ae44-415d-93f4-b379bd050d3b
11188	CREDIT	Meetup Fees	6000	USD	2016-12-23 14:41:48.315-05	2016-12-23 14:41:48.315-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	627	68aef56a-4a63-42e9-b880-91c0acfe5636	269	857	d50fbc55-cf5d-4127-b7c2-523ac9f38bc3
11192	CREDIT	Meetup Fees	6000	USD	2016-12-23 11:37:59.322-05	2016-12-23 11:37:59.322-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	613	a5134e3b-9364-4d8d-9d64-4a62d7a6baf2	260	857	a804ca3b-cd0d-4ee2-a343-32e69406089d
11195	CREDIT	Meetup Fees	6000	USD	2016-12-21 13:53:46.984-05	2016-12-21 13:53:46.984-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	607	ca2acbb0-984c-4181-83e0-f68ee438d381	2	857	f88a87f9-e1e0-4a3e-9bf1-8b8b9240b737
11198	CREDIT	Event suplies	2198	USD	2016-12-13 13:43:16.329-05	2016-12-13 13:43:17.27-05	51	3	1191	\N	\N	\N	\N	\N	\N	\N	1	2198	2198	\N	d0ad6238-a30f-4399-b41d-3211148cf33a	59	857	795d0c75-6392-4ec9-8659-4e32de19b5af
11205	CREDIT	Banner	2000	USD	2016-11-30 16:33:38.691-05	2016-11-30 16:33:38.827-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	2000	2000	\N	1aab13d6-0923-4ee3-8db9-103d3dd1d678	263	857	7893057b-79a0-48ef-9418-0a6745dfcf97
11211	CREDIT	Matthews Group - Leadership Development for Seattle team	60000	USD	2016-11-29 16:46:31.384-05	2016-11-29 16:46:31.384-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	60000	60000	464	c7721ada-3f87-4151-9ac2-ed8e5f6fb649	14	857	726bfdd5-9ee1-4586-8f05-15828f31d287
11213	CREDIT	Installfest	558	USD	2016-12-13 12:30:28.678-05	2016-12-13 12:30:30.347-05	51	3	1191	\N	\N	\N	\N	\N	\N	\N	1	558	558	\N	aa739866-3d4a-4fa9-8527-6bf927727afc	59	857	51bbe62e-284c-4ebb-947d-00b7835a3751
11215	CREDIT	Meetup Fees	6000	USD	2016-12-27 11:50:06.414-05	2016-12-27 11:50:06.414-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	639	45054d92-aed3-40f5-a177-e4de353c440f	273	857	9021ba8f-96fd-409e-afb7-8062d3b112dc
11219	CREDIT	Director t-shirt	2898	USD	2016-10-17 16:57:20.051-04	2016-10-17 16:57:20.056-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	2898	2898	\N	c4b90305-5081-4b03-8920-1d704a4603b0	3	857	376796f8-d456-4c5a-aa02-c37e3f93a78d
11224	CREDIT	WWCode Portland Stickers	31950	USD	2016-10-10 16:12:33.813-04	2016-10-10 16:12:33.813-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	31950	31950	411	ac23fd70-36c5-4b23-ad42-f689d13050a5	59	857	89cafc3f-4a34-49ed-9c44-71f377e533c0
11234	CREDIT	European Leadership Development Workshop -- Transportation, Flight	4728	EUR	2016-12-07 00:00:00.86-05	2016-12-07 00:00:00.86-05	793	1378	\N	\N	\N	\N	\N	\N	\N	\N	1	4728	4700	494	4755278e-67bc-40d1-aabb-9f702483ab09	301	857	aed6cabe-8481-41a5-ba4d-af956ab0c060
11236	CREDIT	WwConnect Conference	658	USD	2016-03-19 20:00:00-04	2016-06-14 14:14:21.806-04	766	31	26	\N	\N	\N	\N	\N	\N	\N	1	658	658	63	a11f73c5-d49f-452b-96b9-c0609987f99e	14	857	1c2b0af2-0241-4a4a-b9ca-283d95becdfe
11239	CREDIT	Drinks at Sept monthly event	2192	USD	2016-10-04 18:06:33.802-04	2016-10-04 18:06:34.357-04	51	3	573	\N	\N	\N	\N	\N	\N	\N	1	2192	2192	\N	fde9f710-eb92-49de-a1e6-4ba230e3909d	15	857	a986f984-051f-46bb-9c47-b852937fe09e
11241	CREDIT	Net budget balance pre-Open Collective	56266	USD	2016-10-04 17:57:44.218-04	2016-10-04 17:57:44.218-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	56266	56266	394	48c94e16-1db6-41b9-a933-ad09ea6e99a1	2	857	41c75384-10d5-448a-8918-68241f26515d
11243	CREDIT	Conference Grant - Sarah Olson	20000	USD	2016-05-25 12:39:09.882-04	2016-06-14 14:14:22.103-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	20000	20000	190	40e1c6f2-67bc-4ca6-9c27-c530f6eee148	48	857	c3617100-d561-48e4-a7c4-187caf0f183f
11250	CREDIT	Network support - Regional Leadership (thanks VMWare)	370000	USD	2016-10-11 15:51:28.361-04	2016-10-11 15:51:28.677-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	370000	370000	\N	31ff137a-a5a0-4140-b253-d661500d6759	262	857	5a6e3686-68ee-4401-98c6-ec621de7c87c
11253	CREDIT	 Network budget balance pre Open Collective	4356	USD	2016-10-04 18:37:57.159-04	2016-10-04 18:37:57.359-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	4356	4356	\N	9e580b90-683e-4136-9407-4c3674efd7e2	273	857	916f2269-55dc-46f5-9557-7976d5b2784d
3950	DEBIT	Decorations / Supplies	-1379	USD	2016-12-13 13:42:06.408-05	2016-12-13 13:42:07.17-05	59	3	1191	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1379	\N	4a743da3-3e6f-482f-8ac3-dd26c8ed51ae	51	857	e6b5d592-3a41-4359-acc2-7c7edd2c45e2
11124	CREDIT	Deposit- We Rise Conference Hosting Location	500000	USD	2017-05-16 17:51:10.574-04	2017-05-16 17:51:10.574-04	690	3206	\N	\N	\N	\N	\N	\N	0	USD	1	500000	500000	1123	4b779c47-8041-4c0a-8d29-5d7b704c0f9d	12	857	9a4858b6-0f6f-48e1-80ea-7ca5e99fd1c1
11139	CREDIT	Regional Leadership Event: Barcelona	19398	EUR	2017-05-16 17:49:07.885-04	2017-05-16 17:49:07.885-04	793	1378	\N	\N	\N	\N	\N	\N	0	EUR	1	19398	19398	1122	9a755016-6b3b-4e24-a8e8-ae2fa7f5aae2	301	857	510a1841-985e-4129-889e-f4a171951b60
11068	DEBIT	\N	-1200	USD	2017-05-04 14:58:24.9-04	2017-05-04 14:58:24.9-04	857	3	\N	\N	\N	2713	0	\N	0	USD	1	-1200	-1200	\N	8983f006-809f-4645-9e2c-a782c7d5b16b	430	857	0401add2-5530-43d2-a6ed-1be087f38b42
11120	DEBIT	Donation received via Meetup, less fees	-788	USD	2016-10-04 12:46:13.302-04	2016-10-04 12:46:13.487-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-788	-788	\N	6625cff1-dc07-4598-b4d4-a51774c8c70c	12	857	6075a9a1-dc87-43de-82bb-b35074a76241
11111	DEBIT	Network Development: Three Year Bonus:)	-50000	USD	2016-10-04 17:52:32.839-04	2016-10-04 17:52:32.962-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-50000	-50000	\N	f50413dd-d10a-4d62-800d-70b66dd1ae8e	2	857	65120030-5816-46e4-8b20-40523e7abd4b
11108	CREDIT	Network Development	10000	USD	2016-10-04 17:50:13.582-04	2016-10-04 17:50:13.787-04	51	3	\N	2017-10-26 17:24:06.88-04	\N	\N	\N	\N	\N	\N	1	\N	10000	\N	68301703-5596-4c67-936d-c7bee19b8036	\N	857	6b54c2cd-f63f-4326-9552-6aafe3e457db
11115	DEBIT	Network Development	-10000	USD	2016-10-04 17:50:13.582-04	2016-10-04 17:50:13.787-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-10000	-10000	\N	dab2c982-ca08-4c78-9a30-9cd092db3a43	15	857	6b54c2cd-f63f-4326-9552-6aafe3e457db
11055	DEBIT	Jasna Rodulfa	-1000	USD	2016-04-15 10:17:21.126-04	2016-04-16 16:40:58.829-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-1000	-1000	\N	632d627f-7630-407c-8173-33302ea5ae6b	13	857	837bc99b-e49c-44eb-8acf-f4cf9199bfff
11085	CREDIT	Network Development	10000	USD	2016-10-11 12:52:38.277-04	2016-10-11 12:52:38.455-04	51	3	\N	2017-10-26 17:24:07.342-04	\N	\N	\N	\N	\N	\N	1	\N	10000	\N	1fa97dd2-ea71-4cc8-94a1-1a5f8c32d3cc	\N	857	cef5d97f-fdeb-44f0-9bcc-2fccc97105e1
11091	DEBIT	Network Development	-10000	USD	2016-10-11 12:52:38.277-04	2016-10-11 12:52:38.455-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-10000	-10000	\N	120104bc-c4ed-4bbd-ba9f-8698effec489	59	857	cef5d97f-fdeb-44f0-9bcc-2fccc97105e1
11080	DEBIT	from Code2040	-90000	USD	2016-10-17 11:43:12.71-04	2016-10-17 11:43:13.113-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-90000	-90000	\N	4fd1fb43-57b5-48b4-8948-0f15540863dc	2	857	d5659c85-3aab-4882-b441-83b1501a0684
11125	DEBIT	Donation via Meetup	-1203	USD	2016-10-04 12:46:07.882-04	2016-10-04 12:46:07.993-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-1203	-1203	\N	81c00427-e471-4ea8-97ff-4df48640068d	13	857	daca6744-f726-4565-9492-05cf0c18496f
11072	CREDIT	WWCode shirt Grisel	3649	USD	2016-10-17 16:48:59.282-04	2016-10-17 16:48:59.313-04	51	3	\N	2017-10-26 17:24:07.497-04	\N	\N	\N	\N	\N	\N	1	\N	3649	\N	62aacee6-97b9-401c-a5fe-ac450bb46007	\N	857	e6ee8418-e4de-4edf-a515-5503bcbe3877
11099	CREDIT	\N	15000	USD	2017-05-03 13:44:48.715-04	2017-05-03 13:44:48.715-04	51	3	\N	2017-10-26 17:24:07.554-04	\N	2697	\N	\N	\N	USD	1	15000	15000	\N	7d5a197c-53e2-428c-a8b8-68affe63ae7a	\N	857	f84648db-6077-401e-8a71-5f57b1c44914
11134	CREDIT	Travel Stipend for Google I/O, now that I have secured my I/O Ticket via Google - see enclosed I/O Ticket Receipt)	88760	GBP	2017-03-27 12:01:27.19-04	2017-03-27 12:01:27.295-04	830	1333	2265	\N	\N	\N	\N	\N	3760	GBP	1	88760	85000	926	417daf8e-9e6e-4a9b-b9bd-3a1a01a2fef7	278	857	0c37be8d-f8f8-42bc-b440-accc66416375
11137	CREDIT	Hackathon 2017 planning meeting	3005	USD	2017-04-11 15:15:09.813-04	2017-04-11 15:15:09.826-04	827	171	2321	\N	\N	\N	\N	\N	114	USD	1	3005	2891	1001	120d4e77-84c0-4a6b-bfe5-a21aef565dec	59	857	43ac40ab-9912-40c0-bceb-58b8b501e16a
11141	CREDIT	payment to artists (spoken word) for performance at IWD event	20610	USD	2017-03-27 08:47:25.654-04	2017-03-27 08:47:25.894-04	762	70	2218	\N	\N	\N	\N	\N	610	USD	1	20610	20000	907	f142bcc2-af4d-4b2c-b7a5-936e9df44d49	12	857	f40effc5-8e82-4156-9496-15a4aa102a74
11151	CREDIT	Fedex 	3418	USD	2016-10-11 20:43:40.215-04	2016-10-11 20:43:40.344-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	3418	3418	\N	c48a3413-961e-4db3-9b5f-2634a91ebc13	48	857	3c52eed5-7c00-4cc1-ae82-8581e9fdee3e
11157	CREDIT	Conference Grant	70000	USD	2016-05-19 15:07:13.723-04	2016-06-14 14:14:22.082-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	70000	70000	178	951b8cb4-1786-408e-a286-90d6d367f4ba	3	857	f928e49f-f908-44ca-b841-d845d52bd531
11161	CREDIT	Reimburse Caterina for program materials	3798	USD	2016-04-05 15:44:01.338-04	2016-06-14 14:14:21.838-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	3798	3798	76	ff4d8496-0957-41a6-a8d0-992e75eb51b8	59	857	3c514fd0-525e-4f42-a2e1-f7550f58fd30
11167	CREDIT	Meetup Fee	6000	USD	2016-12-27 13:35:08.624-05	2016-12-27 13:35:08.624-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	653	49d449b8-bd68-48cd-a972-a83071f23b32	284	857	0b6638d9-7c71-466d-97c6-6e816e03d320
11171	CREDIT	Meetup Fees	6000	USD	2016-12-27 12:49:39.83-05	2016-12-27 12:49:39.83-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	648	b9b8f790-f114-41e8-8863-1cfcda83c4a9	280	857	0aaacde4-838e-40d5-93df-95003cce0dfa
11175	CREDIT	Meetup Fees	6000	MXN	2016-12-27 11:12:26.224-05	2016-12-27 11:12:26.224-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	632	78554aba-09ed-4260-bd76-e288b2f4a760	299	857	13d6aa98-8924-4982-b7da-5edf312e40f0
11179	CREDIT	Food for October Hack Night.	7773	USD	2016-12-07 00:00:00.86-05	2016-12-07 00:00:00.86-05	843	1325	\N	\N	\N	\N	\N	\N	\N	\N	1	7773	7700	484	2c8a1ac6-9bba-44fe-87fc-5cbfcde9f6f2	273	857	33c12076-8925-43a9-b3ad-b2aa96b900a7
11185	CREDIT	Meetup Fees	5700	EUR	2016-12-27 13:11:51.873-05	2016-12-27 13:11:51.873-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	5700	5700	652	73791168-c2ea-46ae-b7eb-e21c2026e161	283	857	66aaeb74-3900-461d-a06d-af8608e78bff
11187	CREDIT	Meetup Fees	6000	USD	2016-12-23 14:50:08.539-05	2016-12-23 14:50:08.539-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	628	c897f783-06c1-4a75-8f94-1f08999ee45d	270	857	ddbddd2d-b7f7-40ad-ba91-5272ec81fd7e
11197	CREDIT	Speaker and sponsor meetings (11/18 + 11/28) and event logistics (12/2)	2870	USD	2016-12-13 13:44:23.973-05	2016-12-13 13:44:24.945-05	51	3	1191	\N	\N	\N	\N	\N	\N	\N	1	2870	2870	\N	ae22151a-3de5-4863-a8d7-0e3ea3a60ac8	59	857	ed14302e-7d93-41df-85f9-8877fe8bb183
11201	CREDIT	Hackathon - prizes for winners + goodies for thank you bags for sponsors/speakers/mentors/judges/volunteers	7750	USD	2016-12-06 11:57:59.164-05	2016-12-06 11:57:59.708-05	51	3	1191	\N	\N	\N	\N	\N	\N	\N	1	7750	7750	\N	1da6888f-c5a0-4b45-b12f-fe42c734514e	59	857	29f5414a-e750-4516-81af-11811241c1eb
11206	CREDIT	Conference Travel Stipend - Google I/O Elese	75000	USD	2016-11-30 16:25:56.197-05	2016-11-30 16:25:56.423-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	75000	75000	\N	44199d2e-5124-4692-b678-f0e3a2de16e3	276	857	43f443d2-22f8-4ae0-b41e-473117887692
11208	CREDIT	Banner	2000	USD	2016-11-29 17:34:04.252-05	2016-11-29 17:34:04.435-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	2000	2000	\N	84738e19-8a1a-4685-8777-7fcce1d54ced	47	857	a20b1b35-341f-4dc5-b4a2-8d9927978c3c
11214	CREDIT	Office Supplies for Hackathon.	10585	USD	2016-12-06 12:00:58.382-05	2016-12-06 12:00:58.806-05	51	3	1191	\N	\N	\N	\N	\N	\N	\N	1	10585	10585	\N	6fc0759b-49d3-47cc-92b1-d7c59df2fbba	59	857	2cd2ee50-3907-4d53-a907-15dff2477059
11222	CREDIT	WWCode Director t-shirt	3649	USD	2016-10-17 16:50:53.853-04	2016-10-17 16:50:53.855-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	3649	3649	\N	73f3a2b1-15d5-4735-8ecf-f81cc1db5576	47	857	e78f61b1-4467-4a71-94f8-c4be5a79e7fe
11226	CREDIT	Feb 1, Lightning Talks	22568	USD	2016-03-20 14:06:09.887-04	2016-06-14 14:14:21.794-04	847	28	26	\N	\N	\N	\N	\N	\N	\N	1	22568	22568	56	639f0d5b-184c-484e-8450-e959e8c97522	2	857	6e29ba63-ee2b-44c3-ae42-7b6ca4fe0b65
11229	CREDIT	Feb 1, Lightning Talks	0	USD	2016-03-20 14:06:09.887-04	2016-03-29 16:37:47.75-04	847	28	\N	2016-03-28 20:00:00-04	\N	\N	\N	\N	\N	\N	1	0	22568	\N	542c4fd2-e3a6-4e9f-ba76-0740c7bdb49d	2	857	c8337f56-3568-4da2-b672-9a86db2c61ec
11232	CREDIT	Quarterly planning meeting	14000	USD	2016-05-05 20:18:43.265-04	2016-06-14 14:14:22.011-04	797	32	26	\N	\N	\N	\N	\N	\N	\N	1	14000	14000	147	88d0b4bf-946f-43f3-8be1-ff0369d38944	14	857	c853f1a1-7e62-4cdd-9805-4f9ab20cda02
11251	CREDIT	Global Development	150	USD	2016-04-17 18:19:12.094-04	2016-06-14 14:14:21.883-04	51	3	\N	2016-06-14 14:14:22.479-04	\N	\N	\N	\N	\N	\N	1	150	150	93	849922a2-3d86-4240-b00d-c4ac83f0bbba	4	857	60ab53eb-a1f7-474f-80e9-a443fb4a1787
11261	CREDIT	Meetup Fees	6000	USD	2016-12-28 11:32:19.412-05	2016-12-28 11:32:19.412-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	667	9feeb2df-a710-4247-801f-051305ed809c	294	857	7106868f-3bf4-415d-8671-235bd5fedefe
11263	CREDIT	Meetup Fees	4900	GBP	2016-12-23 13:04:05.755-05	2016-12-23 13:04:05.755-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	4900	4900	624	88d48e94-1f4e-4fd9-9cbd-5e33f44fa719	267	857	9286402c-95d6-479a-a1ac-b936bae4610a
11266	CREDIT	Meetup Fees	6000	USD	2016-12-27 12:03:23.101-05	2016-12-27 12:03:23.101-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	643	33d284a5-98a8-4041-a1f5-a90cc3c63b02	277	857	3067e8f9-54fe-4b7a-9df7-79c9cac3ac29
11269	CREDIT	Frames for sponsor gifts	4054	USD	2016-11-30 11:11:18.637-05	2016-11-30 11:11:18.805-05	51	3	1191	\N	\N	\N	\N	\N	\N	\N	1	4054	4054	\N	f42b4172-56b1-4879-8f78-2c16896b3550	2	857	063f9d57-952e-45f8-aeba-efa212dd09ea
11272	CREDIT	May 5 South Hack Night	5325	USD	2016-05-22 19:46:04.647-04	2016-06-14 14:14:22.083-04	847	28	26	\N	\N	\N	\N	\N	\N	\N	1	5325	5325	181	403c875a-9e98-4bea-90f1-a0e674b6c74a	2	857	6aaa2e86-8b6e-4d84-91d6-5c75adb3e739
11275	CREDIT	Plaques for IWD awards ceremony​ 	56402	USD	2017-03-15 09:57:14.454-04	2017-03-15 09:57:14.471-04	834	69	2149	\N	\N	\N	\N	\N	1619	USD	1	56402	54783	888	e0f35149-51b7-4970-b236-08a7c0f0172d	12	857	5dbf3ac6-4b96-4cdd-9d0b-152db859b39a
11280	CREDIT	Gift Card for Volunteer	10000	USD	2016-10-27 17:03:46.196-04	2016-10-27 17:03:46.328-04	51	3	1024	\N	\N	\N	\N	\N	\N	\N	1	10000	10000	\N	04a00c1d-f32e-48b6-85f8-2f2fff2ad056	300	857	8e5b30dc-5b3b-4a4e-a5e0-a71f189e5beb
11283	CREDIT	Leadership Development - speaking event	25000	USD	2016-11-29 17:39:25.11-05	2016-11-29 17:39:25.31-05	51	3	\N	2016-11-28 19:00:00-05	\N	\N	\N	\N	\N	\N	1	25000	25000	\N	25623cbd-481e-4c2d-96af-1d3e95303e53	47	857	7c15888a-e589-409d-82d0-365dcabfdea2
11286	CREDIT	Google I/O: Alicia Carr	10000	USD	2016-10-04 11:44:35.988-04	2016-10-04 11:44:35.988-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	10000	10000	387	bbbb67b6-e92a-4ee7-b53a-c222b6583d3a	12	857	4731026f-f82d-4b1d-9611-9a6bd0d86178
11290	CREDIT	Minimum fee - May	990	USD	2016-08-16 10:53:06.001-04	2016-08-16 10:53:06.015-04	51	3	573	\N	\N	\N	\N	\N	\N	\N	1	990	990	\N	d0882b32-3b4b-4f28-8495-9832b946c2a9	13	857	0246e2ec-b6eb-440c-91ad-0b28e5dddec4
11132	CREDIT	Google I/O	51480	USD	2017-03-27 13:11:39.25-04	2017-03-27 13:11:39.275-04	834	69	2265	\N	\N	\N	\N	\N	1480	USD	1	51480	50000	952	2351ff47-d6e8-4824-801e-d1c1b5e01764	12	857	22752b9f-7315-4137-a35c-69b3c0366197
11102	CREDIT	\N	75000	USD	2017-05-03 13:44:10.84-04	2017-05-03 13:44:10.84-04	51	3	\N	2017-10-26 17:24:06.388-04	\N	2696	\N	\N	\N	USD	1	75000	75000	\N	2fe29ad5-5a57-463e-8414-fef20d2adec3	\N	857	1df05da0-ad60-4ccd-893b-526f67bde658
11109	DEBIT	\N	-75000	USD	2017-05-03 13:44:10.84-04	2017-05-03 13:44:10.84-04	857	3	\N	\N	\N	2696	0	\N	0	USD	1	-75000	-75000	\N	edd07692-6053-4ccf-8bb5-d8c85ece76c0	12	857	1df05da0-ad60-4ccd-893b-526f67bde658
11146	DEBIT	Nike Donation	-50000	USD	2016-06-10 00:08:56.525-04	2016-06-10 00:08:56.991-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-50000	-50000	\N	bfc2caa9-7d48-484c-bc62-8245e7f332f0	59	857	446ac15a-83a5-430d-bc9e-f62541ce6788
11119	CREDIT	Donation via Meetup	2036	USD	2016-10-04 12:42:35.996-04	2016-10-04 12:42:36.119-04	51	3	\N	2017-10-26 17:24:06.874-04	\N	\N	\N	\N	\N	\N	1	\N	2036	\N	e5e64248-923f-4de0-9067-a12f2cd663f2	\N	857	6b54108d-7f7d-4fdf-ad41-bbea6a41fea5
11126	DEBIT	Donation via Meetup	-2036	USD	2016-10-04 12:42:35.996-04	2016-10-04 12:42:36.119-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-2036	-2036	\N	3a336b7a-b4f4-4fca-8f7b-71f587c60fc6	300	857	6b54108d-7f7d-4fdf-ad41-bbea6a41fea5
11098	CREDIT	Network Development (Stickers)	62984	USD	2016-10-06 11:49:44.329-04	2016-10-06 11:49:44.472-04	51	3	\N	2017-10-26 17:24:07.105-04	\N	\N	\N	\N	\N	\N	1	\N	62984	\N	98cb91a7-b6e4-45ed-bf74-1d513e9b0db2	\N	857	9f4e0c05-2799-4dd8-8fdc-562a9d79f617
11106	DEBIT	Network Development (Stickers)	-62984	USD	2016-10-06 11:49:44.329-04	2016-10-06 11:49:44.472-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-62984	-62984	\N	c276f68c-9c0f-4259-80a1-12cf8c6a04be	4	857	9f4e0c05-2799-4dd8-8fdc-562a9d79f617
11092	CREDIT	Network Development +	50000	USD	2016-10-07 16:24:13.595-04	2016-10-07 16:24:13.706-04	51	3	\N	2017-10-26 17:24:07.305-04	\N	\N	\N	\N	\N	\N	1	\N	50000	\N	3222fa57-f03d-49d8-b476-6b30ed7068cf	\N	857	c7be7e35-692f-4f6d-9650-36e89035e8db
11077	DEBIT	WWCode shirt Grisel	-3649	USD	2016-10-17 16:48:59.282-04	2016-10-17 16:48:59.313-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-3649	-3649	\N	ece39ef2-7953-46b1-b3de-707aa4f06068	282	857	e6ee8418-e4de-4edf-a515-5503bcbe3877
11130	DEBIT	\N	-300000	USD	2017-05-02 14:43:43.157-04	2017-05-02 14:43:43.157-04	857	3	\N	\N	\N	2676	0	\N	0	USD	1	-300000	-300000	\N	79fa21e1-c0d4-4f55-8bd0-0266699ccd3c	12	857	f968da78-b8d9-4f5b-8a5e-fdc74da7fe52
11074	CREDIT	WWCode DC t-shirts sales	9524	USD	2016-11-17 13:37:58.038-05	2016-11-17 13:37:58.232-05	51	3	\N	2017-10-26 17:24:07.575-04	\N	\N	\N	\N	\N	\N	1	\N	9524	\N	856ceeb0-c625-43f4-8766-c6ee53da2f1e	\N	857	fd9d1263-fa89-4dd7-adcb-e98f1ac39cf8
11082	DEBIT	WWCode DC t-shirts sales	-9524	USD	2016-11-17 13:37:58.038-05	2016-11-17 13:37:58.232-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-9524	-9524	\N	f2d7db2c-b249-4e5f-a1b3-5b4179a86804	13	857	fd9d1263-fa89-4dd7-adcb-e98f1ac39cf8
11150	CREDIT	Regional Leadership Director Training	13031	USD	2016-11-29 17:35:21.354-05	2016-11-29 17:35:21.522-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	13031	13031	\N	fdfe2fe5-e0ef-4c9c-a512-71624ca8abd2	47	857	1a6745c2-ac51-4c90-88b8-807e6c56862a
11156	CREDIT	Atlanta IWD Event	235699	USD	2017-04-17 15:17:23.032-04	2017-04-17 15:17:23.032-04	51	3	\N	\N	\N	\N	\N	\N	0	USD	1	235699	235699	998	921f0aaa-c719-4061-901e-b0fdb437162d	12	857	a05e7357-7c73-4ce6-aef6-391b184c0886
11159	CREDIT	WePay Fee	400	USD	2016-04-10 20:00:00-04	2016-06-14 14:14:21.907-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	400	400	104	980c4063-5b67-45c6-aa4f-9e6d309b933b	48	857	4b5c85f2-4e5b-4e35-a678-984d7dddb47e
11166	CREDIT	Meetup Fees	6000	USD	2016-12-27 13:38:46.887-05	2016-12-27 13:38:46.887-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	654	b5d5cab9-7ea7-4b3c-8441-ee3425e5b752	59	857	612a3392-cf6e-4950-80d9-809a34a899cf
11170	CREDIT	Meetup Fees	6000	AUD	2016-12-27 12:54:00.843-05	2016-12-27 12:54:00.843-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	649	88847fcd-529b-42ca-99a7-65a2f2054480	281	857	0c4fdfa7-de06-449e-8c87-0944eb1ea1b2
11178	CREDIT	February Lightning Talks food	11020	USD	2017-03-14 13:17:53.891-04	2017-03-14 13:17:53.957-04	847	28	1893	\N	\N	\N	\N	\N	340	USD	1	11020	10680	820	29d65fcf-212f-4933-b3f5-3a685e3fe65a	2	857	0f56eae7-75de-4f0d-9ecb-74119a321aee
11184	CREDIT	Meetup Fees	6000	CAD	2016-12-28 11:21:52.469-05	2016-12-28 11:21:52.469-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	663	3c7084be-c47d-40c5-8ae5-8abaa827994c	291	857	0d366a4d-065c-4f9e-ba1c-38b2454509e5
11189	CREDIT	Meetup Fees	6000	USD	2016-12-23 14:38:46.818-05	2016-12-23 14:38:46.818-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	626	6e5c0789-7c4a-4f5b-8956-360f606a823a	268	857	b7469e39-40c1-48da-a885-a6ca5c8cb055
11196	CREDIT	Meetup Fees	6000	USD	2016-12-27 14:53:07.2-05	2016-12-27 14:53:07.2-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	657	78ea4940-0bc1-4da7-a9a6-1876ec363173	14	857	76e7fb22-e588-46f0-8189-c39ae505262e
11199	CREDIT	Decorations / Supplies	1379	USD	2016-12-13 13:42:06.408-05	2016-12-13 13:42:07.17-05	51	3	1191	\N	\N	\N	\N	\N	\N	\N	1	1379	1379	\N	9cef4663-6894-4c97-b60f-6bc2a24ec9c1	59	857	e6b5d592-3a41-4359-acc2-7c7edd2c45e2
11203	CREDIT	Meetup Fees	6000	USD	2016-12-27 11:31:58.557-05	2016-12-27 11:31:58.557-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	636	3e3c09e7-cb26-42bc-abd0-ac1b65cd0cb0	15	857	7347316d-065e-4e36-91db-432c87dc57f6
11210	CREDIT	Fedex - certificate print expense	1962	USD	2016-10-31 17:32:07.365-04	2016-10-31 17:32:07.497-04	51	3	1043	\N	\N	\N	\N	\N	\N	\N	1	1962	1962	\N	d6db5399-c5fb-4413-93d9-0cdfe6303246	300	857	5e41a943-11d4-409f-8a82-52194ccac4bd
11212	CREDIT	Pizza for our monthly October event	9276	USD	2016-10-31 14:07:11.805-04	2016-10-31 14:07:12.736-04	51	3	1024	\N	\N	\N	\N	\N	\N	\N	1	9276	9276	\N	21b6812b-505f-4878-bd04-a60ab3432da6	15	857	ceb60da8-e426-4122-9b62-796b03890b68
11220	CREDIT	Stickers for ATXDivHack 	15300	USD	2016-10-31 17:15:38.727-04	2016-10-31 17:15:38.89-04	51	3	1043	\N	\N	\N	\N	\N	\N	\N	1	15300	15300	\N	c206479b-e250-48e5-a37f-180b0753aa9d	2	857	cc585ccd-bb1e-4141-a268-b249a8bff2c0
11223	CREDIT	Google I/O stipend	50000	USD	2016-10-11 12:00:21.246-04	2016-10-11 12:00:22.203-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	50000	50000	\N	b5f02050-caed-4a78-a4eb-b3c83126c5e7	195	857	56ab81ed-0ac4-44b9-9ae8-a5d4f09dfa45
11230	CREDIT	Food/Drinks for Leadership Team Meeting - Gen, Claire, Halima - Sept 2016	6000	GBP	2016-12-07 00:00:00.86-05	2016-12-07 00:00:00.86-05	830	1333	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	506	3e797692-c13a-4b47-98ff-e91caeb89e10	278	857	891308e1-11ac-4c38-be96-3e77f861c12e
11233	CREDIT	Connect 2016 event setup day dinner	6800	USD	2016-03-17 20:00:00-04	2016-06-14 14:14:21.838-04	797	32	26	\N	\N	\N	\N	\N	\N	\N	1	6800	6800	72	a9891abc-6be2-4ab1-88e2-8867a98cedaf	14	857	66388e2e-b0b6-41bb-9098-c6e64a8772f0
11235	CREDIT	European Leadership Development Workshop -- Transportation, Taxi	4400	EUR	2016-12-07 00:00:00.86-05	2016-12-07 00:00:00.86-05	793	1378	\N	\N	\N	\N	\N	\N	\N	\N	1	4400	4400	493	74c1cde3-5662-4445-86a3-cf1579a488a5	301	857	34b05e99-6b04-464c-9707-c3e6c414cb2a
11247	CREDIT	Gifts for Organizers	2399	USD	2016-10-31 17:14:19.644-04	2016-10-31 17:14:19.81-04	51	3	1043	\N	\N	\N	\N	\N	\N	\N	1	2399	2399	\N	ad5da2b8-259f-41c4-a0b1-feb6fb86f6c6	2	857	dda2ffd1-1727-4889-9c97-bf5cf6244fb1
11248	CREDIT	Global Development	0	USD	2016-04-12 14:52:16.188-04	2016-04-12 17:19:43.124-04	51	3	\N	2016-04-12 17:19:43.124-04	\N	\N	\N	\N	\N	\N	1	0	150	\N	722322c9-3146-404f-8fc4-1fb8c1fc6dfe	4	857	c461b49c-7028-40d2-9a89-e9bc0075ef79
11254	CREDIT	Global Development	100	USD	2016-04-15 13:29:50.291-04	2016-06-14 14:14:21.861-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	100	100	86	cc70b1d9-ff0f-4260-8293-9b2481f14b9e	13	857	ce3a22d2-3b8e-4d72-82c5-41e713c05bd5
11259	CREDIT	CONFERENCE GRANT	80000	USD	2016-05-31 13:47:01.276-04	2016-06-14 14:14:22.123-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	80000	80000	198	598ffdd4-c778-48c9-bb26-7f90e4bc4a0f	13	857	98181ba8-5fab-4ecc-a66e-4fad8cfd38f9
11268	CREDIT	Meetup Fees	6000	USD	2016-12-27 11:55:07.385-05	2016-12-27 11:55:07.385-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	641	8e8b2cb5-1e5c-40a7-80a3-c3f99b9c7060	275	857	e9961387-4ae2-4933-ab1a-182b8e39b529
11270	CREDIT	DIANA A. SCHOLARSHIP GOOGLE I/O	25000	USD	2016-11-21 17:59:43.764-05	2016-11-21 17:59:43.764-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	25000	25000	396	231865b6-fd29-4709-aa30-ec6dd368010a	272	857	7e5333f8-15a9-45a6-9738-f2e0ae33fa0e
11273	CREDIT	Mar 3 hack night	4951	USD	2016-03-20 14:06:09.887-04	2016-06-14 14:14:21.784-04	847	28	26	\N	\N	\N	\N	\N	\N	\N	1	4951	4951	55	7f68c869-dbe6-4ffe-bafc-0e98d6dbdc8c	2	857	115cadd6-4947-41c7-9031-56026dbcd930
11282	CREDIT	Snacks and dessert	38874	USD	2016-12-06 12:02:53.61-05	2016-12-06 12:02:54.44-05	51	3	1191	\N	\N	\N	\N	\N	\N	\N	1	38874	38874	\N	a87a523b-9bbc-4b6d-830e-a79e580cddb4	59	857	b9f10471-847a-48cc-a365-1113d3379006
11292	CREDIT	Minimum Fee - June	995	USD	2016-08-16 10:51:24.796-04	2016-08-16 10:51:24.811-04	51	3	573	\N	\N	\N	\N	\N	\N	\N	1	995	995	\N	33fd4edf-618f-4fd9-8d7a-7f6fb6f114c6	12	857	d8bd55c5-4066-40ad-a3d4-2ee39b9512ca
11295	CREDIT	Leadership Tools (director tees)	2698	USD	2015-12-14 19:00:00-05	2016-06-14 14:14:22.114-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	2698	2698	192	a0df7820-8de6-48c5-80e8-e5ec71bde722	48	857	18e8fd0f-2b5c-4e62-9ac4-93137ef9ab8b
11301	CREDIT	Conference stipend Olivia F.	39585	GBP	2016-10-07 09:35:08.613-04	2016-10-07 09:35:08.724-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	39585	39585	\N	ef54b38e-eda8-4609-9254-71fdf1e00887	278	857	66f1b95d-32e6-49d5-832b-a70c0e53a256
11304	CREDIT	Director t-shirt	3186	USD	2016-10-17 16:58:31.776-04	2016-10-17 16:58:31.789-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	3186	3186	\N	2c679ddf-8395-478d-9ca8-5caaf2a7b4b5	271	857	79dd6530-055a-47c1-8d52-f0551e31461b
11351	DEBIT	Donation to WWCode Washington DC	-52	USD	2016-03-01 23:41:59.916-05	2016-04-16 16:40:58.728-04	704	126	93	\N	\N	95	5	\N	33	USD	1	-52	-100	\N	3fd2a80d-9d73-4bdf-8b51-3cf0fdf2ea12	13	857	d1f21443-dc0b-414f-81d8-c56a989c878c
11271	CREDIT	Postage to send hackathon gifts to sponsors	1628	USD	2016-11-30 11:09:00.364-05	2016-11-30 11:09:00.529-05	51	3	1191	\N	\N	\N	\N	\N	\N	\N	1	1628	1628	\N	a9c8b49d-3113-4c68-8fc0-85bfa33a9db5	2	857	04505a83-d8a1-4840-8a26-a09be1fa5779
11274	CREDIT	Food for monthly hack night from Antonino Bertolo's Pizza & Wine Bar.	4351	USD	2016-12-07 00:00:00.86-05	2016-12-07 00:00:00.86-05	843	1325	\N	\N	\N	\N	\N	\N	\N	\N	1	4351	4300	483	c9ff3a79-76de-45c6-87bd-471b7faf388f	273	857	cc3cfa5f-6000-4638-a3ac-290b798dd568
11277	CREDIT	Leadership team dinner - Sondry interview	11757	USD	2016-08-02 09:44:04.201-04	2016-08-02 09:44:04.214-04	766	31	320	\N	\N	\N	\N	\N	\N	\N	1	11757	11757	307	5f93647b-23dd-42cf-b59b-e5880d94f5d9	14	857	a93e63d8-6ce5-4ecb-b431-4675dbfdb8c4
11287	CREDIT	90/10 split: AT&T Sponsorship (April 2015)	100000	USD	2016-10-04 11:44:28.558-04	2016-10-04 11:44:28.558-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	100000	100000	389	612435d0-07bb-4f96-89bd-e191f6d95472	12	857	4ce6a154-0cab-4b17-af6a-7d85fd9e76e9
11289	CREDIT	Global Development	10000	USD	2016-04-12 14:52:16.188-04	2016-06-14 14:14:21.849-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	10000	10000	80	f412f5ba-e599-4598-93d4-36ee3d840ca9	59	857	04a623c7-58f2-4831-930b-591328b1986f
11302	CREDIT	Leadership Tshirt Order	2698	USD	2016-12-07 11:51:43.784-05	2016-12-07 11:51:44.214-05	51	3	1191	\N	\N	\N	\N	\N	\N	\N	1	2698	2698	\N	1cfc8f19-9f3f-487a-aefa-637ef919f228	59	857	7caa3f23-1b94-4d72-a0c8-80ccc620d84c
11312	CREDIT	Marketing and communications materials for leadership team. 	4264	USD	2016-08-19 13:25:04.062-04	2016-08-19 13:25:04.374-04	51	3	573	\N	\N	\N	\N	\N	\N	\N	1	4264	4264	\N	7fdd9f8f-3c51-440c-b9db-c49abdc8cdfb	59	857	5aec6a99-a6d0-411a-9afb-c5c23210de3a
11316	CREDIT	Minimum Fee - June	1000	USD	2016-08-16 10:55:45.164-04	2016-08-16 10:55:45.179-04	51	3	573	\N	\N	\N	\N	\N	\N	\N	1	1000	1000	\N	63266766-3ffe-490a-aed0-bdb53d512166	59	857	4a8ed9a1-42c8-4a54-8989-fd3f09977378
11322	CREDIT	Cash for Prizes/Bartender (the extra money, $50, was not used for the hackathon)	70000	USD	2016-11-01 11:16:29.544-04	2016-11-01 11:16:30.012-04	51	3	1044	\N	\N	\N	\N	\N	\N	\N	1	70000	70000	\N	71b689cd-f014-4edb-a92a-bf8858d3c4df	2	857	2b6596e0-ef0d-4f32-adda-6d96ce25546f
11325	DEBIT	monthly recurring subscription	-798	USD	2017-02-09 23:43:49.515-05	2017-02-09 23:43:49.515-05	737	1158	731	\N	\N	647	50	\N	52	USD	1	-798	-1000	\N	002436b3-09c4-4cdb-8a4f-c5374d5f9629	241	857	06f8ef12-513f-4f37-b48b-3d7c1410cd20
11333	CREDIT	Meetup Fees	6000	USD	2016-12-27 14:50:16.992-05	2016-12-27 14:50:16.992-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	656	921f2b2e-c897-4862-9baa-5bcb3d21d8cf	288	857	a92116a0-3e95-4a82-9061-70b767a5005f
11342	CREDIT	Conference Travel	53720	USD	2016-11-03 17:27:22.46-04	2016-11-03 17:27:22.847-04	696	142	1117	\N	\N	\N	\N	\N	\N	\N	1	53720	53720	333	d49d7b61-63c4-4a52-84c7-b957289add88	48	857	a6db1f7b-0ccf-492c-ac63-5257adb3a0d2
11349	DEBIT	\N	-2040	USD	2016-10-07 12:49:19.978-04	2016-10-07 12:49:19.978-04	712	1446	884	\N	\N	812	125	\N	85	USD	1	-2040	-2500	\N	d252b9ff-dbe1-43d2-b925-62eaad7b6f49	241	857	a292e6ee-7a62-4659-87b2-62069be05003
11352	DEBIT	Recurring subscription	-52	USD	2016-06-02 01:48:36.714-04	2016-06-02 01:48:36.745-04	704	126	93	\N	\N	95	5	\N	33	USD	1	-52	-100	\N	54b6f003-ed07-49a3-911e-967cf9ac23e9	13	857	8f7cb347-de8d-4805-8907-def8b4ed04b8
7114	DEBIT	Plaques for IWD awards ceremony​ 	-54783	USD	2017-03-15 09:57:14.454-04	2017-03-15 09:57:14.471-04	12	69	2149	\N	\N	\N	\N	\N	1619	USD	1	-54783	-56402	888	a2ba1105-8ddd-44fc-ba97-591d7dfc1356	834	857	5dbf3ac6-4b96-4cdd-9d0b-152db859b39a
98	DEBIT	Libretas Hackathon	-1038000	MXN	2016-02-16 13:56:17.216-05	2016-06-14 14:14:21.738-04	10	7	\N	2016-06-14 14:14:22.435-04	\N	\N	\N	\N	\N	\N	\N	\N	-1038000	33	18ee4a98-66b6-47d6-85a0-0d4ead04f2d7	821	857	a9a5c0e7-c175-43d4-acc9-e05e7d34fe2b
1407	DEBIT	Leadership team dinner - Sondry interview	-11757	USD	2016-08-02 09:44:04.201-04	2016-08-02 09:44:04.214-04	14	31	320	\N	\N	\N	\N	\N	\N	\N	\N	\N	-11757	307	ba0bff8a-9a64-499e-8d6d-99cb47c0787b	766	857	a93e63d8-6ce5-4ecb-b431-4675dbfdb8c4
2839	DEBIT	Cash for Prizes/Bartender	-50000	USD	2016-11-01 11:15:55.737-04	2016-11-01 11:15:55.892-04	2	3	1044	\N	\N	\N	\N	\N	\N	\N	\N	\N	-50000	\N	5f64b05e-f6fb-4b01-adfd-950c22e3a12e	51	857	df997d2a-0ced-4767-9c54-d6950a1d9326
2938	DEBIT	dinner - downpament	-70000	USD	2016-11-03 15:36:06.461-04	2016-11-03 15:36:06.793-04	300	3	1115	\N	\N	\N	\N	\N	\N	\N	\N	\N	-70000	\N	12330ad4-6281-4e16-afad-353af55d6e65	51	857	a7898ab3-a225-4d98-95c9-2b9efff35095
2738	DEBIT	Gift Card for Volunteer	-10000	USD	2016-10-27 17:03:46.196-04	2016-10-27 17:03:46.328-04	300	3	1024	\N	\N	\N	\N	\N	\N	\N	\N	\N	-10000	\N	9783d14c-2659-46ed-948a-7e672ce73c08	51	857	8e5b30dc-5b3b-4a4e-a5e0-a71f189e5beb
3536	DEBIT	Banner	-2000	USD	2016-11-29 18:07:29.03-05	2016-11-29 18:07:29.148-05	289	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-2000	\N	c09714f1-2fc3-4fb8-a367-95d18db0ab21	51	857	feb8c4c0-4959-4958-838a-e395d9a84f3a
3802	DEBIT	Snacks and dessert	-38874	USD	2016-12-06 12:02:53.61-05	2016-12-06 12:02:54.44-05	59	3	1191	\N	\N	\N	\N	\N	\N	\N	\N	\N	-38874	\N	938601d7-a5d1-47a7-94b8-11b626ea9014	51	857	b9f10471-847a-48cc-a365-1113d3379006
3532	DEBIT	Leadership Development - speaking event	-25000	USD	2016-11-29 17:39:25.11-05	2016-11-29 17:39:25.31-05	47	3	\N	2016-11-28 19:00:00-05	\N	\N	\N	\N	\N	\N	\N	\N	-25000	\N	988e7f82-d35f-4c4e-a037-f45bf5115c05	51	857	7c15888a-e589-409d-82d0-365dcabfdea2
2326	DEBIT	Conference stipend - Gen A.	-102409	GBP	2016-10-07 09:10:14.088-04	2016-10-07 09:10:14.841-04	278	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-102409	\N	55b95c98-c784-41c3-be4b-e0f81a9a75dc	51	857	a33b56d4-b70a-48da-8195-4b33c9411c39
2233	DEBIT	Google I/O: Alicia Carr	-10000	USD	2016-10-04 11:44:35.988-04	2016-10-04 11:44:35.988-04	12	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-10000	387	7ae2b68c-c128-4dbd-a90e-a82fa24579bb	51	857	4731026f-f82d-4b1d-9611-9a6bd0d86178
2297	DEBIT	Stickers	-62984	USD	2016-10-06 11:49:20.942-04	2016-10-06 11:49:20.967-04	4	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-62984	\N	fbae4c36-1eef-4816-94f6-f9589f62ef9e	51	857	c52c7e46-264f-48b5-b65c-c5699ff85eac
2232	DEBIT	90/10 split: AT&T Sponsorship (April 2015)	-100000	USD	2016-10-04 11:44:28.558-04	2016-10-04 11:44:28.558-04	12	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-100000	389	254566c7-f97b-43d5-9910-c414520ad3bf	51	857	4ce6a154-0cab-4b17-af6a-7d85fd9e76e9
2261	DEBIT	Beverage for Denver June meetup	-2279	USD	2016-10-04 18:09:25.159-04	2016-10-04 18:09:26.045-04	15	3	573	\N	\N	\N	\N	\N	\N	\N	\N	\N	-2279	\N	392b3edc-b418-4e67-81a4-4a3310f969c7	51	857	b648b5ea-06f5-488d-a75a-5e5fbac5396f
331	DEBIT	Global Development	-10000	USD	2016-04-12 14:52:16.188-04	2016-06-14 14:14:21.849-04	59	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-10000	80	4bb6798b-e4d6-46aa-a5c3-2d0644c040c9	51	857	04a623c7-58f2-4831-930b-591328b1986f
1579	DEBIT	Minimum fee - May	-990	USD	2016-08-16 10:53:06.001-04	2016-08-16 10:53:06.015-04	13	3	573	\N	\N	\N	\N	\N	\N	\N	\N	\N	-990	\N	934eda05-b122-4c9e-8b1a-097bfb4018d7	51	857	0246e2ec-b6eb-440c-91ad-0b28e5dddec4
1575	DEBIT	Minimum Fee - June	-995	USD	2016-08-16 10:51:24.796-04	2016-08-16 10:51:24.811-04	12	3	573	\N	\N	\N	\N	\N	\N	\N	\N	\N	-995	\N	fc97ec24-7b82-4bd3-9b1a-fa6467d7a0b3	51	857	d8bd55c5-4066-40ad-a3d4-2ee39b9512ca
1578	DEBIT	Pizza for July monthly event.	-12555	USD	2016-08-16 10:52:47.781-04	2016-08-16 10:52:47.799-04	15	3	573	\N	\N	\N	\N	\N	\N	\N	\N	\N	-12555	\N	826070d5-3387-42cf-a309-b25b59fd86b1	51	857	c396dfb2-7468-4b99-b2cf-bad02ac60074
1577	DEBIT	Food for Denver Meetup	-9939	USD	2016-08-16 10:52:04.669-04	2016-08-16 10:52:04.682-04	15	3	573	\N	\N	\N	\N	\N	\N	\N	\N	\N	-9939	\N	eacc72ec-714e-4065-adde-f3d1cf5e4c95	51	857	091375f0-9182-4258-99f3-57baf5815d34
865	DEBIT	Reimburse Caterina Paun for supplies and mailing expenses	-5504	USD	2015-12-14 19:00:00-05	2016-06-14 14:14:22.175-04	59	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-5504	225	391f2946-af6d-4dad-9a31-43496d058bb4	51	857	da5ca971-c441-4fb8-921a-2dac66e75731
569	DEBIT	Conference Grant	-50000	MXN	2016-05-16 10:49:37.27-04	2016-06-14 14:14:22.052-04	10	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-50000	164	0076bcbc-8e3e-4830-87c4-d396f2cdf087	51	857	ec6b3b42-3c0a-45cb-8f7f-8975e0110686
369	DEBIT	Stacey Schipper Reimbursement	-2322	USD	2016-04-17 18:19:12.094-04	2016-06-14 14:14:21.873-04	15	3	\N	2016-06-14 14:14:22.471-04	\N	\N	\N	\N	\N	\N	\N	\N	-2322	92	570c1e94-beca-4a11-b728-e574dfead3e1	51	857	f385e73e-5e24-4546-94ff-467f7125439a
329	DEBIT	Meetup Donation Transaction Fee	-163	USD	2016-04-12 14:52:16.188-04	2016-06-14 14:14:21.849-04	4	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-163	81	6fb44ff1-4646-411e-ac08-543d20851f57	51	857	5879dbd1-cd2e-4576-ac1d-2f73354d4e41
9747	DEBIT	Google i/o travel stipend for Yelyzaveta (plus $12 transfer fees)	-101200	USD	2017-05-04 15:06:09.002-04	2017-05-04 15:06:09.002-04	430	3	\N	\N	\N	\N	\N	\N	0	USD	1	-101200	-101200	1099	796b8ada-4bee-4687-a76e-d3f79e5030cb	51	857	380e1d53-f225-4438-9035-781b0f86487e
4377	DEBIT	Meetup Fee	-6000	USD	2016-12-27 11:52:46.242-05	2016-12-27 11:52:46.242-05	274	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	640	edf1e7f7-4ad5-40bc-a2f2-e83febc89c03	51	857	a2041762-00d6-4e22-b190-144fa23a05ef
2328	DEBIT	Conference stipend Olivia F.	-39585	GBP	2016-10-07 09:35:08.613-04	2016-10-07 09:35:08.724-04	278	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-39585	\N	46f8b259-603b-459f-a2b6-c72ed0c247b7	51	857	66f1b95d-32e6-49d5-832b-a70c0e53a256
3829	DEBIT	Leadership Tshirt Order	-2698	USD	2016-12-07 11:51:43.784-05	2016-12-07 11:51:44.214-05	59	3	1191	\N	\N	\N	\N	\N	\N	\N	\N	\N	-2698	\N	1e99a559-2e7a-4e3d-be43-7fa857afba90	51	857	7caa3f23-1b94-4d72-a0c8-80ccc620d84c
3530	DEBIT	Regional Leadership Director Training	-631	USD	2016-11-29 17:38:46.551-05	2016-11-29 17:38:46.748-05	47	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-631	\N	fb0cd838-a20f-4a38-ad81-e738867085b8	51	857	15c315e9-0396-4480-b31b-f1c20773c2b3
2537	DEBIT	Director t-shirt	-3186	USD	2016-10-17 16:58:31.776-04	2016-10-17 16:58:31.789-04	271	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-3186	\N	07e896c6-1747-42c3-ac92-ea9abc902e44	51	857	79dd6530-055a-47c1-8d52-f0551e31461b
11264	CREDIT	45 webcam covers + shipping	9685	USD	2016-12-21 10:39:46.852-05	2016-12-21 10:39:47.49-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	9685	9685	\N	4d1f239e-b30e-4d8d-9d9b-f6f3444d1f93	59	857	98fd14ce-2a3a-4ac5-9b26-fcf7b6d151e3
11267	CREDIT	Meetup Fees	6000	USD	2016-12-27 11:59:33.873-05	2016-12-27 11:59:33.873-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	6000	6000	642	d0f2b490-3e86-4719-b753-0d00b13a4e4e	276	857	53d06d4c-16ae-40f1-993b-a4461aa8114b
11279	CREDIT	Cash for Prizes/Bartender	50000	USD	2016-11-01 11:15:55.737-04	2016-11-01 11:15:55.892-04	51	3	1044	\N	\N	\N	\N	\N	\N	\N	1	50000	50000	\N	ce26d7f5-ad81-457b-9d58-d9fada75cad8	2	857	df997d2a-0ced-4767-9c54-d6950a1d9326
11285	CREDIT	Stickers	62984	USD	2016-10-06 11:49:20.942-04	2016-10-06 11:49:20.967-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	62984	62984	\N	309956a9-85cd-42e6-92f4-d015daaf7f7a	4	857	c52c7e46-264f-48b5-b65c-c5699ff85eac
11288	CREDIT	Beverage for Denver June meetup	2279	USD	2016-10-04 18:09:25.159-04	2016-10-04 18:09:26.045-04	51	3	573	\N	\N	\N	\N	\N	\N	\N	1	2279	2279	\N	538b68ae-0357-413d-8b4a-faa5d2e5b138	15	857	b648b5ea-06f5-488d-a75a-5e5fbac5396f
11296	CREDIT	Conference Grant	50000	MXN	2016-05-16 10:49:37.27-04	2016-06-14 14:14:22.052-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	50000	50000	164	c25f1ce0-6f84-40e4-93c6-33301b2f5050	10	857	ec6b3b42-3c0a-45cb-8f7f-8975e0110686
11305	CREDIT	Sodas for ATXDivHack 	3871	USD	2016-10-31 17:15:22.809-04	2016-10-31 17:15:22.98-04	51	3	1043	\N	\N	\N	\N	\N	\N	\N	1	3871	3871	\N	e39b5627-feb5-48b5-82df-f753dedc33e5	2	857	888594ca-17e2-4fb9-8ccb-4bdea342d60f
11307	CREDIT	Network Budget pre Open Collective	11797	USD	2016-10-11 12:52:07.045-04	2016-10-11 12:52:07.303-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	11797	11797	\N	0995c7b3-9cf8-4c3d-a74c-67e092608bf0	59	857	0fdda3a5-71ee-4129-9422-75729d8302c0
11315	CREDIT	Minimum fee - June	1000	USD	2016-08-16 10:53:58.922-04	2016-08-16 10:53:58.936-04	51	3	573	\N	\N	\N	\N	\N	\N	\N	1	1000	1000	\N	7983f805-b5d1-4d23-b6fe-a94c0e3ac064	15	857	6948b310-f94d-4261-96ad-c8431b0d3742
11317	CREDIT	Thank you materials for several events.	6198	USD	2016-08-19 13:31:26.428-04	2016-08-19 13:31:26.891-04	51	3	573	\N	\N	\N	\N	\N	\N	\N	1	6198	6198	\N	18b26fc1-d3b5-446e-a727-c313a0dd7dd7	59	857	5ec56b21-f53d-44bb-9036-50db9868c835
11319	CREDIT	Global Development	150	USD	2016-07-08 23:52:40.722-04	2016-07-08 23:52:40.722-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	150	150	93	fd5dfbb5-c135-40a1-b545-275684a39f8f	4	857	629b08da-47fe-4d4d-a3d0-b6d077c9bfc8
11330	DEBIT	monthly recurring subscription	-798	USD	2017-05-10 00:43:13.462-04	2017-05-10 00:43:13.462-04	737	1158	731	\N	\N	647	50	\N	52	USD	1	-798	-1000	\N	49db5563-77a5-4f56-a9cb-0ff197fdfe74	241	857	eedd6ffb-2a7b-4eb8-87f0-a4a60dc42d39
11334	CREDIT	Leadership Development Lodging	64600	USD	2016-11-21 16:26:46.916-05	2016-11-21 16:26:46.916-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	1	64600	64600	\N	5eb1617e-a636-40b0-8041-4a08813f61d1	12	857	f0002f35-a096-40f5-b6f7-fa20d73971a7
11340	DEBIT	\N	-16530	USD	2016-11-30 11:11:42.049-05	2016-11-30 11:11:42.049-05	710	1957	1296	\N	\N	1215	1000	\N	470	USD	1	-16530	-20000	\N	ff1ec119-d64f-465b-838c-c0c04f7eabda	2	857	3f99d0a5-a9c3-4865-8baf-f056d1f8531c
11344	DEBIT	\N	-16530	USD	2017-01-03 15:59:37.749-05	2017-01-03 15:59:37.749-05	709	2416	1553	\N	\N	1466	1000	\N	470	USD	1	-16530	-20000	\N	f6a22b21-fe9b-47a8-a3ea-32f775f859f0	2	857	9861bbf1-cf25-4e39-928d-51b8f7e47d34
11347	DEBIT	\N	-20375	EUR	2016-11-29 05:03:23.71-05	2016-11-29 05:03:23.71-05	707	1908	1257	\N	\N	1175	1301	\N	910	USD	0.961057932572174978	-21201	-25000	\N	d8d1c901-72b1-4989-815e-0948fe3c012a	301	857	75cf1591-b9bd-4c91-af9a-e279a57a9288
3199	CREDIT	\N	50000	USD	2016-11-17 12:43:29.797-05	2016-11-17 12:43:29.797-05	59	1808	1179	\N	\N	1098	2500	5000	1130	USD	1	50000	41370	\N	2d80d646-083c-4910-a320-cda0edc1cb3b	708	857	009ab8e6-2d5c-4c54-9e5f-8846f5e4a45c
2336	CREDIT	\N	2500	USD	2016-10-07 12:49:19.978-04	2016-10-07 12:49:19.978-04	241	1446	884	\N	\N	812	125	250	85	USD	1	2500	2040	\N	2ac309ea-89ad-4880-b72a-67054d83865d	712	857	a292e6ee-7a62-4659-87b2-62069be05003
277	CREDIT	Recurring subscription	100	USD	2016-04-02 11:43:33.706-04	2016-04-16 16:40:58.808-04	13	126	93	\N	\N	95	5	10	33	USD	1	100	52	\N	6572dba9-3912-444c-96f4-5ddbec5c098c	704	857	ecc81650-5abb-4ea3-a8a0-671ae192e6ff
726	CREDIT	Recurring subscription	100	USD	2016-06-02 01:48:36.714-04	2016-06-02 01:48:36.745-04	13	126	93	\N	\N	95	5	10	33	USD	1	100	52	\N	23ced910-fe09-4e51-b681-2c4a67ec8eac	704	857	8f7cb347-de8d-4805-8907-def8b4ed04b8
466	CREDIT	Recurring subscription	100	USD	2016-05-02 01:44:10.046-04	2016-05-02 01:44:10.072-04	13	126	93	\N	\N	95	5	10	33	USD	1	100	52	\N	21f38ce7-f977-4526-92c4-f488bc43b39d	704	857	d5ddd594-035b-4ac0-80da-e0d2e6ebf9c0
6930	CREDIT	monthly recurring subscription	100	USD	2017-03-09 13:29:18.778-05	2017-03-09 13:29:18.778-05	3	8	385	\N	\N	320	5	10	32	USD	1	100	53	\N	97fbe8b4-4c66-46ec-bc2f-3432ad3db065	819	857	754cb919-f95b-4b2f-911a-eeebfc8f4f8c
8038	CREDIT	monthly recurring subscription	1000	USD	2017-04-01 19:32:24.254-04	2017-04-01 19:32:24.254-04	2	686	461	\N	\N	386	50	100	52	USD	1	1000	798	\N	b1060810-1e00-4118-b7b9-6cc529fca54a	803	857	56c60d18-f92d-4de7-9782-65ae6c85bdb0
1918	CREDIT	\N	50000	USD	2016-09-13 00:15:04.709-04	2016-09-13 00:15:04.709-04	2	1178	737	\N	\N	653	2500	5000	1130	USD	1	50000	41370	\N	578ab4ce-f187-4636-ad60-c3b5760ac10c	788	857	14520f65-7d04-4c5b-9871-a80d926a084f
995	CREDIT	Donation to WWCode Austin	75000	USD	2016-06-22 16:09:46.403-04	2016-06-22 16:09:46.432-04	2	646	435	\N	\N	364	3750	7500	2625	USD	1	75000	61125	\N	1dd2bb42-e7c2-4e79-8fc7-8949fa3a1e33	771	857	1e98e19a-4737-4c9c-a871-7b2893909921
6931	CREDIT	\N	6000	USD	2017-03-09 13:29:55.496-05	2017-03-09 13:29:55.496-05	259	3442	2104	\N	\N	2003	300	600	162	USD	1	6000	4938	\N	16affe26-a286-4782-8426-d75e1806aef8	754	857	370ac97d-52ac-447b-93a0-02fafe0dc7e0
469	CREDIT	Recurring subscription	100	USD	2016-05-02 13:46:41.832-04	2016-05-02 13:46:41.894-04	14	30	41	\N	\N	67	5	10	33	USD	1	100	52	\N	eb45eaa9-743d-437f-a0df-986c0842d91d	691	857	b1a9f8da-51aa-4bb1-a8bd-43ffe4f78bdb
2887	CREDIT	Recurring subscription	1000	USD	2016-11-01 19:32:30.439-04	2016-11-01 19:32:30.439-04	2	686	461	\N	\N	386	50	100	52	USD	1	1000	798	\N	103586f6-637d-4a72-87bc-a5f247e540e6	803	857	aa18b42d-50dd-40ba-b141-18c55703a7b6
842	CREDIT	Donation to WWCode Washington DC	100000	USD	2016-06-06 20:53:47.603-04	2016-06-06 20:53:47.649-04	13	555	381	\N	\N	316	5000	10000	2930	USD	1	100000	82070	\N	9921b890-042c-4506-b8c0-2a77793a0783	742	857	ccafa374-636a-4d89-947c-80d3aa144d8b
2310	CREDIT	\N	12500	USD	2016-10-06 14:36:38.382-04	2016-10-06 14:36:38.382-04	2	1438	880	\N	\N	808	625	1250	305	USD	1	12500	10320	\N	21b39b65-f892-4961-bed4-4648745d3d23	713	857	984e9bf9-7abf-4e2a-9f2a-31c0719a7e10
9746	CREDIT	\N	1200	USD	2017-05-04 14:58:24.9-04	2017-05-04 14:58:24.9-04	430	3	\N	\N	\N	2713	0	0	0	USD	1	1200	1200	\N	48c218d5-3e53-4a1f-88b4-485b930a9a99	857	857	0401add2-5530-43d2-a6ed-1be087f38b42
3957	CREDIT	Donation via meetup - fees and global development	775	USD	2016-12-13 15:20:15.375-05	2016-12-13 15:20:15.714-05	13	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	775	\N	2c90bf2f-4941-48ed-828c-db67f8249cc1	857	857	0514135f-eb0f-4337-8233-21f5435796e9
2430	CREDIT	Network budget pre Open Collective 	162598	USD	2016-10-12 01:01:43.648-04	2016-10-12 01:01:43.828-04	264	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	162598	\N	4ec8f1b9-f12f-4ec8-962e-29aa026ead03	857	857	0cbf3e92-b02b-49b7-95f2-2f93efbcfa86
4443	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-28 11:31:33.43-05	2016-12-28 11:31:29.837-05	294	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	c257c047-567a-47fb-b8b7-02b7f7a90b12	857	857	0ff77414-2198-4f2e-9ec1-6b7333a5db40
9698	CREDIT	\N	75000	USD	2017-05-03 13:44:10.84-04	2017-05-03 13:44:10.84-04	12	3	\N	\N	\N	2696	0	0	0	USD	1	75000	75000	\N	0d740b6b-249c-4c33-97ec-a5767b5a5799	857	857	1df05da0-ad60-4ccd-893b-526f67bde658
2307	CREDIT	Donation Pamela V.	4500	USD	2016-10-06 14:09:54.319-04	2016-10-06 14:09:54.357-04	13	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	4500	\N	20459f3e-47a2-42c8-8f77-9bdc17072479	857	857	2929d44f-d745-4707-8d7b-18fe80e8102b
407	CREDIT	Mary Griffus	1000	USD	2016-04-27 00:41:38.126-04	2016-04-27 00:41:38.474-04	13	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1000	\N	980ba0b0-ae38-48a2-9488-013c6634622b	857	857	2d5543ba-ae0a-4112-ad41-f78ccb400118
2309	CREDIT	Network budget pre Open Collective 	406519	USD	2016-10-06 14:36:30.275-04	2016-10-06 14:36:30.298-04	13	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	406519	\N	6404bfb0-eb77-4649-a55a-6fbb57c82691	857	857	2e9a5b2e-5e8f-4260-9974-b19c1fe06722
4441	CREDIT	Global Development for Meetup Fee	6000	CAD	2016-12-28 11:29:31.983-05	2016-12-28 11:29:28.409-05	293	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	3c2a09b0-ab81-4e66-8ec6-a6946e367763	857	857	57ffa29b-490a-41c0-b85e-4e7f6b63e31e
2538	CREDIT	Director t-shirt	3325	USD	2016-10-17 17:00:51.295-04	2016-10-17 17:00:51.425-04	298	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3325	\N	7b58a48c-ec76-4fd4-b285-daf541fdd4c4	857	857	5f40e924-07fc-4ce9-beac-6c3b10002037
2245	CREDIT	Donation received via Meetup, less fees	788	USD	2016-10-04 12:46:13.302-04	2016-10-04 12:46:13.487-04	12	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	788	\N	c144fa0c-6234-4fa9-ad5e-e1e1137cdb08	857	857	6075a9a1-dc87-43de-82bb-b35074a76241
2256	CREDIT	Network Development: Three Year Bonus:)	50000	USD	2016-10-04 17:52:32.839-04	2016-10-04 17:52:32.962-04	2	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	50000	\N	e2c9207b-a9aa-48e5-9d97-78fd589d86c9	857	857	65120030-5816-46e4-8b20-40523e7abd4b
2243	CREDIT	Donation via Meetup	2036	USD	2016-10-04 12:42:35.996-04	2016-10-04 12:42:36.119-04	300	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2036	\N	ed01102f-16a4-4587-97a7-eb6ba81c5728	857	857	6b54108d-7f7d-4fdf-ad41-bbea6a41fea5
2255	CREDIT	Network Development	10000	USD	2016-10-04 17:50:13.582-04	2016-10-04 17:50:13.787-04	15	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	10000	\N	42761f67-0665-4e8b-bf08-83f8d2d853dc	857	857	6b54c2cd-f63f-4326-9552-6aafe3e457db
4386	CREDIT	Global Development for Meetup Fee	4900	GBP	2016-12-27 12:32:02.798-05	2016-12-27 12:32:02.918-05	278	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	4900	\N	f57723cd-0a3e-4bf8-b686-8a60ae3e7e78	857	857	74e1c338-3687-4609-83cb-ef1a27c9223f
9714	CREDIT	\N	2175	USD	2017-05-03 20:12:19.814-04	2017-05-03 20:12:19.814-04	259	3	\N	\N	\N	2702	0	0	0	USD	1	2175	2175	\N	e7f2e24e-6899-46c4-919d-dd1cb2d3838c	857	857	7b35bce9-7183-4ae9-8caf-7f4f76add0a6
9696	CREDIT	\N	30000	USD	2017-05-03 13:33:13.688-04	2017-05-03 13:33:13.688-04	51	3	\N	\N	\N	2694	0	0	0	USD	1	30000	30000	\N	bb0ff0a8-b5fd-44c9-ab0b-bf65a00eabbe	857	857	805ba995-a678-4a5e-872a-315caeb020ed
349	CREDIT	Jasna Rodulfa	1000	USD	2016-04-15 10:17:21.126-04	2016-04-16 16:40:58.829-04	13	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1000	\N	4cb4c4ab-f5d6-4d63-a937-8af026b8759d	857	857	837bc99b-e49c-44eb-8acf-f4cf9199bfff
568	CREDIT	Women Techmaker/WWCode Partnership Grant	50000	USD	2016-05-16 16:01:14.238-04	2016-05-16 16:01:14.49-04	10	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	50000	\N	fcdb2afd-4ee1-44a6-95fb-9e1619286c8d	857	857	8a82c2a5-02f0-42dd-96cd-ad71dddc6206
2298	CREDIT	Network Development (Stickers)	62984	USD	2016-10-06 11:49:44.329-04	2016-10-06 11:49:44.472-04	4	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	62984	\N	6f7df12e-1d15-40b9-8987-ae637eede1ee	857	857	9f4e0c05-2799-4dd8-8fdc-562a9d79f617
2253	CREDIT	Network Development	10000	USD	2016-10-04 17:44:54.4-04	2016-10-04 17:44:54.58-04	2	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	10000	\N	c7d7a0f0-4ac1-4169-9368-4b6d19c4680b	857	857	a6e1d16a-6c88-4ffe-9d4c-bf6333af7c87
2254	CREDIT	Network budget balance pre Open Collective	34240	USD	2016-10-04 17:49:31.268-04	2016-10-04 17:49:31.543-04	15	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	34240	\N	ea63f818-0bf1-4576-acd3-559644fa6d35	857	857	b34aff4d-b3dc-4bf7-80e6-d25d077917d5
8175	CREDIT	Travel Stipend for CONNECT	50000	USD	2017-04-03 16:24:58.616-04	2017-04-03 16:24:58.879-04	511	3	\N	2017-04-02 20:00:00-04	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	d8baca94-1547-4dd9-ae1b-b3bdddeac823	857	857	b5a5562c-e980-4f58-a2aa-4a9edaec0d91
2301	CREDIT	Blurb donation	54000	USD	2016-10-06 12:06:35.799-04	2016-10-06 12:06:36.235-04	3	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	54000	\N	634f797f-873a-43f3-9ce9-3df9e5244c4d	857	857	b77a784c-4cdd-4fe6-a8d0-1ca760a759e5
4270	CREDIT	Global Development for Meetup Fee	4900	GBP	2016-12-23 12:55:42.091-05	2016-12-23 12:55:42.249-05	267	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	4900	\N	2acba33f-e56b-49f2-886b-86388493777d	857	857	b7f96a61-bf42-4480-b2d2-4a822c71dc33
7043	CREDIT	Women Who Code Atlanta &amp; DevNexus Soirée global networks support	1450	USD	2017-03-13 13:06:48.459-04	2017-03-13 13:06:51.099-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1450	\N	e2b2b401-0472-40e8-8d1c-84e5ad37b555	857	857	bd495fef-c3fa-493d-bf0c-0c19d90890f6
2342	CREDIT	Network Development +	50000	USD	2016-10-07 16:24:13.595-04	2016-10-07 16:24:13.706-04	300	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	50000	\N	b12c8806-5c99-46cf-8ae9-9f338888f266	857	857	c7be7e35-692f-4f6d-9650-36e89035e8db
2536	CREDIT	Director t-shirt	3186	USD	2016-10-17 16:58:21.952-04	2016-10-17 16:58:22.083-04	271	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3186	\N	ab3a189e-8523-443a-bd54-f8824c3498dc	857	857	c9bc4c3a-762e-49b3-8326-97cdd2fe8488
2404	CREDIT	Network Development	10000	USD	2016-10-11 12:52:38.277-04	2016-10-11 12:52:38.455-04	59	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	10000	\N	9c530187-e104-440b-ab25-54418876db12	857	857	cef5d97f-fdeb-44f0-9bcc-2fccc97105e1
2522	CREDIT	from Code2040	90000	USD	2016-10-17 11:43:12.71-04	2016-10-17 11:43:13.113-04	2	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	90000	\N	d37c6e91-1aa2-45bd-b13d-a4d3a6e32102	857	857	d5659c85-3aab-4882-b441-83b1501a0684
4259	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-23 12:08:24.515-05	2016-12-23 12:08:24.709-05	265	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	8106fc14-9b21-49e9-bd3c-a25e7e6d64ea	857	857	d686bddc-81cb-49d3-aa28-3c7e9e506008
2528	CREDIT	WWCode shirt Grisel	3649	USD	2016-10-17 16:48:59.282-04	2016-10-17 16:48:59.313-04	282	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3649	\N	cdb75283-fd2d-49da-81ca-b7887f3bb44b	857	857	e6ee8418-e4de-4edf-a515-5503bcbe3877
537	CREDIT	WOMEN TECHMAKER/WWCODE PARTNERSHIP GRANT	110000	USD	2016-05-10 17:15:06.327-04	2016-05-10 17:15:06.677-04	48	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	110000	\N	84415409-2268-45c1-a28e-42bbe8a9dedf	857	857	ecc6e049-64c8-4956-bc89-a16bc562d9a7
2530	CREDIT	WWCode Director t-shirt	3649	USD	2016-10-17 16:50:42.245-04	2016-10-17 16:50:42.273-04	47	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3649	\N	b8eabdbe-fc85-4747-a409-0b5a0c49f817	857	857	f46aee3c-d1ec-4f2b-845b-e3dab0a809da
9699	CREDIT	\N	15000	USD	2017-05-03 13:44:48.715-04	2017-05-03 13:44:48.715-04	51	3	\N	\N	\N	2697	0	0	0	USD	1	15000	15000	\N	0bbb8fb9-a8dc-4ee6-8a86-2bee0302b879	857	857	f84648db-6077-401e-8a71-5f57b1c44914
9658	CREDIT	\N	300000	USD	2017-05-02 14:43:43.157-04	2017-05-02 14:43:43.157-04	12	3	\N	\N	\N	2676	0	0	0	USD	1	300000	300000	\N	5e069863-b163-4534-a856-d24c10ad1c67	857	857	f968da78-b8d9-4f5b-8a5e-fdc74da7fe52
3208	CREDIT	WWCode DC t-shirts sales	9524	USD	2016-11-17 13:37:58.038-05	2016-11-17 13:37:58.232-05	13	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9524	\N	36e90498-a765-4be3-b2d7-490d8776e07c	857	857	fd9d1263-fa89-4dd7-adcb-e98f1ac39cf8
129	CREDIT	Recurring subscription	100	USD	2016-03-02 13:26:05.731-05	2016-04-16 16:40:58.833-04	13	30	44	\N	\N	70	5	10	33	USD	1	100	52	\N	73f453a9-ae3a-4ca9-82e9-cc61d3644969	691	857	55a55d62-9a76-444e-a4e5-bef99a864c96
261	CREDIT	Donation to WWCode Austin	30000	USD	2016-03-25 11:11:04.684-04	2016-04-16 16:40:58.812-04	2	192	152	\N	\N	64	0	3000	900	USD	1	30000	26100	\N	112c59b0-b10d-43fc-9d6f-a33b38dfde31	805	857	637b47cd-d1e1-48ff-9145-0da9b8cc477f
2189	CREDIT	Recurring subscription	1000	USD	2016-10-01 19:35:17.911-04	2016-10-01 19:35:17.911-04	2	686	461	\N	\N	386	50	100	52	USD	1	1000	798	\N	07c91ea8-acd4-4942-9cfd-c48cebb9daef	803	857	1ad88c22-7d6b-4245-9adf-0b6873a7d75f
837	CREDIT	Donation to WWCode Austin	150000	USD	2016-06-06 15:04:37.186-04	2016-06-06 15:04:37.308-04	2	551	377	\N	\N	312	7500	15000	4380	USD	1	150000	123120	\N	7b775e3a-0634-4723-9638-3b8d28089e89	781	857	41065c49-be6f-424d-aae0-69d53a3a2966
127	CREDIT	Recurring subscription	500	MXN	2016-03-02 13:06:23.743-05	2016-04-16 16:40:58.731-04	10	80	42	\N	\N	68	2	3	16	USD	17.8570999999999991	28	125	\N	2b05e30a-ef47-4a1e-b090-382b227c3b5b	768	857	25744c7d-32de-4fbb-b11a-76ba05036347
278	CREDIT	Recurring subscription	100	USD	2016-04-02 14:13:51.122-04	2016-04-16 16:40:58.81-04	13	30	43	\N	\N	69	5	10	33	USD	1	100	52	\N	f2a2c11a-e7c9-4578-8401-fb4e1d15e22a	691	857	25db8f90-bb76-4224-8cf4-16bb3962e3e0
281	CREDIT	Recurring subscription	100	USD	2016-04-02 15:27:54.641-04	2016-04-16 16:40:58.809-04	13	30	44	\N	\N	70	5	10	33	USD	1	100	52	\N	09102f53-5640-469e-8568-f546e4636908	691	857	5b5cbeaf-330a-490c-8de5-2ee11cc01701
3621	CREDIT	Regional Leadership Director Meeting 	7500	USD	2016-11-30 16:20:12.669-05	2016-11-30 16:20:16.148-05	269	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7500	\N	33dd6edd-aafe-4257-a57c-a3dd886e6c9a	857	857	141d1111-2b08-4877-a0b8-1936b3723742
2264	CREDIT	Diana A. Scholarship Google I/O	25000	USD	2016-10-04 18:19:06.989-04	2016-10-04 18:19:07.108-04	272	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	25000	\N	8932d7a2-35b5-4d30-b78b-729a53066393	857	857	1c5a4959-9738-465d-b5db-6e190149d67e
4267	CREDIT	Global Development for Meetup Fee	6000	AUD	2016-12-23 12:41:14.029-05	2016-12-23 12:41:14.193-05	266	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	034ce920-1702-43ca-b969-c609763c116b	857	857	1d39b3be-07e6-4975-9946-9ee20bd781ee
2332	CREDIT	Course Hero Hackathon Support	315000	USD	2016-10-07 10:39:15.069-04	2016-10-07 10:39:15.23-04	300	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	315000	\N	5c187624-870d-4c32-b10c-d952bc638fa5	857	857	1efd0e3f-33f3-4cac-8b09-7294c195bfad
4384	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-27 12:24:55.371-05	2016-12-27 12:24:55.632-05	279	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	ad4cf65e-ffab-438f-9b08-a536185a5af3	857	857	273c383e-9e83-49e3-a75c-dc68dbbf058f
2231	CREDIT	Sponsorship: AT&T Hackathon Prize	1000000	USD	2016-10-04 11:40:37.72-04	2016-10-04 11:40:37.853-04	12	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1000000	\N	4b8d36db-e5cf-4fd1-8128-a699de20993f	857	857	2cd57cf6-e3fc-4bff-93c7-29d05bcece28
3600	CREDIT	Banner	2000	USD	2016-11-30 13:40:32.021-05	2016-11-30 13:40:32.139-05	292	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2000	\N	a1457d27-e61b-45de-aadd-378b29544550	857	857	313fa8d0-9222-47a3-8ed5-dc427c1e61ca
2340	CREDIT	Hackbright support for hackathon	45000	USD	2016-10-07 16:04:15.299-04	2016-10-07 16:04:15.435-04	300	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	45000	\N	f861afb4-acee-4677-8343-79a42a833d0f	857	857	3144942f-b642-492b-885e-e46f83feb1f8
2422	CREDIT	Donation from Marie W.	900	USD	2016-10-11 20:26:47.2-04	2016-10-11 20:26:47.59-04	284	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	900	\N	39996606-f7e9-40ee-a5e1-aa68deae24b2	857	857	3198426e-213d-4b72-8f27-f8f20e640e95
4257	CREDIT	Global Development for Meetup Fee	4900	GBP	2016-12-23 12:02:53.836-05	2016-12-23 12:02:53.991-05	264	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	4900	\N	3f46c5c9-4147-486e-b8ab-7a7a89a88f9f	857	857	363a2993-8344-47a0-9875-32dac6958139
3533	CREDIT	Network Development	20000	USD	2016-11-29 17:43:53.719-05	2016-11-29 17:43:53.971-05	286	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	20000	\N	7a9cb9ef-afdd-4d85-b4b5-fa52e346eb92	857	857	3771b950-122d-47e5-a2c6-a13811970366
2431	CREDIT	Network Development (Thanks Atlassian) 	20000	USD	2016-10-12 01:06:05.058-04	2016-10-12 01:06:05.202-04	266	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	20000	\N	9549e2a9-b907-4801-8b47-6407c300e439	857	857	3c7f99a7-a1a0-426f-9f02-00903bbd5471
4382	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-27 12:02:32.71-05	2016-12-27 12:02:32.843-05	277	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	cb83b4cd-aedb-4485-a545-c318b78ca0fe	857	857	41a8399c-ff4f-4b26-95c7-5b78dcc8199e
4380	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-27 11:58:32.613-05	2016-12-27 11:58:32.719-05	276	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	52c10ec3-fc17-4bb0-80dd-b97ef1359708	857	857	45a38c13-cb16-4808-a151-a908e67ff283
2299	CREDIT	Donations via Meetup	2823	USD	2016-10-06 11:53:38.156-04	2016-10-06 11:53:38.231-04	4	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2823	\N	35ce43d6-2009-48a3-bc10-e7c08155cd01	857	857	4710a845-6d8b-4bb8-b000-298a301c8ee7
2398	CREDIT	Network Development	20000	USD	2016-10-11 12:02:18.108-04	2016-10-11 12:02:19.138-04	195	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	20000	\N	9ed15360-3e2f-4801-ac5a-2b41471bc68a	857	857	4886c6df-feb3-4c47-83cd-233a256d15b6
3537	CREDIT	Global Development - thanks VMWare	50000	USD	2016-11-29 18:07:50.964-05	2016-11-29 18:07:51.154-05	289	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	50000	\N	17513123-d08c-4153-96a9-85c8bf346bb8	857	857	5de80078-7915-4bff-89f1-6ef4da815073
2428	CREDIT	Donation from Shugo	450	USD	2016-10-12 00:30:15.825-04	2016-10-12 00:30:15.896-04	295	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	450	\N	0f702272-a446-4280-a96b-9bc994874280	857	857	6250e732-2412-457b-a30b-5790938b9dac
6882	CREDIT	Leadership Development 	14915	MXN	2017-03-07 07:55:53.128-05	2017-03-07 07:55:53.3-05	511	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	14915	\N	58f1389a-1aa3-43b7-8283-5a0d75c4e827	857	857	6c6bdffc-1758-424d-b3ba-acbf53c59209
2263	CREDIT	Network Development	17375	USD	2016-10-04 18:15:45.133-04	2016-10-04 18:15:45.269-04	272	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	17375	\N	43365b78-5277-49da-b188-6a517a926473	857	857	77559847-67a8-4a40-9a25-36d3b435edf8
2300	CREDIT	Network development	6000	USD	2016-10-06 12:01:48.321-04	2016-10-06 12:01:48.667-04	4	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	34694258-edf0-4473-b471-555bdcfddea7	857	857	85a6dbac-4f2e-40be-b685-47ba82531933
4265	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-23 12:31:16.26-05	2016-12-23 12:31:16.392-05	195	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	be353290-3a79-4837-b322-8bcf820cf681	857	857	8d928bbe-5b2e-4324-9219-3fd51d8c562e
2305	CREDIT	Google I/O scholarship	75000	USD	2016-10-06 13:21:27.384-04	2016-10-06 13:21:27.396-04	13	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	75000	\N	eb17e756-ee3f-434d-9493-8f6fbc94ea78	857	857	906ff318-b3e2-4444-9ca2-7348fdca5c36
3540	CREDIT	Donation from PB - fees 	1187	USD	2016-11-29 18:33:50.04-05	2016-11-29 18:33:50.206-05	4	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1187	\N	b1569a2e-654e-4108-9c97-de12187ef171	857	857	a3115ee7-1f41-49fc-8093-f052686cde28
2235	CREDIT	Turner Matching Donation	5000	USD	2016-10-04 11:46:59.013-04	2016-10-04 11:46:59.134-04	12	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	5000	\N	f900d59d-399a-4087-8a99-d5dc330e4483	857	857	a3bb1b9b-64ed-4520-bedf-2c0d26e816ae
2262	CREDIT	Donation via meetup	2363	USD	2016-10-04 18:14:59.695-04	2016-10-04 18:14:59.884-04	272	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2363	\N	dfb49d74-e609-4cc8-8c3e-46ff770309f3	857	857	a712ec2d-d9ac-444f-9b13-146350772d87
3612	CREDIT	Network Development	20000	USD	2016-11-30 15:59:29.087-05	2016-11-30 15:59:29.921-05	280	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	20000	\N	c26e172a-b880-40ae-96e1-245f9122cd42	857	857	a81f1687-1851-4337-8a08-ed10811d3c4d
2306	CREDIT	I am an active member and WWC has taken my career in tech to the next level. All the support and lessons from the WWC DC chapter are instrumental in me remaining in this field.	2250	USD	2016-10-06 13:23:39.409-04	2016-10-06 13:23:39.459-04	13	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2250	\N	efb89f26-5e2c-42bf-b173-27d7bf0406f9	857	857	c3c539d8-b0c5-4511-a89b-0529f94161ac
3514	CREDIT	CONNECT 2016	4536939	USD	2016-11-29 16:44:20.041-05	2016-11-29 16:44:20.185-05	14	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	4536939	\N	184f4788-f08f-4b14-9226-aaca61c2ebb3	857	857	c6fca1c0-10b6-47bc-b9f0-0edb17153a34
4372	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-27 11:38:50.944-05	2016-12-27 11:38:51.039-05	272	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	61be0f13-1f0e-4430-a69b-de48f097255d	857	857	ca079eaf-5d35-435c-a521-2339f7dda6e3
2423	CREDIT	Network Development	19100	USD	2016-10-11 20:28:02.718-04	2016-10-11 20:28:03.121-04	284	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	19100	\N	74d06361-67e4-4923-840d-82fb946093ec	857	857	cc3cc99f-569a-4615-9a68-f26b3975edde
3618	CREDIT	Banner	2000	USD	2016-11-30 16:19:37.017-05	2016-11-30 16:19:37.251-05	269	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2000	\N	d33503e6-bb6e-4b24-b7ed-01842d266e8e	857	857	cf0b9a0f-a4d7-40b9-b2bc-2fcf2d45ede6
3531	CREDIT	Regional Leadership Director Training	631	USD	2016-11-29 17:38:57.006-05	2016-11-29 17:38:57.13-05	47	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	631	\N	aeca0ae5-c39b-46b5-a46a-5a964ab43335	857	857	cfd23047-8a77-4cec-8d2c-192ce4c222d1
4374	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-27 11:48:52.922-05	2016-12-27 11:48:53-05	273	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	f81b72fd-ff9d-453c-85aa-83f26b75e23f	857	857	d6d4c77d-814e-4327-92de-cf110f5eef7f
2333	CREDIT	Hackathon Support Open Gov	45000	USD	2016-10-07 10:41:08.315-04	2016-10-07 10:41:08.391-04	300	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	45000	\N	08afa6d7-318d-47a2-8443-f19c6d9fe1a5	857	857	d9caf112-a17a-4b8c-8451-9d136d5485ea
3617	CREDIT	Global Development	20000	USD	2016-11-30 16:11:00.067-05	2016-11-30 16:11:00.307-05	294	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	20000	\N	eb089b39-6f9d-41c8-9c70-ca094bacbc0a	857	857	de30b118-7091-4703-8e89-17efcb94c86d
3620	CREDIT	Regional Leadership Director Meeting 	7500	USD	2016-11-30 16:20:06.733-05	2016-11-30 16:20:15.577-05	269	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7500	\N	5cd12a4a-4670-41f8-a215-222175234e3e	857	857	dfd71279-d6e2-4f4f-bcc2-5da322661fb1
4255	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-23 11:59:24.039-05	2016-12-23 11:59:24.291-05	263	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	6157d8ed-903e-40f6-b5d8-087f4793a4c2	857	857	dff25d55-9326-4760-b107-43f83dd0f53f
2329	CREDIT	Google I/O stipend	39585	GBP	2016-10-07 09:35:45.945-04	2016-10-07 09:35:46.151-04	278	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39585	\N	31edf1ab-fe0e-470a-b022-11a2727cd41f	857	857	e6926362-00f2-4db7-bc14-c7419ee5b750
2429	CREDIT	Network Development	19550	USD	2016-10-12 00:30:34.678-04	2016-10-12 00:30:34.772-04	295	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	19550	\N	9ddbfb06-db7c-4fa2-a325-6e69943c17fe	857	857	ed046c5d-614b-433e-a6af-c7f05210589d
66	CREDIT	Donation to WWCode Atlanta	1000	USD	2016-01-29 17:23:53.315-05	2016-04-16 16:40:58.701-04	12	30	39	\N	\N	13	0	50	59	USD	1	1000	891	\N	03ad4ae8-f8d6-4d38-88d8-d6ebf43650b9	691	857	8d08295a-233f-48bc-8893-5ea2e7f74f99
3523	CREDIT	Global Development	19100	USD	2016-11-29 17:17:18.389-05	2016-11-29 17:17:18.558-05	287	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	19100	\N	93342e23-5a6d-4557-8988-d48bda18046b	857	857	02e2e8cb-75b1-435c-8848-a15099d69a24
4360	CREDIT	Global Development for Meetup Fee	6000	MXN	2016-12-27 11:10:30.416-05	2016-12-27 11:10:30.529-05	299	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	271d48b8-2cba-40e7-bafa-e632e30dbbce	857	857	058d345c-2203-452f-bb56-903f4fb5255d
2397	CREDIT	Google I/O stipend	75000	USD	2016-10-11 12:01:42.326-04	2016-10-11 12:01:43.286-04	195	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	75000	\N	85005ce6-d4f3-4b07-98d0-ef524443de8a	857	857	0b1c37d3-abdb-49d6-ba08-be87d4b0ccbc
2236	CREDIT	Donation: Beth Laing	5000	USD	2016-10-04 11:47:24.058-04	2016-10-04 11:47:24.175-04	12	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	5000	\N	a4d7f6ff-8014-48b0-aef8-c0d0d62ef7af	857	857	257a68f1-29cf-4bf3-83fa-472534c45b8b
412	CREDIT	Andrea S	1500	USD	2016-04-27 16:05:44.711-04	2016-04-27 16:05:44.974-04	48	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1500	\N	1f5994ab-e490-47ec-af2a-97af7960004f	857	857	2860c49f-3df0-47fd-bb21-6582507854fa
2411	CREDIT	Network Development	17750	USD	2016-10-11 15:17:21.991-04	2016-10-11 15:17:22.199-04	279	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	17750	\N	f87d62ba-99de-42b8-9039-9165dfc2022b	857	857	2893bac3-fee8-45d7-8184-c6d149cd5a45
2265	CREDIT	Donation Hannah B.	9000	USD	2016-10-04 18:35:46.967-04	2016-10-04 18:35:47.153-04	273	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9000	\N	41b245bb-086f-4199-81b9-d6900db24611	857	857	2dce4e7d-3bfa-4f2e-9f4f-4557c16a6f34
3527	CREDIT	Banner	2000	USD	2016-11-29 17:34:22.96-05	2016-11-29 17:34:23.085-05	47	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2000	\N	3097b9bd-e10a-4598-bd6d-b035d0f33f73	857	857	316c2403-9435-4fd6-b50e-875509e5b0e1
3543	CREDIT	Donation via Meetup	775	USD	2016-11-29 18:39:08.069-05	2016-11-29 18:39:08.263-05	300	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	775	\N	d13f4546-ddb3-4403-8ffa-3e94709cd39e	857	857	3978bda7-5e72-4742-b813-a0a5dd960310
4376	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-27 11:52:05.93-05	2016-12-27 11:52:06.061-05	274	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	59f7ddd7-ade8-4ebf-977e-cb823b5ab4cd	857	857	42e9b44f-80b6-491c-83a3-3aa4ba32695e
3528	CREDIT	Regional Leadership Director Training 	13031	USD	2016-11-29 17:35:05.252-05	2016-11-29 17:35:05.379-05	47	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	13031	\N	ce5bf007-5b83-46b2-b82b-17ef62e16627	857	857	467bbcf0-7f8c-4c29-bd37-3d960f697660
667	CREDIT	Proceeds from teespring	10022	USD	2016-05-26 14:38:50.077-04	2016-05-26 14:38:48.41-04	48	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	10022	\N	dce42eaa-b86f-4baa-ac29-a12e270cd434	857	857	47257e5b-aead-4b84-ae31-51f50919848b
306	CREDIT	Leslie Mollner: Thank you very much for all the help I've received from WWCode -TC so far. -Leslie	2250	USD	2016-04-06 14:17:07.204-04	2016-04-16 16:40:58.818-04	48	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2250	\N	d96508af-a33c-42bc-9446-bc438652e8a8	857	857	47c77ff3-fdbc-4006-b3a3-426b2a8320b5
5017	CREDIT	WWCode t-shirt sales	4397	USD	2017-01-17 22:20:52.226-05	2017-01-17 22:20:52.436-05	273	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	4397	\N	232dcd17-1057-4c79-ade5-b368a259f68f	857	857	4c75e063-bba0-49c9-8872-9663868a41bb
3541	CREDIT	Global Development	20000	USD	2016-11-29 18:34:32.59-05	2016-11-29 18:34:32.817-05	259	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	20000	\N	3930af5b-22e9-43a5-b3b5-4c28e21c4a3b	857	857	56bf4c0b-6f72-4445-b133-62ca54171c27
3525	CREDIT	Network Development	2500	USD	2016-11-29 17:29:22.958-05	2016-11-29 17:29:23.167-05	282	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2500	\N	a973cade-bced-498a-aaf3-f6a4f60ca02e	857	857	63bd820d-e310-4d69-98ab-aa1f756ff13a
2414	CREDIT	Network Development	17500	USD	2016-10-11 15:35:59.115-04	2016-10-11 15:35:59.305-04	301	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	17500	\N	bd1df48d-4123-4817-b44a-698351ad76c5	857	857	6421d404-4859-4b01-b484-6c613ab3f67a
5016	CREDIT	WWCode Boston t-shirt sales	1964	USD	2017-01-17 22:19:47.816-05	2017-01-17 22:19:48.024-05	195	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1964	\N	06f8f818-4527-4882-a50c-40de00ed8711	857	857	681a14e4-aa04-4302-b7df-9efc4f702ac2
2413	CREDIT	Donation from Biotti	403	USD	2016-10-11 15:32:58.956-04	2016-10-11 15:32:59.265-04	301	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	403	\N	b07d171f-6a06-4bf1-b5ab-44b28a4d2fe6	857	857	6983ddef-3936-41f4-b56f-116dc4f41165
4405	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-27 14:44:22.123-05	2016-12-27 14:44:22.207-05	287	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	3407cb90-d12e-4698-ae45-68a7626be287	857	857	6abcfc7b-a15c-4276-8266-75157b82acec
2410	CREDIT	From Lucas in honor of Rachel M. She learned Python and HTML/CSS	2250	USD	2016-10-11 15:13:57.013-04	2016-10-11 15:13:57.265-04	279	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2250	\N	9a09da05-1e08-4b56-b452-1236e02b2a92	857	857	6bb0b7ea-1a01-409a-8639-d3cd00c0a49b
2242	CREDIT	Reverse duplicate transaction	500	USD	2016-10-04 12:12:26.671-04	2016-10-04 12:12:26.903-04	12	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	500	\N	bfa51ebc-0ab7-4ed8-9f4e-e4862bf271ba	857	857	6da26700-e573-4cd3-825d-8540d9e4a5a9
3510	CREDIT	Global Development	80000	GBP	2016-11-29 16:14:00.118-05	2016-11-29 16:14:01.107-05	278	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	80000	\N	1a0ffc67-8650-41fd-b3ff-7af4d6f81cbc	857	857	6e23be83-aeae-4513-bd40-3dafda0f0fb5
9659	CREDIT	\N	60000	USD	2017-05-02 14:45:44.253-04	2017-05-02 14:45:44.253-04	51	3	\N	\N	\N	2677	0	0	0	USD	1	60000	60000	\N	3c6bb7c3-caff-4599-b462-6a53ea05cb0b	857	857	76a6b34c-950c-4160-9f3a-d58653783379
2331	CREDIT	Network Development	15755	GBP	2016-10-07 10:03:54.031-04	2016-10-07 10:03:54.119-04	278	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	15755	\N	61afdaf6-bfb9-4948-bca0-bd656fbc2d6f	857	857	78a0e602-07cd-4cea-923e-2921af8ba115
3542	CREDIT	Donation from Margaret - fees	2012	USD	2016-11-29 18:37:14.82-05	2016-11-29 18:37:15.082-05	272	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2012	\N	3e72e75f-912e-4507-8a12-e73a2a2baecb	857	857	7d0406cd-6904-4037-879b-6e0594da132d
333	CREDIT	From Deepa	1500	USD	2016-04-12 17:18:56.547-04	2016-04-16 16:40:58.847-04	4	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1500	\N	886f2733-7967-4b61-93c1-f8242037a5a4	857	857	8b2d652b-5216-455e-a2f7-10647c5beaf0
3544	CREDIT	Donation via meetup	775	USD	2016-11-29 18:39:42.382-05	2016-11-29 18:39:42.512-05	13	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	775	\N	00e31b6f-e424-4f4b-b51e-73cc1c290081	857	857	8f54652f-54d9-4edf-a1cc-503303e05e68
499	CREDIT	Women Techmaker/WWCode partnership grant	50000	USD	2016-05-04 17:17:27.653-04	2016-05-04 17:17:27.886-04	13	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	50000	\N	c81e5698-25db-421e-80ce-4c04a817e59c	857	857	9c4cc495-5200-4f25-8855-78f2e734f469
325	CREDIT	From:\tThao Le	1500	USD	2016-04-12 14:49:06.645-04	2016-04-16 16:40:58.815-04	4	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1500	\N	1a6b4663-7869-49ba-9691-9b3bec6843c4	857	857	a14b43da-2557-403e-aaa1-8bad61c68c59
4188	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-21 13:49:47.667-05	2016-12-21 13:49:47.892-05	2	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	74434b16-1798-42d0-92da-547acdf24d48	857	857	a467cb2b-868f-47d5-aaed-ced232702d6e
3547	CREDIT	Network Development	20000	USD	2016-11-29 19:23:24.87-05	2016-11-29 19:23:24.511-05	285	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	20000	\N	c97c359c-7c4d-491a-9489-1423fc900fd1	857	857	a9e92dc9-25d5-446c-8440-10a922e510a3
2421	CREDIT	Donation Elizabeth B.	9000	USD	2016-10-11 20:22:08.455-04	2016-10-11 20:22:08.557-04	288	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9000	\N	d6590406-0ffc-489f-ab6a-3436c8be0d3a	857	857	b1fd7136-57da-40fc-8018-441b941ba197
4407	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-27 14:48:41.246-05	2016-12-27 14:48:41.318-05	288	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	0764379a-89bf-4a0b-b3cf-02ced834e7c3	857	857	b958e108-3e79-4d0a-b1c9-2d66d2fc6158
3520	CREDIT	Global Development	15600	USD	2016-11-29 17:08:18.065-05	2016-11-29 17:08:18.213-05	241	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	15600	\N	adf0f06c-e558-411f-8551-6c08eaf62de1	857	857	be29d23b-9b29-4c81-8416-3ebde1421789
2234	CREDIT	Donations made via Meetup as of Jan 2016, less transaction fees	9212	USD	2016-10-04 11:46:17.845-04	2016-10-04 11:46:18.02-04	12	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9212	\N	5af62e78-2976-4c04-aaab-f3c34f1297e7	857	857	c1e06911-ef28-4ba5-ab16-f5f228e181a2
2418	CREDIT	Network support - Regional Leadership (thanks VMWare)	370000	USD	2016-10-11 15:51:45.723-04	2016-10-11 15:51:45.897-04	262	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	370000	\N	90107c21-9ee4-41e1-b930-b991cd649629	857	857	c537c49b-cae3-4697-8bc7-4ebec29b7159
3629	CREDIT	Global Development - Thanks VMWare	50000	USD	2016-11-30 16:34:00.324-05	2016-11-30 16:34:01.658-05	263	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	50000	\N	a8125046-2c82-43f8-bf5a-3930226ad6d9	857	857	c6fd0248-2ece-4617-8ae8-2b156a417ca9
2416	CREDIT	Network support - thanks VMWare	200000	USD	2016-10-11 15:50:00.045-04	2016-10-11 15:50:00.312-04	262	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	200000	\N	a4e80a28-1270-4c9e-870c-de3011dd78c7	857	857	cc8854fb-fa73-401a-9b97-038c67be7fdf
2415	CREDIT	Donation Ailia S.	9000	USD	2016-10-11 15:44:42.807-04	2016-10-11 15:44:43.161-04	270	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9000	\N	37933bd0-775c-4ff6-914b-9be5c19aec41	857	857	d1c7a4d4-915c-4061-af4d-34df0dde8688
1042	CREDIT	Donation from MondoRobot & Avery Brewing Company: Hackathon Proceeds	320247	USD	2016-06-29 14:42:31.848-04	2016-06-29 14:42:32.517-04	15	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	320247	\N	3f5141a2-01ec-4026-8ebd-f1d232237947	857	857	d680641c-abc8-45bc-bca4-73e113c57ed0
3627	CREDIT	Banner	2000	USD	2016-11-30 16:33:30.25-05	2016-11-30 16:33:30.386-05	263	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2000	\N	d7f0bea9-9ed6-4ec6-aada-f8d3fe14c421	857	857	da7ad689-969d-4d74-8792-8236c6bb6d88
4409	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-27 14:51:47.92-05	2016-12-27 14:51:48.117-05	14	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	9f8c45b8-537c-4f0f-bb8a-928b528feab2	857	857	e0afd47a-10b7-4734-8c3e-ce96d563fc8a
2420	CREDIT	Network Development (Thanks Zendesk)	16129	USD	2016-10-11 16:26:22.964-04	2016-10-11 16:26:23.172-04	298	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	16129	\N	2b973f59-80ae-4046-996e-35e967509adc	857	857	e39807df-d9f3-4367-8c7e-54dd91d52764
2419	CREDIT	Network Development	20000	USD	2016-10-11 16:03:19.884-04	2016-10-11 16:03:20.084-04	271	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	20000	\N	b5dcca3b-559b-4c43-83ff-a31cd387d1f2	857	857	ecd8394f-1881-4928-bd39-87d67b2ec31b
3522	CREDIT	Erica S. donation - fees	450	USD	2016-11-29 17:12:36.336-05	2016-11-29 17:12:36.503-05	287	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	450	\N	e671d019-152e-4857-b2d0-2d1a5545e33d	857	857	f1fa1b76-776f-4ad8-b56c-bf348e04f9d3
2267	CREDIT	Network Development	15400	USD	2016-10-04 18:39:26.796-04	2016-10-04 18:39:26.9-04	273	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	15400	\N	d40d88e7-8e48-43d2-b629-62c123b275bf	857	857	f89d9896-22af-4257-bd3d-f546c22c96ed
2237	CREDIT	Donation: Syema Ailia	2500	USD	2016-10-04 11:47:46.468-04	2016-10-04 11:47:46.624-04	12	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2500	\N	445859c1-2d38-4be2-8d47-7b91e62aad55	857	857	fb6c3a02-639c-48ec-9062-74fb13dbd874
8350	CREDIT	monthly recurring subscription	100	USD	2017-04-09 14:28:49.104-04	2017-04-09 14:28:49.104-04	3	8	385	\N	\N	320	5	10	32	USD	1	100	53	\N	1ecffc14-65af-42e5-933f-1520f76d4685	819	857	4658e3a5-68e2-4298-8fd9-476f719cf93a
8398	CREDIT	\N	25000	USD	2017-04-10 21:09:50.621-04	2017-04-10 21:09:50.621-04	13	4153	2535	\N	\N	2421	1250	2500	580	USD	1	25000	20670	\N	d4c8f44d-4c88-4533-87da-1bd5b6f1f16b	842	857	6775310c-b72b-4847-b08e-9805014974b4
857	CREDIT	Recurring subscription	100	USD	2016-06-09 13:28:30.802-04	2016-06-09 13:28:30.841-04	3	8	385	\N	\N	320	5	10	33	USD	1	100	52	\N	78157dc7-3c5e-4ff2-a9ce-819906bd27fc	819	857	7bfcd82b-3824-4271-a190-c735e93cce4a
4586	CREDIT	Recurring subscription	1000	USD	2017-01-01 18:32:21.416-05	2017-01-01 18:32:21.416-05	2	686	461	\N	\N	386	50	100	52	USD	1	1000	798	\N	630da817-bfc6-4c3e-8ef4-45d11c81e37e	803	857	f931abed-f721-4561-8287-6c8e4f1c700c
8365	CREDIT	monthly recurring subscription	1000	USD	2017-04-10 00:43:06.965-04	2017-04-10 00:43:06.965-04	241	1158	731	\N	\N	647	50	100	52	USD	1	1000	798	\N	a25de37e-df40-4317-90a5-36e217a8ba46	737	857	da55f5ff-aa9c-425a-b558-0fb257ef541c
2406	CREDIT	Network Development	18200	USD	2016-10-11 13:02:51.621-04	2016-10-11 13:02:51.839-04	291	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	18200	\N	8bc77fb9-7ed7-4099-91aa-18899658861b	857	857	106c8237-a0f0-454b-bf56-c77f5443b40d
2270	CREDIT	Network Development	13286	USD	2016-10-04 18:57:17.136-04	2016-10-04 18:57:17.293-04	260	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	13286	\N	7382b702-3956-405b-b6af-b9d1b04e89ba	857	857	121aa478-d522-4261-9d96-b8dc531d7d8e
5026	CREDIT	WWCode t-shirt sales	4742	USD	2017-01-17 22:31:50.631-05	2017-01-17 22:31:50.774-05	2	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	4742	\N	971f4ef3-3672-4497-8b8e-863c2c187206	857	857	1a2a9657-2411-47ba-97d6-7859927031ac
3204	CREDIT	$1000 Mozilla hackathon support - Global Development	90000	USD	2016-11-17 13:21:06.154-05	2016-11-17 13:21:07.268-05	59	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	90000	\N	646702d0-fba2-4ee2-8e90-8c8871732cac	857	857	27e84d4a-5125-460d-a160-640f89ef7980
4395	CREDIT	Global Development for Meetup Fee	6000	MXN	2016-12-27 12:59:52.939-05	2016-12-27 12:59:53.047-05	10	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	52f1331f-b669-4782-b63a-984ccb097928	857	857	27fe73bb-fd67-4a9c-a21d-47233c8c41e5
2534	CREDIT	Director t-shirt	2898	USD	2016-10-17 16:57:08.514-04	2016-10-17 16:57:08.533-04	3	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2898	\N	bbf57164-512a-42db-baa3-b91df0b4080c	857	857	2f7c6e12-f05c-473e-823f-a257d721bd91
4370	CREDIT	Global Development for Meetup Fee	5700	EUR	2016-12-27 11:34:45.59-05	2016-12-27 11:34:45.771-05	298	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	5700	\N	7c5dc3dd-2211-4c62-bdf3-1d1bff4db06a	857	857	36493410-978b-4ea4-a1d4-bec57607bfd2
4393	CREDIT	Global Development for Meetup Fee	6000	MXN	2016-12-27 12:56:03.911-05	2016-12-27 12:56:03.985-05	282	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	910351cc-fb5f-43ea-bccb-fa3a211093a7	857	857	3816d92b-0193-4261-a649-54ca1df0cdd8
7556	CREDIT	International Women's Day Atlanta	10350	USD	2017-03-28 14:28:28.77-04	2017-03-28 14:28:28.938-04	51	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6c8e7d6b-bcd8-44bc-a3c8-ab4f3fb6b3b5	857	857	38380fb3-3c7d-4ed0-97c6-bb771dc5c9fb
3205	CREDIT	$5000 Intel Hackathon support - global development	450000	USD	2016-11-17 13:23:08.268-05	2016-11-17 13:23:08.461-05	59	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	450000	\N	6b086a9f-6727-4f05-85cd-8f84aa7c79dd	857	857	460d718f-5941-4c48-b4f5-e06dff1b49f1
5029	CREDIT	WWCode t-shirt sales	7570	USD	2017-01-17 22:34:31.424-05	2017-01-17 22:34:31.75-05	300	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7570	\N	98fcd6a4-bf53-4bc0-8277-7935794a138b	857	857	4c136ddc-c105-4a3e-b47f-9d448f0bada0
5023	CREDIT	WWCode t-shirt sales	1964	USD	2017-01-17 22:29:40.155-05	2017-01-17 22:29:40.284-05	273	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1964	\N	6dc8501e-0ceb-40ab-b920-9dc4d4de6ce3	857	857	4d60d400-61c9-4ef6-b9ab-a41a5c9b912d
702	CREDIT	WOMEN TECHMAKER WWCODE PARTNERSHIP GRANT	80000	USD	2016-05-31 14:01:08.532-04	2016-05-31 14:01:07.064-04	13	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	80000	\N	8c1d5f60-5e9f-4262-966c-0b0006e7d309	857	857	4de2e61e-353d-4d8b-9288-d5b140b24ddc
659	CREDIT	Women Techmaker WWCode Partnership Grant	20000	USD	2016-05-25 12:45:53.797-04	2016-05-25 12:45:54.045-04	48	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	20000	\N	b0965077-da41-4ea3-9ff4-a25d7be1a3b6	857	857	4e16210d-0b35-44aa-9b79-6ce838d01d19
9848	CREDIT	\N	16563	EUR	2017-05-08 11:30:18.585-04	2017-05-08 11:30:18.585-04	301	3	\N	\N	\N	2741	0	0	0	EUR	1	16563	16563	\N	04ec7dd9-0032-4318-99fa-52e21ff493ee	857	857	4f473854-3613-4a98-bb6c-cd915cbadf73
3518	CREDIT	Global Development	20000	USD	2016-11-29 16:56:45.442-05	2016-11-29 16:56:45.713-05	290	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	20000	\N	6323fec2-eb32-4b9b-9134-9d658f2efe40	857	857	53ad6d74-130a-40d7-94c2-b57853a3b87b
673	CREDIT	WOMEN TECHMAKER WWCODE PARTNERSHIP GRANT	50000	USD	2016-05-26 16:48:43.015-04	2016-05-26 16:48:43.336-04	59	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	50000	\N	93c08587-c4fb-4077-9f65-00b8920ce72e	857	857	5c17f156-0581-44a0-a2ae-8cbc3078f2a7
2312	CREDIT	Network Development (100%)	10000	USD	2016-10-06 14:42:47.682-04	2016-10-06 14:42:47.71-04	13	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	10000	\N	655af063-49c8-4b0b-9288-086d5e290e34	857	857	60055c4f-14d4-4947-abda-ef9217563ceb
2405	CREDIT	Donation Scott Z. in honor of his sister	1800	USD	2016-10-11 13:01:23.313-04	2016-10-11 13:01:23.731-04	291	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1800	\N	99b8d53c-6e5b-40ee-a937-5d414c12adc6	857	857	6125d794-44d0-46d2-8449-eeeabc4025d8
653	CREDIT	Women Techmaker WWCode Partnership Grant	15000	USD	2016-05-24 16:12:34.913-04	2016-05-24 16:12:35.226-04	13	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	15000	\N	4ec3f9b1-a7c7-4887-b029-6a3f17ada0c4	857	857	65f4c461-0378-46bf-9145-acba2d84008e
3200	CREDIT	Portland t-shirt proceeds	6915	USD	2016-11-17 13:01:32.1-05	2016-11-17 13:01:32.49-05	59	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6915	\N	c96721bd-c150-4300-b6b9-144a4019cefb	857	857	6654dcaf-6b14-4da8-9b23-414c9d74ccff
3201	CREDIT	T-shirt payout	1092	USD	2016-11-17 13:03:13.726-05	2016-11-17 13:03:13.862-05	59	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1092	\N	c83bd839-4222-4e75-b71b-afe58b183300	857	857	6df829d3-8072-46a5-a86a-4f4547a64b26
5027	CREDIT	WWCode t-shirt sales	1389	USD	2017-01-17 22:32:30.654-05	2017-01-17 22:32:30.825-05	15	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1389	\N	166cbb4b-156f-4b77-84d3-a7b2bba53d7f	857	857	7ba01fe1-dcf5-41bf-b093-70098b25cac7
7374	CREDIT	Leadership Development: Google I/O grant for Luisa M.	100000	USD	2017-03-22 13:56:10.528-04	2017-03-22 13:56:10.804-04	3	3	\N	\N	\N	\N	\N	\N	\N	USD	1	\N	100000	\N	3144121e-26df-4745-84f9-51b0af25530c	857	857	86a60d8f-36a3-48ca-8ce0-3f89fab2730b
4430	CREDIT	Global Development for Meetup Fee	6000	AUD	2016-12-28 10:55:25.022-05	2016-12-28 10:55:21.475-05	297	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	1fa71cb1-e48d-4b0c-b102-30d66d120a1e	857	857	8a50dec8-e8ca-4a58-a350-d6d40e08679d
5024	CREDIT	WWCode t-shirt sales	982	USD	2017-01-17 22:30:10.748-05	2017-01-17 22:30:10.906-05	259	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	982	\N	35f3b1a6-7368-418d-9a03-f1da4b5de91f	857	857	a0138364-7fbc-47c2-87cd-3c0649e781ee
3534	CREDIT	Stephen	450	USD	2016-11-29 17:55:31.534-05	2016-11-29 17:55:31.727-05	273	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	450	\N	bc8ea724-7089-4d7e-80dc-6ed375a7bc76	857	857	a611b04a-de08-4000-bcab-e4207926a18c
5031	CREDIT	Donation via meetup	775	USD	2017-01-17 22:48:10.558-05	2017-01-17 22:48:10.699-05	272	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	775	\N	060c2bcb-850a-442e-96a3-907124fbb5e6	857	857	a7d25bad-a0d5-4a9e-98a0-c53a0e969b43
2269	CREDIT	Donation from Adane	450	USD	2016-10-04 18:56:11.881-04	2016-10-04 18:56:13.02-04	260	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	450	\N	ea31005b-cb3b-42d7-9b8c-1c812558ee14	857	857	ab5f91b2-7715-4e57-9c27-9b2ade14b176
2268	CREDIT	Network budget pre Open Collective	6264	USD	2016-10-04 18:51:25.324-04	2016-10-04 18:51:26.129-04	260	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6264	\N	2bd3e74c-84e0-43e2-a21d-b9443200eedc	857	857	b3b7cddb-5541-4350-aa77-e409abe2c332
4702	CREDIT	Donation - fees + global development	1187	USD	2017-01-05 09:58:39.771-05	2017-01-05 09:58:42.205-05	13	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1187	\N	9eb3b1c1-578e-4b80-be38-c28a2c634474	857	857	bc5b13ae-0c57-43c0-ac61-11325a6ee3eb
4397	CREDIT	Global Development for Meetup Fee	5700	EUR	2016-12-27 13:10:14.864-05	2016-12-27 13:10:14.928-05	283	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	5700	\N	f09463dc-da20-4c6a-95fc-b96c106b3d00	857	857	d2058375-56ce-4a59-8c9c-92cf66c2e6e3
4701	CREDIT	donation - fees and global development	798	USD	2017-01-05 09:48:24.355-05	2017-01-05 09:48:26.734-05	241	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	798	\N	42c8ea1c-5292-4ee1-8768-97d910be5fe2	857	857	d42220ba-3283-4df9-b63d-912e9d1220a4
4426	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-28 10:46:26.348-05	2016-12-28 10:46:22.824-05	300	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	549184b8-9951-44b3-804f-5306177e8ec1	857	857	d6baf0e0-d5f9-49eb-acab-a88e90ee258b
4378	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-27 11:53:55.856-05	2016-12-27 11:53:55.969-05	275	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	aa3d7224-7382-4f6f-a0f5-2949228f2339	857	857	e05f5031-9b70-4451-9b02-66209d4114b6
5025	CREDIT	WWCode t-shirt sales	2778	USD	2017-01-17 22:30:54.132-05	2017-01-17 22:30:54.465-05	3	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2778	\N	bf1209ff-a6ec-4161-8120-65342983d214	857	857	e18b08fe-c669-4bbd-af27-8e4dc1043b8f
5022	CREDIT	WWCode t-shirt sales	1106	USD	2017-01-17 22:29:09.407-05	2017-01-17 22:29:09.561-05	14	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1106	\N	ee1df537-bb8d-44e0-ada4-42c56888c466	857	857	e7c07836-6353-4130-ad45-cf80d7cce80b
4677	CREDIT	Donation from Cameron - fees and global development	4350	USD	2017-01-04 15:33:36.359-05	2017-01-04 15:33:37.475-05	259	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	4350	\N	79fb7110-6a80-49d9-9d52-eca9ba262867	857	857	ea262323-607a-4660-9337-30a6ab0ad6d0
4402	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-27 13:37:31.611-05	2016-12-27 13:37:31.721-05	59	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	4d7adb92-d878-4a73-9f39-2c1f66559ba7	857	857	ed5e7690-1ee2-46d8-aa49-f0a9ad782e97
4391	CREDIT	Global Development for Meetup Fee	6000	AUD	2016-12-27 12:52:16.09-05	2016-12-27 12:52:16.167-05	281	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	6f001acd-c75e-4d02-a339-faede0477c42	857	857	f06c085e-9131-40e1-a69b-49f43a043568
4400	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-27 13:33:56.275-05	2016-12-27 13:33:56.372-05	284	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	2f11fdfd-c8b2-4a58-8669-76610d85ac20	857	857	f68b42ed-1f9c-44a2-9c06-f91a98368e56
4432	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-28 10:57:55.359-05	2016-12-28 10:57:51.831-05	241	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	0deb855b-d632-43c8-a2e3-f90f0db86bb4	857	857	feb1b7fc-846f-4469-ac17-88bbf538c9a3
4284	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-23 14:48:39.526-05	2016-12-23 14:48:39.685-05	270	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	cc5c76d9-46e6-4435-8ec6-f0328e93c66c	857	857	021ea432-c8b9-47b1-a087-d11a98cdae64
4363	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-27 11:14:47.836-05	2016-12-27 11:14:47.951-05	271	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	e496c717-ce4a-41a6-b861-8eae2c81db9c	857	857	0b4d9711-eb14-40a5-aad5-e93397374037
8617	CREDIT	\N	41000	GBP	2017-04-17 18:31:52.729-04	2017-04-17 18:31:52.729-04	278	3	\N	\N	\N	2486	0	0	0	GBP	1	41000	41000	\N	463ec0d3-ae29-42e5-97ee-277cca8ceca9	857	857	15fe03d2-b134-41fa-9216-9fed2adbd399
8671	CREDIT	\N	1198	USD	2017-04-18 20:19:14.321-04	2017-04-18 20:19:14.321-04	12	3	\N	\N	\N	2505	0	0	0	USD	1	1198	1198	\N	ff39b4d0-ec21-448e-a987-b2cf172c5bdc	857	857	2542a4b0-e38e-4160-aa99-3c9554b85490
8664	CREDIT	\N	3562	GBP	2017-04-18 15:41:30.286-04	2017-04-18 15:41:30.286-04	278	3	\N	\N	\N	2503	0	0	0	GBP	1	3562	3562	\N	0557cec2-bc9a-43c5-a702-38116a1ab389	857	857	2620cd06-d6aa-41ff-a22a-52d8c07e80c1
4248	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-23 11:45:15.022-05	2016-12-23 11:45:15.147-05	261	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	34260b9e-5cfa-458e-9861-4b037755571a	857	857	26d0a91a-685b-4369-a20b-f44fefdf9da8
8621	CREDIT	\N	2200	MXN	2017-04-17 18:35:55.014-04	2017-04-17 18:35:55.014-04	511	3	\N	\N	\N	2489	0	0	0	MXN	1	2200	2200	\N	a30d7b67-9e28-40c1-a02c-9fd585600114	857	857	2a714010-92a1-46ec-86bb-3c44d3eb9282
4439	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-28 11:27:36.9-05	2016-12-28 11:27:33.309-05	292	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	23d6372f-2d2d-4cbb-afee-5a05e2ef89ce	857	857	2fe08efc-1f65-4e3c-82eb-70cc4b462a78
7667	CREDIT	\N	39800	GBP	2017-03-31 14:01:48.418-04	2017-03-31 14:01:48.418-04	278	3	\N	\N	\N	2209	0	0	0	GBP	1	39800	39800	\N	f38d81a7-0640-43e1-adaa-eae03b43254a	857	857	31745c67-cdeb-485e-ad15-3f61cda10313
4437	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-28 11:24:49.292-05	2016-12-28 11:24:45.838-05	48	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	1f4c7218-151d-4502-a979-3271e65d57da	857	857	320ad09e-b535-4551-be83-ae6e1bceef36
8624	CREDIT	\N	100000	USD	2017-04-17 18:40:40.357-04	2017-04-17 18:40:40.357-04	430	3	\N	\N	\N	2490	0	0	0	USD	1	100000	100000	\N	37a49008-00ca-489c-876a-6d26c25a46bb	857	857	33937e0d-86d5-4b38-9e73-4e25b445e881
4404	CREDIT	Global Development for Meetup Fees	6000	USD	2016-12-27 13:40:49.86-05	2016-12-27 13:40:49.921-05	286	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	84192755-dac6-4b18-996a-89fe17acc8d1	857	857	34cd07ce-7b79-4226-9d08-fbf7aaf6bab2
8305	CREDIT	\N	20000	USD	2017-04-07 08:25:51.09-04	2017-04-07 08:25:51.09-04	516	3	\N	\N	\N	2393	0	0	0	USD	1	20000	20000	\N	01371a79-bfe1-455d-9fae-8901be6f2dbe	857	857	369700f8-926d-40c9-bafb-80d852f5a6cb
4252	CREDIT	Global Development for Meetup Fees	6000	USD	2016-12-23 11:54:04.928-05	2016-12-23 11:54:05.055-05	262	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	084b10da-1bc1-4f57-84d2-3f7089d7c993	857	857	36fd9da6-3b12-45cc-ab3a-1dcf02722a34
614	CREDIT	Women Techmaker WWCode Partnership Grant	70000	USD	2016-05-19 15:17:47.24-04	2016-05-19 15:17:48.401-04	3	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	70000	\N	ddd97a2d-71eb-4643-aae4-af9a7e7fad4e	857	857	3ebbb089-0d33-4b3e-af32-8b2a03b576ad
4389	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-27 12:48:49.207-05	2016-12-27 12:48:49.297-05	280	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	076d787a-dbfb-4781-b854-e3cd9da444ec	857	857	41b75642-0d55-4ce9-b0a5-bb3d45ca52d5
4250	CREDIT	Global Development for Meetup Fees	6000	USD	2016-12-23 11:50:35.869-05	2016-12-23 11:50:36.131-05	12	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	7adbc52c-6996-4d28-899c-835e1561a1b0	857	857	4f2e681e-55c9-4c67-9eaa-2e9d5e0f6422
675	CREDIT	WOMEN TECHMAKER WWCODE PARTNERSHIP GRANT	34750	USD	2016-05-26 16:50:28.413-04	2016-05-26 16:50:28.721-04	59	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	34750	\N	5dc5651e-3b65-4b03-aa66-30990d7efb15	857	857	52559260-4928-4453-a298-1b9dfd7cc130
7687	CREDIT	\N	7500	USD	2017-03-31 18:52:45.079-04	2017-03-31 18:52:45.079-04	286	3	\N	\N	\N	2215	0	0	0	USD	1	7500	7500	\N	a8c774d9-c22c-4df9-a8a2-7b7fb56da05c	857	857	54aba17d-9c1c-45a0-800a-6058158a1350
7665	CREDIT	\N	80500	GBP	2017-03-31 13:54:33.461-04	2017-03-31 13:54:33.461-04	278	3	\N	\N	\N	2208	0	0	0	GBP	1	80500	80500	\N	d7f6d62d-4f73-400b-ac9e-57bcfac50780	857	857	57341510-849e-4ffa-bdd0-0cd943049418
4368	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-27 11:30:02.12-05	2016-12-27 11:30:02.272-05	15	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	69ec7f71-fdf4-4fc1-a013-bcdf6353b94c	857	857	5ea33403-2a6e-4edb-a01c-15e81630b4a1
8612	CREDIT	\N	4250	GBP	2017-04-17 17:06:54.803-04	2017-04-17 17:06:54.803-04	278	3	\N	\N	\N	2475	0	0	0	GBP	1	4250	4250	\N	cda5fd1c-4285-4631-aff6-7a4a1fb62bcb	857	857	62eb6e83-1ce1-4f13-a8c3-6ae7b49506f8
7688	CREDIT	\N	50000	CAD	2017-03-31 19:37:30.819-04	2017-03-31 19:37:30.819-04	291	3	\N	\N	\N	2217	0	0	0	CAD	1	50000	50000	\N	5c191b8e-cc26-4f14-9ad4-bc6c7f3e1f05	857	857	68a158db-92ef-45db-9056-52bf74b9824b
4280	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-23 14:37:32.49-05	2016-12-23 14:37:32.668-05	268	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	4e27357d-7c4c-43e4-b29e-773872e443e8	857	857	68e5fc60-1003-4b42-9815-2d37a08961fe
8675	CREDIT	\N	1480	USD	2017-04-18 20:39:23.15-04	2017-04-18 20:39:23.15-04	14	3	\N	\N	\N	2508	0	0	0	USD	1	1480	1480	\N	85822cfc-ab85-4318-b357-4cbff6b96682	857	857	6c345928-6909-4573-b954-4dc6d2c97d2f
8620	CREDIT	\N	18800	MXN	2017-04-17 18:35:06.093-04	2017-04-17 18:35:06.093-04	511	3	\N	\N	\N	2488	0	0	0	MXN	1	18800	18800	\N	72c1775e-82bb-418c-8112-0953e2c003a2	857	857	702f7f1e-3e93-4453-8775-1c1da30be9cb
7683	CREDIT	\N	100000	USD	2017-03-31 18:32:34.123-04	2017-03-31 18:32:34.123-04	286	3	\N	\N	\N	2212	0	0	0	USD	1	100000	100000	\N	ed1324c1-c55c-47b7-ac88-afc3f3ba3a7d	857	857	7b143042-4424-4df1-9a42-42fab8ab48e2
8672	CREDIT	\N	1480	USD	2017-04-18 20:20:11.527-04	2017-04-18 20:20:11.527-04	12	3	\N	\N	\N	2506	0	0	0	USD	1	1480	1480	\N	41154072-0424-4ec6-9f81-9ca8cce5420a	857	857	7f4c5806-3bed-4438-8463-e948e8845912
7295	CREDIT	Paypal Fees for Travel Stipend	3000	USD	2017-03-20 11:38:54.453-04	2017-03-20 11:38:53.749-04	277	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3000	\N	fea87b26-175e-46ed-b94c-5d7bcec1778f	857	857	8858e320-c2cd-47c7-bf09-fbdfae714763
7662	CREDIT	\N	79600	GBP	2017-03-31 13:20:23.917-04	2017-03-31 13:20:23.917-04	267	3	\N	\N	\N	2206	0	0	0	GBP	1	79600	79600	\N	bd840d8c-6019-4588-bc03-94a0ae07b331	857	857	97336c74-2a22-4072-b5de-094e4a31789f
4282	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-23 14:40:51.309-05	2016-12-23 14:40:51.479-05	269	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	bf5087f3-ca93-402e-8c80-5383c23112a4	857	857	99070318-d9ac-4319-82ab-c496080a510c
8609	CREDIT	\N	5000	USD	2017-04-17 16:41:53.602-04	2017-04-17 16:41:53.602-04	517	3	\N	\N	\N	2473	0	0	0	USD	1	5000	5000	\N	434d7fb0-0b13-4100-bcc9-38a711f799ad	857	857	9e0992b8-9935-4110-a13e-07143f74c4ab
8673	CREDIT	\N	1400	USD	2017-04-18 20:31:31.942-04	2017-04-18 20:31:31.942-04	195	3	\N	\N	\N	2507	0	0	0	USD	1	1400	1400	\N	36ea5d6f-9e03-4116-8db7-201d91018475	857	857	9fb9504d-f559-4f59-9239-639f8795ac3c
7554	CREDIT	International Women's Day Celebrations - Global	51750	USD	2017-03-28 14:27:16.525-04	2017-03-28 14:27:16.748-04	12	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	51750	\N	f2ef8d98-6ac6-4954-bbbe-3cedd9ac7522	857	857	b388fa32-3126-4935-91b9-5f99dbb394eb
8608	CREDIT	\N	100000	USD	2017-04-17 16:41:37.627-04	2017-04-17 16:41:37.627-04	517	3	\N	\N	\N	2472	0	0	0	USD	1	100000	100000	\N	58ac0411-2d75-4b99-b49f-853c0659a78e	857	857	b50454f3-a3f7-4689-83a4-c55b078a35b2
4246	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-23 11:32:00.456-05	2016-12-23 11:32:00.622-05	260	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	713fdfe3-6cf7-4520-aee5-e18c6cf12071	857	857	bb988f08-f90e-4c44-9752-5ee09cb61b46
4435	CREDIT	Global Development for Meetup Fee	6000	CAD	2016-12-28 11:21:14.024-05	2016-12-28 11:21:10.449-05	291	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	06fa2587-6ff6-4229-ab30-031b2088aa97	857	857	c33180c2-c01a-4d7f-b9cb-179396b93072
6733	CREDIT	Event sponsorship - transaction fees and global development 	856500	USD	2017-03-02 01:00:43.46-05	2017-03-02 01:00:44.182-05	12	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	856500	\N	7fef39d1-1059-4a44-94f9-5da063341c94	857	857	c7af087e-a4d3-4392-83a6-4fb404e8bb2f
7526	CREDIT	\N	100000	USD	2017-03-27 13:53:48.539-04	2017-03-27 13:53:48.539-04	277	3	\N	\N	\N	2154	0	0	0	USD	1	100000	100000	\N	79f34f13-1a21-48bc-8119-ab5cf030a034	857	857	ca03e9c0-a1ed-4c24-ac05-14b3146ea528
8605	CREDIT	\N	4000	GBP	2017-04-17 15:31:52.919-04	2017-04-17 15:31:52.919-04	267	3	\N	\N	\N	2470	0	0	0	GBP	1	4000	4000	\N	c32af448-af25-450f-9fe0-4b3c5f8345a5	857	857	d44dae99-dde7-4703-9e3a-4abcb9360ebe
8611	CREDIT	\N	85000	GBP	2017-04-17 17:05:15.067-04	2017-04-17 17:05:15.067-04	278	3	\N	\N	\N	2474	0	0	0	GBP	1	85000	85000	\N	afc6310f-79f8-4fa7-9010-33c13c3dfeec	857	857	d7381bbe-8e6b-42cb-9759-ed2f1f81babf
7294	CREDIT	Travel Stipend for Google I/O	100000	USD	2017-03-20 11:17:43.622-04	2017-03-20 11:17:42.994-04	277	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	100000	\N	e9057982-2758-4b71-96a7-7e852f7d4a0e	857	857	db531c4e-3d6c-4a42-9b40-e3bafdbf0643
8619	CREDIT	\N	25000	MXN	2017-04-17 18:34:32.259-04	2017-04-17 18:34:32.259-04	511	3	\N	\N	\N	2487	0	0	0	MXN	1	25000	25000	\N	3b170ab8-edef-4461-983d-efd3689fda2c	857	857	dde1250e-79cd-4912-a2c7-26ff0dedcbf4
2337	CREDIT	Quotient Hackathon support	90000	USD	2016-10-07 15:52:59.206-04	2016-10-07 15:52:59.391-04	300	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	90000	\N	9790ad68-05b0-4f76-a64a-0bfb9ffb7686	857	857	deef5358-a3c6-4bce-8b9b-a3f815f6e8f7
655	CREDIT	Women Techmaker WWcode Partnership Grant	100000	USD	2016-05-24 16:23:16.28-04	2016-05-24 16:23:16.552-04	3	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	100000	\N	1afc5e7f-3794-4830-8b96-08ce05be814a	857	857	e60fe9c9-3dc1-4342-8c92-af3e180264f5
4367	CREDIT	Global Development for Meetup Fee	6000	INR	2016-12-27 11:24:37.915-05	2016-12-27 11:24:38.038-05	47	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	c54c243c-29a5-4006-b821-adc4d3a389ee	857	857	fe379c2f-8392-4c24-944d-f1c178c7d69b
4189	CREDIT	Global Development for Meetup fee	6000	USD	2016-12-21 13:49:53.054-05	2016-12-21 13:49:53.302-05	3	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	54daaaa7-92d1-4072-9e26-e3664a7eddda	857	857	fea752e0-e8b0-447d-8755-7e688698f395
1876	CREDIT	Recurring subscription	100	USD	2016-09-09 14:29:12.276-04	2016-09-09 14:29:12.276-04	3	8	385	\N	\N	320	5	10	32	USD	1	100	53	\N	0883360f-716b-4be8-a920-9ab0f71e399b	819	857	85e9e749-016b-4046-ad9a-9d6dfb6d0282
1498	CREDIT	Recurring subscription	100	USD	2016-08-09 14:30:50.866-04	2016-08-09 14:30:50.915-04	3	8	385	\N	\N	320	5	10	32	USD	1	100	53	\N	8a688e20-988b-4f55-b69d-bb6632da3ece	819	857	ade1e70e-c0e3-40c7-83f4-57497a017f5a
1174	CREDIT	Recurring subscription	100	USD	2016-07-09 14:31:14.547-04	2016-07-09 14:31:14.585-04	3	8	385	\N	\N	320	5	10	32	USD	1	100	53	\N	321662c1-bd0e-45c1-a83b-15734580a904	819	857	7fd7b99b-f672-4482-9e83-7f8a424fb71e
290	CREDIT	Recurring subscription	100	USD	2016-04-02 22:02:46.616-04	2016-04-16 16:40:58.82-04	14	8	45	\N	\N	71	5	10	33	USD	1	100	52	\N	3464d1b8-8be5-451a-bee5-fd4129ac6455	819	857	ed79af13-e4da-4803-be3a-b46bea674f81
3471	CREDIT	\N	4000	USD	2016-11-28 10:33:14.428-05	2016-11-28 10:33:14.428-05	2	1890	1249	\N	\N	1167	200	400	118	USD	1	4000	3282	\N	52c746a4-eba7-4a0f-963c-e6e2e3f22f53	810	857	461a7850-253c-49d9-a971-08eb8745645e
1461	CREDIT	Donation to WWCode Austin	150000	USD	2016-08-05 16:48:08.414-04	2016-08-05 16:48:08.458-04	2	192	589	\N	\N	513	7500	15000	5250	USD	1	150000	122250	\N	3cd012ba-7cbf-4008-b0db-7a4b51a0d7df	805	857	112aabec-2db7-485c-b867-0f115aab4ca7
1395	CREDIT	Recurring subscription	1000	USD	2016-08-01 19:35:39.219-04	2016-08-01 19:35:39.244-04	2	686	461	\N	\N	386	50	100	52	USD	1	1000	798	\N	9056ebd9-568b-47c4-ba61-a4830e554a1c	803	857	6bd18036-2cfd-40c7-89f5-7bbfdd741fd3
1080	CREDIT	Recurring subscription	1000	USD	2016-07-01 18:38:37.594-04	2016-07-01 18:38:37.617-04	2	686	461	\N	\N	386	50	100	52	USD	1	1000	798	\N	d414ca78-a0ca-4706-8533-c9f54acba200	803	857	b45be811-a169-4b45-9aa8-5a441cdce3fb
9595	CREDIT	monthly recurring subscription	1000	USD	2017-05-01 19:34:11.708-04	2017-05-01 19:34:11.708-04	2	686	461	\N	\N	386	50	100	52	USD	1	1000	798	\N	c70f2fd8-da04-4f99-97a1-72c05a99dfa1	803	857	59e48874-b7a3-4904-a63e-c3d10cb7373a
478	CREDIT	Donation to WWCode Austin	150000	USD	2016-05-03 09:07:28.39-04	2016-05-03 09:07:28.452-04	2	308	230	\N	\N	191	7500	15000	4380	USD	1	150000	123120	\N	31bd69fa-cc92-405a-a116-d31a2a40d4d1	798	857	fdceece5-4ce6-4ec8-ae81-2b82052afed3
2143	CREDIT	\N	19000	USD	2016-09-28 17:47:18.302-04	2016-09-28 17:47:18.302-04	2	1299	842	\N	\N	768	950	1900	665	USD	1	19000	15485	\N	c4585b37-a213-4c1c-ba1f-8b9a0a9e3793	794	857	25cb3632-598e-46fe-a673-782dce6656d4
2055	CREDIT	\N	25000	USD	2016-09-22 21:07:09.492-04	2016-09-22 21:07:09.492-04	59	1263	790	\N	\N	700	1250	2500	580	USD	1	25000	20670	\N	c037d2a1-7fa4-4875-b084-2c8d7605d567	792	857	f19a87fd-002b-4e3d-9ae6-b0d6e9aee57b
984	CREDIT	Donation to WWCode Atlanta	100	USD	2016-06-21 12:02:56.072-04	2016-06-21 12:02:56.13-04	12	642	430	\N	\N	359	5	10	32	USD	1	100	53	\N	fdf511fc-d0e4-4322-aa0a-49ebacbb1e08	775	857	1cb2467d-069e-4a93-868b-dae1605e8f4f
986	CREDIT	Donation to WWCode Twin Cities	100	USD	2016-06-21 12:06:05.517-04	2016-06-21 12:06:05.626-04	48	642	432	\N	\N	361	5	10	32	USD	1	100	53	\N	44e3ee1d-5777-4ea7-9dfb-e651db755946	775	857	97d61982-3f01-41b6-9682-644a956bb70b
4899	CREDIT	Recurring subscription	1000	USD	2017-01-14 12:12:01.244-05	2017-01-14 12:12:01.244-05	270	2549	1616	\N	\N	1531	50	100	52	USD	1	1000	798	\N	63e320d2-5114-4fc3-8daa-8c636b663d98	763	857	d07c3b37-d6b0-431a-8590-6ed01a245180
1392	CREDIT	Donation to WWCode Austin	20000	USD	2016-08-01 11:55:27.083-04	2016-08-01 11:55:27.184-04	2	884	562	\N	\N	489	1000	2000	470	USD	1	20000	16530	\N	c0b172e7-1ce8-45a7-a51d-5c1098baeeb8	750	857	2f4bce76-87ad-4757-a57f-676ba927bd4e
645	CREDIT	Donation to WWCode Austin	50000	USD	2016-05-23 16:27:28.524-04	2016-05-23 16:27:28.599-04	2	426	306	\N	\N	258	2500	5000	1480	USD	1	50000	41020	\N	f63c7344-8631-43e0-8d56-70bf3f01998c	741	857	b3ab8e62-2bba-465d-b59a-7c3b382f42e9
1787	CREDIT	\N	200000	USD	2016-09-01 10:41:36.24-04	2016-09-01 10:41:36.24-04	2	1094	707	\N	\N	622	10000	20000	4430	USD	1	200000	165570	\N	b7a1007d-6e00-4764-b983-c9d27abc2296	738	857	8c7ac22a-9c25-4041-8872-0424eb1420a0
1884	CREDIT	Recurring subscription	1000	USD	2016-09-09 23:42:56.392-04	2016-09-09 23:42:56.392-04	241	1158	731	\N	\N	647	50	100	52	USD	1	1000	798	\N	a73ee6ae-c18d-406f-a24b-4c04f218c3e3	737	857	2d0f7f24-2670-4dda-a03d-95ada2a1a0bd
5044	CREDIT	\N	10000	USD	2017-01-18 08:54:50.597-05	2017-01-18 08:54:50.597-05	48	2594	1647	\N	\N	1557	500	1000	250	USD	1	10000	8250	\N	629c628a-29cb-4690-b71e-ad06f390ea21	697	857	cdca0239-f450-405c-8dcc-6c7e3a818b76
5540	CREDIT	\N	2500	USD	2017-02-01 12:30:48.467-05	2017-02-01 12:30:48.467-05	271	2906	1804	\N	\N	1712	125	250	85	USD	1	2500	2040	\N	a88cbaf9-3c16-494f-9fb9-1ff207e24d4a	693	857	d7ac7509-a0e4-4d57-be79-6391b86e6c5a
6649	CREDIT	monthly recurring subscription	2500	USD	2017-03-01 13:37:53.591-05	2017-03-01 13:37:53.591-05	271	2906	1804	\N	\N	1712	125	250	85	USD	1	2500	2040	\N	ec153d42-d2ae-4d56-a4aa-f223962a4ca2	693	857	2f19ba5e-3ff9-49c4-9d43-f7579f024baf
472	CREDIT	Recurring subscription	100	USD	2016-05-02 14:15:35.25-04	2016-05-02 14:15:35.307-04	13	30	44	\N	\N	70	5	10	33	USD	1	100	52	\N	89fe586a-cc2d-4bbe-9781-196390e19e37	691	857	1b4ae8a6-fd9b-4287-8634-3541c62f4eb7
470	CREDIT	Recurring subscription	100	USD	2016-05-02 14:10:42.774-04	2016-05-02 14:10:42.847-04	13	30	43	\N	\N	69	5	10	33	USD	1	100	52	\N	f99307f9-7e49-4414-a2cf-c69326ceb1c4	691	857	2e05f979-40cc-4b6c-820e-0a3d58863049
68	CREDIT	Donation to WWCode Seattle	100	USD	2016-02-02 11:36:38.327-05	2016-04-16 16:40:58.702-04	14	30	41	\N	\N	67	5	10	33	USD	1	100	52	\N	74fb2375-fab0-436c-8f56-5051ee3c26ad	691	857	565d4e19-aaaf-4805-aabb-1934289f42f9
334	CREDIT	From Deepa	1500	USD	2016-04-12 17:19:00.212-04	2016-04-12 17:19:00.529-04	4	3	\N	2016-04-14 17:19:00.529-04	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3be9f7b2-c97b-41ac-b2bf-2e8dbd11ca27	857	857	096bc827-7737-4ee6-971e-b26926be0c02
9943	CREDIT	\N	90000	USD	2017-05-11 12:41:16.759-04	2017-05-11 12:41:16.759-04	59	3	\N	\N	\N	2794	0	0	0	USD	1	90000	90000	\N	97b3a399-75b9-4ed4-b244-db56f1e2cac0	857	857	19be5c14-eec7-42c1-82d0-8d9429e3df0e
5019	CREDIT	WWCode t-shirt sales	1229	USD	2017-01-17 22:23:59.112-05	2017-01-17 22:23:59.247-05	48	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1229	\N	a43c6a3d-406e-43de-98bb-0e151a1b8fea	857	857	2659df51-8fa5-40ee-a8ba-0b3691201b92
2303	CREDIT	Network development (stickers)	58590	USD	2016-10-06 12:08:20.916-04	2016-10-06 12:08:21.09-04	3	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	58590	\N	3169934f-3f78-4faa-959d-7141ff24163b	857	857	2662baec-30e0-4ffe-b56b-7f97352108c8
8707	CREDIT	\N	1190	USD	2017-04-19 14:26:58.997-04	2017-04-19 14:26:58.997-04	3	3	\N	\N	\N	2521	0	0	0	USD	1	1190	1190	\N	6189157f-8088-48c0-9964-a66fe4fcfee1	857	857	32f9fb80-3dd9-4049-8c37-e3aca02b4aaa
5750	CREDIT	Donations - Fees 	17328	USD	2017-02-06 15:06:15.502-05	2017-02-06 15:06:15.622-05	2	3	\N	2017-02-05 19:00:00-05	\N	\N	\N	\N	\N	\N	\N	\N	173	\N	3bda2f71-4a09-4f4d-9ba9-4d52bdcd10a5	857	857	38b3e113-4a51-4a0e-802f-44a612d2039c
7518	CREDIT	\N	50000	USD	2017-03-27 13:10:04.622-04	2017-03-27 13:10:04.622-04	12	3	\N	\N	\N	2151	0	0	0	USD	1	50000	50000	\N	9c3381f8-416c-44f2-8e0a-a9d37855a5fe	857	857	559fef52-c712-4037-b931-794b5fd83777
5763	CREDIT	Donations via meetup - fees/global development	2000	USD	2017-02-06 17:56:24.306-05	2017-02-06 17:56:24.52-05	272	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	20	\N	96e04578-a558-4d24-a5d5-14d1b469f341	857	857	638165e0-f340-4e3f-8a80-44f4c89a627f
5020	CREDIT	WWCode t-shirt sales	982	USD	2017-01-17 22:24:31.362-05	2017-01-17 22:24:31.504-05	13	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	982	\N	e22d04c4-f74f-4484-a0b3-9007b55c94a8	857	857	6996f965-9b3d-4af4-a02d-c4883ee7e14f
5277	CREDIT	Global Network Development	500000	USD	2017-01-25 13:27:46.907-05	2017-01-25 13:27:47.421-05	51	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	500000	\N	54b79a9d-1205-4d4c-aa91-534fa732fefb	857	857	786d39f7-4e5e-4c7e-ac40-0b8dfdb25e14
330	CREDIT	Intel Donation	100000	USD	2016-04-12 16:32:35.997-04	2016-04-16 16:40:58.826-04	59	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	100000	\N	925c1460-bda7-448f-8dd9-83291db33330	857	857	7a1aa808-0ccb-43fe-a676-08a86d8625c4
9621	CREDIT	\N	2930	USD	2017-05-01 20:33:45.73-04	2017-05-01 20:33:45.73-04	3	3	\N	\N	\N	2662	0	0	0	USD	1	2930	2930	\N	08015eaa-ad1d-4dd5-9704-3de345b88094	857	857	86c2ce2b-1e91-463a-820b-e068cb5a1fec
5751	CREDIT	Taipei Donation - fees and global development	800	USD	2017-02-06 15:11:26.406-05	2017-02-06 15:11:26.522-05	241	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8	\N	7de04ec6-4f91-4e9f-a7e1-f3ccc020cacc	857	857	90aecccb-f9cf-44a8-80b8-d14ac68b2d19
8706	CREDIT	\N	40000	USD	2017-04-19 14:26:01.228-04	2017-04-19 14:26:01.228-04	3	3	\N	\N	\N	2520	0	0	0	USD	1	40000	40000	\N	5272792e-d8c4-4354-8dff-c2e24a66999a	857	857	944cb0fd-553f-4e47-a5e2-785cec9d7c8b
7523	CREDIT	\N	20000	USD	2017-03-27 13:45:17.58-04	2017-03-27 13:45:17.58-04	59	3	\N	\N	\N	2152	0	0	0	USD	1	20000	20000	\N	21139f0a-dcfa-4a47-90cd-bdf239e2cbcb	857	857	955581ef-affc-4ff3-80a6-ccb62a88553d
8756	CREDIT	AJUG - Global and fees	26250	USD	2017-04-20 17:39:17.741-04	2017-04-20 17:39:18.323-04	12	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	a365b026-a438-43c2-9628-8abfa5258787	857	857	9a7aa0d1-0287-47a9-8666-4502ceafda5d
8708	CREDIT	\N	610	USD	2017-04-19 14:35:03.04-04	2017-04-19 14:35:03.04-04	59	3	\N	\N	\N	2522	0	0	0	USD	1	610	610	\N	477a5aef-b895-4774-8b86-b1f5156fd8b6	857	857	9d897eb6-23a2-43ab-ac2c-43ee4cbe9c6e
5755	CREDIT	Gitlab - transaction and global development	41400	USD	2017-02-06 17:12:42.534-05	2017-02-06 17:12:42.684-05	48	3	\N	2017-02-05 19:00:00-05	\N	\N	\N	\N	\N	\N	\N	\N	414	\N	ef68d68b-3fdf-4a96-951d-ac953118ce75	857	857	d41cec13-4cb9-4c3c-b4ed-9af124850221
5754	CREDIT	Donation - fees	800	USD	2017-02-06 17:10:44.604-05	2017-02-06 17:10:44.763-05	270	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8	\N	2628a845-d10d-4426-8c12-14dba874aae2	857	857	d510d8c0-b4d4-4df5-bdca-b93b113c141e
5764	CREDIT	Donations via meetup - fees	1200	USD	2017-02-06 17:58:38.922-05	2017-02-06 17:58:39.29-05	13	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	12	\N	2b8aeffe-03c4-493a-a5aa-a8733db5860d	857	857	ea3c57e1-dc22-4f6a-979c-36998e2583b1
126	CREDIT	Recurring subscription	100	USD	2016-03-02 12:53:54.346-05	2016-04-16 16:40:58.736-04	14	30	41	\N	\N	67	5	10	33	USD	1	100	52	\N	f7a13ef8-2a57-4e4b-99f1-3a016d405ebf	691	857	58b59a09-5be7-4b53-96d0-4e1599668e0f
70	CREDIT	Donation to WWCode Washington DC	100	USD	2016-02-02 12:04:56.247-05	2016-04-16 16:40:58.698-04	13	30	43	\N	\N	69	5	10	33	USD	1	100	52	\N	bedf3c7c-2d98-43a2-b73b-761b68cd2b0c	691	857	07aad868-286d-4019-b282-ef6d00b764c2
280	CREDIT	Recurring subscription	100	USD	2016-04-02 15:09:44.502-04	2016-04-16 16:40:58.811-04	14	30	41	\N	\N	67	5	10	33	USD	1	100	52	\N	de316074-f0f1-41f4-bd2d-502dbfeceeae	691	857	4febb93e-04fd-4b53-ac12-d97f7f2e622b
130	CREDIT	Donation to WWCode Austin	30000	USD	2016-03-02 16:31:50.516-05	2016-04-16 16:40:58.67-04	2	129	94	\N	\N	25	0	3000	900	USD	1	30000	26100	\N	00dfdd70-caa9-4d07-9a89-7157a9464d5c	689	857	44b82a43-575c-41c3-ab6a-d37e78d7dca8
43	CREDIT	Donation to WWCode Mexico City	500	USD	2016-01-18 18:54:06.439-05	2016-04-16 16:40:58.672-04	10	2	34	\N	\N	65	25	50	45	USD	1	500	380	\N	c9a65b3a-a9bd-40b3-a806-ec5d4a273187	688	857	4ca6c68e-83ca-4a5f-b759-09157c99372f
475	CREDIT	Recurring subscription	100	USD	2016-05-02 20:15:49.65-04	2016-05-02 20:15:49.711-04	13	2	46	\N	\N	72	5	10	33	USD	1	100	52	\N	5ed9ac7d-2cbb-49b4-8eb0-35a8a50396b5	688	857	575052a3-9e1c-4fa2-8ab2-b6d3ec794e1b
289	CREDIT	Recurring subscription	100	USD	2016-04-02 21:49:19.352-04	2016-04-16 16:40:58.819-04	13	2	46	\N	\N	72	5	10	33	USD	1	100	52	\N	8ba471ba-ec4f-4181-a1d0-f1c2b029194d	688	857	79b02d11-a213-4bf1-870e-0a2aa638c5b8
104	CREDIT	Recurring subscription	500	USD	2016-02-18 20:11:10.784-05	2016-04-16 16:40:58.716-04	10	2	34	\N	\N	65	25	50	45	USD	1	500	380	\N	c7a4ed19-aed5-411a-a5a9-72a1296ba3d3	688	857	aed703f2-06e4-47b7-958d-7b5bd050736e
78	CREDIT	Donation to WWCode Washington DC	100	USD	2016-02-02 18:09:05.702-05	2016-04-16 16:40:58.699-04	13	2	46	\N	\N	72	5	10	33	USD	1	100	52	\N	24dc1b5d-5ff4-456c-9765-3306cc4ce7bc	688	857	4cbe50e7-903b-4159-990b-615ad236c1c5
5861	CREDIT	\N	84241	USD	2017-02-10 11:47:34.349-05	2017-02-10 11:47:34.349-05	15	3053	1890	\N	\N	1801	4212	8424	1883	USD	1	84241	69722	\N	fc5a47be-5fc1-4a9a-bc52-978334aa0481	838	857	0ebac610-ddec-4303-a28e-caf202d4fc69
5533	CREDIT	\N	22500	USD	2017-02-01 10:16:20.999-05	2017-02-01 10:16:20.999-05	48	2898	1801	\N	\N	1709	1125	2250	525	USD	1	22500	18600	\N	6d643f90-fadf-4d61-bdcf-784eba7d76d1	801	857	dd7863dc-4f43-4a98-8a3a-0bdf38251045
7913	CREDIT	monthly recurring subscription	2500	USD	2017-04-01 14:31:19.231-04	2017-04-01 14:31:19.231-04	271	2906	1804	\N	\N	1712	125	250	85	USD	1	2500	2040	\N	50d19e33-e65e-4c4f-b3bc-851253fdfda5	693	857	911b118a-dcd0-4fd3-a1cd-5e6112953765
2822	DEBIT	Sodas for ATXDivHack 	-3871	USD	2016-10-31 17:15:22.809-04	2016-10-31 17:15:22.98-04	2	3	1043	\N	\N	\N	\N	\N	\N	\N	\N	\N	-3871	\N	b31858ae-48a6-4dc9-a6e5-5c86bb6e6988	51	857	888594ca-17e2-4fb9-8ccb-4bdea342d60f
2403	DEBIT	Network Budget pre Open Collective	-11797	USD	2016-10-11 12:52:07.045-04	2016-10-11 12:52:07.303-04	59	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-11797	\N	60fedebe-23fa-46fa-bf34-3b63869f1e51	51	857	0fdda3a5-71ee-4129-9422-75729d8302c0
2424	DEBIT	Career development event w/ Mike Ross	-65000	USD	2016-10-11 20:42:04.584-04	2016-10-11 20:42:04.834-04	48	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-65000	\N	e4ad5f18-a923-47eb-a3e1-601e2ba3238f	51	857	6609d9cd-0ddf-4b70-aa36-1cd8e7fd8628
2239	DEBIT	90/10 split: Beth Laing	-500	USD	2016-10-04 12:06:09.85-04	2016-10-04 12:06:09.85-04	12	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-500	391	63e96179-a81b-4fba-880f-bc5d5a9f9e51	51	857	48d72bb3-6864-4254-a44a-53b77c9b2e6e
1628	DEBIT	Marketing and communications materials for leadership team. 	-4264	USD	2016-08-19 13:25:04.062-04	2016-08-19 13:25:04.374-04	59	3	573	\N	\N	\N	\N	\N	\N	\N	\N	\N	-4264	\N	fa3527b7-d566-447a-a671-3b80486e9c18	51	857	5aec6a99-a6d0-411a-9afb-c5c23210de3a
1585	DEBIT	Minimum Fee - May	-1000	USD	2016-08-16 10:55:31.274-04	2016-08-16 10:55:31.288-04	59	3	573	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1000	\N	17d4be5b-521f-499f-8753-2dbc163f2ec4	51	857	fb8f2b21-7b61-4fc3-bcc7-189c4497d466
1584	DEBIT	Minimum Fee - June	-995	USD	2016-08-16 10:55:14.822-04	2016-08-16 10:55:14.844-04	48	3	573	\N	\N	\N	\N	\N	\N	\N	\N	\N	-995	\N	e344373f-1e6d-416d-be2b-9ac1ce4866f4	51	857	37966e83-c6f7-4d12-9e5b-0611869d42a1
1586	DEBIT	Minimum Fee - June	-1000	USD	2016-08-16 10:55:45.164-04	2016-08-16 10:55:45.179-04	59	3	573	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1000	\N	2ed495af-5080-42ac-b381-905d29be571e	51	857	4a8ed9a1-42c8-4a54-8989-fd3f09977378
1581	DEBIT	Minimum fee - June	-1000	USD	2016-08-16 10:53:58.922-04	2016-08-16 10:53:58.936-04	15	3	573	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1000	\N	92e56306-3684-425f-b356-b67d306a0ae2	51	857	6948b310-f94d-4261-96ad-c8431b0d3742
867	DEBIT	Global Development	-5000	USD	2016-02-21 19:00:00-05	2016-06-14 14:14:22.186-04	59	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-5000	227	6b865d7e-c324-4c7a-85cd-1ba0aefb8303	51	857	5009c152-5893-4b8d-b81f-9faea4d25f2f
1629	DEBIT	Thank you materials for several events.	-6198	USD	2016-08-19 13:31:26.428-04	2016-08-19 13:31:26.891-04	59	3	573	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6198	\N	0b7f4317-3b95-47d5-89f9-245314e16769	51	857	5ec56b21-f53d-44bb-9036-50db9868c835
1170	DEBIT	Global Development	-150	USD	2016-07-08 23:52:40.722-04	2016-07-08 23:52:40.722-04	4	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-150	93	88b9402f-6888-45e1-b572-0f7b29199c39	51	857	629b08da-47fe-4d4d-a3d0-b6d077c9bfc8
670	DEBIT	FedEx Office	-3418	USD	2016-01-24 19:00:00-05	2016-06-14 14:14:22.114-04	48	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-3418	195	2b7ba22c-916e-45dc-842c-8f7137976c4f	51	857	77ce5fd6-b1b4-4dc1-b5b3-8ea90a872ffa
2396	DEBIT	Conference stipend Elizabeth M.	-75000	USD	2016-10-11 12:01:27.317-04	2016-10-11 12:01:28.351-04	195	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-75000	\N	6b335f4d-a920-4cfc-90a9-6dfe40dfef58	51	857	a9a72f45-418d-418e-8680-ff173e59c486
2840	DEBIT	Cash for Prizes/Bartender (the extra money, $50, was not used for the hackathon)	-70000	USD	2016-11-01 11:16:29.544-04	2016-11-01 11:16:30.012-04	2	3	1044	\N	\N	\N	\N	\N	\N	\N	\N	\N	-70000	\N	be4916cc-ebfc-4a00-8c1f-6fdec9dad74c	51	857	2b6596e0-ef0d-4f32-adda-6d96ce25546f
3836	DEBIT	Food/Drinks for Leadership Team Meeting - Gen, Claire, Halima - Sept 2016	-6000	GBP	2016-12-07 00:00:00.86-05	2016-12-07 00:00:00.86-05	278	1333	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	506	9b7434d9-7779-47eb-b087-5ffd3e765704	830	857	891308e1-11ac-4c38-be96-3e77f861c12e
507	DEBIT	Quarterly planning meeting	-14000	USD	2016-05-05 20:18:43.265-04	2016-06-14 14:14:22.011-04	14	32	26	\N	\N	\N	\N	\N	\N	\N	\N	\N	-14000	147	fbf72440-5d58-4805-afb9-5d67606dfa8c	797	857	c853f1a1-7e62-4cdd-9805-4f9ab20cda02
99	DEBIT	IVA Libretas Hackathon	-166080	MXN	2016-02-16 13:58:04.663-05	2016-06-14 14:14:21.738-04	10	7	\N	2016-06-14 14:14:22.436-04	\N	\N	\N	\N	\N	\N	\N	\N	-166080	34	3c8bacb7-d7c6-4ce3-a801-55ecdd103839	821	857	a4c0fd19-7f38-4c49-9b68-93148be040c7
273	DEBIT	Connect 2016 event setup day dinner	-6800	USD	2016-03-17 20:00:00-04	2016-06-14 14:14:21.838-04	14	32	26	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6800	72	97597693-ae20-489a-bc22-54b2b468147f	797	857	66388e2e-b0b6-41bb-9098-c6e64a8772f0
3864	DEBIT	European Leadership Development Workshop -- Transportation, Flight	-4700	EUR	2016-12-07 00:00:00.86-05	2016-12-07 00:00:00.86-05	301	1378	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-4728	494	e546ea27-19b6-4d72-8b95-6669cc95a981	793	857	aed6cabe-8481-41a5-ba4d-af956ab0c060
3863	DEBIT	European Leadership Development Workshop -- Transportation, Taxi	-4400	EUR	2016-12-07 00:00:00.86-05	2016-12-07 00:00:00.86-05	301	1378	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-4400	493	cc2b4a36-bd6e-45d8-a05b-36a6c5db6cde	793	857	34b05e99-6b04-464c-9707-c3e6c414cb2a
253	DEBIT	WwConnect Conference	-658	USD	2016-03-19 20:00:00-04	2016-06-14 14:14:21.806-04	14	31	26	\N	\N	\N	\N	\N	\N	\N	\N	\N	-658	63	c4d44147-f630-42db-b84f-a28881d5dd21	766	857	1c2b0af2-0241-4a4a-b9ca-283d95becdfe
5275	DEBIT	travel to NY for bell ringing at NYSE	-30000	USD	2017-01-25 13:20:51.642-05	2017-01-25 13:20:54.592-05	12	70	1476	\N	\N	\N	\N	\N	\N	\N	\N	\N	-30000	743	db2e9b39-0096-457f-9db4-a5bb6814f55c	762	857	545bf85d-8ef2-4c2b-b655-190eb0b68656
2259	DEBIT	Drinks at Sept monthly event	-2192	USD	2016-10-04 18:06:33.802-04	2016-10-04 18:06:34.357-04	15	3	573	\N	\N	\N	\N	\N	\N	\N	\N	\N	-2192	\N	7bc0fd8c-3371-4ffc-ab48-dc1d1478f023	51	857	a986f984-051f-46bb-9c47-b852937fe09e
4440	DEBIT	Meetup Fees	-6000	USD	2016-12-28 11:28:15.901-05	2016-12-28 11:28:15.901-05	292	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	665	6ad3295b-2aa8-4bfd-a39e-659ab99c98a1	51	857	a2625aa0-84c7-428c-913d-95534f9d12f1
2257	DEBIT	Net budget balance pre-Open Collective	-56266	USD	2016-10-04 17:57:44.218-04	2016-10-04 17:57:44.218-04	2	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-56266	394	0d80aa7c-4679-499a-abbb-bf69232f55f0	51	857	41c75384-10d5-448a-8918-68241f26515d
7198	CREDIT	WTM Google I/O Travel Stipend	50000	USD	2017-03-17 10:09:18.868-04	2017-03-17 10:09:18.344-04	195	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	50000	\N	9972b655-8830-4ac6-b9c7-2e373feebc03	857	857	434723e4-391d-4399-ad89-e630eee22f7a
8606	CREDIT	\N	9000	USD	2017-04-17 15:41:07.659-04	2017-04-17 15:41:07.659-04	277	3	\N	\N	\N	2471	0	0	0	USD	1	9000	9000	\N	58e25bdf-36bf-4707-bb32-eabd40e0558f	857	857	5f01413a-6b5f-459a-b41a-776a15f63674
5028	CREDIT	WWCode t-shirt sales	2371	USD	2017-01-17 22:33:30.061-05	2017-01-17 22:33:30.587-05	271	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2371	\N	480c104e-d92f-4c75-8e48-a396ffb0172a	857	857	61262692-fde2-4eb7-a4d7-a23139a3777f
5948	CREDIT	Macy's donation - fees and global development	435000	USD	2017-02-13 19:21:10.361-05	2017-02-13 19:21:10.558-05	12	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	435000	\N	31a781ff-5d17-4026-96c3-a5134a2aff92	857	857	98506445-e9b9-4c48-abb2-54cd8063ee3c
3521	CREDIT	Erica S. donation - fees	450	USD	2016-11-29 17:11:37.922-05	2016-11-29 17:11:38.131-05	287	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	450	\N	21b0481e-bb75-445b-b121-6964171ec740	857	857	ac8d8f79-58d4-47bc-bed3-e4b14d0266d4
9385	CREDIT	\N	154800	USD	2017-05-01 14:02:20.511-04	2017-05-01 14:02:20.511-04	13	3	\N	\N	\N	2649	0	0	0	USD	1	154800	154800	\N	557379b2-4691-47ed-b4bc-30b67a70bcf1	857	857	b23a2d3f-57d7-42a9-91f2-9126672ba4d0
7661	CREDIT	\N	50000	USD	2017-03-31 13:17:51.695-04	2017-03-31 13:17:51.695-04	2	3	\N	\N	\N	2204	0	0	0	USD	1	50000	50000	\N	fbf7dada-78ae-4886-9094-aed19838ed67	857	857	e4a9485f-3f41-4a06-850e-a971234a3ee5
7686	CREDIT	\N	20000	USD	2017-03-31 18:50:23.915-04	2017-03-31 18:50:23.915-04	286	3	\N	\N	\N	2214	0	0	0	USD	1	20000	20000	\N	93ca4243-7895-4061-b20e-8d0aaaa2a3f9	857	857	fb8d08c5-1993-4c53-aaa1-516e6089ea27
2258	DEBIT	90/10 split: Hackathon donation	-32000	USD	2016-10-04 18:05:22.85-04	2016-10-04 18:05:22.85-04	15	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-32000	395	0425a551-a9c9-4428-813a-aa4b4a139a49	51	857	a3f4123c-85e4-4819-8c70-38b371d9d4a6
669	DEBIT	Photographer: Mike Ross	-65000	USD	2016-01-05 19:00:00-05	2016-06-14 14:14:22.114-04	48	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-65000	193	7bd8653b-9f4c-4f09-8ec0-99a8a1cdd2c4	51	857	93ea00e2-ea18-4545-bc2d-1599058547db
660	DEBIT	Conference Grant - Sarah Olson	-20000	USD	2016-05-25 12:39:09.882-04	2016-06-14 14:14:22.103-04	48	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-20000	190	668072a8-b0b2-4538-8842-6ffb18f74196	51	857	c3617100-d561-48e4-a7c4-187caf0f183f
654	DEBIT	Conference Grant	-15000	USD	2016-05-24 15:42:50.307-04	2016-06-14 14:14:22.103-04	13	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-15000	188	712f3b65-3cfa-48ae-a939-483739ed9bd7	51	857	002f6bbf-1145-4646-82b1-e4754041f1ce
1564	DEBIT	Minimum Fee - May	-1000	MXN	2016-08-15 15:22:45.367-04	2016-08-15 15:22:45.38-04	10	3	573	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1000	\N	31262fe9-ba55-442a-b76b-b2e456cad550	51	857	cc9ebd38-5528-4419-851c-66af52975484
2818	DEBIT	Gifts for Organizers	-2399	USD	2016-10-31 17:14:19.644-04	2016-10-31 17:14:19.81-04	2	3	1043	\N	\N	\N	\N	\N	\N	\N	\N	\N	-2399	\N	f495583c-df24-4617-8cc5-d12616a0c36e	51	857	dda2ffd1-1727-4889-9c97-bf5cf6244fb1
2819	DEBIT	Gift for organizer	-3499	USD	2016-10-31 17:14:38.997-04	2016-10-31 17:14:39.22-04	2	3	1043	\N	\N	\N	\N	\N	\N	\N	\N	\N	-3499	\N	865b1387-7552-4c8d-9d1c-34ebf653db44	51	857	99a909aa-1e39-4cf3-ba33-3562e168a8df
335	DEBIT	Global Development	-150	USD	2016-04-12 14:52:16.188-04	2016-04-12 17:19:43.124-04	4	3	\N	2016-04-12 17:19:43.124-04	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f5dffc9c-009d-4d80-9983-23b2bc1c0815	51	857	c461b49c-7028-40d2-9a89-e9bc0075ef79
326	DEBIT	Global Developement	-150	USD	2016-04-12 14:46:49.263-04	2016-06-14 14:14:21.849-04	4	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-150	79	c284e464-38a5-4f87-9f50-a1c589f7dc1b	51	857	efd26028-8d84-45f0-931d-a250e37f61f0
2417	DEBIT	Network support - Regional Leadership (thanks VMWare)	-370000	USD	2016-10-11 15:51:28.361-04	2016-10-11 15:51:28.677-04	262	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-370000	\N	a8202103-9dc5-4f86-a2f1-1dbf770906a7	51	857	5a6e3686-68ee-4401-98c6-ec621de7c87c
370	DEBIT	Global Development	-150	USD	2016-04-17 18:19:12.094-04	2016-06-14 14:14:21.883-04	4	3	\N	2016-06-14 14:14:22.479-04	\N	\N	\N	\N	\N	\N	\N	\N	-150	93	df345561-08a9-4963-8863-c675b0fb1006	51	857	60ab53eb-a1f7-474f-80e9-a443fb4a1787
413	DEBIT	Global Development	-150	USD	2016-04-27 12:21:00.228-04	2016-06-14 14:14:21.907-04	48	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-150	103	1a7a975b-c002-4d56-abfb-627346e0f303	51	857	440c09f2-0c1c-479a-b306-ef0e3bd63713
350	DEBIT	Global Development	-100	USD	2016-04-15 13:29:50.291-04	2016-06-14 14:14:21.861-04	13	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-100	86	5d9c2c63-1706-434b-976f-38c44f019e58	51	857	ce3a22d2-3b8e-4d72-82c5-41e713c05bd5
2266	DEBIT	 Network budget balance pre Open Collective	-4356	USD	2016-10-04 18:37:57.159-04	2016-10-04 18:37:57.359-04	273	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-4356	\N	657fb992-7d1d-43b7-be03-5f9d23ccb189	51	857	916f2269-55dc-46f5-9557-7976d5b2784d
408	DEBIT	Global Development	-100	USD	2016-04-26 23:56:08.086-04	2016-06-14 14:14:21.897-04	13	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-100	101	bad5555b-64cf-4f72-85c7-124b7809ade5	51	857	17e064f0-1897-48dd-926a-12d01e321c63
2400	DEBIT	Test	-1000	USD	2016-10-11 12:18:39.252-04	2016-10-11 12:18:39.252-04	195	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1000	413	8d592b72-b737-4fca-995c-a0cee11c26fe	51	857	9dfd16f1-5bf5-4ed4-9311-92ad99941f5c
305	DEBIT	test 	-100	USD	2016-04-06 13:39:39.954-04	2016-04-06 13:46:25.532-04	14	3	\N	2016-04-06 13:46:25.531-04	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	5161e6cf-8e5c-43e1-b626-da7e129d3fe6	51	857	446e928b-8ce4-4ad2-a21c-165c53540447
401	DEBIT	CONNECT 2016	-2452	USD	2016-04-25 20:00:00-04	2016-06-14 14:14:21.896-04	14	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-2452	99	9a5b52f2-5dcb-4760-8d33-ce2e4a2c24ef	51	857	48f23cab-3d30-45d1-9e49-caa7873663f8
703	DEBIT	CONFERENCE GRANT	-80000	USD	2016-05-31 13:47:01.276-04	2016-06-14 14:14:22.123-04	13	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-80000	198	b08560a4-b373-40d8-91ef-20b273f83d98	51	857	98181ba8-5fab-4ecc-a66e-4fad8cfd38f9
4444	DEBIT	Meetup Fees	-6000	USD	2016-12-28 11:32:19.412-05	2016-12-28 11:32:19.412-05	294	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	667	f5ff4621-9e2e-40c3-9b96-849ab7c5f17b	51	857	7106868f-3bf4-415d-8671-235bd5fedefe
387	DEBIT	Global Developement	-100	USD	2016-04-17 18:19:12.094-04	2016-06-14 14:14:21.883-04	13	3	\N	2016-06-14 14:14:22.48-04	\N	\N	\N	\N	\N	\N	\N	\N	-100	97	a30c4579-0d08-49fa-b863-e379e17e4cc4	51	857	9467bc07-5cbe-43fb-88e8-246ed23f6ad1
4442	DEBIT	Meetup Fees	-6000	CAD	2016-12-28 11:30:16.279-05	2016-12-28 11:30:16.279-05	293	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	666	00be055b-1e12-4bd4-8e40-99bfd7602141	51	857	8cd5440a-20c7-409f-b25f-8ce6e35e6e24
4271	DEBIT	Meetup Fees	-4900	GBP	2016-12-23 13:04:05.755-05	2016-12-23 13:04:05.755-05	267	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-4900	624	429a48b8-77bb-4b7b-9e74-d18e7878caf0	51	857	9286402c-95d6-479a-a1ac-b936bae4610a
4183	DEBIT	45 webcam covers + shipping	-9685	USD	2016-12-21 10:39:46.852-05	2016-12-21 10:39:47.49-05	59	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-9685	\N	d9cdec64-d87d-406a-bd84-c8a0b5a9bcb4	51	857	98fd14ce-2a3a-4ac5-9b26-fcf7b6d151e3
4385	DEBIT	Meetup Fees	-6000	USD	2016-12-27 12:27:09.602-05	2016-12-27 12:27:09.602-05	279	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	644	1113ed6f-035d-4558-a161-f41dbe01295f	51	857	638f3084-99dc-4c53-b98d-e8036efe6e6d
4383	DEBIT	Meetup Fees	-6000	USD	2016-12-27 12:03:23.101-05	2016-12-27 12:03:23.101-05	277	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	643	bf299265-3ef1-4480-b14a-3d20c988ef72	51	857	3067e8f9-54fe-4b7a-9df7-79c9cac3ac29
4381	DEBIT	Meetup Fees	-6000	USD	2016-12-27 11:59:33.873-05	2016-12-27 11:59:33.873-05	276	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	642	b5e62766-527a-4a1a-92e7-0600510d8e57	51	857	53d06d4c-16ae-40f1-993b-a4461aa8114b
3588	DEBIT	Frames for sponsor gifts	-4054	USD	2016-11-30 11:11:18.637-05	2016-11-30 11:11:18.805-05	2	3	1191	\N	\N	\N	\N	\N	\N	\N	\N	\N	-4054	\N	892315b3-81bc-4bd8-891b-3b167173d2bc	51	857	063f9d57-952e-45f8-aeba-efa212dd09ea
3294	DEBIT	DIANA A. SCHOLARSHIP GOOGLE I/O	-25000	USD	2016-11-21 17:59:43.764-05	2016-11-21 17:59:43.764-05	272	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-25000	396	0753f9e4-051f-4578-a13f-72dce3b8075d	51	857	7e5333f8-15a9-45a6-9738-f2e0ae33fa0e
3587	DEBIT	Postage to send hackathon gifts to sponsors	-1628	USD	2016-11-30 11:09:00.364-05	2016-11-30 11:09:00.529-05	2	3	1191	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1628	\N	f36b82ec-cc72-4b8e-939b-73ea09a61f92	51	857	04505a83-d8a1-4840-8a26-a09be1fa5779
7070	DEBIT	February Lightning Talks food	-10680	USD	2017-03-14 13:17:53.891-04	2017-03-14 13:17:53.957-04	2	28	1893	\N	\N	\N	\N	\N	340	USD	1	-10680	-11020	820	0b174ca7-35b7-4eb0-b540-345b64730630	847	857	0f56eae7-75de-4f0d-9ecb-74119a321aee
3839	DEBIT	Food for October Hack Night.	-7700	USD	2016-12-07 00:00:00.86-05	2016-12-07 00:00:00.86-05	273	1325	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-7773	484	a55eb032-a0ab-4534-bd7b-86126196aa48	843	857	33c12076-8925-43a9-b3ad-b2aa96b900a7
8306	DEBIT	Stickers	-14630	USD	2017-04-07 08:58:45.517-04	2017-04-07 08:58:45.531-04	516	3419	2321	\N	\N	\N	\N	\N	454	USD	1	-14630	-15084	889	fcf1e41b-dd9f-4534-ade5-5f6fa906d10e	841	857	f8a8570a-a5d0-4d6d-80f9-b2617940d49b
10125	DEBIT	Farewell lunch for Clarissa + Welcome lunch for Pranoti 	-11500	USD	2017-05-16 17:55:26.725-04	2017-05-16 17:55:26.725-04	14	32	\N	\N	\N	\N	\N	\N	0	USD	1	-11500	-11500	1119	200f5721-452d-4ec0-bb90-0970b254c841	797	857	300b704d-ae44-415d-93f4-b379bd050d3b
7296	DEBIT	To redeem travel stipend to Google I/O	-100000	USD	2017-03-20 11:39:23.328-04	2017-03-20 11:39:23.364-04	277	1332	2180	\N	\N	\N	\N	\N	4430	USD	1	-100000	-104430	924	1fdc2835-4858-4cd0-bada-76c19f0f9f0b	831	857	56f672dc-9159-46bc-9876-bb43beaf966d
7073	DEBIT	IWD event -- wine for event	-9732	USD	2017-03-14 13:22:31.446-04	2017-03-14 13:22:31.46-04	12	70	1893	\N	\N	\N	\N	\N	312	USD	1	-9732	-10044	900	22a98043-eb9c-4d56-b246-f3529b741284	762	857	1d123935-e4b4-4795-a005-15e934a0025e
4436	DEBIT	Meetup Fees	-6000	CAD	2016-12-28 11:21:52.469-05	2016-12-28 11:21:52.469-05	291	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	663	84be2b67-931d-405c-99a7-1724a5788a24	51	857	0d366a4d-065c-4f9e-ba1c-38b2454509e5
4433	DEBIT	Meetup Fees	-6000	USD	2016-12-28 10:58:50.078-05	2016-12-28 10:58:50.078-05	241	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	662	74036058-01c1-4f98-a83f-fc82f6510521	51	857	cea24456-b845-4642-8a82-5a0c65e368a9
4281	DEBIT	Meetup Fees	-6000	USD	2016-12-23 14:38:46.818-05	2016-12-23 14:38:46.818-05	268	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	626	d4bdb19b-d165-4c0a-b84d-6bc03f6ed962	51	857	b7469e39-40c1-48da-a885-a6ca5c8cb055
4285	DEBIT	Meetup Fees	-6000	USD	2016-12-23 14:50:08.539-05	2016-12-23 14:50:08.539-05	270	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	628	51faf49d-6a19-43ae-857d-bd10ba1f66e4	51	857	ddbddd2d-b7f7-40ad-ba91-5272ec81fd7e
4254	DEBIT	Meetup Fees	-6000	USD	2016-12-23 11:56:04.579-05	2016-12-23 11:56:04.579-05	262	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	616	f6ab951c-bed5-4749-b0e5-db1a3a7a8ad6	51	857	53c94a51-7764-4de5-9f32-56b2c038fcc9
4283	DEBIT	Meetup Fees	-6000	USD	2016-12-23 14:41:48.315-05	2016-12-23 14:41:48.315-05	269	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	627	1008cc1e-b9d2-43f0-95c2-8ee9e464a929	51	857	d50fbc55-cf5d-4127-b7c2-523ac9f38bc3
4251	DEBIT	Meetup Fees	-6000	USD	2016-12-23 11:52:20.827-05	2016-12-23 11:52:20.827-05	12	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	615	85f323a7-d2f8-447c-8420-1ad74cdd8d67	51	857	856deecb-926c-47d7-a62a-ac006a8d52e5
4249	DEBIT	Meetup Fees	-6000	USD	2016-12-23 11:49:17.444-05	2016-12-23 11:49:17.444-05	261	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	614	6efb3ac7-7d2a-4724-8a1a-ef64d45fe970	51	857	a70ea427-51e3-4663-87b1-90bb208a3aab
4247	DEBIT	Meetup Fees	-6000	USD	2016-12-23 11:37:59.322-05	2016-12-23 11:37:59.322-05	260	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	613	1f6591ab-8565-4278-a8ee-906fd65c5e69	51	857	a804ca3b-cd0d-4ee2-a343-32e69406089d
4191	DEBIT	Meetup Fees	-6000	USD	2016-12-21 13:54:30.839-05	2016-12-21 13:54:30.839-05	3	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	608	53d83a5f-166b-455f-b73f-827fcdcc3a5d	51	857	72853007-a44c-4b65-b218-2596d3fd5637
4190	DEBIT	Meetup Fees	-6000	USD	2016-12-21 13:53:46.984-05	2016-12-21 13:53:46.984-05	2	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	607	d6799057-59a0-4562-8b3e-c2e3e9adf29b	51	857	f88a87f9-e1e0-4a3e-9bf1-8b8b9240b737
4410	DEBIT	Meetup Fees	-6000	USD	2016-12-27 14:53:07.2-05	2016-12-27 14:53:07.2-05	14	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	657	74cde2f7-e7c6-4e97-8c13-0bbaefa37e71	51	857	76e7fb22-e588-46f0-8189-c39ae505262e
3951	DEBIT	Event suplies	-2198	USD	2016-12-13 13:43:16.329-05	2016-12-13 13:43:17.27-05	59	3	1191	\N	\N	\N	\N	\N	\N	\N	\N	\N	-2198	\N	5228b4f5-f0ed-4a43-b5f8-4f2e8cfd7185	51	857	795d0c75-6392-4ec9-8659-4e32de19b5af
3800	DEBIT	WWC T-shirt	-2798	USD	2016-12-06 11:59:36.33-05	2016-12-06 11:59:36.741-05	59	3	1191	\N	\N	\N	\N	\N	\N	\N	\N	\N	-2798	\N	4a126373-6cb3-4e7a-9a94-178466bcefb3	51	857	e964ad85-4eca-47b2-963f-e5dd07fc4040
3799	DEBIT	Hackathon - prizes for winners + goodies for thank you bags for sponsors/speakers/mentors/judges/volunteers	-7750	USD	2016-12-06 11:57:59.164-05	2016-12-06 11:57:59.708-05	59	3	1191	\N	\N	\N	\N	\N	\N	\N	\N	\N	-7750	\N	b09fb537-00cb-4928-9a19-5551090d370a	51	857	29f5414a-e750-4516-81af-11811241c1eb
3798	DEBIT	WWCode Seattle network retreat	-6207	USD	2016-12-06 11:57:26.568-05	2016-12-06 11:57:26.935-05	14	3	1191	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6207	\N	116ff80c-993e-4c5a-83d3-d24df17d5253	51	857	0f06a244-54e0-49a9-946e-557f0451fb9d
4369	DEBIT	Meetup Fees	-6000	USD	2016-12-27 11:31:58.557-05	2016-12-27 11:31:58.557-05	15	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	636	7baa1f62-c9bc-4df0-9a12-18a4dda6c0ce	51	857	7347316d-065e-4e36-91db-432c87dc57f6
2330	DEBIT	Network Budget pre Open Collective	-77659	GBP	2016-10-07 10:03:00.623-04	2016-10-07 10:03:00.89-04	278	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-77659	\N	5f8dd4cc-75b1-4aa2-89a6-cb125c6597ef	51	857	f2429458-8329-48a0-b0ea-62d32622d6ef
3625	DEBIT	Conference Travel Stipend - Google I/O Elese	-75000	USD	2016-11-30 16:25:56.197-05	2016-11-30 16:25:56.423-05	276	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-75000	\N	8654d25a-1d31-4bb8-8a42-09794cf62430	51	857	43f443d2-22f8-4ae0-b41e-473117887692
3628	DEBIT	Banner	-2000	USD	2016-11-30 16:33:38.691-05	2016-11-30 16:33:38.827-05	263	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-2000	\N	026b493f-edc5-4529-b348-1cdb4dfddc9a	51	857	7893057b-79a0-48ef-9418-0a6745dfcf97
3545	DEBIT	Network budget pre open collective	-55923	USD	2016-11-29 19:18:08.154-05	2016-11-29 19:18:07.832-05	285	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-55923	\N	69d0ee19-1d91-42fe-8afa-7f974771bd04	51	857	eb0a8e60-7807-4ed4-896a-c1a583c59e80
3526	DEBIT	Banner	-2000	USD	2016-11-29 17:34:04.252-05	2016-11-29 17:34:04.435-05	47	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-2000	\N	f2092196-e65f-4d9c-9981-37518272c36e	51	857	a20b1b35-341f-4dc5-b4a2-8d9927978c3c
2826	DEBIT	Fedex - certificate print expense	-1962	USD	2016-10-31 17:32:07.365-04	2016-10-31 17:32:07.497-04	300	3	1043	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1962	\N	3d40ddc4-003a-4559-bb76-0dd988cbb2ac	51	857	5e41a943-11d4-409f-8a82-52194ccac4bd
498	DEBIT	Conference Grant	-50000	USD	2016-05-04 17:14:39.136-04	2016-06-14 14:14:22.01-04	13	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-50000	145	61219d5b-692d-4cba-9583-f8a7b033b990	51	857	05b61729-878a-4189-982b-90f9fc2e5870
3516	DEBIT	Matthews Group - Leadership Development for Seattle team	-60000	USD	2016-11-29 16:46:31.384-05	2016-11-29 16:46:31.384-05	14	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-60000	464	fd0c2bc8-e692-4989-a626-db0df4d74291	51	857	726bfdd5-9ee1-4586-8f05-15828f31d287
2802	DEBIT	Pizza for our monthly October event	-9276	USD	2016-10-31 14:07:11.805-04	2016-10-31 14:07:12.736-04	15	3	1024	\N	\N	\N	\N	\N	\N	\N	\N	\N	-9276	\N	91ddc1e2-b108-4f6a-b156-e7b4f593af89	51	857	ceb60da8-e426-4122-9b62-796b03890b68
3801	DEBIT	Office Supplies for Hackathon.	-10585	USD	2016-12-06 12:00:58.382-05	2016-12-06 12:00:58.806-05	59	3	1191	\N	\N	\N	\N	\N	\N	\N	\N	\N	-10585	\N	f298dc78-f218-4213-b29c-2c9a130cb0c8	51	857	2cd2ee50-3907-4d53-a907-15dff2477059
3946	DEBIT	Installfest	-558	USD	2016-12-13 12:30:28.678-05	2016-12-13 12:30:30.347-05	59	3	1191	\N	\N	\N	\N	\N	\N	\N	\N	\N	-558	\N	b2fc8ba1-8436-493a-a163-96064999c897	51	857	51bbe62e-284c-4ebb-947d-00b7835a3751
3828	DEBIT	Supplies / Gift Bags	-4147	USD	2016-12-07 11:50:40.889-05	2016-12-07 11:50:41.383-05	59	3	1191	\N	\N	\N	\N	\N	\N	\N	\N	\N	-4147	\N	67b87648-5991-4d8b-9734-cd9b6a439a04	51	857	408000b0-a3d3-4c78-942c-eeaccb4c34f1
4375	DEBIT	Meetup Fees	-6000	USD	2016-12-27 11:50:06.414-05	2016-12-27 11:50:06.414-05	273	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	639	e25e6f3b-8f97-491c-80a9-88bab6d96c78	51	857	9021ba8f-96fd-409e-afb7-8062d3b112dc
2339	DEBIT	Network budget pre Open Collective	-230712	USD	2016-10-07 16:01:03.429-04	2016-10-07 16:01:03.535-04	300	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-230712	\N	fc099f38-490d-45b7-b117-fadb4863aa22	51	857	d41925c9-e76f-40ca-97f6-2bd571ca387a
2535	DEBIT	Director t-shirt	-2898	USD	2016-10-17 16:57:20.051-04	2016-10-17 16:57:20.056-04	3	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-2898	\N	451a4c15-b647-4eab-82e9-640a825c808b	51	857	376796f8-d456-4c5a-aa02-c37e3f93a78d
2533	DEBIT	Director t-shirt	-2860	USD	2016-10-17 16:56:00.744-04	2016-10-17 16:56:00.777-04	12	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-2860	\N	5356537c-b269-45d7-ac4c-e54da8c0c6c3	51	857	2e753a9a-c31d-4289-8f72-fd9e80f29c6a
2823	DEBIT	Stickers for ATXDivHack 	-15300	USD	2016-10-31 17:15:38.727-04	2016-10-31 17:15:38.89-04	2	3	1043	\N	\N	\N	\N	\N	\N	\N	\N	\N	-15300	\N	547db055-4599-4a8d-8828-96bb66aec39e	51	857	cc585ccd-bb1e-4141-a268-b249a8bff2c0
2531	DEBIT	WWCode Director t-shirt	-3649	USD	2016-10-17 16:50:53.853-04	2016-10-17 16:50:53.855-04	47	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-3649	\N	a66cf7d0-ac6e-42ce-ab24-b0f9f6f0c28e	51	857	e78f61b1-4467-4a71-94f8-c4be5a79e7fe
2395	DEBIT	Google I/O stipend	-50000	USD	2016-10-11 12:00:21.246-04	2016-10-11 12:00:22.203-04	195	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-50000	\N	8916c363-dc64-40c0-9b37-596a418b9c45	51	857	56ab81ed-0ac4-44b9-9ae8-a5d4f09dfa45
2380	DEBIT	WWCode Portland Stickers	-31950	USD	2016-10-10 16:12:33.813-04	2016-10-10 16:12:33.813-04	59	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-31950	411	dab27bf8-4cd0-46ef-93fe-c99e9c4b74fe	51	857	89cafc3f-4a34-49ed-9c44-71f377e533c0
2304	DEBIT	Conference stipend Udisha S.	-75000	USD	2016-10-06 13:21:09.865-04	2016-10-06 13:21:09.933-04	13	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-75000	\N	a07591fb-4e19-4cf3-8f08-da3c9ccff93b	51	857	ce6dc00d-9809-44a9-a9b4-afeb8d420bb1
7517	DEBIT	Travel Stipend for Google I/O, now that I have secured my I/O Ticket via Google - see enclosed I/O Ticket Receipt)	-85000	GBP	2017-03-27 12:01:27.19-04	2017-03-27 12:01:27.295-04	278	1333	2265	\N	\N	\N	\N	\N	3760	GBP	1	-85000	-88760	926	a26b7d78-3ba3-487c-99ab-fea20d22a67e	830	857	0c37be8d-f8f8-42bc-b440-accc66416375
5786	DEBIT	Printing WWCODE pamphlets for Camas STEM Fair for middle-school girls (organized by OHSU).	-4431	USD	2017-02-07 13:40:27.475-05	2017-02-07 13:40:27.96-05	59	171	1718	\N	\N	\N	\N	\N	\N	\N	\N	\N	-4431	736	2bbc0783-4b84-4636-a6aa-9b9336c1550e	827	857	755f24ee-a9c8-47a0-b760-731fd98e5de6
5785	DEBIT	Event supplies for Leads	-2439	USD	2017-02-07 13:38:14.3-05	2017-02-07 13:38:15.58-05	59	171	1718	\N	\N	\N	\N	\N	\N	\N	\N	\N	-2439	737	f07b1e2f-1ddb-43ba-8873-49e911fa25d3	827	857	22f6a569-f9ca-4ee6-b79b-779dd78d6ccd
8421	DEBIT	Event supplies	-1527	USD	2017-04-11 15:13:28.544-04	2017-04-11 15:13:28.599-04	59	171	2321	\N	\N	\N	\N	\N	74	USD	1	-1527	-1601	1002	94f2347a-1fdc-472e-b084-606647265be1	827	857	7a87706f-dd13-4adc-81c4-9a9cf4706904
10118	DEBIT	Regional Leadership Event: Barcelona	-19398	EUR	2017-05-16 17:49:07.885-04	2017-05-16 17:49:07.885-04	301	1378	\N	\N	\N	\N	\N	\N	0	EUR	1	-19398	-19398	1122	3fca3a38-ed21-4b50-903c-7ad1304b11af	793	857	510a1841-985e-4129-889e-f4a171951b60
8422	DEBIT	Hackathon 2017 planning meeting	-2891	USD	2017-04-11 15:15:09.813-04	2017-04-11 15:15:09.826-04	59	171	2321	\N	\N	\N	\N	\N	114	USD	1	-2891	-3005	1001	3ba366f9-e99f-4629-95c3-35280b503ba9	827	857	43ac40ab-9912-40c0-bceb-58b8b501e16a
5781	DEBIT	Last minute (less than 7 day advance purchase) airline price purchase from SFO to JFK. Emailed Joey to alert of higher fare. 	-59040	USD	2017-02-07 13:32:48.784-05	2017-02-07 13:32:49.072-05	14	31	1718	\N	\N	\N	\N	\N	\N	\N	\N	\N	-59040	776	52ec1ede-9280-4e75-b076-1d75225a9773	766	857	dccfdddf-67a7-44e9-beb4-89959e6f6431
7510	DEBIT	payment to artists (spoken word) for performance at IWD event	-20000	USD	2017-03-27 08:47:25.654-04	2017-03-27 08:47:25.894-04	12	70	2218	\N	\N	\N	\N	\N	610	USD	1	-20000	-20610	907	ac007c6a-85a6-404e-9ed8-8c1cb9e9e7e5	762	857	f40effc5-8e82-4156-9496-15a4aa102a74
336	DEBIT	Meetup Transaction Fee	-163	USD	2016-04-12 14:52:16.188-04	2016-06-14 14:14:21.849-04	4	3	\N	2016-06-14 14:14:22.458-04	\N	\N	\N	\N	\N	\N	\N	\N	-163	82	d8012b7a-930b-4c21-a97d-60e676c4c08d	51	857	cd3e327f-5768-4c1c-a2c1-eae51a8e516b
299	DEBIT	Reimburse Caterina for travel expenses to CONNECT 2016	-6500	USD	2016-04-05 15:44:01.338-04	2016-06-14 14:14:21.839-04	59	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6500	75	995b5cdf-7f5d-495b-8937-021414ea6d22	51	857	cf9e0de6-f616-4092-be87-a15946f63158
1583	DEBIT	Minimum Fee - May	-1000	USD	2016-08-16 10:54:57.595-04	2016-08-16 10:54:57.609-04	48	3	573	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1000	\N	cbb3070b-f325-45ad-a323-1210bd2b0499	51	857	b1304f1f-0bcb-4e06-a8bb-709b5ee1c33d
613	DEBIT	Conference Grant	-120000	USD	2016-05-19 15:07:13.723-04	2016-06-14 14:14:22.074-04	12	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-120000	175	0ec09d11-719f-49c7-8785-cdf9a6660274	51	857	449279b8-4af1-43d5-bebf-692a8212d2c9
3529	DEBIT	Regional Leadership Director Training	-13031	USD	2016-11-29 17:35:21.354-05	2016-11-29 17:35:21.522-05	47	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-13031	\N	bc8e0feb-b038-484d-b77e-9671a32f65be	51	857	1a6745c2-ac51-4c90-88b8-807e6c56862a
2425	DEBIT	Fedex 	-3418	USD	2016-10-11 20:43:40.215-04	2016-10-11 20:43:40.344-04	48	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-3418	\N	720b2952-d5b6-4f7f-81ba-a36f52576f1f	51	857	3c52eed5-7c00-4cc1-ae82-8581e9fdee3e
1576	DEBIT	Monthly Minimum Fee - May	-1000	USD	2016-08-16 10:51:38.913-04	2016-08-16 10:51:38.924-04	12	3	573	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1000	\N	1e21e117-2659-49f0-b3c4-0f71be1dafea	51	857	9ae47817-4af0-4bff-81bf-f63352e4d3ad
1582	DEBIT	Minimum fee - May	-1000	USD	2016-08-16 10:54:12.931-04	2016-08-16 10:54:12.95-04	15	3	573	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1000	\N	6dd5e28c-157e-4552-ba9e-f37e75ec0ec4	51	857	1059d11e-b3d0-48db-ad58-6cb4592df70e
8618	DEBIT	Travel Scholarship for WWCode Director	-40970	GBP	2017-04-17 18:32:02.724-04	2017-04-17 18:32:02.724-04	278	3	\N	\N	\N	\N	\N	\N	0	GBP	1	-40970	-40970	768	ac366b27-1c91-4846-b9cb-9fb911edd792	51	857	3cc2ca61-003c-4d59-88f8-58ab5b0776ae
8601	DEBIT	Atlanta IWD Event	-235699	USD	2017-04-17 15:17:23.032-04	2017-04-17 15:17:23.032-04	12	3	\N	\N	\N	\N	\N	\N	0	USD	1	-235699	-235699	998	ed3b2ff8-e7bc-4ffd-a178-056c3ca7ec4c	51	857	a05e7357-7c73-4ce6-aef6-391b184c0886
8616	DEBIT	Network Development: Attend CapOne WIT 2017 Kickoff to announce partnership for re-launch	-100000	USD	2017-04-17 18:12:22.995-04	2017-04-17 18:12:22.995-04	270	3	\N	\N	\N	\N	\N	\N	0	USD	1	-100000	-100000	1027	4ec74672-5586-4acc-b9be-bddf2e0a464c	51	857	1671e106-4c66-43f9-ac71-3d7eaa57594a
615	DEBIT	Conference Grant	-70000	USD	2016-05-19 15:07:13.723-04	2016-06-14 14:14:22.082-04	3	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-70000	178	074c5df4-902c-4af8-b06e-9a222d4899dc	51	857	f928e49f-f908-44ca-b841-d845d52bd531
676	DEBIT	CONFERENCE GRANT	-34750	USD	2016-05-26 15:05:53.771-04	2016-06-14 14:14:22.123-04	59	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-34750	197	d88487be-3043-4198-810a-d989c2c30afb	51	857	2a288453-95f3-4348-9861-137f4573e26d
298	DEBIT	Reimbursement to Kamila for coffee purchased for volunteers at CONNECT 2016	-11815	USD	2016-04-05 15:44:01.338-04	2016-06-14 14:14:21.839-04	14	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-11815	74	8b3bc1cf-1598-4af5-9511-2dea9fcb267a	51	857	f1687580-7a4c-46de-b692-6aebb636eb45
4431	DEBIT	Meetup Fees	-6000	AUD	2016-12-28 10:56:28.934-05	2016-12-28 10:56:28.934-05	297	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	661	6b303a9b-a30c-4cd3-99ca-80c33b0b9197	51	857	0f747c75-347c-400b-bcaf-55ae7cd03533
414	DEBIT	WePay Fee	-400	USD	2016-04-10 20:00:00-04	2016-06-14 14:14:21.907-04	48	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-400	104	87c00eef-d1a6-4f09-8e9c-b288d4bb1d87	51	857	4b5c85f2-4e5b-4e35-a678-984d7dddb47e
300	DEBIT	Reimburse Caterina for program materials	-3798	USD	2016-04-05 15:44:01.338-04	2016-06-14 14:14:21.838-04	59	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-3798	76	42cf26b1-f1f3-4a07-8725-0090dd713617	51	857	3c514fd0-525e-4f42-a2e1-f7550f58fd30
4429	DEBIT	Meetup Fees	-6000	USD	2016-12-28 10:53:05.613-05	2016-12-28 10:53:05.613-05	289	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	660	90fccb78-97b2-4e6b-951d-b476f4a7148f	51	857	b075ab85-a13a-4d9d-9911-3c08b1c7b593
4427	DEBIT	Meetup Fees	-6000	USD	2016-12-28 10:49:16.255-05	2016-12-28 10:49:16.255-05	300	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	659	52806f02-8b52-4053-97ad-eb7b0f5c2c2a	51	857	15e6915f-7b39-479a-9293-be7114a8c55e
4425	DEBIT	Meetup Fees	-6000	USD	2016-12-28 10:44:44.222-05	2016-12-28 10:44:44.222-05	4	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	658	70f09e97-2754-4f16-9e9f-007e253cc35b	51	857	8ab5f270-de91-4e44-88c1-b4672d5b2995
4403	DEBIT	Meetup Fees	-6000	USD	2016-12-27 13:38:46.887-05	2016-12-27 13:38:46.887-05	59	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	654	46876e47-95e8-4b16-ad0e-63703c1710c6	51	857	612a3392-cf6e-4950-80d9-809a34a899cf
4401	DEBIT	Meetup Fee	-6000	USD	2016-12-27 13:35:08.624-05	2016-12-27 13:35:08.624-05	284	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	653	21af77e9-057a-48e4-bc42-cf6de40a4d0b	51	857	0b6638d9-7c71-466d-97c6-6e816e03d320
4396	DEBIT	Meetup Fees	-6000	MXN	2016-12-27 13:01:07.417-05	2016-12-27 13:01:07.417-05	10	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	651	c45178a3-9a29-4d14-b424-414faa770220	51	857	9e015a93-b01d-4472-bd71-440de9af554d
4390	DEBIT	Meetup Fees	-6000	USD	2016-12-27 12:49:39.83-05	2016-12-27 12:49:39.83-05	280	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	648	d59f9559-52ea-4838-86ac-9a89171e4edb	51	857	0aaacde4-838e-40d5-93df-95003cce0dfa
4394	DEBIT	Meetup Fees	-6000	MXN	2016-12-27 12:57:54.314-05	2016-12-27 12:57:54.314-05	282	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	650	3d47c24e-fc5a-4254-80eb-cc221aae8a7e	51	857	28ad78a3-733b-4961-9fb6-b78c083a5344
4392	DEBIT	Meetup Fees	-6000	AUD	2016-12-27 12:54:00.843-05	2016-12-27 12:54:00.843-05	281	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	649	4041ac58-5270-4993-8579-372862540f19	51	857	0c4fdfa7-de06-449e-8c87-0944eb1ea1b2
4388	DEBIT	Meetup Fees	-4900	GBP	2016-12-27 12:34:46.469-05	2016-12-27 12:34:46.469-05	278	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-4900	647	63c1fa30-5905-47e2-9922-3e50406c41e5	51	857	00693c59-9b95-4e66-bdc9-899041e763a7
4366	DEBIT	Meetup Fees	-6000	USD	2016-12-27 11:23:35.936-05	2016-12-27 11:23:35.936-05	13	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	634	19aac764-7f1c-4545-964c-aa419cddcadf	51	857	3d8fa24d-a09f-46fb-aa93-9e3628fdcdb1
4361	DEBIT	Meetup Fees	-6000	MXN	2016-12-27 11:12:26.224-05	2016-12-27 11:12:26.224-05	299	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	632	1475d9f0-a70a-479b-a7a5-0f944217dd0c	51	857	13d6aa98-8924-4982-b7da-5edf312e40f0
4364	DEBIT	Meetup Fees	-6000	USD	2016-12-27 11:16:27.082-05	2016-12-27 11:16:27.082-05	271	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	633	f733707f-81b8-4b1a-8fb4-5d36f7398e4d	51	857	3b983cb7-31dc-4ae9-8dd3-740f17c024a5
7082	DEBIT	Supplies for Agile workshop (2/26)	-5798	USD	2017-03-14 14:16:43.183-04	2017-03-14 14:16:43.22-04	59	171	2149	\N	\N	\N	\N	\N	198	USD	1	-5798	-5996	858	0f6dbfcd-8b66-44e1-8bfa-82b47855e172	827	857	346be754-0405-4f65-bd49-921f26eedf5f
1631	DEBIT	Coding books for our study groups (Humble Bundle -- Joy of Coding)	-1500	USD	2016-08-19 16:58:54.527-04	2016-08-19 16:58:54.67-04	48	142	573	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1500	318	0b0b7cb8-20eb-4ed8-b5eb-d5db91b35e38	696	857	74dc7397-13e8-40a6-a0d7-e27f5eb393dd
254	DEBIT	WwConnect2016	-1025	USD	2016-03-19 20:00:00-04	2016-06-14 14:14:21.806-04	14	31	26	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1025	64	f42fde8c-31a0-49b2-ae8e-8a12eca9f4f5	766	857	67b94b33-115e-4d61-afca-f71bd79b4328
1587	DEBIT	STEM Toys for Coding with Kids Event	-8496	USD	2016-08-16 10:58:01.764-04	2016-08-16 10:58:01.789-04	48	142	573	\N	\N	\N	\N	\N	\N	\N	\N	\N	-8496	294	bd8d9663-a174-448f-94f5-5e6707eb538d	696	857	1d8e7646-c4f5-46f5-bb87-4ce74d5e8323
1588	DEBIT	STEM Toys for Coding with Kids Event	-10212	USD	2016-08-16 10:58:32.03-04	2016-08-16 10:58:32.041-04	48	142	573	\N	\N	\N	\N	\N	\N	\N	\N	\N	-10212	293	40c6d6e9-1a20-4f97-b460-2a318d202796	696	857	543b884f-76a8-4ff2-a38e-25aeae75f561
7087	DEBIT	Leadership Development	-14915	MXN	2017-03-14 14:18:46.358-04	2017-03-14 14:18:46.358-04	511	3	\N	\N	\N	\N	\N	\N	0	MXN	1	-14915	-14915	886	1f55f0d6-8cb7-4e26-bbce-64660bfdf8ad	51	857	0f64e397-e397-445c-8a8f-93aa1afb8e33
7083	DEBIT	Leadership Development	-50616	MXN	2017-03-14 14:17:51.969-04	2017-03-14 14:17:51.969-04	282	3	\N	\N	\N	\N	\N	\N	0	MXN	1	-50616	-50616	887	f70817df-a428-4020-8076-87771fd39b1d	51	857	328ad965-0b97-47ce-b92e-72f60a09b0a3
7080	DEBIT	Wearable Clothing Workshop	-33412	USD	2017-03-14 14:00:11.436-04	2017-03-14 14:00:11.448-04	48	142	2149	\N	\N	\N	\N	\N	999	USD	1	-33412	-34411	815	cc901377-56a8-4787-a296-673763a20a9e	696	857	90f89aeb-63a4-4c2e-8f44-f7010f3156cc
7079	DEBIT	Movie screening for "She Started It"	-25700	USD	2017-03-14 13:59:53.142-04	2017-03-14 13:59:53.153-04	48	142	2149	\N	\N	\N	\N	\N	775	USD	1	-25700	-26475	814	af730af1-7a84-42eb-8443-96f03e6c8347	696	857	3357306e-955f-4b74-b4ad-ad2f0f1f84fb
4266	DEBIT	Meetup Fees	-6000	USD	2016-12-23 12:32:55.31-05	2016-12-23 12:32:55.31-05	195	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	622	f3c80fd2-e51b-4124-a687-69f0abae37d6	51	857	cad05bc1-4c78-4d6d-9a5c-0265427e6823
3949	DEBIT	Post-hackathon shipping supplies + supplies for Women + Tech Holiday Party	-3776	USD	2016-12-13 13:41:20.962-05	2016-12-13 13:41:21.652-05	59	3	1191	\N	\N	\N	\N	\N	\N	\N	\N	\N	-3776	\N	962a1612-7780-4b02-809c-bba5e34b9bf9	51	857	ad0da767-c1f5-4225-aed3-87879a26e119
538	DEBIT	Conference Grant - Sarah Olson	-110000	USD	2016-05-10 15:19:21.785-04	2016-06-14 14:14:22.032-04	48	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-110000	156	5b6a81e3-f2e8-4385-b39e-135cb7b5bb85	51	857	d5cf278b-fb86-4e76-83d2-f96bea636456
1627	DEBIT	Event supplies	-1797	USD	2016-08-19 13:24:23.638-04	2016-08-19 13:24:24.362-04	59	3	573	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1797	\N	aaa90df5-783d-4af5-aadb-848d7da27db0	51	857	6c5cbad7-77f0-4c09-a83b-3184ad449659
1580	DEBIT	Drinks for July monthly event	-3316	USD	2016-08-16 10:53:42.013-04	2016-08-16 10:53:42.04-04	15	3	573	\N	\N	\N	\N	\N	\N	\N	\N	\N	-3316	\N	bc1e4ea6-63a9-41a3-bd5a-a25ff1b41c37	51	857	e6d2f447-1af3-49db-b48c-46a0ca7e73c3
864	DEBIT	Reimburse Caterina Paun for Program Expenses	-9995	USD	2016-02-24 19:00:00-05	2016-06-14 14:14:22.175-04	59	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-9995	224	9f16d9b5-e350-4ca4-8b8f-59334d6ef9f3	51	857	a4f0f2c6-69a5-4c38-8423-81df04996159
674	DEBIT	CONFERENCE GRANT	-50000	USD	2016-05-10 20:00:00-04	2016-06-14 14:14:22.114-04	59	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-50000	196	7916b5ad-1d71-481f-b774-1a9d79d2c8e0	51	857	bae34342-5c90-404a-9d32-e6cac2303909
859	DEBIT	Global Development 	-150	USD	2016-06-09 14:38:16.857-04	2016-06-14 14:14:22.175-04	4	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-150	222	33ddf644-201a-470f-b745-de2dece2159b	51	857	4ce6a9d4-952b-4c77-bfe5-38e32a5f4f0e
377	DEBIT	WePay fee	-125	USD	2016-04-17 18:19:12.094-04	2016-06-14 14:14:21.883-04	13	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-125	95	535a716d-edbd-4914-9b57-78bd671fd49a	51	857	ed8bc2ad-07f3-4d02-b990-415e972b4ecf
539	DEBIT	Conference Expense	-8320	USD	2016-05-10 15:19:21.785-04	2016-06-14 14:14:22.042-04	48	3	\N	2016-06-14 14:14:22.515-04	\N	\N	\N	\N	\N	\N	\N	\N	-8320	158	158dcb8d-7226-4bd0-a0c6-601340d5ab84	51	857	7e07bf10-a45a-4da7-9706-bbdbd8d4b54d
8237	DEBIT	Meetup Fees	-6000	USD	2017-04-05 10:19:21.293-04	2017-04-05 10:19:21.293-04	295	3	\N	\N	\N	\N	\N	\N	0	USD	1	-6000	-6000	988	87b9bea2-2195-4ea2-b065-d18bc0c3368c	51	857	e2dd278f-032c-43a1-89b2-9ae04d39d763
4373	DEBIT	Meetup Fees	-6000	USD	2016-12-27 11:41:27.235-05	2016-12-27 11:41:27.235-05	272	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	638	c036838f-9cbc-45c5-935f-9d9b57ea2836	51	857	0f2fe6d5-6359-4065-87d4-6c3c37627fef
4371	DEBIT	Meetup Fees	-5700	EUR	2016-12-27 11:36:05.296-05	2016-12-27 11:36:05.296-05	298	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-5700	637	33760db0-25e7-4b85-89df-040f38e22adb	51	857	064218eb-be97-4251-887d-395af6b399db
4262	DEBIT	Meetup Fees	-5700	EUR	2016-12-23 12:15:16.054-05	2016-12-23 12:15:16.054-05	301	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-5700	620	274351b9-2cc0-438e-8c7d-4a8e7771bb0c	51	857	8aa5b486-c5c5-4288-9d6c-79ce00dc0f0b
4264	DEBIT	Meetup Fees	-6000	USD	2016-12-23 12:21:53.018-05	2016-12-23 12:21:53.018-05	259	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	621	0446afb9-0ce6-4148-a588-e6ac299a3997	51	857	56d9fbe4-73d8-4547-ade3-e6577e190e65
4260	DEBIT	Meetup Fees	-6000	USD	2016-12-23 12:10:34.733-05	2016-12-23 12:10:34.733-05	265	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	619	eb811f1b-7c0b-4d61-9105-9366e6aa84d8	51	857	0b520997-2aef-4c4a-bb20-a2e50394afd9
4258	DEBIT	Meetup Fees	-4900	GBP	2016-12-23 12:05:41.927-05	2016-12-23 12:05:41.927-05	264	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-4900	618	9a33a7df-c65b-40f9-9207-191220694bc5	51	857	fef8070e-9c22-4edb-b65d-63d1181e7962
4256	DEBIT	Meetup Fees	-6000	USD	2016-12-23 12:00:25.987-05	2016-12-23 12:00:25.987-05	263	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	617	57853d10-9d39-4960-9921-b48c4b182e12	51	857	78d119b6-c841-468f-b1c8-e37c916138e6
3622	DEBIT	Regional Leadership Director Meeting 	-7500	USD	2016-11-30 16:20:31.263-05	2016-11-30 16:20:31.464-05	269	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-7500	\N	7e10ae09-c940-4b3e-a151-459585138199	51	857	f79ccc4e-137c-4c9d-b29b-3915a37333f1
3613	DEBIT	Leadership Development - Conference Travel Stipend Google I/O	-130000	USD	2016-11-30 16:06:48.939-05	2016-11-30 16:06:49.116-05	241	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-130000	\N	6a1fa977-065a-47a6-bf3e-ae8934921597	51	857	6097c564-e731-4d41-89ed-eeeac61e9ed0
3599	DEBIT	Banner	-2000	USD	2016-11-30 13:40:24.258-05	2016-11-30 13:40:24.443-05	292	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-2000	\N	dddd092c-b5a8-475a-a35e-d4f12bc724d6	51	857	3fe0cd40-23e1-4791-b0bf-4b808bbeec1e
3591	DEBIT	Envelopes for hackathon sponsor prizes	-907	USD	2016-11-30 11:12:35.291-05	2016-11-30 11:12:35.54-05	2	3	1191	\N	\N	\N	\N	\N	\N	\N	\N	\N	-907	\N	eeee1a04-ad18-42e4-8252-db32a174e369	51	857	1b8c5874-2f34-4c12-b795-7f7be90b9dae
3589	DEBIT	Photos for sponsor gifts	-2104	USD	2016-11-30 11:11:36.238-05	2016-11-30 11:11:36.377-05	2	3	1191	\N	\N	\N	\N	\N	\N	\N	\N	\N	-2104	\N	5c8b4fc6-fa71-4ca6-ac8b-984c0d5fa454	51	857	30c4f29c-3f4f-4da6-900c-c064b137eeb1
2426	DEBIT	Engineering (Web) - A Small Orange	-12700	USD	2016-10-11 20:44:30.933-04	2016-10-11 20:44:31.081-04	48	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-12700	\N	0f9b2d4b-60a1-4cd9-b233-5569b822348d	51	857	309939b6-315f-46ff-8548-89055e027009
656	DEBIT	Conference Grant	-100000	USD	2016-05-24 15:42:50.307-04	2016-06-14 14:14:22.103-04	3	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-100000	189	e8d5c717-1fca-4334-96d2-b8fa8d899ca1	51	857	d8bc7439-422d-4132-ab45-9346696275fd
2302	DEBIT	Network Stickers	-58590	USD	2016-10-06 12:08:07.615-04	2016-10-06 12:08:07.66-04	3	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-58590	\N	b48ad8e6-3729-4d25-be11-03328df1f7b8	51	857	f0af53e4-c393-4b2b-9ee5-97189f281ec3
2260	DEBIT	Food at our Sept. monthly event	-11478	USD	2016-10-04 18:07:11.046-04	2016-10-04 18:07:11.615-04	15	3	573	\N	\N	\N	\N	\N	\N	\N	\N	\N	-11478	\N	bbb5901e-3328-4653-a858-b80c40422cd0	51	857	73aa80f4-7a3a-4f3c-9919-f547e7b7dcbe
2241	DEBIT	90/10 split: Syema Ailia	-250	USD	2016-10-04 12:06:23.454-04	2016-10-04 12:06:23.454-04	12	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-250	390	3e7d1081-0039-41e3-b36f-4b37b44b3e0c	51	857	cbe30c5b-cd47-4005-b7f6-a3ad91c7ca62
2240	DEBIT	90/10 split: Beth Laing	-500	USD	2016-10-04 12:06:16.796-04	2016-10-04 12:06:16.796-04	12	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-500	392	0c5e3510-cf16-42de-bde2-147e6ab9a46d	51	857	d966f041-a4b8-4663-ab1e-eda5a1c28a0d
2815	DEBIT	Markers, pens, sticky notes (ATXDivHack)	-2108	USD	2016-10-31 17:13:19.592-04	2016-10-31 17:13:19.745-04	2	28	1043	\N	\N	\N	\N	\N	\N	\N	\N	\N	-2108	448	812a47a9-0b51-4948-9963-c610c2bbea43	847	857	44a0999f-b2ed-4be0-a3ca-1c4ac3961923
2814	DEBIT	Drinks and snacks (ATXDivHack)	-75932	USD	2016-10-31 17:13:05.943-04	2016-10-31 17:13:06.106-04	2	28	1043	\N	\N	\N	\N	\N	\N	\N	\N	\N	-75932	449	2e748309-ca69-4812-83e1-506c5649d783	847	857	a7fbb2b4-b67a-49e2-81ad-6e32c01e5405
2812	DEBIT	June South Hack Night	-20568	USD	2016-10-31 17:11:20.573-04	2016-10-31 17:11:20.753-04	2	28	1042	\N	\N	\N	\N	\N	\N	\N	\N	\N	-20568	451	540d3476-03f3-4c01-9191-0b4593c34fd4	847	857	8b640bae-f50c-4f7a-9ac2-fd8eb0604f94
2816	DEBIT	Drinks for Happy Hour (ATXDivHack)	-5518	USD	2016-10-31 17:13:39.794-04	2016-10-31 17:13:40.146-04	2	28	1043	\N	\N	\N	\N	\N	\N	\N	\N	\N	-5518	447	635f6580-ccbc-4232-bf25-eded2b10fdd7	847	857	842645f1-0a3a-485d-8d18-0ada1dedaf58
2811	DEBIT	May AI Workshop	-26800	USD	2016-10-31 17:10:54.112-04	2016-10-31 17:10:54.327-04	2	28	1042	\N	\N	\N	\N	\N	\N	\N	\N	\N	-26800	452	db3e939f-96e8-4790-bba4-e8a8a33ac1b2	847	857	ddc479b1-0893-4493-8881-f9ad8e42748a
2813	DEBIT	September Ruby Tuesday	-6497	USD	2016-10-31 17:11:36.488-04	2016-10-31 17:11:36.731-04	2	28	1042	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6497	450	82a4bfeb-95ef-4a2a-9d9d-5ca157938b53	847	857	2a1ddc60-2a7a-415b-ac43-4a93701e415b
2739	DEBIT	DJ (ATXDivHack)	-35000	USD	2016-10-27 17:08:48.506-04	2016-10-27 17:08:48.71-04	2	28	1024	\N	\N	\N	\N	\N	\N	\N	\N	\N	-35000	453	4bfee0a6-77d3-4608-92bb-fb59f6d1f3f2	847	857	ef5e10c6-a5eb-4754-8611-d3e59c8d659e
3332	DEBIT	Thank you cards, Christmas cards, stamps (for hackathon and all 2016 sponsors)	-4874	USD	2016-11-22 16:55:10.575-05	2016-11-22 16:55:10.713-05	59	171	1191	\N	\N	\N	\N	\N	\N	\N	\N	\N	-4874	498	f33703a8-5093-41fa-8cc7-0f246e735325	827	857	1931df99-c5d5-42af-aae3-ffc3038eb6a0
2805	DEBIT	Food for JavaScript Study Night - Oct. 11th	-1446	USD	2016-10-31 14:19:11.822-04	2016-10-31 14:19:12.067-04	59	171	1024	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1446	419	e2c41034-2610-460e-814d-b143dc9280fe	827	857	f932e404-8d34-4881-a581-c9545d1f17c1
2288	DEBIT	Marketing Materials	-2475	USD	2016-10-05 12:45:14.357-04	2016-10-05 12:45:14.485-04	59	171	573	\N	\N	\N	\N	\N	\N	\N	\N	\N	-2475	376	a346ac76-b04b-4514-be71-84d9bf2c88ce	827	857	5d6ec404-9928-4fcd-ac2e-15dc65071fe2
2287	DEBIT	Event Food	-7167	USD	2016-10-05 12:44:47.862-04	2016-10-05 12:44:48.013-04	59	171	573	\N	\N	\N	\N	\N	\N	\N	\N	\N	-7167	378	0591fc4f-0d49-4e83-ac11-6f4b4e5475ea	827	857	01d5c213-fa67-4c0d-a4df-c7ff2c72de37
3793	DEBIT	We Code Hackathon 2016	-2374	USD	2016-12-06 11:50:34.842-05	2016-12-06 11:50:35.964-05	59	171	1191	\N	\N	\N	\N	\N	\N	\N	\N	\N	-2374	500	38b70e02-a7b4-40c6-952d-6af6478b8b15	827	857	fc486953-6f99-47d7-8862-2bc437d599e6
2286	DEBIT	Event supplies	-2715	USD	2016-10-05 12:44:00.394-04	2016-10-05 12:44:00.521-04	59	171	573	\N	\N	\N	\N	\N	\N	\N	\N	\N	-2715	375	42291373-8c70-4ccc-b6c1-ec4c36403599	827	857	80ce1240-6451-4150-b033-2ef25e07425d
3843	DEBIT	Leadership Event in Sofia	-6444	EUR	2016-12-07 16:38:07.287-05	2016-12-07 16:38:07.429-05	301	1379	1191	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6444	471	4ca35a75-88d7-4546-b608-ce07199942fb	800	857	75d45d59-c888-4665-8cdd-905067fda701
3835	DEBIT	Leadership Event in Sofia	-1019	EUR	2016-12-07 16:30:48.339-05	2016-12-07 16:30:48.523-05	301	1379	1191	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1019	470	84e835ea-fd72-47a5-8dd8-92a3cee7fe26	800	857	c06dc633-ea26-4447-bf1c-64b326b75f7d
2800	DEBIT	WWCode Seattle planning lunch with Sara	-2700	USD	2016-10-31 13:52:44.962-04	2016-10-31 13:52:45.274-04	14	32	1024	\N	\N	\N	\N	\N	\N	\N	\N	\N	-2700	420	de0990ce-e767-47a3-8594-d6d7dc3f62c7	797	857	b2df7d58-e036-4806-ae38-c80cf969e5a9
2763	DEBIT	lunch ordered at Costco	-64978	USD	2016-10-28 17:30:59.537-04	2016-10-28 17:30:59.772-04	300	1371	1024	\N	\N	\N	\N	\N	\N	\N	\N	\N	-64978	418	19a3cace-58b7-4661-b4a1-076155bb69aa	795	857	e07a423d-3ffd-4f9e-8151-3bdc13b4c2df
2809	DEBIT	Costco breakfast, lunch, drinks, plates, cups, utensils, snacks, deserts ...	-48435	USD	2016-10-31 17:08:49.332-04	2016-10-31 17:08:49.517-04	300	1371	1042	\N	\N	\N	\N	\N	\N	\N	\N	\N	-48435	417	7bfc67b7-3dd7-4f2c-a42e-1fd52bf01230	795	857	dc15cb90-b7be-4bff-a979-08fc9d64894e
2801	DEBIT	Monthly core team meeting. Beverages with dinner for six members 	-3080	USD	2016-10-31 13:59:53.602-04	2016-10-31 13:59:53.96-04	14	31	1024	\N	\N	\N	\N	\N	\N	\N	\N	\N	-3080	401	6071a2e5-9c4e-4724-98ef-faa4c9b34169	766	857	0a05e240-0f6e-4652-98ef-2f1786107966
2810	DEBIT	500 gift cards, 19.62 printed awards	-51962	USD	2016-10-31 17:09:11.281-04	2016-10-31 17:09:11.484-04	300	1371	1042	\N	\N	\N	\N	\N	\N	\N	\N	\N	-51962	416	34e49664-e27e-4576-9895-33d5e0ddf2f8	795	857	006dc738-3846-441d-887c-9a2f0b20dca1
2942	DEBIT	food/drink for organizers of NODE workshop (had to buy from on-site snack bar)	-2838	USD	2016-11-03 17:13:31.956-04	2016-11-03 17:13:32.241-04	12	70	1117	\N	\N	\N	\N	\N	\N	\N	\N	\N	-2838	409	edf0f89b-9f88-4050-a39b-a1c03329fd49	762	857	440bc1da-d04f-4303-a1b6-533fb191c758
4139	DEBIT	Leadership - Planning for 2017 - Afternoon Coffee	-1175	USD	2016-12-19 13:42:59.021-05	2016-12-19 13:42:59.545-05	48	142	1191	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1175	601	8d0fb08a-cd76-4efd-acb9-1f5b191f029c	696	857	b3cc48a0-39d1-48ca-a13f-331a2302ffc3
4140	DEBIT	Leadership - Planning for 2017 - Evening Coffee	-875	USD	2016-12-19 13:43:53.809-05	2016-12-19 13:43:54.334-05	48	142	1191	\N	\N	\N	\N	\N	\N	\N	\N	\N	-875	603	f95b80fd-f1aa-4343-894f-09450d3990a7	696	857	8fe5b776-cde9-4083-bc93-3d1f92178045
4137	DEBIT	Robotics: Coding with Your Kids HackNight Supplies	-20397	USD	2016-12-19 11:20:39.625-05	2016-12-19 11:20:40.499-05	48	142	1191	\N	\N	\N	\N	\N	\N	\N	\N	\N	-20397	604	b7646d69-4189-45a4-8672-7c783ff2f2b7	696	857	e18c0040-ab6a-4a72-b056-966be4a67e7d
4141	DEBIT	Leadership - Planning for 2017 - Dinner	-9240	USD	2016-12-19 13:45:09.113-05	2016-12-19 13:45:09.64-05	48	142	1191	\N	\N	\N	\N	\N	\N	\N	\N	\N	-9240	602	03814f58-ecac-4145-b6bc-f448075970e0	696	857	0b88f790-7ef8-4c0d-bffe-09be53b838a8
3972	DEBIT	3D Printer & Supplies	-30496	USD	2016-12-14 08:03:21.144-05	2016-12-14 08:03:21.949-05	48	142	1191	\N	\N	\N	\N	\N	\N	\N	\N	\N	-30496	591	9e429b4f-81f9-4ff9-bf62-9f292e3e9b1e	696	857	7fcc9779-9f25-4a5a-a591-ba20f322ec11
4230	DEBIT	Website - Domain Name	-2200	USD	2016-12-22 17:19:51.088-05	2016-12-22 17:19:52.143-05	48	142	1476	\N	\N	\N	\N	\N	\N	\N	\N	\N	-2200	372	09bf7a91-7939-4a04-80b5-721c536454af	696	857	e11bc7ca-5cee-4121-87c2-77aca0b7bc00
1630	DEBIT	Dinner for last night's HackNight	-13526	USD	2016-08-19 16:58:34.342-04	2016-08-19 16:58:34.554-04	48	142	573	\N	\N	\N	\N	\N	\N	\N	\N	\N	-13526	319	e4f6cb02-9565-4e90-8156-b4b6f7190889	696	857	423bdd9d-94bf-4449-89ca-a4b461c22f21
2111	DEBIT	My coworker donated his evening to giving demos of his personal Oculus Rift for our AR/VR event, so I sent him a gift card to thank him for his help with the event.	-2500	USD	2016-09-27 15:33:54.08-04	2016-09-27 15:33:54.272-04	48	142	573	\N	\N	\N	\N	\N	\N	\N	\N	\N	-2500	367	4593d1b5-cc34-42f2-9f9a-00a5e0bb8366	696	857	35afd412-dd6d-48e3-9b88-0938d4e4fb40
2110	DEBIT	Two VR headsets for our AR/VR event at Best Buy.	-4898	USD	2016-09-27 15:31:43.164-04	2016-09-27 15:31:43.42-04	48	142	573	\N	\N	\N	\N	\N	\N	\N	\N	\N	-4898	366	20ddc19e-87b3-4e08-9648-4ae868f40fe9	696	857	dee30261-9267-4820-97f8-ea7b59fc6215
3795	DEBIT	Supplies	-3918	USD	2016-12-06 11:51:20.162-05	2016-12-06 11:51:20.661-05	59	171	1191	\N	\N	\N	\N	\N	\N	\N	\N	\N	-3918	508	e74be4f9-1c06-4a7a-ae85-656ef5ecf2e9	827	857	34df37d5-950b-4a12-b340-46fa53cbd88e
3331	DEBIT	Thank you bags (16) for hackathon speakers and judges, and for pre-hackathon events volunteers and sponsors.  Each bag contains a WWCode Portland coffee mug, a chocolate bar, ghirardellis squares, and a thank you card.	-8181	USD	2016-11-22 16:54:33.366-05	2016-11-22 16:54:33.644-05	59	171	1191	\N	\N	\N	\N	\N	\N	\N	\N	\N	-8181	499	bf974271-bd1f-43fd-b113-f1c26a528e73	827	857	fc84fb74-1df6-4619-95f2-bba7f3be7ec2
3313	DEBIT	Thank you gift to an amazing sponsor!	-1700	USD	2016-11-22 07:31:00.49-05	2016-11-22 07:31:00.691-05	59	171	1191	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1700	501	125a7d4b-8e1c-43c0-af9a-e948de08c5a3	827	857	268c3a64-2607-4c10-b71f-ff1262281e29
6199	DEBIT	Domain name for hackathon and study night projects	-1798	USD	2017-02-20 15:53:02.864-05	2017-02-20 15:53:02.879-05	59	171	1893	\N	\N	\N	\N	\N	\N	\N	\N	\N	-1798	497	3aae7b32-dbf9-4383-94eb-9c339211043a	827	857	59f36c91-93a4-4be4-b7bb-0aca6550054f
5787	DEBIT	Food for 2017 Planning Meeting w/ leadership team (Jan. 22)	-9050	USD	2017-02-07 13:40:49.494-05	2017-02-07 13:40:49.852-05	59	171	1718	\N	\N	\N	\N	\N	\N	\N	\N	\N	-9050	790	e25d3885-580e-477b-ac27-6dfaa2ab8466	827	857	e1301829-9efd-4a95-8d1e-8d3ec6f07ced
7072	DEBIT	meetup with speaker, Heather VanCura, in conjunction with DevNexus conference	-20950	USD	2017-03-14 13:22:10.666-04	2017-03-14 13:22:10.681-04	12	70	1893	\N	\N	\N	\N	\N	638	USD	1	-20950	-21588	899	bef0ae4e-365f-4158-a0e0-ee82ba3b21e6	762	857	9eec12b6-ad3b-43af-9210-3a6e030240ca
4268	DEBIT	Meetup Fees	-6000	AUD	2016-12-23 12:42:18.688-05	2016-12-23 12:42:18.688-05	266	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-6000	623	f36420c0-4283-44cb-a9c5-d91eb735988f	51	857	e1d8cf75-2f5f-4e99-b0b8-063950419e57
1403	DEBIT	Transportation for Sandra and Cici to get to meeting location with core team members	-749	USD	2016-08-02 09:39:15.789-04	2016-08-02 09:39:15.797-04	14	31	320	\N	\N	\N	\N	\N	\N	\N	\N	\N	-749	256	c50bb623-b773-41c6-b71f-c815f6a3394c	766	857	dfb13291-16e5-4d17-ad52-e71ff6a97aab
3838	DEBIT	Food for monthly hack night from Antonino Bertolo's Pizza & Wine Bar.	-4300	USD	2016-12-07 00:00:00.86-05	2016-12-07 00:00:00.86-05	273	1325	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-4351	483	01ad80e1-007c-45b3-8b32-1583b3417b16	843	857	cc3cfa5f-6000-4638-a3ac-290b798dd568
668	DEBIT	Leadership Tools (director tees)	-2698	USD	2015-12-14 19:00:00-05	2016-06-14 14:14:22.114-04	48	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-2698	192	f90b7ceb-7395-4eb6-b70e-aa3b53a18421	51	857	18e8fd0f-2b5c-4e62-9ac4-93137ef9ab8b
10604	CREDIT	\N	100000	USD	2017-03-27 13:52:38.123-04	2017-03-27 13:52:38.123-04	51	3	\N	2017-10-26 17:24:06.244-04	\N	2153	\N	\N	\N	USD	1	100000	100000	\N	4ccf2436-79dd-460e-8c35-16fe043534c7	\N	857	0082b1d9-f1eb-4a91-b6d5-031794faaf9b
7525	CREDIT	\N	100000	USD	2017-03-27 13:52:38.123-04	2017-03-27 13:52:38.123-04	277	3	\N	\N	\N	2153	0	0	0	USD	1	100000	100000	\N	5fd1044d-b479-447e-bfb5-e6f578c69921	857	857	0082b1d9-f1eb-4a91-b6d5-031794faaf9b
10751	CREDIT	Conference Travel Stipend - Google I/O Elese	75000	USD	2016-11-30 16:25:31.161-05	2016-11-30 16:25:41.165-05	51	3	\N	2017-10-26 17:24:06.25-04	\N	\N	\N	\N	\N	\N	1	\N	75000	\N	9fc8ac0f-09a2-4c6c-8c92-d2c21a675305	\N	857	00da65f6-8655-4ede-baf0-d292f707473f
3624	CREDIT	Conference Travel Stipend - Google I/O Elese	75000	USD	2016-11-30 16:25:31.161-05	2016-11-30 16:25:41.165-05	276	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	75000	\N	09bd1cc4-9ecf-4dd9-a3a6-2bfe654015da	857	857	00da65f6-8655-4ede-baf0-d292f707473f
10576	CREDIT	\N	100000	USD	2017-04-17 18:09:42.57-04	2017-04-17 18:09:42.57-04	51	3	\N	2017-10-26 17:24:06.255-04	\N	2477	\N	\N	\N	USD	1	100000	100000	\N	30e5a7a5-8c2a-426b-b10a-9b966bc2d3be	\N	857	0181d00b-2103-42e7-b060-21a5a26bce9b
8615	CREDIT	\N	100000	USD	2017-04-17 18:09:42.57-04	2017-04-17 18:09:42.57-04	270	3	\N	\N	\N	2477	0	0	0	USD	1	100000	100000	\N	d6795ff7-d1a1-4a77-a77b-a0731062a244	857	857	0181d00b-2103-42e7-b060-21a5a26bce9b
10710	DEBIT	Global Development for Meetup Fee	-6000	USD	2016-12-23 14:48:39.526-05	2016-12-23 14:48:39.685-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	1ab7afa4-12be-4e18-b7df-5338f05f1d2a	270	857	021ea432-c8b9-47b1-a087-d11a98cdae64
10771	CREDIT	Global Development	19100	USD	2016-11-29 17:17:18.389-05	2016-11-29 17:17:18.558-05	51	3	\N	2017-10-26 17:24:06.265-04	\N	\N	\N	\N	\N	\N	1	\N	19100	\N	914069d1-812a-4f62-b3c7-c1d3cf2050c6	\N	857	02e2e8cb-75b1-435c-8848-a15099d69a24
8705	CREDIT	\N	1480	USD	2017-04-19 14:18:19.043-04	2017-04-19 14:18:19.043-04	2	3	\N	\N	\N	2519	0	0	0	USD	1	1480	1480	\N	48409b35-4280-4659-971c-3ec3178252f0	857	857	03af26d7-0f9b-4078-a245-2f51bd327f0f
10866	CREDIT	Global Development for Meetup Fee	6000	MXN	2016-12-27 11:10:30.416-05	2016-12-27 11:10:30.529-05	51	3	\N	2017-10-26 17:24:06.29-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	97ee5768-3f84-48b0-bade-21f3351fc089	\N	857	058d345c-2203-452f-bb56-903f4fb5255d
11089	CREDIT	Network budget pre Open Collective 	162598	USD	2016-10-12 01:01:43.648-04	2016-10-12 01:01:43.828-04	51	3	\N	2017-10-26 17:24:06.314-04	\N	\N	\N	\N	\N	\N	1	\N	162598	\N	95f71e4d-9535-4a6b-8c18-b0eeaf79d73d	\N	857	0cbf3e92-b02b-49b7-95f2-2f93efbcfa86
4263	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-23 12:20:13.429-05	2016-12-23 12:20:13.545-05	259	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6000	\N	6d9dd70c-2b98-4094-8a7f-d8d14ebdfe64	857	857	0d9e6906-e705-4919-aa9c-057ed092fc23
8308	CREDIT	VMWare foundation Donation - global development (Ramya V., Swathi U. and Anonymous) 	24750	USD	2017-04-07 12:43:42.261-04	2017-04-07 12:43:42.673-04	262	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	27a1347b-f50e-4eb5-af41-d06f4b4bc654	857	857	2c703f5f-0ba5-4961-9cd1-1d82e9347ad4
10529	CREDIT	\N	1190	USD	2017-04-19 14:26:58.997-04	2017-04-19 14:26:58.997-04	51	3	\N	2017-10-26 17:24:06.535-04	\N	2521	\N	\N	\N	USD	1	1190	1190	\N	d62b7660-4519-4625-8151-d5304625b727	\N	857	32f9fb80-3dd9-4049-8c37-e3aca02b4aaa
10804	CREDIT	Global Development for Meetup Fee	5700	EUR	2016-12-27 11:34:45.59-05	2016-12-27 11:34:45.771-05	51	3	\N	2017-10-26 17:24:06.559-04	\N	\N	\N	\N	\N	\N	1	\N	5700	\N	082cb248-2dbb-45f0-8b40-ad4589f5a967	\N	857	36493410-978b-4ea4-a1d4-bec57607bfd2
11142	CREDIT	Nike Donation	50000	USD	2016-06-10 00:08:56.525-04	2016-06-10 00:08:56.991-04	51	3	\N	2017-10-26 17:24:06.632-04	\N	\N	\N	\N	\N	\N	1	\N	50000	\N	e8b1d57e-6f31-423e-ba77-8d3192895ce0	\N	857	446ac15a-83a5-430d-bc9e-f62541ce6788
10587	DEBIT	\N	-4250	GBP	2017-04-17 17:06:54.803-04	2017-04-17 17:06:54.803-04	857	3	\N	\N	\N	2475	0	\N	0	GBP	1	-4250	-4250	\N	1771c176-8c8a-480b-98fa-88284a75aa04	278	857	62eb6e83-1ce1-4f13-a8c3-6ae7b49506f8
11058	CREDIT	Travel Stipend for CONNECT	50000	USD	2017-04-03 16:24:58.616-04	2017-04-03 16:24:58.879-04	51	3	\N	2017-10-26 17:24:07.224-04	\N	\N	\N	\N	\N	\N	1	\N	50000	\N	d7adacff-8bd5-4b31-a98b-ddd34d88c5da	\N	857	b5a5562c-e980-4f58-a2aa-4a9edaec0d91
10683	CREDIT	Global Development for Meetup Fee	6000	AUD	2016-12-27 12:52:16.09-05	2016-12-27 12:52:16.167-05	51	3	\N	2017-10-26 17:24:07.533-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	a207dad5-2f4a-4a6a-87ba-47c31c8669a8	\N	857	f06c085e-9131-40e1-a69b-49f43a043568
11076	CREDIT	$500 OpenGov hackathon support - transaction and global development	43500	USD	2016-11-17 13:36:48.896-05	2016-11-17 13:36:49.046-05	51	3	\N	2017-10-26 17:24:06.271-04	\N	\N	\N	\N	\N	\N	1	\N	43500	\N	7306e47c-17f8-4d27-94bf-1762fbb49e65	\N	857	037e8a19-cadd-4281-9061-a544689d4c51
10872	CREDIT	Generous donation from Target to support WWCode Twin Cities	500000	USD	2016-05-26 14:37:24.922-04	2016-05-26 14:37:23.286-04	51	3	\N	2017-10-26 17:24:06.294-04	\N	\N	\N	\N	\N	\N	1	\N	500000	\N	838849d3-1716-4c5d-b1f2-893229580141	\N	857	0871a018-40ba-4634-9bde-65a47b006184
10730	CREDIT	Global Development for Meetup Fee	6000	USD	2016-12-27 14:54:51.439-05	2016-12-27 14:54:51.679-05	51	3	\N	2017-10-26 17:24:06.318-04	\N	\N	\N	\N	\N	\N	1	\N	6000	\N	9c8442ce-6d63-4422-8b30-cacf047db1d7	\N	857	0cfc2cff-42a6-44d4-9ee9-e59f07fe304c
10962	DEBIT	Global Development for Meetup Fee	-6000	USD	2016-12-23 12:20:13.429-05	2016-12-23 12:20:13.545-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	9f2ca746-3858-44dd-af90-a64684ccd019	259	857	0d9e6906-e705-4919-aa9c-057ed092fc23
3519	CREDIT	Network Development - 10k member bonus	100000	USD	2016-11-29 16:58:23.625-05	2016-11-29 16:58:23.799-05	4	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	100000	\N	2266fe36-fda5-4fbb-bca6-7cda7e67318b	857	857	0dd3db16-97eb-4b65-8cb9-c91554d5d325
10663	CREDIT	WOMEN TECHMAKER WWCODE PARTNERSHIP GRANT	50000	USD	2016-05-26 16:48:43.015-04	2016-05-26 16:48:43.336-04	51	3	\N	2017-10-26 17:24:06.76-04	\N	\N	\N	\N	\N	\N	1	\N	50000	\N	3c7a63ee-b039-46c5-9548-87650f1497ea	\N	857	5c17f156-0581-44a0-a2ae-8cbc3078f2a7
10986	DEBIT	Global Development - thanks VMWare	-50000	USD	2016-11-29 18:07:50.964-05	2016-11-29 18:07:51.154-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-50000	-50000	\N	e950c492-bb03-4813-967a-ee1b152cffd4	289	857	5de80078-7915-4bff-89f1-6ef4da815073
3614	CREDIT	Leadership development - conference stipend Google I/O	130000	USD	2016-11-30 16:07:12.142-05	2016-11-30 16:07:12.419-05	241	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	130000	\N	e8834ded-c290-4ab8-b367-c3356b2c9eb3	857	857	7773592c-36cc-44a6-8756-edae871029b6
11054	CREDIT	Women Techmaker/WWCode Partnership Grant	50000	USD	2016-05-16 16:01:14.238-04	2016-05-16 16:01:14.49-04	51	3	\N	2017-10-26 17:24:07.018-04	\N	\N	\N	\N	\N	\N	1	\N	50000	\N	fc1c47d4-fb3a-45e5-81c3-6bd71b2617f3	\N	857	8a82c2a5-02f0-42dd-96cd-ad71dddc6206
11065	CREDIT	Women Who Code Atlanta &amp; DevNexus Soirée global networks support	1450	USD	2017-03-13 13:06:48.459-04	2017-03-13 13:06:51.099-04	51	3	\N	2017-10-26 17:24:07.252-04	\N	\N	\N	\N	\N	\N	1	\N	1450	\N	e5bb1277-a9f0-4073-bef8-64b18a1368e2	\N	857	bd495fef-c3fa-493d-bf0c-0c19d90890f6
11010	CREDIT	I am an active member and WWC has taken my career in tech to the next level. All the support and lessons from the WWC DC chapter are instrumental in me remaining in this field.	2250	USD	2016-10-06 13:23:39.409-04	2016-10-06 13:23:39.459-04	51	3	\N	2017-10-26 17:24:07.278-04	\N	\N	\N	\N	\N	\N	1	\N	2250	\N	992122f9-867c-4412-be18-8fd8dd2e78cd	\N	857	c3c539d8-b0c5-4511-a89b-0529f94161ac
3207	CREDIT	$500 OpenGov hackathon support - transaction and global development	43500	USD	2016-11-17 13:36:48.896-05	2016-11-17 13:36:49.046-05	59	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	43500	\N	3726c26f-142a-4030-9306-3dbaad9081f0	857	857	037e8a19-cadd-4281-9061-a544689d4c51
10930	CREDIT	Donation via meetup - fees and global development	775	USD	2016-12-13 15:20:15.375-05	2016-12-13 15:20:15.714-05	51	3	\N	2017-10-26 17:24:06.287-04	\N	\N	\N	\N	\N	\N	1	\N	775	\N	453ccc5c-f6a1-4c73-9bbd-879d1cd43531	\N	857	0514135f-eb0f-4337-8233-21f5435796e9
666	CREDIT	Generous donation from Target to support WWCode Twin Cities	500000	USD	2016-05-26 14:37:24.922-04	2016-05-26 14:37:23.286-04	48	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	500000	\N	345acef4-87b2-455f-beef-b23517d7a460	857	857	0871a018-40ba-4634-9bde-65a47b006184
11095	DEBIT	Network budget pre Open Collective 	-162598	USD	2016-10-12 01:01:43.648-04	2016-10-12 01:01:43.828-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-162598	-162598	\N	a6bf5088-d9ab-459c-893a-e1ab7c5437a4	264	857	0cbf3e92-b02b-49b7-95f2-2f93efbcfa86
10687	DEBIT	Global Development for Meetup Fee	-6000	MXN	2016-12-27 12:56:03.911-05	2016-12-27 12:56:03.985-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-6000	-6000	\N	7b0a7f18-6a3f-4a36-b8bd-7d4a435e45c0	282	857	3816d92b-0193-4261-a649-54ca1df0cdd8
10617	CREDIT	Macy's donation - fees and global development	435000	USD	2017-02-13 19:21:10.361-05	2017-02-13 19:21:10.558-05	51	3	\N	2017-10-26 17:24:07.08-04	\N	\N	\N	\N	\N	\N	1	\N	435000	\N	3286500b-c40a-4aa3-a71a-2678a739b4a9	\N	857	98506445-e9b9-4c48-abb2-54cd8063ee3c
11118	DEBIT	Network budget balance pre Open Collective	-34240	USD	2016-10-04 17:49:31.268-04	2016-10-04 17:49:31.543-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-34240	-34240	\N	4f914315-06ab-4626-8ddd-ce400ac69a8e	15	857	b34aff4d-b3dc-4bf7-80e6-d25d077917d5
10534	CREDIT	\N	1480	USD	2017-04-19 14:18:19.043-04	2017-04-19 14:18:19.043-04	51	3	\N	2017-10-26 17:24:06.276-04	\N	2519	\N	\N	\N	USD	1	1480	1480	\N	46353efa-411f-44e4-86c5-cc28ac5765ce	\N	857	03af26d7-0f9b-4078-a245-2f51bd327f0f
10517	CREDIT	From Deepa	1500	USD	2016-04-12 17:19:00.212-04	2016-04-12 17:19:00.529-04	51	3	\N	2017-10-26 17:24:06.299-04	\N	\N	\N	\N	\N	\N	1	\N	1500	\N	7be7d431-0141-4cd6-9568-5a9823612133	\N	857	096bc827-7737-4ee6-971e-b26926be0c02
10920	DEBIT	Google I/O stipend	-75000	USD	2016-10-11 12:01:42.326-04	2016-10-11 12:01:43.286-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-75000	-75000	\N	cf7b0d64-f469-4ab9-859a-63c46ac83527	195	857	0b1c37d3-abdb-49d6-ba08-be87d4b0ccbc
7042	CREDIT	Women Who Code Atlanta &amp; DevNexus Soirée - fees + global	10875	USD	2017-03-13 13:05:28.744-04	2017-03-13 13:05:31.582-04	12	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	10875	\N	c188572e-6d9c-4795-8540-7fd3bcea20bf	857	857	171271be-3b4f-40b2-be9b-6184c8e4bacc
10722	CREDIT	VMWare foundation Donation - global development (Ramya V., Swathi U. and Anonymous) 	24750	USD	2017-04-07 12:43:42.261-04	2017-04-07 12:43:42.673-04	51	3	\N	2017-10-26 17:24:06.47-04	\N	\N	\N	\N	\N	\N	1	\N	24750	\N	15f3a3b1-1628-4628-8dff-db145bfe4171	\N	857	2c703f5f-0ba5-4961-9cd1-1d82e9347ad4
10991	DEBIT	Network Development	-20000	USD	2016-11-29 17:43:53.719-05	2016-11-29 17:43:53.971-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-20000	-20000	\N	7bc8c63e-52ed-4adf-91e6-d1aaf6ae8640	286	857	3771b950-122d-47e5-a2c6-a13811970366
3524	CREDIT	Network Budget Balance Pre Open Collective	17475	USD	2016-11-29 17:28:03.065-05	2016-11-29 17:28:03.231-05	282	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	17475	\N	3ca715da-37c9-48d6-8b41-15a1dd421d81	857	857	37dca71f-17eb-4664-9ebe-41b327bd6519
3206	CREDIT	$3500 Course Hero Hackathon support - transaction & global development	304500	USD	2016-11-17 13:27:12.528-05	2016-11-17 13:27:12.742-05	59	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	304500	\N	05d80488-2759-4454-abe3-0a379836df31	857	857	73e8270e-fe8d-4fef-9c9f-a0b3ed87e722
10628	CREDIT	Taipei Donation - fees and global development	800	USD	2017-02-06 15:11:26.406-05	2017-02-06 15:11:26.522-05	51	3	\N	2017-10-26 17:24:07.046-04	\N	\N	\N	\N	\N	\N	1	\N	800	\N	77622831-f756-484a-a372-45f791aff701	\N	857	90aecccb-f9cf-44a8-80b8-d14ac68b2d19
10905	DEBIT	Network development - thanks Atlassian	-50000	USD	2016-10-11 15:30:14.934-04	2016-10-11 15:30:15.155-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-50000	-50000	\N	fe4ac008-729e-491d-a4e6-537043acde48	297	857	912773e6-b3d9-42c3-82a5-d7e45d37b780
11060	CREDIT	\N	1200	USD	2017-05-04 14:58:24.9-04	2017-05-04 14:58:24.9-04	51	3	\N	2017-10-26 17:24:06.283-04	\N	2713	\N	\N	\N	USD	1	1200	1200	\N	98b68d64-a908-407a-85d9-15506774273c	\N	857	0401add2-5530-43d2-a6ed-1be087f38b42
10912	CREDIT	Google I/O stipend	75000	USD	2016-10-11 12:01:42.326-04	2016-10-11 12:01:43.286-04	51	3	\N	2017-10-26 17:24:06.304-04	\N	\N	\N	\N	\N	\N	1	\N	75000	\N	6d8fedcd-d5cb-4604-b7c8-a4a0713a69f6	\N	857	0b1c37d3-abdb-49d6-ba08-be87d4b0ccbc
10780	CREDIT	Network Development - 10k member bonus	100000	USD	2016-11-29 16:58:23.625-05	2016-11-29 16:58:23.799-05	51	3	\N	2017-10-26 17:24:06.328-04	\N	\N	\N	\N	\N	\N	1	\N	100000	\N	b31658eb-5a97-41a0-90f0-532b638eaf67	\N	857	0dd3db16-97eb-4b65-8cb9-c91554d5d325
10573	CREDIT	\N	41000	GBP	2017-04-17 18:31:52.729-04	2017-04-17 18:31:52.729-04	51	3	\N	2017-10-26 17:24:06.354-04	\N	2486	\N	\N	\N	GBP	1	41000	41000	\N	7b8977b2-8890-4759-af5c-9a7149a7ec01	\N	857	15fe03d2-b134-41fa-9216-9fed2adbd399
10868	DEBIT	Donation: Beth Laing	-5000	USD	2016-10-04 11:47:24.058-04	2016-10-04 11:47:24.175-04	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-5000	-5000	\N	5577e4a9-938c-4414-a670-0e841b9f1acd	12	857	257a68f1-29cf-4bf3-83fa-472534c45b8b
7511	CREDIT	Leadership Development: Google I/O travel grant for Gen A. 	85000	USD	2017-03-27 09:25:14.008-04	2017-03-27 09:25:14.169-04	278	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	85000	\N	7092cdf1-407a-4c49-bddd-4729693bb136	857	857	53b0b458-283d-4f3d-b93c-e48c07be82db
10570	CREDIT	\N	18800	MXN	2017-04-17 18:35:06.093-04	2017-04-17 18:35:06.093-04	51	3	\N	2017-10-26 17:24:06.91-04	\N	2488	\N	\N	\N	MXN	1	18800	18800	\N	bcc231f8-c3db-4599-8768-af75d9ca5a32	\N	857	702f7f1e-3e93-4453-8775-1c1da30be9cb
10898	CREDIT	Network development - thanks Atlassian	50000	USD	2016-10-11 15:30:14.934-04	2016-10-11 15:30:15.155-04	51	3	\N	2017-10-26 17:24:07.051-04	\N	\N	\N	\N	\N	\N	1	\N	50000	\N	3105ef97-d608-4d53-8406-264107a2f357	\N	857	912773e6-b3d9-42c3-82a5-d7e45d37b780
11122	CREDIT	Conference Grant: Google/IO Alicia Carr	10000	USD	2016-10-04 11:25:59.981-04	2016-10-04 11:26:00.186-04	51	3	\N	2017-10-26 17:24:07.288-04	\N	\N	\N	\N	\N	\N	1	\N	10000	\N	36082ae9-ea75-499c-8f6e-dd89e2121cc0	\N	857	c650bdd5-10e1-4e35-9bcf-c1d55ef47014
10682	DEBIT	Global Development for Meetup Fee	-5700	EUR	2016-12-27 13:10:14.864-05	2016-12-27 13:10:14.928-05	857	3	\N	\N	\N	\N	\N	\N	\N	\N	1	-5700	-5700	\N	7ecfcc99-b80d-46d6-96a7-16c76c26e4a5	283	857	d2058375-56ce-4a59-8c9c-92cf66c2e6e3
10877	CREDIT	Network Development (Thanks Zendesk)	16129	USD	2016-10-11 16:26:22.964-04	2016-10-11 16:26:23.172-04	51	3	\N	2017-10-26 17:24:07.481-04	\N	\N	\N	\N	\N	\N	1	\N	16129	\N	9c383569-63f3-42f5-a8bd-c659cc55f0f6	\N	857	e39807df-d9f3-4367-8c7e-54dd91d52764
\.


                                                                                                                                                                                                                                          4029.dat                                                                                            0000600 0004000 0002000 00000063720 13174451173 0014266 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1329	fedfabd0763d3993683de654cc8e68b7@gmail.com	*****	*****	*****	2016-09-29 14:09:42.785-04	2016-09-29 14:09:42.785-04	\N	\N	*****	*****	\N	Dana	Dalling	\N	f	687
30	df61fcd898d629d05fe8ae08fd66ec4d@gmail.com	*****	*****	*****	2016-01-09 16:31:01.954-05	2017-04-03 08:58:04.717-04	\N	\N	*****	*****	\N	Pia	Mancini	\N	f	691
3206	9c1a8a4fc15ce332c7c5624952bceeff@gmail.com	*****	*****	*****	2017-02-21 11:55:29.631-05	2017-05-16 12:49:19.822-04	\N	\N	*****	*****	\N	WWCode		\N	f	690
4173	3be24eacaf70dddd5f990afac0574189@gmail.com	*****	*****	*****	2017-04-11 22:05:32.736-04	2017-04-11 22:06:03.772-04	\N	\N	*****	*****	\N	Anne	Brown	\N	f	692
2906	3b3d000425befc5172a5208310218fc2@gmail.com	*****	*****	*****	2017-02-01 12:30:43.176-05	2017-02-01 13:35:36.827-05	\N	\N	*****	*****	\N	\N	\N	\N	f	693
577	8c4471bffc28c261aa4ef2a5d7004de4@gmail.com	*****	*****	*****	\N	2016-12-28 17:36:35.346-05	\N	\N	*****	*****	\N	Georgia	Andrews	\N	f	694
1331	60767513ea7e3d82d4a50d8241faea30@gmail.com	*****	*****	*****	2016-09-29 14:10:43.391-04	2017-03-28 01:13:36.913-04	\N	\N	*****	*****	\N	Chee	Yim Goh	\N	f	695
171	475c85fcbd1984c9e5e19cea267c4f33@gmail.com	*****	*****	*****	2016-03-19 18:11:53.101-04	2017-05-18 13:47:24.123-04	\N	\N	*****	*****	\N	Caterina	Paun	\N	f	827
1359	d6b1ce23201e994cee24a7971a79d810@gmail.com	*****	*****	*****	2016-09-29 14:33:37.087-04	2016-09-29 14:33:37.087-04	\N	\N	*****	*****	\N	Himi	Sato	\N	f	828
1375	2e951f7b3ce79f4faad5da347e302b27@gmail.com	*****	*****	*****	2016-09-29 14:43:49.04-04	2016-09-29 14:43:49.04-04	\N	\N	*****	*****	\N	Anouk	Ruhaak	\N	f	829
1333	c39681f94c378e9adbbbca79b24dd9ff@gmail.com	*****	*****	*****	2016-09-29 14:11:53.842-04	2017-04-12 10:42:51.09-04	\N	\N	*****	*****	\N	Gen	Ashley	\N	f	830
1332	4d4dfee45f10b2b8affd87ee5a82b7a1@gmail.com	*****	*****	*****	2016-09-29 14:10:43.392-04	2017-03-20 12:33:13.852-04	\N	\N	*****	*****	\N	Jecelyn		\N	f	831
1361	9220296eae97265c78dd6ae0722eb573@gmail.com	*****	*****	*****	2016-09-29 14:33:37.095-04	2016-09-29 14:33:37.095-04	\N	\N	*****	*****	\N	Mami	Enomoto	\N	f	832
69	75e923f20ab3d84a3ac4b36a4109d13c@gmail.com	*****	*****	*****	2016-01-29 18:18:47.287-05	2017-05-21 09:24:37.706-04	\N	\N	*****	*****	\N	Alicia		\N	f	834
1358	b78218b19cc91ab0dfb943c6c253ca85@gmail.com	*****	*****	*****	2016-09-29 14:32:00.983-04	2016-09-29 14:32:00.983-04	\N	\N	*****	*****	\N	Laura	Scholl	\N	f	833
1327	ebd16aa661c34f4cfdca849165c47ecb@gmail.com	*****	*****	*****	2016-09-29 14:08:19.487-04	2016-09-29 14:08:19.487-04	\N	\N	*****	*****	\N	Karen	Farzam	\N	f	835
3999	15daf29f3c0fcdf9a94e700ce94f90f6@gmail.com	*****	*****	*****	2017-04-04 15:51:02.718-04	2017-04-04 15:51:03.29-04	\N	\N	*****	*****	\N	Allie	Winkelman	\N	f	836
3301	e6aa8986385415192e05127010441ae4@gmail.com	*****	*****	*****	2017-02-27 19:25:15.503-05	2017-02-27 19:25:19.402-05	\N	\N	*****	*****	\N	Sue	Sinclair	\N	f	837
3053	2bbfedaf9e616d5c252c38e6019481ec@gmail.com	*****	*****	*****	2017-02-09 15:42:02.01-05	2017-02-10 11:48:15.699-05	\N	\N	*****	*****	\N	Flock:	Accelerating Women In Tech	\N	f	838
3419	c4d4a0ed522a5106c5aa8b3e4c077071@gmail.com	*****	*****	*****	2017-03-07 14:01:52.704-05	2017-03-07 14:02:04.53-05	\N	\N	*****	*****	\N	Erin	Spiceland	\N	f	841
4348	4e25fd969973d6fd55614b86c0c74dc5@gmail.com	*****	*****	*****	2017-04-20 05:34:08.219-04	2017-05-04 18:58:47.619-04	\N	\N	*****	*****	\N	Craft	CMS	\N	f	840
4153	adb8ed8f9a018d919a1dca1d502d6b3b@gmail.com	*****	*****	*****	2017-04-10 21:09:47.41-04	2017-04-10 21:09:51.31-04	\N	\N	*****	*****	\N	Nikko	Patten	\N	f	842
1325	5c0594710825406596a99025a319d635@gmail.com	*****	*****	*****	2016-09-29 14:06:00.962-04	2017-02-03 18:06:45.932-05	\N	\N	*****	*****	\N	Pamela	Wood Browne	\N	f	843
141	688f744a10db3334b59d756689fa8250@gmail.com	*****	*****	*****	2016-03-07 04:50:58.721-05	2017-05-20 07:50:46.742-04	\N	\N	*****	*****	\N	Jigyasa	Grover	\N	f	844
74	26888a78bd38eaf94af924a9675ae705@gmail.com	*****	*****	*****	2016-01-29 18:19:36.407-05	2016-09-28 06:15:16.735-04	\N	\N	*****	*****	\N	Chantal		\N	f	845
4720	2248e9f4451791491178e6ad6e8b395f@gmail.com	*****	*****	*****	2017-05-09 14:14:19.572-04	2017-05-09 14:14:20.294-04	\N	\N	*****	*****	\N	Nicole	Giannone	\N	f	846
28	332cb39ce5e614d5fcad01ae28c6e9d5@gmail.com	*****	*****	*****	2015-12-21 11:34:26.053-05	2017-02-01 14:55:11.641-05	\N	\N	*****	*****	\N	Holly		\N	f	847
883	8cdf243bb6d94e727c22e74f7f73780b@gmail.com	*****	*****	*****	2016-08-01 11:54:10.844-04	2016-08-01 11:57:32.536-04	\N	\N	*****	*****	\N	Rackspace		\N	f	856
1378	303f22fe5fcfb3542479af3c0d7ffb51@gmail.com	*****	*****	*****	2016-09-29 14:43:49.205-04	2017-05-10 17:26:04.82-04	\N	\N	*****	*****	\N	Glenna	Buford	\N	f	793
1299	ca840ad4fb9f966b78a7608f23916ce3@gmail.com	*****	*****	*****	2016-09-28 17:47:14.881-04	2016-09-28 17:49:30.346-04	\N	\N	*****	*****	\N	data.world	Swider	\N	f	794
1371	20ef75e5bb432fb540423c3b6fd60a1a@gmail.com	*****	*****	*****	2016-09-29 14:41:11.052-04	2016-09-29 14:41:11.052-04	\N	\N	*****	*****	\N	Guiti	Nabavi	\N	f	795
1372	6a3a6e3cc3f4bb5cb7ef241e3ed3167a@gmail.com	*****	*****	*****	2016-09-29 14:41:11.058-04	2016-09-29 14:41:11.058-04	\N	\N	*****	*****	\N	Radhika	Rayadu	\N	f	796
32	e0d3d2a0a00a30ae6368aa47ab545566@gmail.com	*****	*****	*****	2016-01-11 13:54:33.296-05	2017-05-10 13:19:29.673-04	\N	\N	*****	*****	\N	Saranya	Karuppusamy	\N	f	797
4834	0174cfb68bc98317384ae65d2bb4b6a5@gmail.com	*****	*****	*****	2017-05-15 08:07:56.682-04	2017-05-15 08:09:17.931-04	\N	\N	*****	*****	\N	Brian	Vinci	\N	f	799
1379	26ac149a5ae8d0a09a8eadac9b2153d8@gmail.com	*****	*****	*****	2016-09-29 14:43:49.211-04	2016-09-29 14:43:49.211-04	\N	\N	*****	*****	\N	Aleksandra	Gavriloska	\N	f	800
2898	e3073fd059876de0de39852d83a06783@gmail.com	*****	*****	*****	2017-02-01 10:16:17.461-05	2017-02-01 10:16:17.461-05	\N	\N	*****	*****	\N	\N	\N	\N	f	801
1369	a67e0bdc09dd2ba28385c89f334828f5@gmail.com	*****	*****	*****	2016-09-29 14:38:54.935-04	2016-09-29 14:38:54.935-04	\N	\N	*****	*****	\N	Erika	Aguayo	\N	f	802
686	411be685dd05fee05f62ca6e48aef8a3@gmail.com	*****	*****	*****	2016-07-01 18:31:42.541-04	2016-09-28 06:15:17.556-04	\N	\N	*****	*****	\N	\N	\N	\N	f	803
1368	bc2d687d77a9548c85d4d5cd2f9be8a4@gmail.com	*****	*****	*****	2016-09-29 14:38:54.934-04	2016-09-29 14:38:54.934-04	\N	\N	*****	*****	\N	Ana	Castro	\N	f	804
35	26547a83f9ce5ae0839349325b1e7343@gmail.com	*****	*****	*****	2016-01-11 13:59:41.948-05	2017-05-12 00:19:54.192-04	\N	\N	*****	*****	\N	Erica		\N	f	806
1366	548f55e7c60e649394294a500b7435f5@gmail.com	*****	*****	*****	2016-09-29 14:37:07.344-04	2016-09-29 14:37:07.344-04	\N	\N	*****	*****	\N	Vicky	Twomey-Lee	\N	f	807
170	bd2fd32d181880d2fc0c95d7ba8ce17d@gmail.com	*****	*****	*****	2016-03-19 18:11:44.881-04	2016-03-19 18:11:44.881-04	\N	\N	*****	*****	\N	Paige	Hubbell	\N	f	809
1890	29831b25c00785980ab934f70d4813b1@gmail.com	*****	*****	*****	2016-11-28 10:33:11.726-05	2016-11-28 10:33:31.466-05	\N	\N	*****	*****	\N	Jamie	Lu	\N	f	810
1365	8e6ff81f47ed88c6f6588511e5a3202e@gmail.com	*****	*****	*****	2016-09-29 14:37:07.337-04	2016-09-29 14:37:07.337-04	\N	\N	*****	*****	\N	Laura	Uzcátegui	\N	f	811
1364	20e1ef7ed0e42f913b1b0fb8bc15b50d@gmail.com	*****	*****	*****	2016-09-29 14:34:59.505-04	2016-09-29 14:34:59.505-04	\N	\N	*****	*****	\N	Peggy	Kuo	\N	f	812
1362	12a217393125c49fba8faf93dadafcd8@gmail.com	*****	*****	*****	2016-09-29 14:34:59.499-04	2016-09-29 14:34:59.499-04	\N	\N	*****	*****	\N	Daphne	Chong	\N	f	814
108	13ce3747cb13689865309d537ea4842f@gmail.com	*****	*****	*****	2016-02-18 14:54:08.5-05	2016-09-28 06:15:16.811-04	\N	\N	*****	*****	\N	Emily	Heist Moss	\N	f	813
1363	97e510a21c89bac3e0111d73f5737b05@gmail.com	*****	*****	*****	2016-09-29 14:34:59.504-04	2016-09-29 14:34:59.504-04	\N	\N	*****	*****	\N	Lucy	Bain	\N	f	815
71	f74d1d9b9d4e727c9f1634da2669cd85@gmail.com	*****	*****	*****	2016-01-29 18:19:12.899-05	2016-09-28 06:15:16.707-04	\N	\N	*****	*****	\N	Brenda		\N	f	816
33	c31f8fee92777f265a2c4215007f35a2@gmail.com	*****	*****	*****	2016-01-11 13:57:18.467-05	2016-01-11 13:57:18.467-05	\N	\N	*****	*****	\N	Kaylyn		\N	f	817
1360	58564fc814b9e582dc1dcfb9242ca2ac@gmail.com	*****	*****	*****	2016-09-29 14:33:37.088-04	2016-09-29 14:33:37.088-04	\N	\N	*****	*****	\N	Aya	Nakagawa	\N	f	818
7	163233711ccd4a6968191c8fbd549d8a@gmail.com	*****	*****	*****	2015-11-19 05:09:51.192-05	2017-04-12 16:22:46.946-04	\N	\N	*****	*****	\N	Marcela	Lango	\N	f	821
37	4c06d3aa9533a2d242b1fa57930c6603@gmail.com	*****	*****	*****	2016-01-11 14:02:41.058-05	2016-02-15 17:33:29.118-05	\N	\N	*****	*****	\N	Fernanda		\N	f	822
34	6f62bd61a70f4848e632242e885cc9ed@gmail.com	*****	*****	*****	2016-01-11 13:58:47.796-05	2016-01-11 13:58:47.796-05	\N	\N	*****	*****	\N	Kelly		\N	f	823
1370	7efecdcdea73d6875db52b91f68c0603@gmail.com	*****	*****	*****	2016-09-29 14:38:54.951-04	2016-09-29 14:38:54.951-04	\N	\N	*****	*****	\N	Viv	Del Rio	\N	f	825
36	a3f15edbecbe7da5265fba790e9feeb9@gmail.com	*****	*****	*****	2016-01-11 14:01:43.411-05	2016-02-15 17:33:12.306-05	\N	\N	*****	*****	\N	Dayra		\N	f	826
308	6bdf7bcd29fbb8a428b7a2ccf20c38d2@gmail.com	*****	*****	*****	2016-04-29 14:46:16.143-04	2016-05-03 09:10:49.728-04	\N	\N	*****	*****	\N	Cisco		\N	f	851
192	5effb40d83347a559b155bf5762a3985@gmail.com	*****	*****	*****	2016-03-25 11:11:02.011-04	2016-03-25 11:11:20.398-04	\N	\N	*****	*****	\N	RigUp		\N	f	852
303	357489ee6e6984e56d512c2bbf4f5b18@gmail.com	*****	*****	*****	2016-04-29 09:51:16.619-04	2016-04-29 09:51:42.705-04	\N	\N	*****	*****	\N	The	Human Geo Group	\N	f	853
224	a32663428ce0d29c94f0f78666e7c06e@gmail.com	*****	*****	*****	2016-04-13 12:46:07.217-04	2016-04-13 14:44:12.626-04	\N	\N	*****	*****	\N	Bonsai.io		\N	f	854
283	c07b3781151a9c9fb2991128a4675d06@gmail.com	*****	*****	*****	2016-04-28 11:01:14.69-04	2016-04-28 11:02:00.631-04	\N	\N	*****	*****	\N	Dev	Bootcamp 	\N	f	855
1320	843f89b3975c3b7fc84068f95fc796cc@gmail.com	*****	*****	*****	2016-09-29 14:02:54.546-04	2016-09-29 14:02:54.546-04	\N	\N	*****	*****	\N	Amber	Houle	\N	f	751
1321	309a70eda3c7ffe404a6ca6569c939bf@gmail.com	*****	*****	*****	2016-09-29 14:02:54.555-04	2016-09-29 14:02:54.555-04	\N	\N	*****	*****	\N	Candice	Haddad	\N	f	752
1319	6bfab1190102baca886112ebc885f691@gmail.com	*****	*****	*****	2016-09-29 14:01:49.703-04	2016-09-29 14:01:49.703-04	\N	\N	*****	*****	\N	Neha	Kaura	\N	f	753
3442	b6e18803305e056856ccb858af7e6d86@gmail.com	*****	*****	*****	2017-03-09 13:29:51.939-05	2017-03-09 13:30:24.238-05	\N	\N	*****	*****	\N	Polson	& Polson, P.C.	\N	f	754
68	7ddc7e8e6d4fdfa9d934e55a2b005d87@gmail.com	*****	*****	*****	2016-01-29 18:18:13.688-05	2016-09-28 06:15:17.148-04	\N	\N	*****	*****	\N	Rylee		\N	f	755
1347	8f78c6c692cd973103ba9c647a361577@gmail.com	*****	*****	*****	2016-09-29 14:25:21.95-04	2016-09-29 14:25:21.95-04	\N	\N	*****	*****	\N	Marisol	Acuna	\N	f	756
1318	96950200d2eca5a63244a97b75f536b7@gmail.com	*****	*****	*****	2016-09-29 14:01:04.636-04	2016-09-29 14:01:04.636-04	\N	\N	*****	*****	\N	Sally	Kingston	\N	f	757
1317	7c54f08b683464eac663bd982037283a@gmail.com	*****	*****	*****	2016-09-29 14:01:04.636-04	2016-09-29 14:01:04.636-04	\N	\N	*****	*****	\N	Amber	Joyner	\N	f	758
896	898029d0f8816a246e0c7a7c65341485@gmail.com	*****	*****	*****	2016-08-03 13:47:13.173-04	2016-09-28 06:15:17.897-04	\N	\N	*****	*****	\N	Geoff	Domoracki	\N	f	759
1316	2d3396ed13ba45c0c471b3af1aabdf2a@gmail.com	*****	*****	*****	2016-09-29 13:59:15.428-04	2016-09-29 13:59:15.428-04	\N	\N	*****	*****	\N	Mia	Zhu	\N	f	760
1315	f23b8ce26e6121a5e9dc38462e2776fa@gmail.com	*****	*****	*****	2016-09-29 13:58:16.63-04	2016-09-29 13:58:16.63-04	\N	\N	*****	*****	\N	Isabella	Oliveira	\N	f	761
70	5c7fa359b4ee800bae4b5e919a433171@gmail.com	*****	*****	*****	2016-01-29 18:18:53.83-05	2017-03-12 14:10:38.549-04	\N	\N	*****	*****	\N	beth	laing	\N	f	762
2549	80afcb383424a739a793e105bdb617f9@gmail.com	*****	*****	*****	2017-01-14 12:11:39.224-05	2017-02-22 19:10:36.94-05	\N	\N	*****	*****	\N	Eileen	C	\N	f	763
1314	d8775d54111aaf3d47957c5c4f539049@gmail.com	*****	*****	*****	2016-09-29 13:54:53.462-04	2016-09-29 13:54:53.462-04	\N	\N	*****	*****	\N	Sheree	Atcheson	\N	f	764
1313	cf9301117f3684b125ddc70a811c9ff9@gmail.com	*****	*****	*****	2016-09-29 13:54:53.45-04	2016-09-29 13:54:53.45-04	\N	\N	*****	*****	\N	Gillian	Colan-O'Leary	\N	f	765
31	27e19add9323d39d0b3f60dde40fee33@gmail.com	*****	*****	*****	2016-01-11 13:53:43.73-05	2016-07-04 16:12:12.413-04	\N	\N	*****	*****	\N	Sandra		\N	f	766
1312	71eb923685350087d1aa38bed7843ac3@gmail.com	*****	*****	*****	2016-09-29 13:53:00.503-04	2016-09-29 13:53:00.503-04	\N	\N	*****	*****	\N	Xinhui	Li	\N	f	767
80	447bd08d1ff86983e66a70858775669d@gmail.com	*****	*****	*****	2016-02-02 11:52:02.222-05	2016-09-28 06:15:16.766-04	\N	\N	*****	*****	\N	Maru	Lango	\N	f	768
1310	31d3a19861b19e3c5d1eb2b483370ee1@gmail.com	*****	*****	*****	2016-09-29 13:51:29.334-04	2016-09-29 13:51:29.334-04	\N	\N	*****	*****	\N	Smitha	Radhakrishnan	\N	f	770
646	e717495c9186295c79d02397add07124@gmail.com	*****	*****	*****	2016-06-22 16:09:43.896-04	2016-09-28 06:15:17.513-04	\N	\N	*****	*****	\N	Lindsey	Barrett	\N	f	771
1309	24b7f50b91ac3f9b0fbf879e9039aa0a@gmail.com	*****	*****	*****	2016-09-29 13:51:29.333-04	2016-09-29 13:51:29.333-04	\N	\N	*****	*****	\N	Shwetha	Lakshman Rao	\N	f	772
72	9d5e8daeff013b0f404f87206eed86f9@gmail.com	*****	*****	*****	2016-01-29 18:19:22.243-05	2016-09-28 06:15:16.708-04	\N	\N	*****	*****	\N	Elizabeth	Ferrao	\N	f	773
77	7ac57722768c7d3749d19e06e8ba389d@gmail.com	*****	*****	*****	2016-01-29 18:19:53.922-05	2016-09-28 06:15:16.734-04	\N	\N	*****	*****	\N	Zoe	Madden-Wood	\N	f	774
642	c798ff50a86d1b17424f940a93fe10d8@gmail.com	*****	*****	*****	2016-06-21 12:02:52.874-04	2016-09-28 06:15:17.476-04	\N	\N	*****	*****	\N	Joey	Rosenberg	\N	f	775
1367	a95d13b713d4ac6181570e7e9b909b05@gmail.com	*****	*****	*****	2016-09-29 14:37:07.344-04	2016-09-29 14:37:07.344-04	\N	\N	*****	*****	\N	Christina	Lynch	\N	f	776
1308	ae5eeb5acc070587de95739c5f58d0a1@gmail.com	*****	*****	*****	2016-09-29 13:49:43.061-04	2016-09-29 13:49:43.061-04	\N	\N	*****	*****	\N	Racha	Bella	\N	f	777
75	ef131790a7c920cf2e1603358efc1449@gmail.com	*****	*****	*****	2016-01-29 18:19:43.713-05	2016-09-28 06:15:16.708-04	\N	\N	*****	*****	\N	Gabriela	Adamova	\N	f	779
78	4983e60f20be60f3cd44948b1c1c0087@gmail.com	*****	*****	*****	2016-01-29 18:20:00.061-05	2016-09-28 06:15:16.735-04	\N	\N	*****	*****	\N	Fanya		\N	f	778
1307	35523780be14ccacd1194641ba0bde57@gmail.com	*****	*****	*****	2016-09-29 13:49:43.051-04	2016-09-29 13:49:43.051-04	\N	\N	*****	*****	\N	Fatma	Djoudjou	\N	f	780
551	a4f59257d033d8eb46bbb19bcf290430@gmail.com	*****	*****	*****	2016-06-06 15:04:33.418-04	2016-09-28 06:15:17.39-04	\N	\N	*****	*****	\N	Allison	Canestaro	\N	f	781
1377	e59b939ecc4c77c350f966165188ad7e@gmail.com	*****	*****	*****	2016-09-29 14:43:49.189-04	2016-09-29 14:43:49.189-04	\N	\N	*****	*****	\N	Silvia	Pina	\N	f	782
1305	aba7551e89f249da0fae69d2be8f5128@gmail.com	*****	*****	*****	2016-09-29 13:44:40.429-04	2016-09-29 13:44:40.429-04	\N	\N	*****	*****	\N	Judith	Agbotse	\N	f	783
76	d13f331afaae109d7c30e231be465401@gmail.com	*****	*****	*****	2016-01-29 18:19:47.116-05	2016-09-28 06:15:16.734-04	\N	\N	*****	*****	\N	Rose	THERESA	\N	f	784
4550	35cf86710c6d930ee7610bf1bb5dbe11@gmail.com	*****	*****	*****	2017-05-01 13:13:32.139-04	2017-05-01 13:13:35.793-04	\N	\N	*****	*****	\N	Lacey	Reinoehl	\N	f	785
1376	c11e740d05e136e14f4588e08a01f460@gmail.com	*****	*****	*****	2016-09-29 14:43:49.157-04	2016-09-29 14:43:49.157-04	\N	\N	*****	*****	\N	Carola	Nitz	\N	f	786
67	61b08842f8750a6bc18d274dc954fa02@gmail.com	*****	*****	*****	2016-01-29 18:16:09.038-05	2016-09-28 06:15:16.707-04	\N	\N	*****	*****	\N	Nupur	Kapoor	\N	f	787
1178	d49f580dd3b9b503a43175705afc72ff@gmail.com	*****	*****	*****	2016-09-13 00:15:01.959-04	2016-09-28 06:15:18.213-04	\N	\N	*****	*****	\N	Google	Fiber	\N	f	788
1311	4bdb3020da3f8070227aa9cd1662f481@gmail.com	*****	*****	*****	2016-09-29 13:53:00.502-04	2016-09-29 13:53:00.502-04	\N	\N	*****	*****	\N	Lucy	Shang	\N	f	789
1335	11dfac5cbe9c44dd072f6d704c64f19b@gmail.com	*****	*****	*****	2016-09-29 14:12:58.838-04	2016-09-29 14:12:58.838-04	\N	\N	*****	*****	\N	Irina	Muchnik	\N	f	790
1356	d182a2ddbeeb69d5629028cfaeda4356@gmail.com	*****	*****	*****	2016-09-29 14:30:54.244-04	2016-09-29 14:30:54.244-04	\N	\N	*****	*****	\N	Dinah	Shi	\N	f	720
1351	2112fabeedef785fff13999b12f6e057@gmail.com	*****	*****	*****	2016-09-29 14:28:08.47-04	2016-09-29 14:28:08.47-04	\N	\N	*****	*****	\N	Kathy	Trammell	\N	f	721
1350	275a7843d04d598eb4949a8f3b98f170@gmail.com	*****	*****	*****	2016-09-29 14:26:35.139-04	2016-09-29 14:26:35.139-04	\N	\N	*****	*****	\N	Yoka	Liu	\N	f	722
1349	784d1666f6262338f095884b8b2ab1d8@gmail.com	*****	*****	*****	2016-09-29 14:26:35.133-04	2016-09-29 14:26:35.133-04	\N	\N	*****	*****	\N	Qianyi	Zheng	\N	f	723
1348	feb1e25523fe209c41071badd848f502@gmail.com	*****	*****	*****	2016-09-29 14:25:21.969-04	2016-09-29 14:25:21.969-04	\N	\N	*****	*****	\N	Roxane	Castelein	\N	f	724
73	9cc8932f53ca5322fab8553db692e6a7@gmail.com	*****	*****	*****	2016-01-29 18:19:28.648-05	2016-09-28 06:15:18.347-04	\N	\N	*****	*****	\N	Barbara		\N	f	725
1346	c9606a2459e0fef1e21cdc86c3eb2683@gmail.com	*****	*****	*****	2016-09-29 14:24:17.81-04	2016-09-29 14:24:17.81-04	\N	\N	*****	*****	\N	Shruti	Sethi	\N	f	726
1345	32d477008ca7ce468c8b6894d3527377@gmail.com	*****	*****	*****	2016-09-29 14:24:17.802-04	2016-09-29 14:24:17.802-04	\N	\N	*****	*****	\N	Ashma	Sethi	\N	f	727
1343	8832824eb21ff845244a89b2aeb53972@gmail.com	*****	*****	*****	2016-09-29 14:19:11.446-04	2016-09-29 14:19:11.446-04	\N	\N	*****	*****	\N	Andreza	Leite	\N	f	728
1341	0cd39d443715253ede1c195f212fa858@gmail.com	*****	*****	*****	2016-09-29 14:16:52.099-04	2016-09-29 14:16:52.099-04	\N	\N	*****	*****	\N	Jennifer	Hoover	\N	f	729
1342	530e82f7e0744b9b860f9811257e0b13@gmail.com	*****	*****	*****	2016-09-29 14:17:47.289-04	2016-09-29 14:17:47.289-04	\N	\N	*****	*****	\N	Veronica	Cannon	\N	f	730
1340	8abf71093dbd2bfc653a5bc12a5a7b89@gmail.com	*****	*****	*****	2016-09-29 14:16:17.115-04	2016-09-29 14:16:17.115-04	\N	\N	*****	*****	\N	Emily	Reese	\N	f	731
1338	27196e10ddabe6055a003b98d791a15b@gmail.com	*****	*****	*****	2016-09-29 14:14:46.606-04	2016-09-29 14:14:46.606-04	\N	\N	*****	*****	\N	Princy	James	\N	f	732
1339	99b642de95827a0d4bba0315ddd40723@gmail.com	*****	*****	*****	2016-09-29 14:15:23.931-04	2016-09-29 14:15:23.931-04	\N	\N	*****	*****	\N	Grisel	Ancona	\N	f	733
1337	d32d64b3fc1390780651de634d212e50@gmail.com	*****	*****	*****	2016-09-29 14:13:48.772-04	2016-09-29 14:13:48.772-04	\N	\N	*****	*****	\N	Isabel	Yepes	\N	f	734
1336	0830431cc80ea3b8d7b9dc5eed3fde68@gmail.com	*****	*****	*****	2016-09-29 14:12:58.852-04	2016-09-29 14:12:58.852-04	\N	\N	*****	*****	\N	Tiffany	Andrews	\N	f	735
1334	416e8cd289733c0bb5ed83f3ede37276@gmail.com	*****	*****	*****	2016-09-29 14:11:53.843-04	2016-09-29 14:11:53.843-04	\N	\N	*****	*****	\N	Vinita	Khandelwal Rathi	\N	f	736
1158	3a0a65e6b6e105f4835f188459a7b979@gmail.com	*****	*****	*****	2016-09-09 23:42:48.933-04	2016-09-28 06:15:18.225-04	\N	\N	*****	*****	\N	Pieceofr		\N	f	737
1145	0d11c83dcf3d75bc133ab5010187b7b6@gmail.com	*****	*****	*****	2016-09-07 18:13:23.624-04	2016-09-28 06:15:18.184-04	\N	\N	*****	*****	\N	Jane	Shih	\N	f	739
1330	51d33c46424eb3f4647ded569bda1da3@gmail.com	*****	*****	*****	2016-09-29 14:09:42.794-04	2016-09-29 14:09:42.794-04	\N	\N	*****	*****	\N	FJ	Genus	\N	f	740
426	c989f4c11bd20a6754a75c38303a4767@gmail.com	*****	*****	*****	2016-05-23 16:27:26.092-04	2016-09-28 06:15:17.365-04	\N	\N	*****	*****	\N	Ellevest		\N	f	741
555	3379a40c501c7f24d233be62ce9a94c5@gmail.com	*****	*****	*****	2016-06-06 20:53:44.829-04	2016-09-28 06:15:17.29-04	\N	\N	*****	*****	\N	Shahnaz	Kamberi	\N	f	742
1326	64b6e8606a0a0dcdd531b7f51f0dfe24@gmail.com	*****	*****	*****	2016-09-29 14:06:44.745-04	2016-09-29 14:06:44.745-04	\N	\N	*****	*****	\N	KeSha	Shah	\N	f	743
1323	d4caf7062fecc15e4fa181bf8632bbdf@gmail.com	*****	*****	*****	2016-09-29 14:05:19.073-04	2016-09-29 14:05:19.073-04	\N	\N	*****	*****	\N	Maira	Bejamin	\N	f	745
1324	8fd43f5cd0be03abdf7f57c45559f394@gmail.com	*****	*****	*****	2016-09-29 14:05:19.079-04	2016-09-29 14:05:19.079-04	\N	\N	*****	*****	\N	Candace	Lazarou	\N	f	744
898	ad38fa1d5fec65ace946d4b5a1da5e78@gmail.com	*****	*****	*****	2016-08-02 20:00:00-04	2016-08-02 20:00:00-04	\N	\N	*****	*****	\N	Casey	Gruppioni	\N	f	746
4749	42cdf9a221d1dbffc6da14cd53207b4c@gmail.com	*****	*****	*****	2017-05-10 19:45:43.307-04	2017-05-10 19:45:44.074-04	\N	\N	*****	*****	\N	Elijah	Van Der Giessen	\N	f	747
897	a48b149e339d16ec672b8abea68be0e3@gmail.com	*****	*****	*****	2016-08-02 20:00:00-04	2017-04-17 12:41:26.051-04	\N	\N	*****	*****	\N	Radhika	Malik	\N	f	748
1322	bc72c4b9fd99b99cfd7cc6decbd58008@gmail.com	*****	*****	*****	2016-09-29 14:03:46.798-04	2017-02-15 13:12:58.843-05	\N	\N	*****	*****	\N	Carole	Bennett	\N	f	749
1094	acb49a7f9ec2454380130c56c32ebbec@gmail.com	*****	*****	*****	2016-09-01 10:41:33.243-04	2016-09-01 10:43:52.954-04	\N	\N	*****	*****	\N	thirteen23		\N	f	849
1328	8808873dd5e6a229bca3641b8890d754@gmail.com	*****	*****	*****	2016-09-29 14:08:19.492-04	2016-09-29 14:08:19.492-04	\N	\N	*****	*****	\N	Michelle	Sun	\N	f	686
2	b0021cf62c2ef3dc137cf0a87e2af92b@gmail.com	*****	*****	*****	2015-11-05 08:44:30.93-05	2017-05-25 14:22:59.819-04	\N	\N	*****	*****	2016-03-03 19:07:14.176-05	Xavier	Damman	\N	f	688
3	a1c73eb4917522c4cdcebe8736395eb3@gmail.com	*****	*****	*****	2015-11-19 05:07:53.479-05	2017-05-22 12:22:41.796-04	\N	\N	*****	*****	2017-03-02 00:58:23.993-05	Women	Who Code	\N	t	51
142	3723537c491f597e9c203bad685dd9d7@gmail.com	*****	*****	*****	2016-03-07 04:51:08.328-05	2017-02-10 19:24:03.134-05	\N	\N	*****	*****	\N	Sarah	Olson	\N	f	696
2594	ad47316cbe8c10d21978ee1dc5746792@gmail.com	*****	*****	*****	2017-01-18 08:49:53.082-05	2017-01-18 08:55:44.616-05	\N	\N	*****	*****	\N	Tamouse	Temple	\N	f	697
1344	d6dd386d45dd48d56872b57c7502ba72@gmail.com	*****	*****	*****	2016-09-29 14:19:11.45-04	2017-04-30 18:09:37.177-04	\N	\N	*****	*****	\N	Karina		\N	f	698
2561	0dbc97aceea70683f46b266f2c0e559a@gmail.com	*****	*****	*****	2017-01-16 13:03:53.479-05	2017-01-16 13:03:53.479-05	\N	\N	*****	*****	\N	Amanda	Folson	\N	f	699
2220	73e73afea6c744a00d6963fbf8a4ef16@gmail.com	*****	*****	*****	2016-12-18 20:41:26.473-05	2017-01-07 02:47:05.144-05	\N	\N	*****	*****	\N	Cameron	🐳✨	\N	f	700
1846	f57e8a5f4bb72290e312a6c29b1407a3@gmail.com	*****	*****	*****	2016-11-22 10:22:35.912-05	2016-11-22 10:23:28.441-05	\N	\N	*****	*****	\N	Portland	Modern Manufacturing Collective	\N	f	701
1303	da23087dbcb3966f332eb0d22ebbdde1@gmail.com	*****	*****	*****	2016-09-29 13:43:14.052-04	2016-11-23 02:21:46.01-05	\N	\N	*****	*****	\N	Shirley	Hicks	\N	f	702
2431	f4da08d72d1a2dfe1f47db5f46a62a5b@gmail.com	*****	*****	*****	2017-01-03 19:00:00-05	2017-04-28 16:39:58.316-04	\N	\N	*****	*****	\N	Nataliia	Ilchenko	\N	f	703
1374	4d9f4287fe4e2a93b73c1cb08be76148@gmail.com	*****	*****	*****	2016-09-29 14:41:11.059-04	2016-12-19 17:20:00.592-05	\N	\N	*****	*****	\N	Snehal	Patil	\N	f	706
129	f93705c9774686499d4f9efbcaa81e07@gmail.com	*****	*****	*****	2016-03-02 16:31:50.497-05	2016-03-02 16:32:53.053-05	\N	\N	*****	*****	\N	MakerSquare		\N	f	848
126	89144a979199c98e09581ea3cdcd89f5@gmail.com	*****	*****	*****	2016-03-01 23:41:59.905-05	2016-12-01 15:04:48.511-05	\N	\N	*****	*****	\N	Alaina	Percival	\N	f	704
1304	e1b16aaaf8961ee0acdbd9d306561b03@gmail.com	*****	*****	*****	2016-09-29 13:44:40.419-04	2016-12-29 13:39:36.018-05	\N	\N	*****	*****	\N	Afia	Owusu-Forfie	\N	f	705
1446	17ab59318e1a638274d84ee4f4617cd4@gmail.com	*****	*****	*****	2016-10-07 12:49:14.297-04	2016-10-07 12:49:50.24-04	\N	\N	*****	*****	\N	Wei-Juin	Lin	\N	f	712
1808	ca0ddd5acb195ee0e3884842e8656755@gmail.com	*****	*****	*****	2016-11-17 12:43:26.15-05	2016-11-17 12:44:20.864-05	\N	\N	*****	*****	\N	Rigado		\N	f	708
2416	c909e10b24422a34ea20a79b9a906cf5@gmail.com	*****	*****	*****	2017-01-03 15:59:33.995-05	2017-01-03 15:59:33.995-05	\N	\N	*****	*****	\N	Kelly	Erickson	\N	f	709
1908	8a3f905ee55db87a19779a214587e529@gmail.com	*****	*****	*****	2016-11-29 05:03:21.301-05	2016-11-29 05:04:01.298-05	\N	\N	*****	*****	\N	Wooga		\N	f	707
1957	d9ca31bcfecac96ff71cf6036d192503@gmail.com	*****	*****	*****	2016-11-30 11:11:38.749-05	2016-11-30 11:12:01.534-05	\N	\N	*****	*****	\N	Maddy	Lau	\N	f	710
4711	32714f8fbf59186a1fe4eb47e2d1d40e@gmail.com	*****	*****	*****	2017-05-09 01:59:11.628-04	2017-05-09 01:59:13.896-04	\N	\N	*****	*****	\N	Kristine	Paas	\N	f	711
1438	ca459f986fe2770c3231788ec004352a@gmail.com	*****	*****	*****	2016-10-06 14:36:34.986-04	2016-10-06 14:37:42.185-04	\N	\N	*****	*****	\N	Hector	Torres	\N	f	713
1355	4365a1d13eca1c78bd460ec7d17b2544@gmail.com	*****	*****	*****	2016-09-29 14:30:08.978-04	2016-09-29 14:30:08.978-04	\N	\N	*****	*****	\N	Oksana	Denesiuk	\N	f	769
1373	4b43d6eaedbb506b76bf9f73351958f4@gmail.com	*****	*****	*****	2016-09-29 14:41:11.058-04	2016-09-29 14:41:11.058-04	\N	\N	*****	*****	\N	Sonia	Prabhu	\N	f	791
1357	923bd4c7e11e7c7afc4c51e31374a7f5@gmail.com	*****	*****	*****	2016-09-29 14:32:00.979-04	2016-09-29 14:32:00.979-04	\N	\N	*****	*****	\N	Britten	Kuckelman	\N	f	714
1354	a77dcae86c4a98f96f10de27166b1212@gmail.com	*****	*****	*****	2016-09-29 14:30:08.971-04	2016-09-29 14:30:08.971-04	\N	\N	*****	*****	\N	Ksenia	Barshchyk	\N	f	715
1352	6b0788c1db2895a00b16e51bbda21ee5@gmail.com	*****	*****	*****	2016-09-29 14:28:08.475-04	2016-12-20 14:09:35.349-05	\N	\N	*****	*****	\N	Sarrah	Vesselov	\N	f	716
1244	e953c9a4e2c5bb69552f3c92acb936ed@gmail.com	*****	*****	*****	2016-09-20 16:58:49.633-04	2016-09-28 06:15:18.662-04	\N	\N	*****	*****	\N	Grain		\N	f	717
392	914df0c8ab1f8b15a8ab1a7e77a3bcc0@gmail.com	*****	*****	*****	2016-05-19 15:24:40.738-04	2016-09-28 06:15:18.36-04	\N	\N	*****	*****	\N	Travis	Swicegood	\N	f	718
1353	672ed3d7420c37155d2978ef9bb4bddd@gmail.com	*****	*****	*****	2016-09-29 14:28:54.276-04	2016-09-29 14:28:54.276-04	\N	\N	*****	*****	\N	Ria	Riaz	\N	f	719
1263	6dc155c0ad37d1bea19426f9c9f5c882@gmail.com	*****	*****	*****	2016-09-22 21:07:06.058-04	2016-09-28 06:15:17.268-04	\N	\N	*****	*****	\N	Isaac	Potoczny-Jones	\N	f	792
8	9f23b14304ccc62b927759bbf7ca73c8@gmail.com	*****	*****	*****	2015-11-30 15:20:11.257-05	2017-05-09 16:20:42.144-04	\N	\N	*****	*****	\N	Aseem	Sood	\N	f	819
884	ee80bff7c018dc2ecb0468b05451d03c@gmail.com	*****	*****	*****	2016-08-01 11:55:23.132-04	2016-08-01 11:56:25.628-04	\N	\N	*****	*****	\N	New	York Code + Design Academy (Austin)	\N	f	850
\.


                                                3752.dat                                                                                            0000600 0004000 0002000 00000000005 13174451173 0014253 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           restore.sql                                                                                         0000600 0004000 0002000 00000154603 13174451173 0015403 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        --
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.5
-- Dumped by pg_dump version 10.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = public, pg_catalog;

ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_CollectiveId_fkey";
ALTER TABLE ONLY public."Members" DROP CONSTRAINT "UserGroups_UserId_fkey";
ALTER TABLE ONLY public."Members" DROP CONSTRAINT "UserGroups_GroupId_fkey";
ALTER TABLE ONLY public."Transactions" DROP CONSTRAINT "Transactions_UserId_fkey";
ALTER TABLE ONLY public."Transactions" DROP CONSTRAINT "Transactions_HostCollectiveId_fkey";
ALTER TABLE ONLY public."Transactions" DROP CONSTRAINT "Transactions_GroupId_fkey";
ALTER TABLE ONLY public."Transactions" DROP CONSTRAINT "Transactions_FromCollectiveId_fkey";
ALTER TABLE ONLY public."Transactions" DROP CONSTRAINT "Transactions_ExpenseId_fkey";
ALTER TABLE ONLY public."Transactions" DROP CONSTRAINT "Transactions_DonationId_fkey";
ALTER TABLE ONLY public."Transactions" DROP CONSTRAINT "Transactions_CardId_fkey";
ALTER TABLE ONLY public."Tiers" DROP CONSTRAINT "Tiers_GroupId_fkey";
ALTER TABLE ONLY public."Notifications" DROP CONSTRAINT "Subscriptions_UserId_fkey";
ALTER TABLE ONLY public."Notifications" DROP CONSTRAINT "Subscriptions_GroupId_fkey";
ALTER TABLE ONLY public."PaymentMethods" DROP CONSTRAINT "PaymentMethods_CollectiveId_fkey";
ALTER TABLE ONLY public."Orders" DROP CONSTRAINT "Orders_TierId_fkey";
ALTER TABLE ONLY public."Orders" DROP CONSTRAINT "Orders_FromCollectiveId_fkey";
ALTER TABLE ONLY public."Members" DROP CONSTRAINT "Members_TierId_fkey";
ALTER TABLE ONLY public."Members" DROP CONSTRAINT "Members_MemberCollectiveId_fkey";
ALTER TABLE ONLY public."Collectives" DROP CONSTRAINT "Groups_lastEditedByUserId_fkey";
ALTER TABLE ONLY public."Expenses" DROP CONSTRAINT "Expenses_lastEditedById_fkey";
ALTER TABLE ONLY public."Expenses" DROP CONSTRAINT "Expenses_UserId_fkey";
ALTER TABLE ONLY public."Expenses" DROP CONSTRAINT "Expenses_GroupId_fkey";
ALTER TABLE ONLY public."Orders" DROP CONSTRAINT "Donations_UserId_fkey";
ALTER TABLE ONLY public."Orders" DROP CONSTRAINT "Donations_SubscriptionId_fkey";
ALTER TABLE ONLY public."Orders" DROP CONSTRAINT "Donations_PaymentMethodId_fkey";
ALTER TABLE ONLY public."Orders" DROP CONSTRAINT "Donations_GroupId_fkey";
ALTER TABLE ONLY public."ConnectedAccounts" DROP CONSTRAINT "ConnectedAccounts_UserId_fkey";
ALTER TABLE ONLY public."ConnectedAccounts" DROP CONSTRAINT "ConnectedAccounts_GroupId_fkey";
ALTER TABLE ONLY public."Collectives" DROP CONSTRAINT "Collectives_ParentCollectiveId_fkey";
ALTER TABLE ONLY public."Collectives" DROP CONSTRAINT "Collectives_HostCollectiveId_fkey";
ALTER TABLE ONLY public."Collectives" DROP CONSTRAINT "Collectives_CreatedByUserId_fkey";
ALTER TABLE ONLY public."CollectiveHistories" DROP CONSTRAINT "CollectiveHistories_ParentCollectiveId_fkey";
ALTER TABLE ONLY public."CollectiveHistories" DROP CONSTRAINT "CollectiveHistories_HostCollectiveId_fkey";
ALTER TABLE ONLY public."CollectiveHistories" DROP CONSTRAINT "CollectiveHistories_CreatedByUserId_fkey";
ALTER TABLE ONLY public."PaymentMethods" DROP CONSTRAINT "Cards_UserId_fkey";
ALTER TABLE ONLY public."Activities" DROP CONSTRAINT "Activities_UserId_fkey";
ALTER TABLE ONLY public."Activities" DROP CONSTRAINT "Activities_TransactionId_fkey";
ALTER TABLE ONLY public."Activities" DROP CONSTRAINT "Activities_GroupId_fkey";
DROP INDEX public."type-tags";
DROP INDEX public.transactions_uuid;
DROP INDEX public.subscriptions_type__group_id__user_id;
DROP INDEX public."UniqueSlugIndex";
DROP INDEX public."Transactions_GroupId";
DROP INDEX public."ParentCollectiveId";
DROP INDEX public."MemberCollectiveId-CollectiveId-role";
DROP INDEX public."DonationId";
DROP INDEX public."CollectiveId-type";
DROP INDEX public."CollectiveId-role";
DROP INDEX public."CollectiveId-deletedAt";
DROP INDEX public."CollectiveId-FromCollectiveId-type";
DROP INDEX public."CollectiveId";
ALTER TABLE ONLY public."Users" DROP CONSTRAINT email_unique_idx;
ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_pkey";
ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_email_key";
ALTER TABLE ONLY public."Members" DROP CONSTRAINT "UserGroups_pkey";
ALTER TABLE ONLY public."Transactions" DROP CONSTRAINT "Transactions_pkey";
ALTER TABLE ONLY public."Tiers" DROP CONSTRAINT "Tiers_pkey";
ALTER TABLE ONLY public."Subscriptions" DROP CONSTRAINT "Subscriptions_pkey1";
ALTER TABLE ONLY public."Notifications" DROP CONSTRAINT "Subscriptions_pkey";
ALTER TABLE ONLY public."Sessions" DROP CONSTRAINT "Sessions_pkey";
ALTER TABLE ONLY public."SequelizeMeta" DROP CONSTRAINT "SequelizeMeta_pkey";
ALTER TABLE ONLY public."Collectives" DROP CONSTRAINT "Groups_pkey";
ALTER TABLE ONLY public."CollectiveHistories" DROP CONSTRAINT "GroupHistories_pkey";
ALTER TABLE ONLY public."Expenses" DROP CONSTRAINT "Expenses_pkey";
ALTER TABLE ONLY public."ExpenseHistories" DROP CONSTRAINT "ExpenseHistories_pkey";
ALTER TABLE ONLY public."Orders" DROP CONSTRAINT "Donations_pkey";
ALTER TABLE ONLY public."ConnectedAccounts" DROP CONSTRAINT "ConnectedAccounts_pkey";
ALTER TABLE ONLY public."PaymentMethods" DROP CONSTRAINT "Cards_pkey";
ALTER TABLE ONLY public."Activities" DROP CONSTRAINT "Activities_pkey";
ALTER TABLE public."Users" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public."Transactions" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public."Tiers" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public."Subscriptions" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public."PaymentMethods" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public."Orders" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public."Notifications" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public."Members" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public."Expenses" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public."ExpenseHistories" ALTER COLUMN hid DROP DEFAULT;
ALTER TABLE public."ConnectedAccounts" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public."Collectives" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public."CollectiveHistories" ALTER COLUMN hid DROP DEFAULT;
ALTER TABLE public."Activities" ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE public."Users_id_seq";
DROP TABLE public."Users";
DROP SEQUENCE public."UserGroups_id_seq";
DROP SEQUENCE public."Transactions_id_seq";
DROP TABLE public."Transactions";
DROP SEQUENCE public."Tiers_id_seq";
DROP TABLE public."Tiers";
DROP SEQUENCE public."Subscriptions_id_seq1";
DROP SEQUENCE public."Subscriptions_id_seq";
DROP TABLE public."Subscriptions";
DROP TABLE public."Sessions";
DROP TABLE public."SequelizeMeta";
DROP TABLE public."Notifications";
DROP TABLE public."Members";
DROP SEQUENCE public."Groups_id_seq";
DROP SEQUENCE public."GroupHistories_hid_seq";
DROP SEQUENCE public."Expenses_id_seq";
DROP TABLE public."Expenses";
DROP SEQUENCE public."ExpenseHistories_hid_seq";
DROP TABLE public."ExpenseHistories";
DROP SEQUENCE public."Donations_id_seq";
DROP TABLE public."Orders";
DROP SEQUENCE public."ConnectedAccounts_id_seq";
DROP TABLE public."ConnectedAccounts";
DROP TABLE public."Collectives";
DROP TABLE public."CollectiveHistories";
DROP SEQUENCE public."Cards_id_seq";
DROP TABLE public."PaymentMethods";
DROP SEQUENCE public."Activities_id_seq";
DROP TABLE public."Activities";
DROP TYPE public."enum_UserGroups_role";
DROP TYPE public."enum_Groups_membership_type";
DROP EXTENSION postgis;
DROP EXTENSION plpgsql;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


SET search_path = public, pg_catalog;

--
-- Name: enum_Groups_membership_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE "enum_Groups_membership_type" AS ENUM (
    'donation',
    'monthlyfee',
    'yearlyfee'
);


--
-- Name: enum_UserGroups_role; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE "enum_UserGroups_role" AS ENUM (
    'admin',
    'writer',
    'viewer'
);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: Activities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "Activities" (
    id integer NOT NULL,
    type character varying(255),
    data json,
    "createdAt" timestamp with time zone,
    "CollectiveId" integer,
    "UserId" integer,
    "TransactionId" integer
);


--
-- Name: Activities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "Activities_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Activities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "Activities_id_seq" OWNED BY "Activities".id;


--
-- Name: PaymentMethods; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "PaymentMethods" (
    id integer NOT NULL,
    name character varying(255),
    token character varying(255),
    "customerId" character varying(255),
    service character varying(255) DEFAULT 'stripe'::character varying,
    data json,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "confirmedAt" timestamp with time zone,
    "deletedAt" timestamp with time zone,
    "CreatedByUserId" integer,
    "expiryDate" timestamp with time zone,
    uuid uuid,
    "CollectiveId" integer,
    "archivedAt" timestamp with time zone,
    "monthlyLimitPerMember" integer,
    "primary" boolean DEFAULT false,
    currency character varying(3)
);


--
-- Name: Cards_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "Cards_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Cards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "Cards_id_seq" OWNED BY "PaymentMethods".id;


--
-- Name: CollectiveHistories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "CollectiveHistories" (
    id integer,
    name character varying(255),
    description character varying(255),
    currency character varying(255),
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "deletedAt" timestamp with time zone,
    "isActive" boolean,
    "longDescription" text,
    image character varying(255),
    slug character varying(255),
    website character varying(255),
    "twitterHandle" character varying(255),
    mission character varying(255),
    "backgroundImage" character varying(255),
    "hostFeePercent" double precision,
    settings json,
    data json,
    tags character varying(255)[],
    "isSupercollective" boolean,
    "LastEditedByUserId" integer,
    hid bigint NOT NULL,
    "archivedAt" timestamp with time zone NOT NULL,
    "CreatedByUserId" integer,
    "HostCollectiveId" integer,
    "ParentCollectiveId" integer,
    type character varying(255) DEFAULT 'COLLECTIVE'::character varying,
    "startsAt" timestamp with time zone,
    "endsAt" timestamp with time zone,
    "locationName" character varying(255),
    address character varying(255),
    timezone character varying(255),
    "maxAmount" integer,
    "maxQuantity" integer,
    "geoLocationLatLong" geometry(Point)
);


--
-- Name: Collectives; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "Collectives" (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    currency character varying(255) DEFAULT 'USD'::character varying,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "deletedAt" timestamp with time zone,
    "isActive" boolean DEFAULT false,
    "longDescription" text,
    image character varying(255),
    slug character varying(255),
    website character varying(255),
    "twitterHandle" character varying(255),
    mission character varying(128),
    "backgroundImage" character varying(255),
    "hostFeePercent" double precision,
    settings json,
    data json,
    tags character varying(255)[],
    "isSupercollective" boolean DEFAULT false,
    "LastEditedByUserId" integer,
    "CreatedByUserId" integer,
    "HostCollectiveId" integer,
    "ParentCollectiveId" integer,
    type character varying(255) DEFAULT 'COLLECTIVE'::character varying,
    "startsAt" timestamp with time zone,
    "endsAt" timestamp with time zone,
    "locationName" character varying(255),
    address character varying(255),
    timezone character varying(255),
    "maxAmount" integer,
    "maxQuantity" integer,
    "geoLocationLatLong" geometry(Point)
);


--
-- Name: ConnectedAccounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "ConnectedAccounts" (
    id integer NOT NULL,
    service character varying(255),
    username character varying(255),
    "clientId" character varying(255),
    token character varying(255),
    data json,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "deletedAt" timestamp with time zone,
    "CreatedByUserId" integer,
    "CollectiveId" integer,
    "refreshToken" character varying(255)
);


--
-- Name: ConnectedAccounts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "ConnectedAccounts_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ConnectedAccounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "ConnectedAccounts_id_seq" OWNED BY "ConnectedAccounts".id;


--
-- Name: Orders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "Orders" (
    id integer NOT NULL,
    "CreatedByUserId" integer,
    "CollectiveId" integer,
    currency character varying(255) DEFAULT 'USD'::character varying,
    "totalAmount" integer,
    description character varying(255),
    "SubscriptionId" integer,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "deletedAt" timestamp with time zone,
    "PaymentMethodId" integer,
    "processedAt" timestamp with time zone,
    "privateMessage" text,
    "TierId" integer,
    "FromCollectiveId" integer,
    "publicMessage" character varying(255),
    quantity integer
);


--
-- Name: Donations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "Donations_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Donations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "Donations_id_seq" OWNED BY "Orders".id;


--
-- Name: ExpenseHistories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "ExpenseHistories" (
    id integer,
    "UserId" integer,
    "CollectiveId" integer,
    currency character varying(255),
    amount integer,
    description character varying(255),
    "payoutMethod" character varying(255),
    "privateMessage" text,
    attachment character varying(255),
    category character varying(255),
    vat integer,
    "lastEditedById" integer,
    status character varying(255),
    "incurredAt" timestamp with time zone,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "deletedAt" timestamp with time zone,
    hid bigint NOT NULL,
    "archivedAt" timestamp with time zone NOT NULL
);


--
-- Name: ExpenseHistories_hid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "ExpenseHistories_hid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ExpenseHistories_hid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "ExpenseHistories_hid_seq" OWNED BY "ExpenseHistories".hid;


--
-- Name: Expenses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "Expenses" (
    id integer NOT NULL,
    "UserId" integer NOT NULL,
    "CollectiveId" integer NOT NULL,
    currency character varying(255) NOT NULL,
    amount integer NOT NULL,
    description character varying(255) NOT NULL,
    "privateMessage" text,
    attachment character varying(255),
    category character varying(255),
    vat integer,
    "lastEditedById" integer NOT NULL,
    status character varying(255) DEFAULT 'PENDING'::character varying NOT NULL,
    "incurredAt" timestamp with time zone NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "deletedAt" timestamp with time zone,
    "payoutMethod" character varying(255) NOT NULL
);


--
-- Name: Expenses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "Expenses_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Expenses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "Expenses_id_seq" OWNED BY "Expenses".id;


--
-- Name: GroupHistories_hid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "GroupHistories_hid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: GroupHistories_hid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "GroupHistories_hid_seq" OWNED BY "CollectiveHistories".hid;


--
-- Name: Groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "Groups_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "Groups_id_seq" OWNED BY "Collectives".id;


--
-- Name: Members; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "Members" (
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "deletedAt" timestamp with time zone,
    "CreatedByUserId" integer NOT NULL,
    "CollectiveId" integer NOT NULL,
    role character varying(255) DEFAULT 'MEMBER'::character varying NOT NULL,
    id integer NOT NULL,
    description character varying(255),
    "MemberCollectiveId" integer,
    "TierId" integer
);


--
-- Name: Notifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "Notifications" (
    id integer NOT NULL,
    channel character varying(255) DEFAULT 'email'::character varying,
    type character varying(255),
    active boolean DEFAULT true,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "UserId" integer,
    "CollectiveId" integer,
    "webhookUrl" character varying(255)
);


--
-- Name: SequelizeMeta; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "SequelizeMeta" (
    name character varying(255) NOT NULL
);


--
-- Name: Sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "Sessions" (
    sid character varying(32) NOT NULL,
    expires timestamp with time zone,
    data text,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


--
-- Name: Subscriptions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "Subscriptions" (
    id integer NOT NULL,
    amount integer,
    currency character varying(255) DEFAULT 'USD'::character varying,
    "interval" character varying(8) DEFAULT NULL::character varying,
    "isActive" boolean DEFAULT false,
    data json,
    "stripeSubscriptionId" character varying(255),
    "activatedAt" timestamp with time zone,
    "deactivatedAt" timestamp with time zone,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "deletedAt" timestamp with time zone
);


--
-- Name: Subscriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "Subscriptions_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Subscriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "Subscriptions_id_seq" OWNED BY "Notifications".id;


--
-- Name: Subscriptions_id_seq1; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "Subscriptions_id_seq1"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Subscriptions_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "Subscriptions_id_seq1" OWNED BY "Subscriptions".id;


--
-- Name: Tiers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "Tiers" (
    id integer NOT NULL,
    name character varying(255),
    description character varying(510),
    amount integer,
    currency character varying(255) DEFAULT 'USD'::character varying,
    "maxQuantity" integer,
    password character varying(255),
    "startsAt" timestamp with time zone,
    "endsAt" timestamp with time zone,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "deletedAt" timestamp with time zone,
    slug character varying(255),
    "maxQuantityPerUser" integer,
    goal integer,
    type character varying(255) DEFAULT 'TICKET'::character varying,
    "CollectiveId" integer,
    "interval" character varying(8) DEFAULT NULL::character varying,
    button character varying(255),
    presets json
);


--
-- Name: Tiers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "Tiers_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Tiers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "Tiers_id_seq" OWNED BY "Tiers".id;


--
-- Name: Transactions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "Transactions" (
    id integer NOT NULL,
    type character varying(255),
    description character varying(255),
    amount integer,
    currency character varying(255) DEFAULT 'USD'::character varying,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone NOT NULL,
    "CollectiveId" integer,
    "CreatedByUserId" integer,
    "PaymentMethodId" integer,
    "deletedAt" timestamp with time zone,
    data json,
    "OrderId" integer,
    "platformFeeInHostCurrency" integer,
    "hostFeeInHostCurrency" integer,
    "paymentProcessorFeeInHostCurrency" integer,
    "hostCurrency" character varying(255),
    "hostCurrencyFxRate" double precision,
    "amountInHostCurrency" integer,
    "netAmountInCollectiveCurrency" integer,
    "ExpenseId" integer,
    uuid uuid,
    "FromCollectiveId" integer,
    "HostCollectiveId" integer,
    "TransactionGroup" uuid
);


--
-- Name: Transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "Transactions_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "Transactions_id_seq" OWNED BY "Transactions".id;


--
-- Name: UserGroups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "UserGroups_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: UserGroups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "UserGroups_id_seq" OWNED BY "Members".id;


--
-- Name: Users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "Users" (
    id integer NOT NULL,
    email character varying(255),
    _salt character varying(255) DEFAULT '$2a$10$JqAcT6sBbBs5pO9FkwqLEu'::character varying,
    refresh_token character varying(255) DEFAULT '$2a$10$IHs8e8FdK1.bqjvZxr4Zvu'::character varying,
    password_hash character varying(255),
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    "seenAt" timestamp with time zone,
    "deletedAt" timestamp with time zone,
    "paypalEmail" character varying(255),
    "resetPasswordTokenHash" character varying(255),
    "resetPasswordSentAt" timestamp with time zone,
    "firstName" character varying(128),
    "lastName" character varying(128),
    "billingAddress" character varying(255),
    "isHost" boolean DEFAULT false,
    "CollectiveId" integer
);


--
-- Name: Users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "Users_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "Users_id_seq" OWNED BY "Users".id;


--
-- Name: Activities id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Activities" ALTER COLUMN id SET DEFAULT nextval('"Activities_id_seq"'::regclass);


--
-- Name: CollectiveHistories hid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "CollectiveHistories" ALTER COLUMN hid SET DEFAULT nextval('"GroupHistories_hid_seq"'::regclass);


--
-- Name: Collectives id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Collectives" ALTER COLUMN id SET DEFAULT nextval('"Groups_id_seq"'::regclass);


--
-- Name: ConnectedAccounts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "ConnectedAccounts" ALTER COLUMN id SET DEFAULT nextval('"ConnectedAccounts_id_seq"'::regclass);


--
-- Name: ExpenseHistories hid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "ExpenseHistories" ALTER COLUMN hid SET DEFAULT nextval('"ExpenseHistories_hid_seq"'::regclass);


--
-- Name: Expenses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Expenses" ALTER COLUMN id SET DEFAULT nextval('"Expenses_id_seq"'::regclass);


--
-- Name: Members id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Members" ALTER COLUMN id SET DEFAULT nextval('"UserGroups_id_seq"'::regclass);


--
-- Name: Notifications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Notifications" ALTER COLUMN id SET DEFAULT nextval('"Subscriptions_id_seq"'::regclass);


--
-- Name: Orders id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Orders" ALTER COLUMN id SET DEFAULT nextval('"Donations_id_seq"'::regclass);


--
-- Name: PaymentMethods id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "PaymentMethods" ALTER COLUMN id SET DEFAULT nextval('"Cards_id_seq"'::regclass);


--
-- Name: Subscriptions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Subscriptions" ALTER COLUMN id SET DEFAULT nextval('"Subscriptions_id_seq1"'::regclass);


--
-- Name: Tiers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Tiers" ALTER COLUMN id SET DEFAULT nextval('"Tiers_id_seq"'::regclass);


--
-- Name: Transactions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Transactions" ALTER COLUMN id SET DEFAULT nextval('"Transactions_id_seq"'::regclass);


--
-- Name: Users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Users" ALTER COLUMN id SET DEFAULT nextval('"Users_id_seq"'::regclass);


--
-- Data for Name: Activities; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "Activities" (id, type, data, "createdAt", "CollectiveId", "UserId", "TransactionId") FROM stdin;
\.
COPY "Activities" (id, type, data, "createdAt", "CollectiveId", "UserId", "TransactionId") FROM '$$PATH$$/4001.dat';

--
-- Data for Name: CollectiveHistories; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "CollectiveHistories" (id, name, description, currency, "createdAt", "updatedAt", "deletedAt", "isActive", "longDescription", image, slug, website, "twitterHandle", mission, "backgroundImage", "hostFeePercent", settings, data, tags, "isSupercollective", "LastEditedByUserId", hid, "archivedAt", "CreatedByUserId", "HostCollectiveId", "ParentCollectiveId", type, "startsAt", "endsAt", "locationName", address, timezone, "maxAmount", "maxQuantity", "geoLocationLatLong") FROM stdin;
\.
COPY "CollectiveHistories" (id, name, description, currency, "createdAt", "updatedAt", "deletedAt", "isActive", "longDescription", image, slug, website, "twitterHandle", mission, "backgroundImage", "hostFeePercent", settings, data, tags, "isSupercollective", "LastEditedByUserId", hid, "archivedAt", "CreatedByUserId", "HostCollectiveId", "ParentCollectiveId", type, "startsAt", "endsAt", "locationName", address, timezone, "maxAmount", "maxQuantity", "geoLocationLatLong") FROM '$$PATH$$/4013.dat';

--
-- Data for Name: Collectives; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "Collectives" (id, name, description, currency, "createdAt", "updatedAt", "deletedAt", "isActive", "longDescription", image, slug, website, "twitterHandle", mission, "backgroundImage", "hostFeePercent", settings, data, tags, "isSupercollective", "LastEditedByUserId", "CreatedByUserId", "HostCollectiveId", "ParentCollectiveId", type, "startsAt", "endsAt", "locationName", address, timezone, "maxAmount", "maxQuantity", "geoLocationLatLong") FROM stdin;
\.
COPY "Collectives" (id, name, description, currency, "createdAt", "updatedAt", "deletedAt", "isActive", "longDescription", image, slug, website, "twitterHandle", mission, "backgroundImage", "hostFeePercent", settings, data, tags, "isSupercollective", "LastEditedByUserId", "CreatedByUserId", "HostCollectiveId", "ParentCollectiveId", type, "startsAt", "endsAt", "locationName", address, timezone, "maxAmount", "maxQuantity", "geoLocationLatLong") FROM '$$PATH$$/4015.dat';

--
-- Data for Name: ConnectedAccounts; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "ConnectedAccounts" (id, service, username, "clientId", token, data, "createdAt", "updatedAt", "deletedAt", "CreatedByUserId", "CollectiveId", "refreshToken") FROM stdin;
\.
COPY "ConnectedAccounts" (id, service, username, "clientId", token, data, "createdAt", "updatedAt", "deletedAt", "CreatedByUserId", "CollectiveId", "refreshToken") FROM '$$PATH$$/4005.dat';

--
-- Data for Name: ExpenseHistories; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "ExpenseHistories" (id, "UserId", "CollectiveId", currency, amount, description, "payoutMethod", "privateMessage", attachment, category, vat, "lastEditedById", status, "incurredAt", "createdAt", "updatedAt", "deletedAt", hid, "archivedAt") FROM stdin;
\.
COPY "ExpenseHistories" (id, "UserId", "CollectiveId", currency, amount, description, "payoutMethod", "privateMessage", attachment, category, vat, "lastEditedById", status, "incurredAt", "createdAt", "updatedAt", "deletedAt", hid, "archivedAt") FROM '$$PATH$$/4009.dat';

--
-- Data for Name: Expenses; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "Expenses" (id, "UserId", "CollectiveId", currency, amount, description, "privateMessage", attachment, category, vat, "lastEditedById", status, "incurredAt", "createdAt", "updatedAt", "deletedAt", "payoutMethod") FROM stdin;
\.
COPY "Expenses" (id, "UserId", "CollectiveId", currency, amount, description, "privateMessage", attachment, category, vat, "lastEditedById", status, "incurredAt", "createdAt", "updatedAt", "deletedAt", "payoutMethod") FROM '$$PATH$$/4011.dat';

--
-- Data for Name: Members; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "Members" ("createdAt", "updatedAt", "deletedAt", "CreatedByUserId", "CollectiveId", role, id, description, "MemberCollectiveId", "TierId") FROM stdin;
\.
COPY "Members" ("createdAt", "updatedAt", "deletedAt", "CreatedByUserId", "CollectiveId", role, id, description, "MemberCollectiveId", "TierId") FROM '$$PATH$$/4027.dat';

--
-- Data for Name: Notifications; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "Notifications" (id, channel, type, active, "createdAt", "updatedAt", "UserId", "CollectiveId", "webhookUrl") FROM stdin;
\.
COPY "Notifications" (id, channel, type, active, "createdAt", "updatedAt", "UserId", "CollectiveId", "webhookUrl") FROM '$$PATH$$/4017.dat';

--
-- Data for Name: Orders; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "Orders" (id, "CreatedByUserId", "CollectiveId", currency, "totalAmount", description, "SubscriptionId", "createdAt", "updatedAt", "deletedAt", "PaymentMethodId", "processedAt", "privateMessage", "TierId", "FromCollectiveId", "publicMessage", quantity) FROM stdin;
\.
COPY "Orders" (id, "CreatedByUserId", "CollectiveId", currency, "totalAmount", description, "SubscriptionId", "createdAt", "updatedAt", "deletedAt", "PaymentMethodId", "processedAt", "privateMessage", "TierId", "FromCollectiveId", "publicMessage", quantity) FROM '$$PATH$$/4007.dat';

--
-- Data for Name: PaymentMethods; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "PaymentMethods" (id, name, token, "customerId", service, data, "createdAt", "updatedAt", "confirmedAt", "deletedAt", "CreatedByUserId", "expiryDate", uuid, "CollectiveId", "archivedAt", "monthlyLimitPerMember", "primary", currency) FROM stdin;
\.
COPY "PaymentMethods" (id, name, token, "customerId", service, data, "createdAt", "updatedAt", "confirmedAt", "deletedAt", "CreatedByUserId", "expiryDate", uuid, "CollectiveId", "archivedAt", "monthlyLimitPerMember", "primary", currency) FROM '$$PATH$$/4003.dat';

--
-- Data for Name: SequelizeMeta; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "SequelizeMeta" (name) FROM stdin;
\.
COPY "SequelizeMeta" (name) FROM '$$PATH$$/4018.dat';

--
-- Data for Name: Sessions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "Sessions" (sid, expires, data, "createdAt", "updatedAt") FROM stdin;
\.
COPY "Sessions" (sid, expires, data, "createdAt", "updatedAt") FROM '$$PATH$$/4019.dat';

--
-- Data for Name: Subscriptions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "Subscriptions" (id, amount, currency, "interval", "isActive", data, "stripeSubscriptionId", "activatedAt", "deactivatedAt", "createdAt", "updatedAt", "deletedAt") FROM stdin;
\.
COPY "Subscriptions" (id, amount, currency, "interval", "isActive", data, "stripeSubscriptionId", "activatedAt", "deactivatedAt", "createdAt", "updatedAt", "deletedAt") FROM '$$PATH$$/4020.dat';

--
-- Data for Name: Tiers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "Tiers" (id, name, description, amount, currency, "maxQuantity", password, "startsAt", "endsAt", "createdAt", "updatedAt", "deletedAt", slug, "maxQuantityPerUser", goal, type, "CollectiveId", "interval", button, presets) FROM stdin;
\.
COPY "Tiers" (id, name, description, amount, currency, "maxQuantity", password, "startsAt", "endsAt", "createdAt", "updatedAt", "deletedAt", slug, "maxQuantityPerUser", goal, type, "CollectiveId", "interval", button, presets) FROM '$$PATH$$/4023.dat';

--
-- Data for Name: Transactions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "Transactions" (id, type, description, amount, currency, "createdAt", "updatedAt", "CollectiveId", "CreatedByUserId", "PaymentMethodId", "deletedAt", data, "OrderId", "platformFeeInHostCurrency", "hostFeeInHostCurrency", "paymentProcessorFeeInHostCurrency", "hostCurrency", "hostCurrencyFxRate", "amountInHostCurrency", "netAmountInCollectiveCurrency", "ExpenseId", uuid, "FromCollectiveId", "HostCollectiveId", "TransactionGroup") FROM stdin;
\.
COPY "Transactions" (id, type, description, amount, currency, "createdAt", "updatedAt", "CollectiveId", "CreatedByUserId", "PaymentMethodId", "deletedAt", data, "OrderId", "platformFeeInHostCurrency", "hostFeeInHostCurrency", "paymentProcessorFeeInHostCurrency", "hostCurrency", "hostCurrencyFxRate", "amountInHostCurrency", "netAmountInCollectiveCurrency", "ExpenseId", uuid, "FromCollectiveId", "HostCollectiveId", "TransactionGroup") FROM '$$PATH$$/4025.dat';

--
-- Data for Name: Users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "Users" (id, email, _salt, refresh_token, password_hash, "createdAt", "updatedAt", "seenAt", "deletedAt", "paypalEmail", "resetPasswordTokenHash", "resetPasswordSentAt", "firstName", "lastName", "billingAddress", "isHost", "CollectiveId") FROM stdin;
\.
COPY "Users" (id, email, _salt, refresh_token, password_hash, "createdAt", "updatedAt", "seenAt", "deletedAt", "paypalEmail", "resetPasswordTokenHash", "resetPasswordSentAt", "firstName", "lastName", "billingAddress", "isHost", "CollectiveId") FROM '$$PATH$$/4029.dat';

--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: -
--

COPY spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.
COPY spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM '$$PATH$$/3752.dat';

--
-- Name: Activities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"Activities_id_seq"', 27901, true);


--
-- Name: Cards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"Cards_id_seq"', 3023, true);


--
-- Name: ConnectedAccounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"ConnectedAccounts_id_seq"', 1026, true);


--
-- Name: Donations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"Donations_id_seq"', 2912, true);


--
-- Name: ExpenseHistories_hid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"ExpenseHistories_hid_seq"', 1607, true);


--
-- Name: Expenses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"Expenses_id_seq"', 1159, true);


--
-- Name: GroupHistories_hid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"GroupHistories_hid_seq"', 31393, true);


--
-- Name: Groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"Groups_id_seq"', 857, true);


--
-- Name: Subscriptions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"Subscriptions_id_seq"', 17102, true);


--
-- Name: Subscriptions_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"Subscriptions_id_seq1"', 2214, true);


--
-- Name: Tiers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"Tiers_id_seq"', 128, true);


--
-- Name: Transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"Transactions_id_seq"', 11354, true);


--
-- Name: UserGroups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"UserGroups_id_seq"', 4728, true);


--
-- Name: Users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"Users_id_seq"', 4973, true);


--
-- Name: Activities Activities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Activities"
    ADD CONSTRAINT "Activities_pkey" PRIMARY KEY (id);


--
-- Name: PaymentMethods Cards_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "PaymentMethods"
    ADD CONSTRAINT "Cards_pkey" PRIMARY KEY (id);


--
-- Name: ConnectedAccounts ConnectedAccounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "ConnectedAccounts"
    ADD CONSTRAINT "ConnectedAccounts_pkey" PRIMARY KEY (id);


--
-- Name: Orders Donations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Orders"
    ADD CONSTRAINT "Donations_pkey" PRIMARY KEY (id);


--
-- Name: ExpenseHistories ExpenseHistories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "ExpenseHistories"
    ADD CONSTRAINT "ExpenseHistories_pkey" PRIMARY KEY (hid);


--
-- Name: Expenses Expenses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Expenses"
    ADD CONSTRAINT "Expenses_pkey" PRIMARY KEY (id);


--
-- Name: CollectiveHistories GroupHistories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "CollectiveHistories"
    ADD CONSTRAINT "GroupHistories_pkey" PRIMARY KEY (hid);


--
-- Name: Collectives Groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Collectives"
    ADD CONSTRAINT "Groups_pkey" PRIMARY KEY (id);


--
-- Name: SequelizeMeta SequelizeMeta_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "SequelizeMeta"
    ADD CONSTRAINT "SequelizeMeta_pkey" PRIMARY KEY (name);


--
-- Name: Sessions Sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Sessions"
    ADD CONSTRAINT "Sessions_pkey" PRIMARY KEY (sid);


--
-- Name: Notifications Subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Notifications"
    ADD CONSTRAINT "Subscriptions_pkey" PRIMARY KEY (id);


--
-- Name: Subscriptions Subscriptions_pkey1; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Subscriptions"
    ADD CONSTRAINT "Subscriptions_pkey1" PRIMARY KEY (id);


--
-- Name: Tiers Tiers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Tiers"
    ADD CONSTRAINT "Tiers_pkey" PRIMARY KEY (id);


--
-- Name: Transactions Transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Transactions"
    ADD CONSTRAINT "Transactions_pkey" PRIMARY KEY (id);


--
-- Name: Members UserGroups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Members"
    ADD CONSTRAINT "UserGroups_pkey" PRIMARY KEY (id);


--
-- Name: Users Users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Users"
    ADD CONSTRAINT "Users_email_key" UNIQUE (email);


--
-- Name: Users Users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Users"
    ADD CONSTRAINT "Users_pkey" PRIMARY KEY (id);


--
-- Name: Users email_unique_idx; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Users"
    ADD CONSTRAINT email_unique_idx UNIQUE (email);


--
-- Name: CollectiveId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "CollectiveId" ON "Users" USING btree ("CollectiveId");


--
-- Name: CollectiveId-FromCollectiveId-type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "CollectiveId-FromCollectiveId-type" ON "Transactions" USING btree ("CollectiveId", "FromCollectiveId", "deletedAt");


--
-- Name: CollectiveId-deletedAt; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "CollectiveId-deletedAt" ON "Tiers" USING btree ("CollectiveId", "deletedAt");


--
-- Name: CollectiveId-role; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "CollectiveId-role" ON "Members" USING btree ("CollectiveId", role);


--
-- Name: CollectiveId-type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "CollectiveId-type" ON "Transactions" USING btree ("CollectiveId", type);


--
-- Name: DonationId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "DonationId" ON "Transactions" USING btree ("OrderId");


--
-- Name: MemberCollectiveId-CollectiveId-role; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "MemberCollectiveId-CollectiveId-role" ON "Members" USING btree ("MemberCollectiveId", "CollectiveId", role);


--
-- Name: ParentCollectiveId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ParentCollectiveId" ON "Collectives" USING btree ("ParentCollectiveId");


--
-- Name: Transactions_GroupId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Transactions_GroupId" ON "Transactions" USING btree ("CollectiveId", "deletedAt");


--
-- Name: UniqueSlugIndex; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "UniqueSlugIndex" ON "Collectives" USING btree (slug);


--
-- Name: subscriptions_type__group_id__user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX subscriptions_type__group_id__user_id ON "Notifications" USING btree (type, "CollectiveId", "UserId");


--
-- Name: transactions_uuid; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX transactions_uuid ON "Transactions" USING btree (uuid);


--
-- Name: type-tags; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "type-tags" ON "Collectives" USING btree (type, tags);


--
-- Name: Activities Activities_GroupId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Activities"
    ADD CONSTRAINT "Activities_GroupId_fkey" FOREIGN KEY ("CollectiveId") REFERENCES "Collectives"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Activities Activities_TransactionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Activities"
    ADD CONSTRAINT "Activities_TransactionId_fkey" FOREIGN KEY ("TransactionId") REFERENCES "Transactions"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Activities Activities_UserId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Activities"
    ADD CONSTRAINT "Activities_UserId_fkey" FOREIGN KEY ("UserId") REFERENCES "Users"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: PaymentMethods Cards_UserId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "PaymentMethods"
    ADD CONSTRAINT "Cards_UserId_fkey" FOREIGN KEY ("CreatedByUserId") REFERENCES "Users"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: CollectiveHistories CollectiveHistories_CreatedByUserId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "CollectiveHistories"
    ADD CONSTRAINT "CollectiveHistories_CreatedByUserId_fkey" FOREIGN KEY ("CreatedByUserId") REFERENCES "Users"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: CollectiveHistories CollectiveHistories_HostCollectiveId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "CollectiveHistories"
    ADD CONSTRAINT "CollectiveHistories_HostCollectiveId_fkey" FOREIGN KEY ("HostCollectiveId") REFERENCES "Collectives"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: CollectiveHistories CollectiveHistories_ParentCollectiveId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "CollectiveHistories"
    ADD CONSTRAINT "CollectiveHistories_ParentCollectiveId_fkey" FOREIGN KEY ("ParentCollectiveId") REFERENCES "Collectives"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Collectives Collectives_CreatedByUserId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Collectives"
    ADD CONSTRAINT "Collectives_CreatedByUserId_fkey" FOREIGN KEY ("CreatedByUserId") REFERENCES "Users"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Collectives Collectives_HostCollectiveId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Collectives"
    ADD CONSTRAINT "Collectives_HostCollectiveId_fkey" FOREIGN KEY ("HostCollectiveId") REFERENCES "Collectives"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Collectives Collectives_ParentCollectiveId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Collectives"
    ADD CONSTRAINT "Collectives_ParentCollectiveId_fkey" FOREIGN KEY ("ParentCollectiveId") REFERENCES "Collectives"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: ConnectedAccounts ConnectedAccounts_GroupId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "ConnectedAccounts"
    ADD CONSTRAINT "ConnectedAccounts_GroupId_fkey" FOREIGN KEY ("CollectiveId") REFERENCES "Collectives"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ConnectedAccounts ConnectedAccounts_UserId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "ConnectedAccounts"
    ADD CONSTRAINT "ConnectedAccounts_UserId_fkey" FOREIGN KEY ("CreatedByUserId") REFERENCES "Users"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Orders Donations_GroupId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Orders"
    ADD CONSTRAINT "Donations_GroupId_fkey" FOREIGN KEY ("CollectiveId") REFERENCES "Collectives"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Orders Donations_PaymentMethodId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Orders"
    ADD CONSTRAINT "Donations_PaymentMethodId_fkey" FOREIGN KEY ("PaymentMethodId") REFERENCES "PaymentMethods"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Orders Donations_SubscriptionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Orders"
    ADD CONSTRAINT "Donations_SubscriptionId_fkey" FOREIGN KEY ("SubscriptionId") REFERENCES "Subscriptions"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Orders Donations_UserId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Orders"
    ADD CONSTRAINT "Donations_UserId_fkey" FOREIGN KEY ("CreatedByUserId") REFERENCES "Users"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Expenses Expenses_GroupId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Expenses"
    ADD CONSTRAINT "Expenses_GroupId_fkey" FOREIGN KEY ("CollectiveId") REFERENCES "Collectives"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Expenses Expenses_UserId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Expenses"
    ADD CONSTRAINT "Expenses_UserId_fkey" FOREIGN KEY ("UserId") REFERENCES "Users"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Expenses Expenses_lastEditedById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Expenses"
    ADD CONSTRAINT "Expenses_lastEditedById_fkey" FOREIGN KEY ("lastEditedById") REFERENCES "Users"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Collectives Groups_lastEditedByUserId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Collectives"
    ADD CONSTRAINT "Groups_lastEditedByUserId_fkey" FOREIGN KEY ("LastEditedByUserId") REFERENCES "Users"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Members Members_MemberCollectiveId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Members"
    ADD CONSTRAINT "Members_MemberCollectiveId_fkey" FOREIGN KEY ("MemberCollectiveId") REFERENCES "Collectives"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Members Members_TierId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Members"
    ADD CONSTRAINT "Members_TierId_fkey" FOREIGN KEY ("TierId") REFERENCES "Tiers"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Orders Orders_FromCollectiveId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Orders"
    ADD CONSTRAINT "Orders_FromCollectiveId_fkey" FOREIGN KEY ("FromCollectiveId") REFERENCES "Collectives"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Orders Orders_TierId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Orders"
    ADD CONSTRAINT "Orders_TierId_fkey" FOREIGN KEY ("TierId") REFERENCES "Tiers"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: PaymentMethods PaymentMethods_CollectiveId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "PaymentMethods"
    ADD CONSTRAINT "PaymentMethods_CollectiveId_fkey" FOREIGN KEY ("CollectiveId") REFERENCES "Collectives"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Notifications Subscriptions_GroupId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Notifications"
    ADD CONSTRAINT "Subscriptions_GroupId_fkey" FOREIGN KEY ("CollectiveId") REFERENCES "Collectives"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Notifications Subscriptions_UserId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Notifications"
    ADD CONSTRAINT "Subscriptions_UserId_fkey" FOREIGN KEY ("UserId") REFERENCES "Users"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Tiers Tiers_GroupId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Tiers"
    ADD CONSTRAINT "Tiers_GroupId_fkey" FOREIGN KEY ("CollectiveId") REFERENCES "Collectives"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Transactions Transactions_CardId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Transactions"
    ADD CONSTRAINT "Transactions_CardId_fkey" FOREIGN KEY ("PaymentMethodId") REFERENCES "PaymentMethods"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Transactions Transactions_DonationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Transactions"
    ADD CONSTRAINT "Transactions_DonationId_fkey" FOREIGN KEY ("OrderId") REFERENCES "Orders"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Transactions Transactions_ExpenseId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Transactions"
    ADD CONSTRAINT "Transactions_ExpenseId_fkey" FOREIGN KEY ("ExpenseId") REFERENCES "Expenses"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Transactions Transactions_FromCollectiveId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Transactions"
    ADD CONSTRAINT "Transactions_FromCollectiveId_fkey" FOREIGN KEY ("FromCollectiveId") REFERENCES "Collectives"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Transactions Transactions_GroupId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Transactions"
    ADD CONSTRAINT "Transactions_GroupId_fkey" FOREIGN KEY ("CollectiveId") REFERENCES "Collectives"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Transactions Transactions_HostCollectiveId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Transactions"
    ADD CONSTRAINT "Transactions_HostCollectiveId_fkey" FOREIGN KEY ("HostCollectiveId") REFERENCES "Collectives"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Transactions Transactions_UserId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Transactions"
    ADD CONSTRAINT "Transactions_UserId_fkey" FOREIGN KEY ("CreatedByUserId") REFERENCES "Users"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Members UserGroups_GroupId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Members"
    ADD CONSTRAINT "UserGroups_GroupId_fkey" FOREIGN KEY ("CollectiveId") REFERENCES "Collectives"(id);


--
-- Name: Members UserGroups_UserId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Members"
    ADD CONSTRAINT "UserGroups_UserId_fkey" FOREIGN KEY ("CreatedByUserId") REFERENCES "Users"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Users Users_CollectiveId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Users"
    ADD CONSTRAINT "Users_CollectiveId_fkey" FOREIGN KEY ("CollectiveId") REFERENCES "Collectives"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: geography_columns; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE geography_columns TO opencollective;


--
-- Name: geometry_columns; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE geometry_columns TO opencollective;


--
-- Name: raster_columns; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE raster_columns TO opencollective;


--
-- Name: raster_overviews; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE raster_overviews TO opencollective;


--
-- Name: spatial_ref_sys; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE spatial_ref_sys FROM aseem;
REVOKE SELECT ON TABLE spatial_ref_sys FROM PUBLIC;
GRANT ALL ON TABLE spatial_ref_sys TO opencollective;
GRANT SELECT ON TABLE spatial_ref_sys TO PUBLIC;


--
-- PostgreSQL database dump complete
--

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             