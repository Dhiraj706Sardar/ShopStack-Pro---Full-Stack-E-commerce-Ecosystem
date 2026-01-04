package com.ecommerce.service.impl;

import com.ecommerce.dto.OrderDTO;
import com.ecommerce.dto.OrderItemDTO;
import com.ecommerce.service.PdfService;
import com.lowagie.text.*;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import org.springframework.stereotype.Service;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.util.stream.Stream;

@Service
public class PdfServiceImpl implements PdfService {

    @Override
    public ByteArrayInputStream generateInvoice(OrderDTO order) {
        Document document = new Document();
        ByteArrayOutputStream out = new ByteArrayOutputStream();

        try {
            PdfWriter.getInstance(document, out);
            document.open();

            // Header Section
            PdfPTable headerTable = new PdfPTable(2);
            headerTable.setWidthPercentage(100);

            // Company Info
            Font companyFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18);
            PdfPCell companyCell = new PdfPCell(new Phrase("E-Commerce Platform", companyFont));
            companyCell.setBorder(Rectangle.NO_BORDER);
            headerTable.addCell(companyCell);

            // Invoice Label
            Font invoiceFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 20, java.awt.Color.GRAY);
            PdfPCell invoiceCell = new PdfPCell(new Phrase("INVOICE", invoiceFont));
            invoiceCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
            invoiceCell.setBorder(Rectangle.NO_BORDER);
            headerTable.addCell(invoiceCell);

            document.add(headerTable);
            document.add(Chunk.NEWLINE);
            document.add(Chunk.NEWLINE);

            // Details Section (Bill To & Order Info)
            PdfPTable detailsTable = new PdfPTable(2);
            detailsTable.setWidthPercentage(100);

            // Bill To
            PdfPCell billToCell = new PdfPCell();
            billToCell.setBorder(Rectangle.NO_BORDER);
            billToCell.addElement(new Paragraph("Bill To:", FontFactory.getFont(FontFactory.HELVETICA_BOLD)));
            billToCell.addElement(new Paragraph(order.getUserName()));
            billToCell.addElement(new Paragraph(order.getUserEmail()));
            billToCell.addElement(new Paragraph(order.getShippingAddress()));
            detailsTable.addCell(billToCell);

            // Order Info
            PdfPCell orderInfoCell = new PdfPCell();
            orderInfoCell.setBorder(Rectangle.NO_BORDER);
            orderInfoCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
            // Create a nested table for right alignment content
            PdfPTable infoContent = new PdfPTable(1);
            infoContent.setWidthPercentage(100);

            PdfPCell infoCell = new PdfPCell(new Paragraph("Order ID: " + order.getId()));
            infoCell.setBorder(Rectangle.NO_BORDER);
            infoCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
            infoContent.addCell(infoCell);

            infoCell = new PdfPCell(new Paragraph("Date: " + order.getOrderDate().toString().split("T")[0]));
            infoCell.setBorder(Rectangle.NO_BORDER);
            infoCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
            infoContent.addCell(infoCell);

            infoCell = new PdfPCell(new Paragraph("Status: " + order.getStatus()));
            infoCell.setBorder(Rectangle.NO_BORDER);
            infoCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
            infoContent.addCell(infoCell);

            orderInfoCell.addElement(infoContent);
            detailsTable.addCell(orderInfoCell);

            document.add(detailsTable);
            document.add(Chunk.NEWLINE);
            document.add(Chunk.NEWLINE);

            // Items Table
            PdfPTable table = new PdfPTable(5); // Added Seller Column
            table.setWidthPercentage(100);
            table.setWidths(new int[] { 4, 3, 2, 2, 2 });
            table.setSpacingBefore(10);

            addTableHeader(table);
            addRows(table, order);

            document.add(table);
            document.add(Chunk.NEWLINE);

            // Total Amount
            Font totalFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 14);
            Paragraph total = new Paragraph("Total Amount: $" + String.format("%.2f", order.getTotalAmount()),
                    totalFont);
            total.setAlignment(Element.ALIGN_RIGHT);
            document.add(total);

            document.add(Chunk.NEWLINE);
            document.add(Chunk.NEWLINE);

            // Footer
            Font footerFont = FontFactory.getFont(FontFactory.HELVETICA_OBLIQUE, 10, java.awt.Color.GRAY);
            Paragraph footer = new Paragraph("Thank you for your business!", footerFont);
            footer.setAlignment(Element.ALIGN_CENTER);
            document.add(footer);

            Paragraph contact = new Paragraph("Contact: support@ecommerce.com | +1 234 567 890", footerFont);
            contact.setAlignment(Element.ALIGN_CENTER);
            document.add(contact);

            document.close();
        } catch (DocumentException e) {
            e.printStackTrace();
        }

        return new ByteArrayInputStream(out.toByteArray());
    }

    private void addTableHeader(PdfPTable table) {
        Stream.of("Product", "Seller", "Quantity", "Price", "Total")
                .forEach(columnTitle -> {
                    PdfPCell header = new PdfPCell();
                    header.setBackgroundColor(java.awt.Color.LIGHT_GRAY);
                    header.setBorderWidth(1);
                    header.setPadding(5);
                    header.setPhrase(new Phrase(columnTitle, FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12)));
                    header.setHorizontalAlignment(Element.ALIGN_CENTER);
                    table.addCell(header);
                });
    }

    private void addRows(PdfPTable table, OrderDTO order) {
        for (OrderItemDTO item : order.getItems()) {
            table.addCell(new PdfPCell(new Phrase(item.getProductName())));
            table.addCell(new PdfPCell(new Phrase(item.getSellerName() != null ? item.getSellerName() : "N/A")));

            PdfPCell qtyCell = new PdfPCell(new Phrase(String.valueOf(item.getQuantity())));
            qtyCell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(qtyCell);

            PdfPCell priceCell = new PdfPCell(new Phrase("$" + String.format("%.2f", item.getPrice())));
            priceCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
            table.addCell(priceCell);

            PdfPCell totalCell = new PdfPCell(
                    new Phrase("$" + String.format("%.2f", item.getPrice() * item.getQuantity())));
            totalCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
            table.addCell(totalCell);
        }
    }
}
