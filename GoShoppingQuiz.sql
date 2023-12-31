PGDMP                         {            GoShoppingQuiz    15.3    15.3 !    5           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            6           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            7           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            8           1262    19937    GoShoppingQuiz    DATABASE     �   CREATE DATABASE "GoShoppingQuiz" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_Indonesia.1252';
     DROP DATABASE "GoShoppingQuiz";
                postgres    false                        3079    19938 	   uuid-ossp 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;
    DROP EXTENSION "uuid-ossp";
                   false            9           0    0    EXTENSION "uuid-ossp"    COMMENT     W   COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';
                        false    2            �            1255    20002    ord_id()    FUNCTION     �   CREATE FUNCTION public.ord_id() RETURNS character varying
    LANGUAGE sql
    AS $$
select CONCAT('PO','-',lpad(''||nextval('seq_order'),4,'0'))
$$;
    DROP FUNCTION public.ord_id();
       public          postgres    false            �            1259    19949    category    TABLE     �   CREATE TABLE public.category (
    cateid uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    catename character varying(100)
);
    DROP TABLE public.category;
       public         heap    postgres    false    2            �            1259    19982    itemproduct    TABLE     �   CREATE TABLE public.itemproduct (
    cartid uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    product uuid,
    qty integer,
    subtotal numeric,
    "user" uuid
);
    DROP TABLE public.itemproduct;
       public         heap    postgres    false    2            �            1259    20017    orderlineitem    TABLE     �   CREATE TABLE public.orderlineitem (
    ordlineid uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    product uuid,
    qty integer,
    subtotal numeric,
    "order" uuid
);
 !   DROP TABLE public.orderlineitem;
       public         heap    postgres    false    2            �            1259    20003    orders    TABLE     �   CREATE TABLE public.orders (
    orderid uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    orderno character varying(50) DEFAULT public.ord_id(),
    "user" uuid,
    totalprice numeric,
    status character varying(30)
);
    DROP TABLE public.orders;
       public         heap    postgres    false    2    232            �            1259    19963    product    TABLE     �   CREATE TABLE public.product (
    prodid uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(200),
    category uuid,
    stock integer,
    price numeric
);
    DROP TABLE public.product;
       public         heap    postgres    false    2            �            1259    20000 	   seq_order    SEQUENCE     r   CREATE SEQUENCE public.seq_order
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
     DROP SEQUENCE public.seq_order;
       public          postgres    false            �            1259    19976    users    TABLE        CREATE TABLE public.users (
    userid uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    username character varying(200)
);
    DROP TABLE public.users;
       public         heap    postgres    false    2            ,          0    19949    category 
   TABLE DATA           4   COPY public.category (cateid, catename) FROM stdin;
    public          postgres    false    215   �$       /          0    19982    itemproduct 
   TABLE DATA           M   COPY public.itemproduct (cartid, product, qty, subtotal, "user") FROM stdin;
    public          postgres    false    218   (%       2          0    20017    orderlineitem 
   TABLE DATA           S   COPY public.orderlineitem (ordlineid, product, qty, subtotal, "order") FROM stdin;
    public          postgres    false    221   E%       1          0    20003    orders 
   TABLE DATA           N   COPY public.orders (orderid, orderno, "user", totalprice, status) FROM stdin;
    public          postgres    false    220   {&       -          0    19963    product 
   TABLE DATA           G   COPY public.product (prodid, name, category, stock, price) FROM stdin;
    public          postgres    false    216   V'       .          0    19976    users 
   TABLE DATA           1   COPY public.users (userid, username) FROM stdin;
    public          postgres    false    217   J)       :           0    0 	   seq_order    SEQUENCE SET     8   SELECT pg_catalog.setval('public.seq_order', 53, true);
          public          postgres    false    219            �           2606    19954    category category_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (cateid);
 @   ALTER TABLE ONLY public.category DROP CONSTRAINT category_pkey;
       public            postgres    false    215            �           2606    19989    itemproduct itemproduct_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.itemproduct
    ADD CONSTRAINT itemproduct_pkey PRIMARY KEY (cartid);
 F   ALTER TABLE ONLY public.itemproduct DROP CONSTRAINT itemproduct_pkey;
       public            postgres    false    218            �           2606    20024     orderlineitem orderlineitem_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.orderlineitem
    ADD CONSTRAINT orderlineitem_pkey PRIMARY KEY (ordlineid);
 J   ALTER TABLE ONLY public.orderlineitem DROP CONSTRAINT orderlineitem_pkey;
       public            postgres    false    221            �           2606    20011    orders orders_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (orderid);
 <   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_pkey;
       public            postgres    false    220            �           2606    19970    product product_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (prodid);
 >   ALTER TABLE ONLY public.product DROP CONSTRAINT product_pkey;
       public            postgres    false    216            �           2606    19981    users users_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (userid);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    217            �           2606    19971    product fk_category    FK CONSTRAINT     z   ALTER TABLE ONLY public.product
    ADD CONSTRAINT fk_category FOREIGN KEY (category) REFERENCES public.category(cateid);
 =   ALTER TABLE ONLY public.product DROP CONSTRAINT fk_category;
       public          postgres    false    3213    215    216            �           2606    20030    orderlineitem fk_order    FK CONSTRAINT     {   ALTER TABLE ONLY public.orderlineitem
    ADD CONSTRAINT fk_order FOREIGN KEY ("order") REFERENCES public.orders(orderid);
 @   ALTER TABLE ONLY public.orderlineitem DROP CONSTRAINT fk_order;
       public          postgres    false    220    221    3221            �           2606    19990    itemproduct fk_product    FK CONSTRAINT     {   ALTER TABLE ONLY public.itemproduct
    ADD CONSTRAINT fk_product FOREIGN KEY (product) REFERENCES public.product(prodid);
 @   ALTER TABLE ONLY public.itemproduct DROP CONSTRAINT fk_product;
       public          postgres    false    216    3215    218            �           2606    20025    orderlineitem fk_product    FK CONSTRAINT     }   ALTER TABLE ONLY public.orderlineitem
    ADD CONSTRAINT fk_product FOREIGN KEY (product) REFERENCES public.product(prodid);
 B   ALTER TABLE ONLY public.orderlineitem DROP CONSTRAINT fk_product;
       public          postgres    false    221    3215    216            �           2606    19995    itemproduct fk_user    FK CONSTRAINT     u   ALTER TABLE ONLY public.itemproduct
    ADD CONSTRAINT fk_user FOREIGN KEY ("user") REFERENCES public.users(userid);
 =   ALTER TABLE ONLY public.itemproduct DROP CONSTRAINT fk_user;
       public          postgres    false    3217    217    218            �           2606    20012    orders fk_user    FK CONSTRAINT     p   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk_user FOREIGN KEY ("user") REFERENCES public.users(userid);
 8   ALTER TABLE ONLY public.orders DROP CONSTRAINT fk_user;
       public          postgres    false    220    217    3217            ,   v   x��;�0 й���۩s��!!(*b���g�<U���#`���l�Z�V�v��:�酲6�!�3p*�rP#���y��q|�Q�s���}(cw�NR��m1���xF�^J)?�&�      /      x������ � �      2   &  x�����E!Ͼ\�A�\����n����L�ta���I@�	�6A�R��c�ed���ދ�-&Ԩytvu�m7����ֵv�B�8�	,Ƃ��Ņ՟��.0ҋ��3: �TnVo}d��}*���3�/l�a�<;O7�,w�V�C��6�mz��>��"��ӯ�NNZ���1�a>$�zѐ�6�2Gv��R�q���Մ� �R't�0�2K��.���89�t9`����p�	��ks�~z��Ԛ|%�ۺ:5k�qg{i������y�?�o�^      1   �   x�-�;n�0Dk�.H���6��Ҧ!%��G��x���kk=Ba^ Hlr��snٴ1�O@��d���U���:ذ-V]��D8�/�|���|�p���e��@u!s3ڛn>'���ف��W��s���ơC��?��<���2�h�6�H��-
wi]�P/���1f7U��z�AE���S&���|��3�|��H�      -   �  x����j[1���S����e %)�i�U)݌�Qbpl�kh��_�g���h��pu���e�zchL�RO3�(X���m��a���]Ig��t��,�BF�
p��4��B�������,:Iιz��]q=ϡG	a�,���/���ʾ��Ӕ1�>��uB�J@�1���h���+!^ ���˄�Sv��	s�2p�7k�'����Rѐ��H9�T@������<�:�6��Ѯ�?٥|�=�}����>�(s�Q@�g�2D]���5�X�F�~ �a^���w�r��I��C��Y�(H�Ů�%���XK`7a`S@J��j��&c��Z�����t���^��vѱ@߽�����@��0��r�T�z��E[nO�M�]/��V�3��)�%�)�s�V�G��qԈ������;���+���:�[�͵�a�M���D��[_}z~�8t�.���[�~Y,�ӛ�G      .   n   x�%�1�0 �9��cl�/]��R�L���V��'�{����7�u��P���HWYG\�E�sFrb+���kc��=��͏ϻnj`�4�SG���Hb6��Z���/���/��#�     